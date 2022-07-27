Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3475826F2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiG0Mrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiG0Mrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:47:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4896A1CB26
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 05:47:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E328B60ABB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 12:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCAAC433D6;
        Wed, 27 Jul 2022 12:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658926051;
        bh=XuFtqN23dSuIFq0y8p4ETr/6CgsJu41LfPO3wuUj/lY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yeunWGh0a5i/Djb0trgDdUL+hy2MDxqaZrOOCm91Jn0Olo2lWsYiDcNiBD974/r9r
         AhMrHqGaMPI4pYsS0azgpSUffKtA5TReurhfdtFX2QL8YvUlgCLmDsPjeycy9tAPAY
         T0/miobKalnlMbuY4EYxjFQKOd9pQsATejIHUHOw=
Date:   Wed, 27 Jul 2022 14:47:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Phillip Potter <phil@philpotter.co.uk>, Larry.Finger@lwfinger.net,
        paskripkin@gmail.com, straube.linux@gmail.com, martin@kaiser.cx,
        abdun.nihaal@gmail.com, philipp.g.hortmann@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: convert rtw_pwr_wakeup to correct
 error code semantics
Message-ID: <YuEz4Edtp8J3Honj@kroah.com>
References: <20220725220745.12739-1-phil@philpotter.co.uk>
 <YuDcKoSibAo93a6P@kroah.com>
 <20220727124342.GR2316@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727124342.GR2316@kadam>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 03:43:42PM +0300, Dan Carpenter wrote:
> On Wed, Jul 27, 2022 at 08:33:14AM +0200, Greg KH wrote:
> > > diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
> > > index cf9020a73933..8b1c50668dfe 100644
> > > --- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
> > > +++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
> > > @@ -381,24 +381,24 @@ int rtw_pwr_wakeup(struct adapter *padapter)
> > >  	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
> > >  	unsigned long timeout = jiffies + msecs_to_jiffies(3000);
> > >  	unsigned long deny_time;
> > > -	int ret = _SUCCESS;
> > > +	int ret = 0;
> > >  
> > >  	while (pwrpriv->ps_processing && time_before(jiffies, timeout))
> > >  		msleep(10);
> > >  
> > >  	/* I think this should be check in IPS, LPS, autosuspend functions... */
> > >  	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
> > > -		ret = _SUCCESS;
> > > +		ret = 0;
> > 
> > Nit, you don't need to set this again, as you already set it above to 0.
> > 
> 
> I would sort of prefer to drop the initialization and keep this one.

Fine with me, either works.

greg k-h
