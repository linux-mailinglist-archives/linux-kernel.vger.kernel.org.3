Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922E44AD6A2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356733AbiBHL1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348926AbiBHKWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:22:45 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E574C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 02:22:44 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k3-20020a1ca103000000b0037bdea84f9cso1256179wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 02:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BHauapHfF44an40hU7SptoMcYixp1Tdu/mmN+fWrOX0=;
        b=Fk0BGpmrbwxjBQEgQt6uMphVKetXH9SZR9GoBX4W396NexTqeuikmBsDorlTwRT83A
         7u5LVWQHFKkJjGj2yLzQtSmDATAshPb8r8tJlWfI/SODzqAOYrcBqkHR1b1ceQwAT8aJ
         2/9Yzu3Fxj0LZqkcIMNsCuj6I38WvRCx6/I+3MLhm/82J1g1fdOtc0drcJJxqoMHjD61
         +fIhGv5V/kMrDlauHejq0wPLTEQl3GuP8eM1nHVXb5imsAEmHho7mqIFhiiKR/2E97H0
         1a8vj8NaH3f0YLEteHY1OepDpWc1t/qCqYndEPVTTBeOpcgjIe9rxZcgq5lleiuLaBhG
         d5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BHauapHfF44an40hU7SptoMcYixp1Tdu/mmN+fWrOX0=;
        b=VESpTpTjzKSkn2mCtRZnUXCRbYdLnptD/1PGG/nG5F3NmukjK2pDWYQ+7mQJA6zlR/
         bW5k0ZeN4xH8WjH3cE/hP69yEUPu4ENVjdbEm/P+Yr8YhF7K5IawnNxjzfiYwLklshAm
         ycDEKTq3jV775KcmTaYarAsPJ+UCUKMA/Bf6tZi8yCADKuFvhhIZVWFHjkwybeZ2L6TY
         86M2KP/NMa2dawZstNuuUdyz6mQ/cKyvd7YqCCX8u2fS/Xd0Am/9wbp+WYl/diYD7Jk7
         khRZUBRnDCyuhgYNWlM41cHwXXd2/3TEXqanInVmlEn9zD44km7UCYkNWijjUaTRdErV
         feUg==
X-Gm-Message-State: AOAM5316ItKijhC+Y7oQDTbcCJ7ca1MuJOyTCP5lv9WljNP2xiZD1mnq
        Xsbf/7m93P6F6PKd9pHQ4SKZ8u34B6I=
X-Google-Smtp-Source: ABdhPJzwSTuri/Ot/vSuTWCPFQ+TtGdyyI9rLcI7XYBZKk7vGgftFQ9Qkzc099h6ucxaldt/+aTyFg==
X-Received: by 2002:a05:600c:3d8c:: with SMTP id bi12mr491220wmb.109.1644315762857;
        Tue, 08 Feb 2022 02:22:42 -0800 (PST)
Received: from leap.localnet (host-95-245-2-16.retail.telecomitalia.it. [95.245.2.16])
        by smtp.gmail.com with ESMTPSA id i9sm1359392wmq.2.2022.02.08.02.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 02:22:42 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Use kzalloc() with GFP_ATOMIC in atomic context
Date:   Tue, 08 Feb 2022 11:22:40 +0100
Message-ID: <2743885.88bMQJbFj6@leap>
In-Reply-To: <YgI40Dm/ar+IubIA@kroah.com>
References: <20220206225943.7848-1-fmdefrancesco@gmail.com> <YgI40Dm/ar+IubIA@kroah.com>
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

On marted? 8 febbraio 2022 10:33:04 CET Greg Kroah-Hartman wrote:
> On Sun, Feb 06, 2022 at 11:59:43PM +0100, Fabio M. De Francesco wrote:
> > Use the GFP_ATOMIC flag of kzalloc() with two memory allocation in
> > rtw_set_key(). This function is called while holding spinlocks and with
> > disabled bottom halves, therefore it is not allowed to sleep. With the
> > GFP_ATOMIC type flag, the allocation is high priority and cannot sleep.
> > 
> > This issue is detected by Smatch which emits the following warning:
> > drivers/staging/r8188eu/core/rtw_pwrctrl.c:79 ips_leave() warn: sleeping in atomic context
> > drivers/staging/r8188eu/core/rtw_pwrctrl.c:81 ips_leave() warn: sleeping in atomic context
> > 
> > The calls chain (in reverse order) is the following:
> > 
> > rtw_set_key()
> > -> ips_leave()
> > -> -> rtw_pwr_wakeup()
> > -> -> -> rtw_set_802_11_disassociate()
> > 
> > The disable of bottom halves and the acquisition of a spinlock is in
> > rtw_set_802_11_disassociate().
> > 
> > After the changes, the post-commit hook output the following messages:
> > 
> > CHECK: Prefer kzalloc(sizeof(*pcmd)...) over kzalloc(sizeof(struct cmd_obj)...)
> > +       pcmd = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
> > 
> > CHECK: Prefer kzalloc(sizeof(*psetkeyparm)...) over kzalloc(sizeof(struct setkey_parm)...)
> > +       psetkeyparm = kzalloc(sizeof(struct setkey_parm), GFP_ATOMIC).
> > 
> > According to the above "CHECK[S]", use the preferred style in the first
> > kzalloc().
> > 
> > Fixes: 79f712ea994d ("staging: r8188eu: Remove wrappers for kalloc() and kzalloc()")
> > Fixes: 15865124feed ("staging: r8188eu: introduce new core dir for RTL8188eu driver")
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  drivers/staging/r8188eu/core/rtw_mlme.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > [...]
> 
> You are making two different changes here.  Please do the first patch to
> change the sizeof() change to fix up checkpatch, and then the second one
> for the GFP_ATOMIC change so that if there is a problem with either of
> them we can only revert the offending change.
>
OK, thanks for your reply. I'm about to split this patch in two steps as 
you require.

In the while I've noticed that, after git-reset HARD^, Smatch now points directly 
to the kzalloc() calls and emits a different output:

"drivers/staging/r8188eu/core/rtw_mlme.c:1603 rtw_set_key() warn: sleeping in 
atomic context
  CHECK   drivers/staging/r8188eu/core/rtw_mlme_ext.c".

So now it complains specifically about the first of the two kzalloc[s]() in 
rtw_set_key(). Before sending v2, I'd like to check why when I made v1 it pointed 
to the lines that call rtw_set_key(). You'll see that change in the commit message
of v2.

Thanks,

Fabio
>
> thanks,
> 
> greg k-h
> 
> 




