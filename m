Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DE94AD507
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 10:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355123AbiBHJdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 04:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355058AbiBHJdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:33:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CBEC03FEC6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 01:33:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6841BB816F4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E60DC004E1;
        Tue,  8 Feb 2022 09:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644312787;
        bh=FhxF+wItARpZEpojfEM3m80n83PqP7keXml5yW7Krh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jcVAU0JycApzdCpf3F+CSz4y7JYsNl4IY4HAVuudcq3QsQ7YSFwkO2iUK6AL5sy02
         7SjB+HEMp+BXorBndR6oyC1l611CmK8mf/PFWHZE2aLrvl9db5DMRVw+B5llmBoA59
         bNZg685EYovI5MtvZDxBmTXx80qsrDQipFm6IX54=
Date:   Tue, 8 Feb 2022 10:33:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Use kzalloc() with GFP_ATOMIC in
 atomic context
Message-ID: <YgI40Dm/ar+IubIA@kroah.com>
References: <20220206225943.7848-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220206225943.7848-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2022 at 11:59:43PM +0100, Fabio M. De Francesco wrote:
> Use the GFP_ATOMIC flag of kzalloc() with two memory allocation in
> rtw_set_key(). This function is called while holding spinlocks and with
> disabled bottom halves, therefore it is not allowed to sleep. With the
> GFP_ATOMIC type flag, the allocation is high priority and cannot sleep.
> 
> This issue is detected by Smatch which emits the following warning:
> drivers/staging/r8188eu/core/rtw_pwrctrl.c:79 ips_leave() warn: sleeping in atomic context
> drivers/staging/r8188eu/core/rtw_pwrctrl.c:81 ips_leave() warn: sleeping in atomic context
> 
> The calls chain (in reverse order) is the following:
> 
> rtw_set_key()
> -> ips_leave()
> -> -> rtw_pwr_wakeup()
> -> -> -> rtw_set_802_11_disassociate()
> 
> The disabilitation of bottom halves and the acquisition of a spinlock is in
> rtw_set_802_11_disassociate().
> 
> After the changes, the post-commit hook output the following messages:
> 
> CHECK: Prefer kzalloc(sizeof(*pcmd)...) over kzalloc(sizeof(struct cmd_obj)...)
> +       pcmd = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
> 
> CHECK: Prefer kzalloc(sizeof(*psetkeyparm)...) over kzalloc(sizeof(struct setkey_parm)...)
> +       psetkeyparm = kzalloc(sizeof(struct setkey_parm), GFP_ATOMIC).
> 
> According to the above "CHECK[S]", use the preferred style in the first
> kzalloc().
> 
> Fixes: 79f712ea994d ("staging: r8188eu: Remove wrappers for kalloc() and kzalloc()")
> Fixes: 15865124feed ("staging: r8188eu: introduce new core dir for RTL8188eu driver")
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_mlme.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
> index 038bddc361c3..860835e29b79 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme.c
> @@ -1600,12 +1600,12 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
>  	struct mlme_priv		*pmlmepriv = &adapter->mlmepriv;
>  	int	res = _SUCCESS;
>  
> -	pcmd = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
> +	pcmd = kzalloc(sizeof(*pcmd), GFP_ATOMIC);
>  	if (!pcmd) {
>  		res = _FAIL;  /* try again */
>  		goto exit;
>  	}
> -	psetkeyparm = kzalloc(sizeof(struct setkey_parm), GFP_KERNEL);
> +	psetkeyparm = kzalloc(sizeof(*psetkeyparm), GFP_ATOMIC);

You are making two different changes here.  Please do the first patch to
change the sizeof() change to fix up checkpatch, and then the second one
for the GFP_ATOMIC change so that if there is a problem with either of
them we can only revert the offending change.

thanks,

greg k-h
