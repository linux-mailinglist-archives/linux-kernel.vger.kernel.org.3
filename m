Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07965A91ED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbiIAIS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbiIAISR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:18:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1877A12D504
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:18:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE88261E00
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE58C433C1;
        Thu,  1 Sep 2022 08:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662020293;
        bh=SJti5AlwG2smz35iBVA8XDbLCLC67wZdHYc+9fqVbXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pb1dVILhPHNKqfWSEAI/tUlkXYHUEI01IWEePIoQYrIaw8EaAYhNyDGBklePtxOjI
         LrYCeNCYK9v0OpGfbxqPXJ4ZpqIIJ1w4j3z3wzO1BTGMFm3lZFVbFHhNBOBg0jLTC3
         S//qOMMjmd1I9RS5nIpN1W+MoV8mAump2Kqw5RpA=
Date:   Thu, 1 Sep 2022 10:18:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     hdegoede@redhat.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virt: vbox: Add check for device_create_file
Message-ID: <YxBqwp6rzR54RTZ3@kroah.com>
References: <20220901074521.3448337-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901074521.3448337-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 03:45:21PM +0800, Jiasheng Jiang wrote:
> As device_create_file() can return error number,
> it should be better to check the return value and
> deal with the exception.
> 
> Fixes: 0ba002bc4393 ("virt: Add vboxguest driver for Virtual Box Guest integration")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/virt/vboxguest/vboxguest_linux.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
> index 4ccfd30c2a30..0fee8e6ee6e0 100644
> --- a/drivers/virt/vboxguest/vboxguest_linux.c
> +++ b/drivers/virt/vboxguest/vboxguest_linux.c
> @@ -390,8 +390,13 @@ static int vbg_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
>  	}
>  
>  	pci_set_drvdata(pci, gdev);
> -	device_create_file(dev, &dev_attr_host_version);
> -	device_create_file(dev, &dev_attr_host_features);
> +
> +	ret = device_create_file(dev, &dev_attr_host_version);
> +	if (ret)
> +		goto err_unregister_misc_device_user;
> +	ret = device_create_file(dev, &dev_attr_host_features);
> +	if (ret)
> +		goto err_unregister_misc_device_user;

This is also buggy, please always test your changes before sending them
out :(

