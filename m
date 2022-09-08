Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7662E5B1533
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiIHGyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiIHGym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:54:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A45C1707F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 23:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662620080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nHL0XEYTXLcZefnMw6bBCvJkV743B4SE2a16m3bx7n8=;
        b=T/HlkPDFmjf/FaihjLYhfOBV6GKtAA/cgJvMDzh/UR/NBTBgzGZ4TCT/riUmZ49HOoBKiF
        7cpHNVa0tnchmTRJ2k/4GuBFAPC3laH/dqqlW6gjJIv3u7BPWJdXkLupXrXFtdQiU4FUt0
        cn4zh3mQe67tT1hYwDwYTC6psYn+MR0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-113-JH2jYDKSOl2lm2yKoRlyrQ-1; Thu, 08 Sep 2022 02:54:39 -0400
X-MC-Unique: JH2jYDKSOl2lm2yKoRlyrQ-1
Received: by mail-qv1-f71.google.com with SMTP id mx9-20020a0562142e0900b004a1ddfe8ee3so8526914qvb.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 23:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nHL0XEYTXLcZefnMw6bBCvJkV743B4SE2a16m3bx7n8=;
        b=g/b2DMaSXu3WYx/0svTE/yTPvx1gJ/HZEREzMVIk69AIgItjqIVNqjOJr3/45TH9F0
         pCoAFf44bIJUYRbEoJzu62xQ0l+48TglfmFE45JckPD+B7VxRp4Faik7dGsrcT105QKx
         46a3xFHLxLq2PnWLtb+dQiR5ICGYTRIbriJ1RIGxeBBJ+B5yATekfBZkyLvXEUF/ASlH
         KQ+YLQe2uh8yD00GsLb1xLMzEl31guvs1Kx3Cmu8oKNyQRAyZyfW59rlCfof6TDFkQXd
         V/VAjEV/EfQCGtbAlGhVM4kLEMEe3lkowW5EvzxHKMKJ8+hPn6LppqQzcnjoCEypBxw7
         5Nrg==
X-Gm-Message-State: ACgBeo2Hoh6jC9wt9i6a4NxUsMK95mur0BczYvtUFb2OXPL/DRbBvO/+
        p1IrZxpa/0AWeqT+Of9wx82y1oVIroI8vk22iCZ7WR2xiJOFJy4OgS9zSS88Cc317X8jZSUz7UT
        NEXj13cfJ5B//8x3GkQmRYqMT
X-Received: by 2002:ac8:7f92:0:b0:344:8cd8:59a1 with SMTP id z18-20020ac87f92000000b003448cd859a1mr6807541qtj.384.1662620079405;
        Wed, 07 Sep 2022 23:54:39 -0700 (PDT)
X-Google-Smtp-Source: AA6agR52Xov5cqsUaFVLXlu1IBW/IoPWGVHUUv+hSoJto0E43WN49rdem8KUx8Rvak+C4iyke51hvw==
X-Received: by 2002:ac8:7f92:0:b0:344:8cd8:59a1 with SMTP id z18-20020ac87f92000000b003448cd859a1mr6807531qtj.384.1662620079179;
        Wed, 07 Sep 2022 23:54:39 -0700 (PDT)
Received: from redhat.com ([45.144.113.243])
        by smtp.gmail.com with ESMTPSA id y8-20020a05620a44c800b006c479acd82fsm14129379qkp.7.2022.09.07.23.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 23:54:38 -0700 (PDT)
Date:   Thu, 8 Sep 2022 02:54:33 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking: Detect includes rwlock.h outside of spinlock.h
Message-ID: <20220908025047-mutt-send-email-mst@kernel.org>
References: <YweemHxJx7O8rjBx@linutronix.de>
 <YxmNsnCPSPt1SJcz@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YxmNsnCPSPt1SJcz@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 08:37:38AM +0200, Sebastian Andrzej Siewior wrote:
> On 2022-08-25 18:08:59 [+0200], To linux-kernel@vger.kernel.org wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > 
> > The check for __LINUX_SPINLOCK_H within rwlock.h (and other files)
> > detects the direct include of the header file if it is at the very
> > beginning of the include section.
> > If it is listed later then chances are high that spinlock.h was already
> > included (including rwlock.h) and the additional listing of rwlock.h
> > will not cause any failure.
> > 
> > On PREEMPT_RT this additional rwlock.h will lead to compile failures
> > since it uses a different rwlock implementation.
> > 
> > Add __LINUX_INSIDE_SPINLOCK_H to spinlock.h and check for this instead
> > of __LINUX_SPINLOCK_H to detect wrong includes. This will help detect
> > direct includes of rwlock.h with without PREEMPT_RT enabled.
> > 
> > [ bigeasy: add remaining __LINUX_SPINLOCK_H user and rewrite
> >   commit description. ]
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> > 
> > This is to avoid patches like
> >    https://lkml.kernel.org/r/20220816074816.173227-1-bigeasy@linutronix.de
> > 
> > in the future which is not the first I sent…
> 
> polite *ping*
> 
> Sebastian

This needs to be merged by locking maintainers IMHO, not by me.

-- 
MST

