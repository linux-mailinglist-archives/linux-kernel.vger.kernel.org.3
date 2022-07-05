Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E425E5675C3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbiGERaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbiGER3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:29:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED493220C4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 10:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zR33MMpcXSEF0WEP/osw4umkJspfbWxY04cS0PgwShs=; b=mrjGcebVMenj5+hil2MAPSiZWn
        +JHIPNzEJKTEC9lYVX9FfR29NI5dP+VRe0npgpci241LG64jTrJGc7qzFCXVncSe3SyaQXTpxJHgZ
        y8cenUsGJWrzDcjMTPLZELCff1DtC7AKbsteD8+1s9/bGGebg2G35LefJaRz1ZvEc6BYbDnaEvfii
        h1dD4sl/UCP2t+o5Xm4Hxq2VRpnTA4+7aLO0E6OgmvrEUyApLFXTtDYoIjGEjPhiJcNPBYJnqouF9
        jQvj/6OZzZDMBWq8vMc5qbnwRCCwhTZj383Z+ptu4uOuhVpG30ca48tvof+Zqs2KWJcB4rKK8hT3U
        C+YfziPA==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8mLt-000mJ9-3l; Tue, 05 Jul 2022 17:28:45 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 628F6980059; Tue,  5 Jul 2022 19:28:43 +0200 (CEST)
Date:   Tue, 5 Jul 2022 19:28:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] locking/qspinlock: stop renaming
 queued_spin_lock_slowpath to native_queued_spin_lock_slowpath
Message-ID: <YsR0yw80NgUTNXys@worktop.programming.kicks-ass.net>
References: <20220704143820.3071004-1-npiggin@gmail.com>
 <20220704143820.3071004-9-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704143820.3071004-9-npiggin@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 12:38:15AM +1000, Nicholas Piggin wrote:
> The native version can simply be queued_spin_lock_slowpath, and the
> paravirt version __pv_queued_spin_lock_slowpath, which is as they are
> named in the C code.
> 

Humm... so it is the x86 paravirt convention to have native_*()
functions for everthing, which sometimes are unconditionally called
whenever the paravirt indirection is unwarranted etc..

I suppose that's not the case with the spinlock code thouhg, so yeah,
why not.
