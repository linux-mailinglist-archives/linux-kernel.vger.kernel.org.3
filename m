Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534E94F0061
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 12:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354266AbiDBKPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 06:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354255AbiDBKPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 06:15:19 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6BD34647
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 03:13:26 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id u26so5582570eda.12
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 03:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nq7rsHg8A3iBgRJPmTpgXY1OAM+6fX6NYBzTSzTX1C4=;
        b=CTwZbdYvrj4KAu0xHRfcJUQGyWJaqzAOfCiguc/crzFxDm2B7eKW5F2KudW+/zpD4h
         ENeIVrF38WevKHfBGdtUAtVLwHbjAlNvHiGllWuMkg3t7SNnyktQ/wfYmk2Iu57V7Hqh
         p1RVlMCOrWp/kou0x5bp8xAazC2aiox4Gyb15wS0KL8ReMTgj6mC3siHhSbTWB9u6vzp
         iodgdPSC0x7qOoFuAM5Ls52XjBLpHTZY3glwRBtFswt9TBj6rrawGSKbATE5IroqfN7H
         GFNKHu9mUNTqTUtf1m6EnqQJGKTFY/iOp4Y73YsDUmiIBparj1N4WCQpByskqMRv4snO
         me7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nq7rsHg8A3iBgRJPmTpgXY1OAM+6fX6NYBzTSzTX1C4=;
        b=4ZX6MyLBjfi/MjtM9EIwrzt+9GhK7iyQyg7QDIejTwVAPz5PghHyCaW8BcuA9QBhSv
         1Z7czNfI0zy44D3g55Iol3pguasBC70lP4q7t5lC7RK/OX5Y/lJ2EE20Fp/MoWdLKlht
         Ab6U3gG6iHTyGoqKC/YpL4vSPBW/WHh6m0Rbpu/AGkzZoWB/RuzUavmAA7it1Uxh3gOg
         lukgh8hXjw/Clpxf9b8UX445+3QVPr/u4pCeTwESRAq45DPUaj4MfltZQQ58SRBmlKYz
         IswSmifo5AdfcIlGvbZBlJmOlyLLnZ6XRWxm7lX+XYnJDQ6Q88Flu7bX8yxLZnhAzZ9S
         0kHA==
X-Gm-Message-State: AOAM532V8Qnrg4tc/fswJdvb4/e4QFOq4bQG40UihU5JlDXKJnXnV0Gp
        GYeJtwi4yug9OBVKL/mitqX1ACwoS80=
X-Google-Smtp-Source: ABdhPJzqJkyefi7J2cWzB2Ryqz9jNoMNznjyESx9VUbicGy3kNqEj5pQvaHy6jaGftlqgmnLWXAdjg==
X-Received: by 2002:a05:6402:13d6:b0:419:2eab:d21 with SMTP id a22-20020a05640213d600b004192eab0d21mr24687793edx.78.1648894405231;
        Sat, 02 Apr 2022 03:13:25 -0700 (PDT)
Received: from leap.localnet (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id gq12-20020a170906e24c00b006e067c93e1bsm1929807ejb.39.2022.04.02.03.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:13:23 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: r8188eu: Remove goto to no-op exit label
Date:   Sat, 02 Apr 2022 12:13:20 +0200
Message-ID: <1724388.VLH7GnMWUR@leap>
In-Reply-To: <YkdjhGtMwnbJcz+P@iweiny-desk3>
References: <20220401183513.26222-1-fmdefrancesco@gmail.com> <YkdjhGtMwnbJcz+P@iweiny-desk3>
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

On venerd? 1 aprile 2022 22:41:40 CEST Ira Weiny wrote:
> On Fri, Apr 01, 2022 at 08:35:13PM +0200, Fabio M. De Francesco wrote:
> > In function rtw_free_netdev() there are two "goto" jumps to a no-op exit
> > label called "RETURN". Remove the label and return in line.
> 
> Thanks for the patch!  However, A good commit message lists the why and what of
> a change.  I don't see a why for this commit?

Yes I forgot the "why" :(
I'll rework the commit message for v2.

> 
> FWIW (For what it's worth) I know of a couple of good reasons for this change
> but you should get in the habit of putting that in the commit message.  Even
> for obvious things like this.
> 
> Anyway, I think this patch can stand on it's own with an updated commit
> message.  However, see below...
> 
> > 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  drivers/staging/r8188eu/os_dep/osdep_service.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
> > index 7a6fcc96081a..d680bfba7f5d 100644
> > --- a/drivers/staging/r8188eu/os_dep/osdep_service.c
> > +++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
> > @@ -117,18 +117,15 @@ void rtw_free_netdev(struct net_device *netdev)
> >  	struct rtw_netdev_priv_indicator *pnpi;
> >  
> >  	if (!netdev)
> > -		goto RETURN;
> > +		return;

Actually this function doesn't need to test for a valid "netdev". There are only
two callers of this function (they are in os_dep/usb_intf.c) and they already test
the pointer soon before calling rtw_free_netdev().

Therefore, I'll remove the test for a valid "netdev" and (obviously) the code has
no more need to return at that point in function.

> >  
> >  	pnpi = netdev_priv(netdev);
> >  
> >  	if (!pnpi->priv)
> > -		goto RETURN;
> > +		return;

I cannot see how pnpi->priv might ever be NULL. Pavel Skripkin made me notice
that "in rtw_alloc_etherdev() (I can confirm this information because now I've 
just read the code), if pnpi->priv allocation fails, then netdev will
be just freed.". If "netdev" is already free, this function is never called.

Therefore, I'll remove this test too.

> This does not look right.  If netdev is not NULL why does this function skip
> free_netdev()?

After the two removals I've talked about above, the code will always call 
vfree(pnpi->priv) and then free_netdev(netdev).

Therefore, the code won't anymore skip free_netdev() and the bug is avoided.

> 
> Fabio could you follow up with Larry and/or Phillip and see why the code does
> this?  To me it looks like a potential bug.
> 
> Thanks!
> Ira
> 
> >  
> >  	vfree(pnpi->priv);
> >  	free_netdev(netdev);
> > -
> > -RETURN:
> > -	return;
> >  }
> >  
> >  int rtw_change_ifname(struct adapter *padapter, const char *ifname)
> > -- 
> > 2.34.1
> > 
> 

This is how I think to rework rtw_free_netdev():

void rtw_free_netdev(struct net_device *netdev)
{
        struct rtw_netdev_priv_indicator *pnpi = netdev_priv(netdev);

        vfree(pnpi->priv);
        free_netdev(netdev);
}

Am I missing something?

@Greg: please discard this patch; I'll send another that has the purpose
to rework rtw_free_netdev() as I showed above for the purpose to avoid 
redundant tests and avoid the potential skipping of free_netdev() (as Ira 
has correctly noted, currently we have a bug).

Thanks,

Fabio


