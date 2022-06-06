Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167DC53E362
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbiFFHuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 03:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiFFHuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 03:50:06 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C8BB1C1B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 00:50:04 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so7469484wmz.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 00:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+jmhoqJpyhhqIncv/yIeyyd/Y7l7QLXlTo6Fm8J66hI=;
        b=lXwodVqB/aZL/jAQr9I+EKcA0rIfagTQm795hCwZ3uihpRIm57OwyCNbL/9W7PWT2g
         rclgEfmrPiF17ujHyQaz+gePe8WfKfwJSu/U2hzTMj6wyogPV+MCBhSODc6a3BZdK0vf
         P89gvCJgacyuYx6FG6qeenmabsljmIhffnDiXBhQNYLyEd3dv3eWh38zOWCYeGdNM1r3
         U7+pqIfLhIxzXvEyBd3oD6TRxq7xA8XROTzWZUrhn0sMYZskSWYy3i7C09Q5rYN59M74
         w2Kp0CQvwVO+y+udKWWFlroWWqCrRMpGUjJhHuWA8ddw3SMD9+m9935pquMDog+Vgw9n
         YN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+jmhoqJpyhhqIncv/yIeyyd/Y7l7QLXlTo6Fm8J66hI=;
        b=fGXTtVXQDCAYzUMaN2Bt2FSOm8oKi6Fn8D2aR8vUOH/v4MgikhW5f9NzlkfxMgZD8y
         nPYJ6vPxDrDytpJPFvRe0tX9wWUY13rvDRVrK/lsLoFDKrWj0TH4It5IulYJhBYgIKsG
         a1J3xQ61MyNdWUCGy7isoIzcPqHdgb+TXCsbNH0y94BXalDWB/wW+Ia1CqL5eweyWwJS
         N1n1fCg0rl0i0oYnC5VG5a4tlAZlkk3Y7qsbGrBMNlZfUEXTEVkeTmjF/3tx6r1V37hx
         3ET2oi3u6IxZw5nde/hP8Q2MS+/pYQEuPPi1eTpgqRnxPnotjUv37MYuHItMsAjcXJvx
         yWIA==
X-Gm-Message-State: AOAM531wUP/VbdNhPRbC0pMeJNIFNkHPLBhS4yDMGjDnFF91oaM+eGKb
        ojTU4Ja/7n+wyaxePvuE+8Upow==
X-Google-Smtp-Source: ABdhPJyjhHhqqIjiug39zbvUZTfTFIhox6OzAP8wB57IDE4bopJh028VRe5fS0Vu78RrZ4AitIopZQ==
X-Received: by 2002:a7b:cd84:0:b0:39c:3620:301c with SMTP id y4-20020a7bcd84000000b0039c3620301cmr18421247wmj.19.1654501802906;
        Mon, 06 Jun 2022 00:50:02 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id p5-20020adfce05000000b002102739add8sm17766251wrn.54.2022.06.06.00.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 00:50:02 -0700 (PDT)
Date:   Mon, 6 Jun 2022 08:49:59 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Pavel Skripkin <paskripkin@gmail.com>, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, dan.carpenter@oracle.com,
        fmdefrancesco@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 4/4] MAINTAINERS: add myself as r8188eu reviewer
Message-ID: <Yp2xpxkbvaKLGvvC@equinox>
References: <cover.1652993983.git.paskripkin@gmail.com>
 <7656c9eb3d430524373f4826714f7d205480c3e2.1652993983.git.paskripkin@gmail.com>
 <Yp2VZkfEv2pemEDi@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp2VZkfEv2pemEDi@kroah.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 07:49:26AM +0200, Greg KH wrote:
> On Fri, May 20, 2022 at 12:10:08AM +0300, Pavel Skripkin wrote:
> > I was reviewing r8188eu patches for a while, but I am missing some of
> > them, since I am not in CC list. I want to be CC'ed to help reviewing
> > and testing more patches.
> > 
> > Acked-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> > ---
> > 
> > Changes since v1:
> > 	- Added Dan's Ack. Thanks to Dan! :)
> > 
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0a635f2ae5b9..bd38a2e465cc 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -18716,6 +18716,7 @@ F:	drivers/staging/olpc_dcon/
> >  STAGING - REALTEK RTL8188EU DRIVERS
> >  M:	Larry Finger <Larry.Finger@lwfinger.net>
> >  M:	Phillip Potter <phil@philpotter.co.uk>
> > +R:	Pavel Skripkin <paskripkin@gmail.com>
> 
> For obvious reasons, I can't take changes like this unless the
> maintainers agree with it.
> 
> thanks,
> 
> greg k-h

Hi Greg,

Speaking only for myself of course, I would be happy for Pavel to be
added as a reviewer in MAINTAINERS.

He is helpful and skilful at what he does, and certainly makes up for the
small amount of time I get to spend looking at r8188eu :-)

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Many thanks,
Phil
