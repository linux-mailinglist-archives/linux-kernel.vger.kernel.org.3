Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1852C530A4C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiEWHa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiEWHYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:24:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0892618
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:19:52 -0700 (PDT)
Date:   Mon, 23 May 2022 09:09:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653289748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9fXGl02y6RMoaaLIdcX/WdBIdoqHbzfOjOVe1GnCbiE=;
        b=QPcVXQdx4xVhSQNlutu55LBMOkk8goN5Yd+g6Qk9Yhcf7EkeMlTCJzW1nF/JDLQiN2i/mo
        VjWizzvX3DYgUkZyZ+2uyfx/nvVxb5S4NoY8S641n+BVB4TAH9lhIaFLZ7lVVgaob3pKNm
        4pWcVIx8ARh4iCLufnUlYDEXCgoklMoENYGUdkkTQvBClT2iRWIYy+g82n5+gG7nSQpbzk
        uc2cziWUWFtIhRB6GAyOc7h0U/gsMResXK2mHeQZ1oOlV8jidjXd6V5gsMqOhIX8h8LX+t
        O6RM8h90/TUwzgfYhoKmiKym5D3RrsugGQi9aEXdVlBCn9Ymi1uwkeHzGWx78g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653289748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9fXGl02y6RMoaaLIdcX/WdBIdoqHbzfOjOVe1GnCbiE=;
        b=pUirtnHH1iEt/KEVCWaqVL0y0hyZIc/JCv0kjCf/2hMeSSRWirZ4kt/fVVPpXhIL51SZmV
        Y8rSMa3rqAiRXqCA==
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
Message-ID: <YoszE8lQ9VcofLtX@linutronix.de>
References: <77d6d498-7dd9-03eb-60f2-d7e682bb1b20@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <77d6d498-7dd9-03eb-60f2-d7e682bb1b20@i2se.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-22 01:22:00 [+0200], Stefan Wahren wrote:
> Hi,
Hi,

> while testing the staging/vc04_services/interface/vchiq_arm driver with my
> Raspberry Pi 3 B+ (multi_v7_defconfig) i noticed a huge performance
> regression since [ff042f4a9b050895a42cae893cc01fa2ca81b95c] mm:
> lru_cache_disable: replace work queue synchronization with synchronize_rcu
> 
> Usually i run "vchiq_test -f 1" to see the driver is still working [1].

What about
	https://lore.kernel.org/all/YmrWK%2FKoU1zrAxPI@fuller.cnet/

Sebastian
