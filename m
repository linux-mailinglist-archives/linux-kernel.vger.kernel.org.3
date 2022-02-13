Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9794B3C95
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 18:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237364AbiBMRh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 12:37:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiBMRh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 12:37:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40A759A70;
        Sun, 13 Feb 2022 09:37:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8155EB80B46;
        Sun, 13 Feb 2022 17:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2154EC340F1;
        Sun, 13 Feb 2022 17:37:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BhgujmGH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644773866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KzeRk+q9X7yreqZXOe2rKT8HieNs8MmYCncgF1afFCA=;
        b=BhgujmGH+fM6WvNonjJDkYv0kNi1+j8f4eS3Dx2r4oQ3oGzzs8AlofFO3ME/H7uIw2+Z8o
        wY5criDLh0Q51PJRix9k3EVkE0YSUf03TKfJyFPG6XoIbSGwCJsuL9q/AWMA4yMeMK3KzY
        4stn/jpE3Gsk6Gin0z9+11DIOpWq950=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 62e9e6cd (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 13 Feb 2022 17:37:46 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id c6so39784383ybk.3;
        Sun, 13 Feb 2022 09:37:45 -0800 (PST)
X-Gm-Message-State: AOAM533J4RvLGE+Tyf0PuM+KirZAoRZm9/MqktVj7v0dsUwXBDlmUVMs
        aPkvaMg2YjW8TSMS6wbdrIAxTlp9b6w4fNTotWw=
X-Google-Smtp-Source: ABdhPJwc58MVBsmNBRa5Jx+/F8n8Er/6ECOx8BWEIwhQclcaQSLMGYBTfBohbw83tZnZnXnRkelvPkk98BPhR9CmUsY=
X-Received: by 2002:a81:3283:: with SMTP id y125mr10762552ywy.100.1644773864692;
 Sun, 13 Feb 2022 09:37:44 -0800 (PST)
MIME-Version: 1.0
References: <YgZ6IEbiDgz5X1ON@linutronix.de> <20220211162515.554867-1-Jason@zx2c4.com>
 <YgaSYlVEBOxfJbSD@linutronix.de> <CAHmME9rC_q4LGq2JaAAeGbtRA2cibTe9bnvhMLng+QnzAy2DVg@mail.gmail.com>
 <YgaV0UZO1KfmtLLh@linutronix.de>
In-Reply-To: <YgaV0UZO1KfmtLLh@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 13 Feb 2022 18:37:33 +0100
X-Gmail-Original-Message-ID: <CAHmME9rsOWuprpYqo9G9eUboQwUxRgWqYRYgyHG7cNOG16c5EA@mail.gmail.com>
Message-ID: <CAHmME9rsOWuprpYqo9G9eUboQwUxRgWqYRYgyHG7cNOG16c5EA@mail.gmail.com>
Subject: Re: [PATCH v6] random: defer fast pool mixing to worker
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 5:59 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> > > What do we do here vs RT? I suggested this
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=a2d2d54409481aa23a3e11ab9559a843e36a79ec
> > >
> > > Is this doable?
> >
> > It might be, but last time I checked it seemed problematic. As I
> > mentioned in an earlier thread, I'll take a look again at that next
> > week after this patch here settles. Haven't forgotten.
>
> Ah, cheers.

I started looking at this and came up with this draft with questions:
https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?h=jd/no-irq-trylocks

Some research remains...

Jason
