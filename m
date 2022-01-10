Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657B048A13C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343697AbiAJU4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343690AbiAJU4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:56:06 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75B3C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 12:56:05 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h10so18983404wrb.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 12:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NH00wvgzSBu075ZlsRFt1eAfhX6GcrnxDSDE9TnCjtE=;
        b=fHaJAlljhP2NPoLA1IsGrrExlEisLMnvA2pphAZUHGUjYOP6HHSxbYhnHcHAtK3nRT
         jG1Mp9EvF/dKdqgh+VG/9UuBtP1+Y2UHoA9mIEMOhttkodV7F7pcVKb3OGnMEqvLnifF
         hYLCQp6Nh0aRUcXMIzuDfh9zHlC/8cHBQpNIREpGJTMTbi8Qagt96DetpLuOJuFfz5rZ
         lhITB9gYByn4l9VEtwCABrdDTIV1qhZxb9Y1G3VsG8dqmqLb5TWATNyjDaVfhZUzk2Pa
         UF57vJzE6KGF/ThdG80S0e7h7V7sYnTbN5gEPg+ipzqqYefXzCcp5x2rG5UtpWb4VxJ3
         OWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NH00wvgzSBu075ZlsRFt1eAfhX6GcrnxDSDE9TnCjtE=;
        b=5NGz1KPhEqaiHUeaMK2D1hwLIFKoV0nYr7RWUluI9gqc0oJLRm9cw8mZFuPUAAHlGL
         Baut6k5D51OxAij4yy7m/N6dJ6y+DtacprdVZo8QrMeVqhipSiiiIvZNMkY0MRuxJMqy
         nd/shdT5bLGRnQjTP6egJ/Ho3i1e8xZ6OBuL2O/+DQi/k2gxnIGMSF9Pf2dxjsUpeseE
         jQozcNzDVqmbuM7lMa+XUC7kdi/6uREaZiyJ1GmMJugIZC11Mn6pLBg247PHdN2X1H3X
         K+NbwCuE2HLjFn/I5RMiSs3GC+Mg2snquMid7JzHbBlUYUJOjg5C5KJK7h3lHcPEAOKm
         uBQA==
X-Gm-Message-State: AOAM533GjxZX0hyQm6yc+jsLtQpe+ZWLs0dqpatqu56cURrs7IIJzcFB
        QkS7OyncVmuOZfBMYW4pULq/Vg==
X-Google-Smtp-Source: ABdhPJys17cBO+N6fWfnZJiSmxn+PAF0SxFfWG5jY3SMFiSjvHV2cbjLdn/b6eW4S15O5I9L+u0r7g==
X-Received: by 2002:a5d:4c4d:: with SMTP id n13mr1104632wrt.641.1641848164366;
        Mon, 10 Jan 2022 12:56:04 -0800 (PST)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id p18sm7999858wmq.23.2022.01.10.12.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 12:56:03 -0800 (PST)
Date:   Mon, 10 Jan 2022 20:56:02 +0000
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] staging: r8188eu: convert DBG_88E calls in
 core/rtw_iol.c
Message-ID: <YdydYlpVzHoLy2Wh@equinox>
References: <20220109215427.887-1-phil@philpotter.co.uk>
 <20220109215427.887-4-phil@philpotter.co.uk>
 <20220110100843.GC1951@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110100843.GC1951@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 01:08:43PM +0300, Dan Carpenter wrote:
> On Sun, Jan 09, 2022 at 09:54:23PM +0000, Phillip Potter wrote:
> > Convert the DBG_88E macro calls in core/rtw_iol.c to use pr_debug
> > or netdev_dbg appropriately, as their information may be useful to
> > observers, and this gets the driver closer to the point of being
> > able to remove DBG_88E itself.
> > 
> > Some calls are at points in the call chain where use of dev_dbg or
> > netdev_dbg isn't possible due to lack of device pointer, so plain
> > pr_debug is appropriate here.
> > 
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > ---
> >  drivers/staging/r8188eu/core/rtw_iol.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/r8188eu/core/rtw_iol.c b/drivers/staging/r8188eu/core/rtw_iol.c
> > index 7e78b47c1284..923da2a9f6ae 100644
> > --- a/drivers/staging/r8188eu/core/rtw_iol.c
> > +++ b/drivers/staging/r8188eu/core/rtw_iol.c
> > @@ -12,13 +12,15 @@ struct xmit_frame	*rtw_IOL_accquire_xmit_frame(struct adapter  *adapter)
> >  
> >  	xmit_frame = rtw_alloc_xmitframe(pxmitpriv);
> >  	if (!xmit_frame) {
> > -		DBG_88E("%s rtw_alloc_xmitframe return null\n", __func__);
> > +		netdev_dbg(adapter->pnetdev,
> > +			   "rtw_alloc_xmitframe return null\n");
> 
> You're going to have to send this anyway because of the compile issue.
> 
> I feel like you are not being aggressive enough in the debug messages
> that you delete.  For example, this one should definitely be deleted.
> Don't print an error message for alloc failures.
> 
> It would be easier to Ack a mass delete of these messages.
> 
> regards,
> dan carpenter
> 

Dear Dan,

Thank you for your feedback. I already sent a V2 series to fix the empty case
label I left in core/rtw_mlme_ext.c, sounds like a V3 is needed though 
based on this feedback - admittedly I have tried to be conservative and
basically only removed commented DBG_88E calls or calls which just print the
function name/line number so far.

I get what you're saying about deleting them all just being easier,
but I've already converted several in previous series that have
made it in. It would make sense to delete these converted calls as well
if going for the total deletion approach. Also, I do worry some of the
info could be useful. I'd appreciate your thoughts on this.

I am happy to delete it all by all means, just want to make sure majority
would be happy with that approach, as opposed to a refinement of this
approach and being more judicious with deletion of more DBG_88E calls.

Thanks again,
Phil
