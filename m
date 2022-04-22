Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1334550B47B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446302AbiDVJ7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446285AbiDVJ7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:59:38 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CCE53B6C;
        Fri, 22 Apr 2022 02:56:45 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id k14so6994112pga.0;
        Fri, 22 Apr 2022 02:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4z0DG/HTGjm0nnHIhD5v7rm7s7fXaigHD/5btxNfFCk=;
        b=KnDr5TtxaHLKB/6Qy7Jus6MHdsRi3aLqIG52gWYCLtsuQRIqYzvx6Btesrkh3ECEup
         wGS/yAONCHvSgQ1oTRV8kD3YvcmnArQdgDHvS1dolRqJQUgOWk7Wh4TbgoyFgDcuAsiR
         Ngms1Go/S44idIyo9RpPsk+o/nKEx1glBalAJx1FKoJtlMB0cC4XZ2MBSPeIPNr90EHI
         Uorxsu0oEyBLI2/tXqHBZizkgSjM2JJ2vFtvjy6Ww/o+p8xT3bBI8uTe7Gkto/93uCxZ
         Mmi94sEXjiuNrwen4hbeGYAxRcTdPHQ8EiMAwVShwSfN4R4D4yXremQvuHHAgIiZt+FX
         ohoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4z0DG/HTGjm0nnHIhD5v7rm7s7fXaigHD/5btxNfFCk=;
        b=aM/eASQ9z3SK1uFdh09kNSgbFyuNaF8kD80S3DqPOBNfDJ9ogQsfTo2lIOxLBTVU9B
         wBB84lLDM6FabChKBAhQ54beAMUFe1YgUi4i1C+oORuUf6+QlDRaoA8GmnrlA1gPzqcF
         jMhFqdOwpt+IVwOXaV/hAtXVZKx+dIbV1ey2Sqr0W6K+AKH0uzukefh9YgXKo6PcFIO1
         6MwjuFLgEKM3CEf3BJWaQAmbcNy+bh8vnl0dkeEL4rQ7MWhOty30yjWYy3XmuShBTY3O
         k/U08y1uu2QYXyRVgzw84zla1RaASLmYTQiuiKEW2++5pYY0ad7r9CNpCMgXNODcIs38
         It/g==
X-Gm-Message-State: AOAM533Jryq8rVbjKz+uwpkSIJVvLTUmxDPRr4czCrLj/Ulq2Qh2XLsD
        bD6+9IDWivzfEH5GhcVYxQ==
X-Google-Smtp-Source: ABdhPJymP25I1AQXQk1+BZt3KKsq69o66XmBVh4Uoc2nQ2OVFQLlErCTqoeUB+sho6sq2LWimXe3XQ==
X-Received: by 2002:a63:780f:0:b0:386:5d6f:2153 with SMTP id t15-20020a63780f000000b003865d6f2153mr3150837pgc.555.1650621404650;
        Fri, 22 Apr 2022 02:56:44 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c139-20020a624e91000000b005060cdff4ffsm1995538pfb.129.2022.04.22.02.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 02:56:44 -0700 (PDT)
Date:   Fri, 22 Apr 2022 17:56:37 +0800
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
Message-ID: <YmJ71apr/9MPtT7g@piliu.users.ipa.redhat.com>
References: <20220420140521.45361-1-kernelfans@gmail.com>
 <20220420140521.45361-5-kernelfans@gmail.com>
 <YmBOBRMWlk4H11sc@osiris>
 <YmDRMUUzBq6uyIzj@piliu.users.ipa.redhat.com>
 <YmFDQ0wH+Y15bKX0@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmFDQ0wH+Y15bKX0@osiris>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 01:42:59PM +0200, Heiko Carstens wrote:
> On Thu, Apr 21, 2022 at 11:36:17AM +0800, Pingfan Liu wrote:
> > Oops. You are right. What about using rcu_read_lock() directly?
> > 
> > 
> > diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
> > index 3033f616e256..45393919fe61 100644
> > --- a/arch/s390/kernel/irq.c
> > +++ b/arch/s390/kernel/irq.c
> > @@ -205,7 +205,7 @@ static void show_msi_interrupt(struct seq_file *p, int irq)
> >  	unsigned long flags;
> >  	int cpu;
> >  
> > -	irq_lock_sparse();
> > +	rcu_read_lock();
> >  	desc = irq_to_desc(irq);
> >  	if (!desc)
> >  		goto out;
> > @@ -224,7 +224,7 @@ static void show_msi_interrupt(struct seq_file *p, int irq)
> >  	seq_putc(p, '\n');
> >  	raw_spin_unlock_irqrestore(&desc->lock, flags);
> >  out:
> > -	irq_unlock_sparse();
> > +	rcu_read_unlock();
> 
> That looks like it should work. Please resend and also add a reference
> to commit 74bdf7815dfb ("genirq: Speedup show_interrupts()") which
> explains why this works.

Thanks for your review. I will follow up with V2.

Regards,

	Pingfan
