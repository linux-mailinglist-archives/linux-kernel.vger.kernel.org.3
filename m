Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A430A4B71B3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241378AbiBOQKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:10:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238278AbiBOQK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:10:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C679D4FE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:10:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A331B81B0B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 16:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110F8C340EC;
        Tue, 15 Feb 2022 16:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644941415;
        bh=btmIpiqpKbhsvTMtjH1n8pyIl3PypLvmjDYFv6l3URU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jX1Js0zkOXAvMHbLktSGh36A0Fx5IarIZ5AdvVvA1JFW7tqBKZ2Czk2ZT0vkhh1eI
         5m+GnAt2frvbsCQYDEUSQOTa3VXhiKvnkUVGAUnWIVdVHwIlacfGOFey20Yj0TOv3b
         Q7y7fnJrki9NOreG9945F8Aprab8j+i3C2uH85KY=
Date:   Tue, 15 Feb 2022 17:10:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] staging: r8188eu: Use kzalloc() with GFP_ATOMIC
 in atomic context
Message-ID: <YgvQZDBLCsvwTtJM@kroah.com>
References: <20220208180426.27455-1-fmdefrancesco@gmail.com>
 <20220208180426.27455-3-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208180426.27455-3-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 07:04:26PM +0100, Fabio M. De Francesco wrote:
> Use the GFP_ATOMIC flag of kzalloc() with two memory allocation in rtw_set_key() 
> because it is not allowed to sleep while it executes in atomic context.
> 
> With the GFP_ATOMIC type flag, the allocation is high priority and thus it 
> cannot sleep.
> 
> This issue is detected by Smatch which emits the following warning:
> 
> "drivers/staging/r8188eu/core/rtw_mlme.c:1603 rtw_set_key() warn: sleeping in atomic context".
> 
> Fixes: 79f712ea994d ("staging: r8188eu: Remove wrappers for kalloc() and kzalloc()")
> Fixes: 15865124feed ("staging: r8188eu: introduce new core dir for RTL8188eu driver")
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_mlme.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
> index f5b2df72e0f4..860835e29b79 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme.c
> @@ -1600,12 +1600,12 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
>  	struct mlme_priv		*pmlmepriv = &adapter->mlmepriv;
>  	int	res = _SUCCESS;
>  
> -	pcmd = kzalloc(sizeof(*pcmd), GFP_KERNEL);
> +	pcmd = kzalloc(sizeof(*pcmd), GFP_ATOMIC);
>  	if (!pcmd) {
>  		res = _FAIL;  /* try again */
>  		goto exit;
>  	}
> -	psetkeyparm = kzalloc(sizeof(*psetkeyparm), GFP_KERNEL);
> +	psetkeyparm = kzalloc(sizeof(*psetkeyparm), GFP_ATOMIC);
>  	if (!psetkeyparm) {
>  		kfree(pcmd);
>  		res = _FAIL;
> -- 
> 2.34.1

What code path is calling this in atomic context?

thanks,

greg k-h
