Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576FE4BE768
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238376AbiBURFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 12:05:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236770AbiBURFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 12:05:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E7CCD2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 09:05:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EE6E61359
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 17:05:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236EBC340E9;
        Mon, 21 Feb 2022 17:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645463124;
        bh=5MfT2oHc40ecxh8J5Ub5ggnpJn5KsjhhqhGoFvH2PBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2Hw+yRmAqVoMat+juk54S2+mFp4mWhfVxu2KLCfHrJ8JUrst+w2uA7Ahf7716md/n
         RVbJbOkBdpZBeyLPuAL5Vwox7mWNlfschmfoWbDtNKqBMbh5rt7XR+wharlsAXRLGa
         okobl9AJXkSojAoVDgDxVigR3adCnawQZ3zgiz8s=
Date:   Mon, 21 Feb 2022 18:05:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xkernel.wang@foxmail.com
Cc:     jerome.pouiller@silabs.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] staging: wfx: check the return value of
 devm_kmalloc()
Message-ID: <YhPGUlkeT3UtvIEd@kroah.com>
References: <tencent_24A24A3EFF61206ECCC4B94B1C5C1454E108@qq.com>
 <tencent_3CB9DC1C721449E14B4AD3FF65201CCC4C08@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_3CB9DC1C721449E14B4AD3FF65201CCC4C08@qq.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 10:04:02PM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> devm_kmalloc() returns a pointer to allocated memory on success, NULL
> on failure. While there is a memory allocation of devm_kmalloc()
> without proper check. It is better to check the return value of it to
> prevent wrong memory access.
> And I use the err label which is introduced by the previous patch to
> handle the error.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
> Changelog
> v1->v2 update the description.
>  drivers/staging/wfx/main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
> index 9ff69c5..85fcdc3 100644
> --- a/drivers/staging/wfx/main.c
> +++ b/drivers/staging/wfx/main.c
> @@ -294,6 +294,9 @@ struct wfx_dev *wfx_init_common(struct device *dev,
>  	hw->wiphy->n_iface_combinations = ARRAY_SIZE(wfx_iface_combinations);
>  	hw->wiphy->iface_combinations = wfx_iface_combinations;
>  	hw->wiphy->bands[NL80211_BAND_2GHZ] = devm_kmalloc(dev, sizeof(wfx_band_2ghz), GFP_KERNEL);
> +	if (!hw->wiphy->bands[NL80211_BAND_2GHZ])
> +		goto err;
> +
>  	// FIXME: also copy wfx_rates and wfx_2ghz_chantable
>  	memcpy(hw->wiphy->bands[NL80211_BAND_2GHZ], &wfx_band_2ghz,
>  	       sizeof(wfx_band_2ghz));
> -- 

This patch does not apply to my tree at all.  Please rebase and resend.

thanks,

greg k-h
