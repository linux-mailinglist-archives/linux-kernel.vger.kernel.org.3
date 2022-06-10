Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5893F546E1C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 22:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348510AbiFJUPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 16:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346780AbiFJUPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 16:15:09 -0400
Received: from mailrelay2-1.pub.mailoutpod1-cph3.one.com (mailrelay2-1.pub.mailoutpod1-cph3.one.com [46.30.210.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB0B22FA2C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 13:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
         message-id:subject:cc:to:from:date:from;
        bh=Qwc3jsYGMMqT1lMF2ZePT2cA2lu7ug+Aeub0TRrh9pA=;
        b=WelP2lHu1IHe3N39oxt9HPTXlfnXtbCFHbD6GEhf/BzCoGQKmrpf7WS+xF6IPQhR/QqQJLOm9qbAZ
         ozEtKlvUQfNFjk++65zl8TM53oSMkZqIuRiwCzv/YLUZVMdoR7t4vDB/3g5HtNZ6gZSZyKkTn51+c2
         bn0ssN619PoWC+O4Mc6TLFPFg81hMwInDd1lqiJn1d4jxQrro/8CcIWD4LRS5voKswV5wK43rLb4i1
         DfPI9P9qG4NokM+uC/jrTWzKz4EXwnwrIQ5btMyfctc3E5cAc9bNa2E/PraMx9NerR89/3L/UXoIG6
         GwRl0x6wqkZHGrWQ6SSvSs2UoL0pF/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
         message-id:subject:cc:to:from:date:from;
        bh=Qwc3jsYGMMqT1lMF2ZePT2cA2lu7ug+Aeub0TRrh9pA=;
        b=phIPlxmJsn1++tDLUpQijJ4FZv0izyRz7Rh7GRVjWFbN1liI24Tw4viIRjW4OpofNTQhum8TRYOw+
         QHg2960DQ==
X-HalOne-Cookie: d4be63dccea4d9e47b03f38a7de073a9517d9143
X-HalOne-ID: 02ffdc44-e8fa-11ec-a912-d0431ea8a290
Received: from mailproxy3.cst.dirpod3-cph3.one.com (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 02ffdc44-e8fa-11ec-a912-d0431ea8a290;
        Fri, 10 Jun 2022 20:15:03 +0000 (UTC)
Date:   Fri, 10 Jun 2022 22:15:01 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/3] drm/panel: panel-dsi-cm: Use backlight helpers
Message-ID: <YqOmRTVGQMXy2HVM@ravnborg.org>
References: <20220607182026.1121992-1-steve@sk2.org>
 <20220607182026.1121992-3-steve@sk2.org>
 <20220609215236.ojxw6l2vkf652hgu@mercury.elektranox.org>
 <20220610194720.485cf7be@heffalump.sk2.org>
 <YqObYPttYuRDikrO@ravnborg.org>
 <20220610215236.0d5d47b7@heffalump.sk2.org>
 <20220610215606.5c7a97b9@heffalump.sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220610215606.5c7a97b9@heffalump.sk2.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,
> > > > 
> > > > Thanks, I’ll wait a little more to see if there are any other reviews of
> > > > the patches and then push a v2 with that fix.    
> > > It would be very nice if you could kill all uses of FB_BLANK in the
> > > drivers/gpu/drm/panel/* drivers, and post them as one series.
> > > This is long overdue to introduce the backlight helpers.
> > > 
> > > The three you posted is already a nice step forward, and there may be
> > > more panel drivers I have missed.  
> > 
> > With this series on top of 5.19-rc1, the only remaining .fb_blank reference
> > is in acx565akm_backlight_init() in panel-sony-acx565akm.c; I was planning
> > on nuking that along with the other .fb_blank initialisers in a series
> > removing .fb_blank entirely from backlight_properties. I’ll add it as a
> > fourth patch for drm/panel if that makes things easier!
> 
> That’s in drivers/gpu/drm/panel of course, there are a few others elsewhere
> (I’ve got patches in flight for most of them, I’ve got the rest ready for
> submission).
> 
> > There will still be references to FB_BLANK constants since they’re used for
> > backlight_properties.power values. Would it make sense to rename those?
> 
> Just to make sure — I’m cleaning up backlight_properties.fb_blank, not
> fb_ops.fb_blank. I wasn’t planning on touching the latter...

Nuking props.fb_blank - that a fine goal - so keep focus there.
We can then later revisit the other clean-up possibilities.

Since you do this tree-wide do not do the mistake and try to cover too
much at the same time, because then you never finish.
So forget my comment for now and keep up the good work on removing
props.fb_blank.

	Sam
