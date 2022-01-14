Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4781A48E1A5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 01:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238484AbiANAm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 19:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbiANAmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 19:42:55 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424DAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 16:42:55 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so4756820wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 16:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PdLaFJ7mQpkrAJQLB818USTGDL7xDCP3yDj71WsdZOc=;
        b=ermvpzRfAeXvbQoW/NU+Nyz8KsVNsA+9MkTJMeZnzvAz8noUZtj+DIoLp5KH1pToY4
         nO0EcZKTo7/CBd8fwseqhxZuZzaCHgJg9Y2wIvKJYLU5D/pFkPrlnUmgU+Ybmr6f3MJ9
         Obj1b+Gqt3LebbsYskHDf/TCCDEMVW+3d5QAkrVU+cdkhnB+3pAYe91cUowL6COSHauy
         MXdA8+dbSBPlLz3HO5z6XyXFzk2vb1FqVrAy7M/gEI61kT9hhiuv0C3lEj4UTEkSqjuN
         FNh1Gf/Q/aIy0ZzMC8Ps0iX31+vJScTapecJ0dqLUmQOPG4pRQMs1P2pRhErlF/mkIED
         WGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PdLaFJ7mQpkrAJQLB818USTGDL7xDCP3yDj71WsdZOc=;
        b=WdsdqemgYovjb17u/HhHT3Grvdg69JO5FtPBQyYjCtHedNqQI+1kIk9RpGfuphh/q/
         CTMdzgINetyQTq3cklbc+NQ2PabJWu4edGJ84vzZKqB+ib08ZdmWexcHojFIYtaeiPlX
         2r90NFtfyWu+nI75dKJjJ7bNmXsY3xVYJOh3WfJUww679vuUnJjeSkI7ioBisADCrdB7
         NmpxaIbhPQxfezWp+FMIEPB/qWoD/VpmEloUhIl9vo2z8yET65phTwR8HZ7JVRPoPIk2
         ms8feaPwZp6j3ai9xBeZK8gU7Lpg4/HJFHhXxXOdYTfEf/Cc3dVFmuYxmhGBz1M+JdlF
         t+xw==
X-Gm-Message-State: AOAM533tGZiaIVi1HNspwkmPOPYjPHyfRQ7UzyIZPbnlOtpTFd675Sbi
        tR7WeqSRu0mc1tnUxTCI0odwdVPgxrEd8Q==
X-Google-Smtp-Source: ABdhPJzBs1bQyASATtj77sp9ccpf3cUeDakj6icFSLtQN2uQCU+yX18t3BthUb6wWC0qkOFApNc4xQ==
X-Received: by 2002:a05:600c:4e46:: with SMTP id e6mr6117400wmq.132.1642120973799;
        Thu, 13 Jan 2022 16:42:53 -0800 (PST)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id bk17sm3594437wrb.105.2022.01.13.16.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 16:42:53 -0800 (PST)
Date:   Fri, 14 Jan 2022 00:42:50 +0000
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] staging: r8188eu: convert DBG_88E calls in
 core/rtw_iol.c
Message-ID: <YeDHCtZ+hy0Q+ZXV@equinox>
References: <20220109215427.887-1-phil@philpotter.co.uk>
 <20220109215427.887-4-phil@philpotter.co.uk>
 <20220110100843.GC1951@kadam>
 <YdydYlpVzHoLy2Wh@equinox>
 <20220111050644.GD1951@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111050644.GD1951@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 08:06:44AM +0300, Dan Carpenter wrote:
> On Mon, Jan 10, 2022 at 08:56:02PM +0000, Phillip Potter wrote:
> > On Mon, Jan 10, 2022 at 01:08:43PM +0300, Dan Carpenter wrote:
> > > On Sun, Jan 09, 2022 at 09:54:23PM +0000, Phillip Potter wrote:
> > > > Convert the DBG_88E macro calls in core/rtw_iol.c to use pr_debug
> > > > or netdev_dbg appropriately, as their information may be useful to
> > > > observers, and this gets the driver closer to the point of being
> > > > able to remove DBG_88E itself.
> > > > 
> > > > Some calls are at points in the call chain where use of dev_dbg or
> > > > netdev_dbg isn't possible due to lack of device pointer, so plain
> > > > pr_debug is appropriate here.
> > > > 
> > > > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > > > ---
> > > >  drivers/staging/r8188eu/core/rtw_iol.c | 10 ++++++----
> > > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/r8188eu/core/rtw_iol.c b/drivers/staging/r8188eu/core/rtw_iol.c
> > > > index 7e78b47c1284..923da2a9f6ae 100644
> > > > --- a/drivers/staging/r8188eu/core/rtw_iol.c
> > > > +++ b/drivers/staging/r8188eu/core/rtw_iol.c
> > > > @@ -12,13 +12,15 @@ struct xmit_frame	*rtw_IOL_accquire_xmit_frame(struct adapter  *adapter)
> > > >  
> > > >  	xmit_frame = rtw_alloc_xmitframe(pxmitpriv);
> > > >  	if (!xmit_frame) {
> > > > -		DBG_88E("%s rtw_alloc_xmitframe return null\n", __func__);
> > > > +		netdev_dbg(adapter->pnetdev,
> > > > +			   "rtw_alloc_xmitframe return null\n");
> > > 
> > > You're going to have to send this anyway because of the compile issue.
> > > 
> > > I feel like you are not being aggressive enough in the debug messages
> > > that you delete.  For example, this one should definitely be deleted.
> > > Don't print an error message for alloc failures.
> > > 
> > > It would be easier to Ack a mass delete of these messages.
> > > 
> > > regards,
> > > dan carpenter
> > > 
> > 
> > Dear Dan,
> > 
> > Thank you for your feedback. I already sent a V2 series to fix the empty case
> > label I left in core/rtw_mlme_ext.c, sounds like a V3 is needed though 
> > based on this feedback - admittedly I have tried to be conservative and
> > basically only removed commented DBG_88E calls or calls which just print the
> > function name/line number so far.
> 
> Yeah.  I saw v3.  It's fine.  I'm not really trying to nak your patches.
> 
> > 
> > I get what you're saying about deleting them all just being easier,
> > but I've already converted several in previous series that have
> > made it in. It would make sense to delete these converted calls as well
> > if going for the total deletion approach. Also, I do worry some of the
> > info could be useful. I'd appreciate your thoughts on this.
> > 
> > I am happy to delete it all by all means, just want to make sure majority
> > would be happy with that approach, as opposed to a refinement of this
> > approach and being more judicious with deletion of more DBG_88E calls.
> 
> In the original code DBG_88E was kind of an error level severity message
> not a debug level severity.  Of course, you had to use a module option
> to turn on any output at all so it's hard to judge how that works in
> real life.  By making them debug level severity, you've basically
> deleted them already...  Don't be a hoarder.
> 
> Once you change it to dev_dbg() then it becomes more difficult
> emotionally to do a mass delete.
> 
> There is a real value to just deleting stuff.
> 
> regards,
> dan carpenter

Thanks Dan,

OK - based on what you've said, I will make a series to just remove all
DBG_88E calls, including any I've already converted that have been
merged, and also the aliased versions that are defined via additional
preprocessor directives.

Greg - please could you disregard this series and the previous smaller
one I sent? The new series will supersede them both when it's ready.
Many thanks.

Regards,
Phil
