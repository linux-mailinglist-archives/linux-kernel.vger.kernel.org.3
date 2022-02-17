Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B384B9C13
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238695AbiBQJcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:32:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237306AbiBQJce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:32:34 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F63F1A3B6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 01:32:20 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k127-20020a1ca185000000b0037bc4be8713so5679511wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 01:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nbXYhw8dgoBziBxoGAo22rvr5bNzjQ5ucWxP7h7o2B8=;
        b=CeCHv6teUMuPC/sZNjh3SNiO72NIUgD+NSubxrOwOB8OUOadK9Ag9DlSSAK1R6B6wH
         hUIOshX680Xz55BPdqtdlG0P6FgIlPdPvh3nEfJ6XJ/JCvmtNugY8ePOlRK3KzFWyEE3
         3ZDmmfc4T4FQrIybwGlODuPpVcUgkWukOubW0H59wt4MIJaJoT09FP4ABpT01oHylXhH
         BtWflGNeCj1PARxLwhj/jfphLkmRJ6xRBkeNphZf7q6Bz92+8Pt0rdP22ivdQfGkFsaR
         mP5IPRxY/XmOyVJtrfFCkzRW4gAT3GvquXxf0XmdyldAUAet+jbQQCBEG6szYj/fzmjT
         QbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nbXYhw8dgoBziBxoGAo22rvr5bNzjQ5ucWxP7h7o2B8=;
        b=AlZXhtl0s8cqze691coaMIrcC+Pg6SnDxKHFt2P4n9/bJGwj8MnVODp9z5B4RM/PvT
         xwmqzO+obGV9DoKozRY6OSVV9YyO5ZokqKjQKLmRPnoKRw+HqV83I49yC9DC9o9cfuEQ
         8aYXYMyKm4OpQPaAV/pl8zrSJCc7+zYX2Ilt/rDHWEeIpz3vxsDI7Day5h3SNsbMwU9u
         xXFHTwT6m48MlsuGMLv9Pj+Xe71weMaRba6pJ1NjPlEuDHrFzE2PhPi9C2H7w4BQE9zz
         ihcXXQrBhbblW+8ylJJlU3BnUTymQ8arqUusMJ5w9PpymXz+YN+j1bd7MBdiseEZQVMS
         J/9g==
X-Gm-Message-State: AOAM532lfF6xH+37WIAlnfPkaaRO6K1YUbmUk70JgWpwhTDksqGzuE3Y
        TeyV9XrMP7kC9SWFfusWeSE=
X-Google-Smtp-Source: ABdhPJxRNLwCDd9nmp+raZKa4cBctVx6tmXCI47K8udxt40tReAq7npn1n/BSyUmtQ6x/t4795b9mQ==
X-Received: by 2002:a7b:c932:0:b0:346:35f6:e81 with SMTP id h18-20020a7bc932000000b0034635f60e81mr1903292wml.15.1645090338480;
        Thu, 17 Feb 2022 01:32:18 -0800 (PST)
Received: from leap.localnet (host-79-27-0-81.retail.telecomitalia.it. [79.27.0.81])
        by smtp.gmail.com with ESMTPSA id c5sm7606994wrq.102.2022.02.17.01.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 01:32:15 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] staging: r8188eu: Use kzalloc() with GFP_ATOMIC in atomic context
Date:   Thu, 17 Feb 2022 10:32:13 +0100
Message-ID: <8028416.T7Z3S40VBb@leap>
In-Reply-To: <YgvQZDBLCsvwTtJM@kroah.com>
References: <20220208180426.27455-1-fmdefrancesco@gmail.com> <20220208180426.27455-3-fmdefrancesco@gmail.com> <YgvQZDBLCsvwTtJM@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On marted? 15 febbraio 2022 17:10:12 CET Greg Kroah-Hartman wrote:
> On Tue, Feb 08, 2022 at 07:04:26PM +0100, Fabio M. De Francesco wrote:
> > Use the GFP_ATOMIC flag of kzalloc() with two memory allocation in rtw_set_key() 
> > because it is not allowed to sleep while it executes in atomic context.
> > 
> > With the GFP_ATOMIC type flag, the allocation is high priority and thus it 
> > cannot sleep.
> > 
> > This issue is detected by Smatch which emits the following warning:
> > 
> > "drivers/staging/r8188eu/core/rtw_mlme.c:1603 rtw_set_key() warn: sleeping in atomic context".
> > 
> > Fixes: 79f712ea994d ("staging: r8188eu: Remove wrappers for kalloc() and kzalloc()")
> > Fixes: 15865124feed ("staging: r8188eu: introduce new core dir for RTL8188eu driver")
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  drivers/staging/r8188eu/core/rtw_mlme.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
> > index f5b2df72e0f4..860835e29b79 100644
> > --- a/drivers/staging/r8188eu/core/rtw_mlme.c
> > +++ b/drivers/staging/r8188eu/core/rtw_mlme.c
> > @@ -1600,12 +1600,12 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
> >  	struct mlme_priv		*pmlmepriv = &adapter->mlmepriv;
> >  	int	res = _SUCCESS;
> >  
> > -	pcmd = kzalloc(sizeof(*pcmd), GFP_KERNEL);
> > +	pcmd = kzalloc(sizeof(*pcmd), GFP_ATOMIC);
> >  	if (!pcmd) {
> >  		res = _FAIL;  /* try again */
> >  		goto exit;
> >  	}
> > -	psetkeyparm = kzalloc(sizeof(*psetkeyparm), GFP_KERNEL);
> > +	psetkeyparm = kzalloc(sizeof(*psetkeyparm), GFP_ATOMIC);
> >  	if (!psetkeyparm) {
> >  		kfree(pcmd);
> >  		res = _FAIL;
> > -- 
> > 2.34.1
> 
> What code path is calling this in atomic context?
> 
> thanks,
> 
> greg k-h
> 
I blindly trusted Smatch and didn't check properly :(

Now I'm pretty sure that all(?) the code paths that lead to those kzalloc() do 
not call rtw_set_key() in atomic context.

The only calls chain that seemed to call rtw_set_key() in atomic context was 
rtw_set_key() <- ips_leave() <- _rtw_pwr_wakeup() <- rtw_set_802_11_disassociate() 
but Smatch (and I) missed that, immediately before calling ips_leave(), an 'if'
condition makes _rtw_pwr_wakeup() exit and return to rtw_set_802_11_disassociate().

Therefore, please drop this patch.

Thanks,

Fabio M. De Francesco  



