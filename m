Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E8058061B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbiGYVDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiGYVDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:03:07 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18218237CB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:03:06 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bn9so6769272wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d+Hqxz4RRPJLCTHSIiVCPF7z5zk8mUqGkNImeYhB/Bo=;
        b=FikTVW+l8ctWpTzOFnFgI3WLbYbqrp23QGZgJrSP7vAi7eQVpsX60nPN4/8fLunpY+
         zsmdymCXZVXl+WT1IPhxGmwaDyTjkrx22g0LWY5V0RSMLtx7IV1T0hfe5G7y6rS0Zt9x
         6U4rrMgymSvPGKZ2FwaHwQ93C7vtg5J278uBuXxOtyl4jfq7PLpRFuUJEnpyIt+/7TuI
         zitVoOC3o3CgqsJi+8EVJO9RodA7synBTpQT2z5LfAkHENp+DL8iTORVR3xms0BWFapJ
         QzuRDi22+u1+lXFfHbmLDFJODfGBTWKxA43P913igBKk8zRssa5BiTZDBZrEks4JIEG1
         qm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d+Hqxz4RRPJLCTHSIiVCPF7z5zk8mUqGkNImeYhB/Bo=;
        b=K3ngrtj749ljif6XbD4qBNJLcuYpcRr08rQT86z1i1YS5V3uDV+nGf4EzUcIMJor6/
         Frweyc03RVkUFPZFHJUmVhvjBSt3uC5i9vS2JPVdzVAmya3HqdShY2bVA5feCieddM2/
         9CKhPMRrfrl3FCgY6yWIlF9SkufNi/MDIMHjd/2H3bn6tTG1D2G3gvJklI4x3g3asHAp
         upd9tVzvzpGNdd0qEKadHGqm5nbFKlOsqHmRT0wlD7ZfdDDGi0fv8owT71rNyLvsJCAj
         LB7hImTqkmVpeHVXsA6jKvcTfAdxLZ0Rl4i4J80XLxywy3LRklP2uZjWztncaOwjb6oa
         t8Gw==
X-Gm-Message-State: AJIora8keXTIrwSPEJr4wNrUq88ppmilQ86zg3uLSeDwrVwjlgOCluu8
        duuT5/l9EAjkONR7O0ke55kO/Q==
X-Google-Smtp-Source: AGRyM1s9H+mH/Qv5InvhcruvLp49I1h5xrIjNR2n3ohTpZdF+kPuTXZEBoSCVCNa3PKZYk/u/iKHSw==
X-Received: by 2002:a5d:5a96:0:b0:21e:6120:edeb with SMTP id bp22-20020a5d5a96000000b0021e6120edebmr8360935wrb.121.1658782984561;
        Mon, 25 Jul 2022 14:03:04 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id bg2-20020a05600c3c8200b003a31b79dc0esm238393wmb.1.2022.07.25.14.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:03:03 -0700 (PDT)
Date:   Mon, 25 Jul 2022 22:03:02 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        paskripkin@gmail.com, straube.linux@gmail.com, martin@kaiser.cx,
        abdun.nihaal@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: convert rtw_pwr_wakeup to correct
 error code semantics
Message-ID: <Yt8FBtHnNCGSZAf/@equinox>
References: <20220724163055.961-1-phil@philpotter.co.uk>
 <20220725104027.GO2338@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725104027.GO2338@kadam>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 01:40:27PM +0300, Dan Carpenter wrote:
> On Sun, Jul 24, 2022 at 05:30:55PM +0100, Phillip Potter wrote:
> > Convert the rtw_pwr_wakeup function to use 0 on success and -EPERM on
> > error - in all places where we handle this response, we use either -1 or
> > -EPERM currently anyway, which are equivalent. Also, for other places
> > along the same call chain where we are using -1, use -EPERM.
> > 
> 
> I can't get behind a change to -EPERM.  Try to pick an appropriate
> error code.  I'm not going to be very strict on it, but we have to at
> least *try*.
> 
> Probably, leave the return -1; lines alone.  Fixing that seems like an
> unrelated change.  We need to do this kind of change but I got bitten by
> it before so I want to avoid that next time.  My reviews will hopefully
> be more careful now.
> 
> > This gets the driver closer to removal of the non-standard _SUCCESS and
> > _FAIL definitions, which are inverted compared to the standard in-kernel
> > error code mechanism.
> > 
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > ---
> >  drivers/staging/r8188eu/core/rtw_p2p.c       |  4 +--
> >  drivers/staging/r8188eu/core/rtw_pwrctrl.c   | 10 +++---
> >  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 32 ++++++++++----------
> >  3 files changed, 23 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
> > index c306aafa183b..bd654d4ff8b4 100644
> > --- a/drivers/staging/r8188eu/core/rtw_p2p.c
> > +++ b/drivers/staging/r8188eu/core/rtw_p2p.c
> > @@ -1888,7 +1888,7 @@ int rtw_p2p_enable(struct adapter *padapter, enum P2P_ROLE role)
> >  
> >  	if (role == P2P_ROLE_DEVICE || role == P2P_ROLE_CLIENT || role == P2P_ROLE_GO) {
> >  		/* leave IPS/Autosuspend */
> > -		if (rtw_pwr_wakeup(padapter) == _FAIL) {
> > +		if (rtw_pwr_wakeup(padapter)) {
> >  			ret = _FAIL;
> >  			goto exit;
> >  		}
> 
> Fine.  The caller now changes from negative error codes to _SUCCESS/_FAIL.
> Later we will transition this to normal error codes so we'll update it
> to preserve the error code from rtw_pwr_wakeup() at that point.
> 
> > diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > index 930bb4aea435..e0ae0c3c51f8 100644
> > --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > @@ -689,7 +689,7 @@ static int rtw_wx_set_mode(struct net_device *dev, struct iw_request_info *a,
> >  
> >  
> >  
> > -	if (_FAIL == rtw_pwr_wakeup(padapter)) {
> > +	if (rtw_pwr_wakeup(padapter)) {
> >  		ret = -EPERM;
> >  		goto exit;
> >  	}
> 
> This code is returning negative error codes so it should preserve the
> code from rtw_pwr_wakeup().
> 
> 	ret = rtw_pwr_wakeup(padapter);
> 	if (ret)
> 		goto exit;
> 
> > @@ -933,13 +933,13 @@ static int rtw_wx_set_wap(struct net_device *dev,
> >  
> >  
> >  
> > -	if (_FAIL == rtw_pwr_wakeup(padapter)) {
> > -		ret = -1;
> > +	if (rtw_pwr_wakeup(padapter)) {
> > +		ret = -EPERM;
> 
> Same.
> 
> >  		goto exit;
> >  	}
> >  
> >  	if (!padapter->bup) {
> > -		ret = -1;
> > +		ret = -EPERM;
> 
> Unrelated.
> 
> >  		goto exit;
> >  	}
> >  
> 
> [ snip ]
> 
> > @@ -1252,13 +1252,13 @@ static int rtw_wx_set_essid(struct net_device *dev,
> >  
> >  	uint ret = 0, len;
> >  
> > -	if (_FAIL == rtw_pwr_wakeup(padapter)) {
> > -		ret = -1;
> > +	if (rtw_pwr_wakeup(padapter)) {
> > +		ret = -EPERM;
> 
> Preserve the error code.
> 
> >  		goto exit;
> >  	}
> 
> regards,
> dan carpenter

Hi Dan,

Thanks very much for the review. I'll get a V2 sent out shortly.

Regards,
Phil
