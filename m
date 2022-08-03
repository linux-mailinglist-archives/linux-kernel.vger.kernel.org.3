Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F7E588F6E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 17:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238166AbiHCPce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 11:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238106AbiHCPbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:31:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DCC7667
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 08:31:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 571EE616EA
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 15:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2EBC433D6;
        Wed,  3 Aug 2022 15:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659540709;
        bh=4kJ4xy7PCOglgb5A8neG/nrQqkuTk6XSoLuM//2BqBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E/z8n+T64G2PEC0VWKp2AK+h3GscLWyMyrFIT046nn0jGxfJAkyUtumavEbnpF/uk
         wbKB0YUVprc/JT033VPHUAZF62oWRXSCk9TPTulIE+hNeB8s1NBrvVU2aZqvKL+k7j
         5OAZivhicWrZEQo+jq/jPXOqRyBJPeTjuZMgxbN4=
Date:   Wed, 3 Aug 2022 17:31:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     bchalios@amazon.es
Cc:     linux-kernel@vger.kernel.org, tytso@mit.edu, Jason@zx2c4.com,
        dwmw@amazon.co.uk, graf@amazon.de, xmarcalx@amazon.co.uk
Subject: Re: [PATCH 2/2] virt: vmgenid: add support for generation counter
Message-ID: <YuqU4wXNBt4pAK+C@kroah.com>
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
> +	/* Backwards compatibility. If CTRA is not there we just don't expose
> +	 * the char device

Backwards compatibility with what?

> +	 */
> +	ret = parse_vmgenid_address(device, "CTRA", &state->gen_cntr_addr);
> +	if (ret)
> +		return 0;
> +
> +	state->next_counter = devm_memremap(&device->dev, state->gen_cntr_addr,
> +			sizeof(u32), MEMREMAP_WB);
> +	if (IS_ERR(state->next_counter))
> +		return 0;

This too is an error, you can not return with "all is good", right?
Once you try to create this device because the address is present, you
can't just give up and succeed no matter what went wrong, that seems
incorrect.

thanks,

greg k-h
