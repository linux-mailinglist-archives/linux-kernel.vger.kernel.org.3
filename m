Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57E654FAAF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 17:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383040AbiFQP47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 11:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbiFQP46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:56:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9902F006
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 08:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1og0G+jMuH4LpomwNdV+Rmme0bj4/1cUhjZZACY/B+U=; b=AbcDdyS+eoHqmJnCQ3xm3r+OXR
        X+3ZJGQAychhV9rmwM3BecocG/MfYvwywj5HDCnl+o206Q/QgNMA4X2wC5VsvcMzYXrklfpHsCInD
        JhUsbODDUBUORf46pLdCMDOsjoSa8jqL4+AAF4bJUzIadZTkd5IGWOlnYIO+ywZWshfw8x60BDYQ5
        x3Yp18tEzVUsMHoOZD0rCSEt0N647eGXxZFB2yXuLFsM/ViNtvrDCRWfwu9n0dTtFyYiwZmMeeGWJ
        +Xc5/m1HWAmtfDNwxfB9JEaCF3/sSrGAtYxG9CGxQMrAUffyMVcP1vpTsp4mfMHlGjctt/mqNKVjz
        dL/mPlxQ==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2EL0-008jGE-4Q; Fri, 17 Jun 2022 15:56:46 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 014CF9816B5; Fri, 17 Jun 2022 17:56:43 +0200 (CEST)
Date:   Fri, 17 Jun 2022 17:56:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Waiman Long <longman@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>, Roman Penyaev <rpenyaev@suse.de>
Subject: Re: [PATCH] locking/rwlocks: do not starve writers
Message-ID: <YqykOzBJtNbTB9I6@worktop.programming.kicks-ass.net>
References: <20220617091039.2257083-1-eric.dumazet@gmail.com>
 <YqxufxqsnHjVfQOs@worktop.programming.kicks-ass.net>
 <2dd754f9-3a79-ed17-e423-6b411c3afb69@redhat.com>
 <CALvZod5ijDz=coEE8G8v_haPaKuUa5jHYzEwKvLVxHGphixsFA@mail.gmail.com>
 <2730b855-8f99-5a9e-707e-697d3bd9811d@redhat.com>
 <CANn89iJLWJMmNrLYQ0EU7_0Wri6c3Kn9vYMOiWu1Ds8Af2KOnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iJLWJMmNrLYQ0EU7_0Wri6c3Kn9vYMOiWu1Ds8Af2KOnw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 05:24:58PM +0200, Eric Dumazet wrote:

> If only tasklist_lock is problematic and needs the unfair variant,
> then changing a few read_lock() for tasklist_lock will be less
> invasive than ~1000 read_lock() elsewhere....

This is unknown. tasklist_lock was the obvious one, there might be more.
Lockdep should be able to tell you.
