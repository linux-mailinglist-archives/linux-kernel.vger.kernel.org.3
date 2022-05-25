Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B708D533F20
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbiEYO07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242426AbiEYO0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:26:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EFD1115F
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:26:31 -0700 (PDT)
Date:   Wed, 25 May 2022 16:26:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653488789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g0Mv/hEChR/V+/w+toAJrTJdteedx/mB9mVO7SBB6UM=;
        b=ebhCUS1Dh2guv3NsO2B1Nc7XeAfwTNwhQB/RAHF98DVM8HdNKorMeaMexNT/uvyP2q4myg
        iaBpOcDQzD7tbhdKEMmxzUFr44Q8AN2hZrfcEg0cUgFP60D3nhsie/lX92qhixbD4WjYy6
        RXcj72CnZdVi/OxACy4JMJLBJRxQBW4HNBKx3dhBkNjYeGS2e4JhaMqjh+u18vIj7VcOUF
        W+CtElWdYcAZDkkU6rIhXeL6eA9y6DMsBflN5RofteAooeCZf3+pwf3xrVL48D4Rvczigt
        FxXdxgwDKAsTKdx3NUQNC+Dl3s8Oytnc5c1PbjkMFLGUVmIGhxN0PhxWdzVj7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653488789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g0Mv/hEChR/V+/w+toAJrTJdteedx/mB9mVO7SBB6UM=;
        b=oxXUxxwUv1uzXvHWGZCI3ZXGoDpOjQL+DfKrw55C4YVxTXrMZ2xsifAi/6R9Hf2p10vwnA
        +vUNdOXnk8LbxaAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Phil Elwell <phil@raspberrypi.com>, regressions@lists.linux.dev
Subject: Re: vchiq: Performance regression since 5.18-rc1
Message-ID: <Yo48k4InPmj8lDxZ@linutronix.de>
References: <77d6d498-7dd9-03eb-60f2-d7e682bb1b20@i2se.com>
 <YoszE8lQ9VcofLtX@linutronix.de>
 <Yo41ggMvkI1B9TeM@fuller.cnet>
 <e0402350-687e-14b6-2e30-4b459afa9afb@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e0402350-687e-14b6-2e30-4b459afa9afb@i2se.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-25 16:07:47 [+0200], Stefan Wahren wrote:
> this was the same as Paul send. I think i need more time for investigation,
> maybe there is an issue with the application.

I haven't seen Paul referring to *that* patch. He pointed to some fs/
related changes.

Sebastian
