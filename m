Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28D2509579
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 05:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383969AbiDUDjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 23:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383970AbiDUDjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 23:39:13 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019A7B1E7;
        Wed, 20 Apr 2022 20:36:24 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id bg24so3786523pjb.1;
        Wed, 20 Apr 2022 20:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WIOoqIr6umdvALY95vQEJn502kHehzZOSqy7EehNNow=;
        b=V1l5+zYvtG8Tx38oDHIK2bx1KQkhwmPYUGkq8vX11Rm4twv2u01+86DNalFydcBv+6
         kmjtzQOAzkue4JX/UT8CjsDhkhb+UsdyajKT2z7RZRWcwYPHskXGExWWp3mjspogCGjl
         712L5vZM0jejCQJIWdgxS+yJ8TkbtrBppUFOoRQtUihRvmTT4u2/hXTHtwP9vbg3/RaL
         Uu08S7JxXhOkjskUbACRhsFav00CXiJ+xUAF1M3zh+6qZzY8AahKdpn2ZR+stc3DPMYb
         uHDmPIb6nYG4D0r0SAwN201vQ/6XRenYwDAcJtj2jFGP28Mi3yBhAvj0UG+s9ARqyFik
         aVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WIOoqIr6umdvALY95vQEJn502kHehzZOSqy7EehNNow=;
        b=XEY/RqZZYonVvehHp9XB5jYP5rgL6RRYJVGHCBdGxBZl5DN5/nht1LJGd6QJGDqcmp
         EBPnosyPQy9aRp8NtCWJRYH6ykketmF2etdzSrDbqu6Kbel5XzbPvjk3sZmCFGHf+Ivd
         Kz3p2NTXKJUQElwbNVljbxV9WD54TWv1BPoZRSW3KQHKawtdDjZnzGR0Y7X5bMct0B1b
         IAPUcQP+YGX7nsMjAR7koW4ROPDHAMecNLzHLyAzUdM5GfGQjqH16e84KBBbjBezYMIw
         0x3Sl/uA7VFbNQgz8SGMx2j8zqEgC//FZR8M08XfV0lCPSyD1zL6cUs+DgNl/TzAIart
         KVCQ==
X-Gm-Message-State: AOAM531351zigpzttjBcFO7ELRrqYsP4gZlI0ix9fTSrkZ7e+IG1vvBy
        tecJcWJB3FF08Vy77QgO5cnocuZmSw==
X-Google-Smtp-Source: ABdhPJyt3wHj72NitSPr4/sRrGQ63Mu8S1ynsJF4YIEMTc5WHvgLDEKHW0wrglrSyKEqGTtXgRWWZA==
X-Received: by 2002:a17:902:f282:b0:158:339c:d4a2 with SMTP id k2-20020a170902f28200b00158339cd4a2mr22775956plc.134.1650512184410;
        Wed, 20 Apr 2022 20:36:24 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m13-20020a17090b068d00b001cd4989fee0sm656049pjz.44.2022.04.20.20.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 20:36:23 -0700 (PDT)
Date:   Thu, 21 Apr 2022 11:36:17 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] s390/irq: utilize RCU instead of irq_lock_sparse()
 in show_msi_interrupt()
Message-ID: <YmDRMUUzBq6uyIzj@piliu.users.ipa.redhat.com>
References: <20220420140521.45361-1-kernelfans@gmail.com>
 <20220420140521.45361-5-kernelfans@gmail.com>
 <YmBOBRMWlk4H11sc@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmBOBRMWlk4H11sc@osiris>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 08:16:37PM +0200, Heiko Carstens wrote:
> On Wed, Apr 20, 2022 at 10:05:16PM +0800, Pingfan Liu wrote:
> > irq_desc can be accessed safely in RCU read section as demonstrated by
> > kstat_irqs_usr(). And raw_spin_lock_irqsave() context can provide a rcu
> > read section, which can be utilized to get rid of irq_lock_sparse().
> > 
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Heiko Carstens <hca@linux.ibm.com>
> > Cc: Vasily Gorbik <gor@linux.ibm.com>
> > Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> > Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> > Cc: Sven Schnelle <svens@linux.ibm.com>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Cc: linux-kernel@vger.kernel.org
> > To: linux-s390@vger.kernel.org
> > ---
> >  arch/s390/kernel/irq.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
> > index 3033f616e256..6302dc7874cf 100644
> > --- a/arch/s390/kernel/irq.c
> > +++ b/arch/s390/kernel/irq.c
> > @@ -205,12 +205,13 @@ static void show_msi_interrupt(struct seq_file *p, int irq)
> >  	unsigned long flags;
> >  	int cpu;
> >  
> > -	irq_lock_sparse();
> > +	raw_spin_lock_irqsave(&desc->lock, flags);
> >  	desc = irq_to_desc(irq);
> 
> How is this supposed to work? desc get's initialized after its random
> stack value has been used as a pointer to lock something...

Oops. You are right. What about using rcu_read_lock() directly?


diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index 3033f616e256..45393919fe61 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -205,7 +205,7 @@ static void show_msi_interrupt(struct seq_file *p, int irq)
 	unsigned long flags;
 	int cpu;
 
-	irq_lock_sparse();
+	rcu_read_lock();
 	desc = irq_to_desc(irq);
 	if (!desc)
 		goto out;
@@ -224,7 +224,7 @@ static void show_msi_interrupt(struct seq_file *p, int irq)
 	seq_putc(p, '\n');
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 out:
-	irq_unlock_sparse();
+	rcu_read_unlock();
 }
 
 /*


Thanks,

	Pingfan
