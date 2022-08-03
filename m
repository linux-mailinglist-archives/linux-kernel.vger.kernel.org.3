Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49319588F59
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 17:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbiHCPab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 11:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236050AbiHCPa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:30:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95835FC5
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 08:30:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9143AB822D7
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 15:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3780C433C1;
        Wed,  3 Aug 2022 15:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659540624;
        bh=WyiGNSvjUwTkeWatQt6mvRLOsng36yiXnSh2JSzLRrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i6Jc7cQbD2cp2V52UmyKRjQOZyQPrH26eeYGyQKiRCcM50RyTyUIdw5lXyOut5mXV
         Py9O9dinpZU5uHS/nRKPHG3Cit8NnTzIQzuikohG4AoCqyWK+2OSQPmNtLAP9PtrC5
         IkRvV45yNk27fFbVzY2jsAYraB87SQOZcCPLK/SY=
Date:   Wed, 3 Aug 2022 17:30:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     bchalios@amazon.es
Cc:     linux-kernel@vger.kernel.org, tytso@mit.edu, Jason@zx2c4.com,
        dwmw@amazon.co.uk, graf@amazon.de, xmarcalx@amazon.co.uk
Subject: Re: [PATCH 2/2] virt: vmgenid: add support for generation counter
Message-ID: <YuqUjUBxq6X738t/@kroah.com>
References: <20220803152127.48281-1-bchalios@amazon.es>
 <20220803152127.48281-3-bchalios@amazon.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803152127.48281-3-bchalios@amazon.es>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 05:21:27PM +0200, bchalios@amazon.es wrote:
> +static const struct file_operations fops = {
> +	.owner = THIS_MODULE,
> +	.open = vmgenid_open,
> +	.read = vmgenid_read,
> +	.mmap = vmgenid_mmap,
> +	.llseek = noop_llseek,

Where is this new user/kernel api being documented?

See, put it in the code please, no one knows to look in a random file in
Documentation/ 


> +};
> +
> +static struct miscdevice vmgenid_misc = {
> +	.minor = MISC_DYNAMIC_MINOR,
> +	.name = "vmgenid",
> +	.fops = &fops,
>  };
>  
>  static int parse_vmgenid_address(struct acpi_device *device, acpi_string object_name,
> @@ -57,7 +124,7 @@ static int vmgenid_add(struct acpi_device *device)
>  	phys_addr_t phys_addr;
>  	int ret;
>  
> -	state = devm_kmalloc(&device->dev, sizeof(*state), GFP_KERNEL);
> +	state = devm_kzalloc(&device->dev, sizeof(*state), GFP_KERNEL);
>  	if (!state)
>  		return -ENOMEM;
>  
> @@ -74,6 +141,27 @@ static int vmgenid_add(struct acpi_device *device)
>  
>  	device->driver_data = state;
>  
> +	/* Backwards compatibility. If CTRA is not there we just don't expose
> +	 * the char device
> +	 */
> +	ret = parse_vmgenid_address(device, "CTRA", &state->gen_cntr_addr);
> +	if (ret)
> +		return 0;
> +
> +	state->next_counter = devm_memremap(&device->dev, state->gen_cntr_addr,
> +			sizeof(u32), MEMREMAP_WB);
> +	if (IS_ERR(state->next_counter))
> +		return 0;
> +
> +	memcpy(&state->misc, &vmgenid_misc, sizeof(state->misc));
> +	ret = misc_register(&state->misc);
> +	if (ret) {
> +		devm_memunmap(&device->dev, state->next_counter);
> +		return 0;

Why are you not returning an error?  Why is this ok?

And why call devm_memunmap() directly?  That kind of defeats the purpose
of using devm_memremap(), right?

thanks,

greg k-h
