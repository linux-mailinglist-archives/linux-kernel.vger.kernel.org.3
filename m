Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B8D58EA90
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 12:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiHJKlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 06:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiHJKlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 06:41:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0660E6B66C;
        Wed, 10 Aug 2022 03:41:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EBF9611B7;
        Wed, 10 Aug 2022 10:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA45BC433D6;
        Wed, 10 Aug 2022 10:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660128108;
        bh=UTgDPlLmDwf3UdAjiC20kp3vocuyG6ERqW53VpoUqWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hkUhxpdTGKBCILjzQV8Q4xOSsJzF6VT3kayFmWnEWeMlSmjVOBO/Eu4TUWAEa2mZv
         hpCqv3KSHJ/XeT9mgXydskDbLrrzGT23Vr/b4LiUgvU1eUwjxU+mGo1itlyFaxH5pB
         Xk8t6MzBtLtuk6rTKccMTDNQyQ/Vz1xGVVpCNn30=
Date:   Wed, 10 Aug 2022 12:41:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Szuying Chen <chensiying21@gmail.com>
Cc:     mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yd_Tseng@asmedia.com.tw, Chloe_Chen@asmedia.com.tw,
        Richard_Hsu@asmedia.com.tw
Subject: Re: [PATCH] thunderbolt: thunderbolt: add vendor's NVM formats
Message-ID: <YvOLacO4H3ObAGL3@kroah.com>
References: <20220810101743.11214-1-chensiying21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810101743.11214-1-chensiying21@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 06:17:43PM +0800, Szuying Chen wrote:
> The patch add tb_nvm_quirks() contain an array that has functions
> pointers to tb_nvm_vendor_apply().
> And tb_nvm_vendor_apply() that recognize supported vendor works in one
> of the following cases:
> Case NvmUpgradeSuppport: enable nvm's attribute by setting
> no_nvm_upgrade flag to create nvm_authenticate file node.
> Case NvmAdd:add active/non-active NVM devices.
> Case NvmWrite:update firmware to non-ative NVM device.
> 
> Signed-off-by: Szuying Chen <chensiying21@gmail.com>
> ---
>  drivers/thunderbolt/nvm.c    | 59 ++++++++++++++----------------------
>  drivers/thunderbolt/switch.c | 19 +++++++-----
>  drivers/thunderbolt/tb.h     | 18 +++++++----
>  3 files changed, 46 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
> index d5f283889da8..2aae8b3fa5dc 100644
> --- a/drivers/thunderbolt/nvm.c
> +++ b/drivers/thunderbolt/nvm.c
> @@ -14,6 +14,7 @@
>  #include "tb.h"
> 
>  static DEFINE_IDA(nvm_ida);
> +
>  static int tb_switch_nvm_read(void *priv, unsigned int offset, void *val,
>  			      size_t bytes)
>  {
> @@ -22,7 +23,6 @@ static int tb_switch_nvm_read(void *priv, unsigned int offset, void *val,
>  	int ret;
> 
>  	pm_runtime_get_sync(&sw->dev);
> -
>  	if (!mutex_trylock(&sw->tb->lock)) {
>  		ret = restart_syscall();
>  		goto out;

These are odd whitespace changes that you do not discuss in your
changelog, which means we can't take this.  Also, whitespace cleanups
should be in a separate commit.

thanks,

greg k-h
