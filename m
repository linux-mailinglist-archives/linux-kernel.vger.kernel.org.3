Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3966E52FF37
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 22:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbiEUUNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 16:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiEUUNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 16:13:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A1E2CCA8
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 13:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tdfpypjILo7uMMEjNSBlBhMSijPAPOm5pT3lespMGJ8=; b=QZd8y+vsLi7Ifyi4NS1iHvzuD9
        fqH435LIS8G+nYad9wee14NEXvzpfjYmj0GT4VGhV+LUqXWhJU6XRWRbp9pkH/e04ZeqYnHrZKMMs
        V81a/HXSnFA5pjWC9Z+JKzgQp+PQsSjOjRXDIARyqg2PxyQe37gswu0DrMIIOS1PhRYHDYGg64Yp8
        ISOPMqK4TQ3cpH6NX3fUUZQQ1ym32QBiB97oHPBIxdqJHj3tgP/iMICNBURMjAw3sWI0ZgN7hNlyP
        jMNAsOK9mobt/BzFGioV6vlMK8bQy9A1HRg4lViiOOyQvj1gnEG7ZOp0JfJdqpIctgdGLjzb7YcGF
        dFGaDyFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsVSh-00Esiq-EY; Sat, 21 May 2022 20:12:31 +0000
Date:   Sat, 21 May 2022 21:12:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Chih-En Lin <shiyn.lin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Colin Cross <ccross@google.com>,
        Feng Tang <feng.tang@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mike Rapoport <rppt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        linux-kernel@vger.kernel.org, Kaiyang Zhao <zhao776@purdue.edu>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Jim Huang <jserv.tw@gmail.com>
Subject: Re: [RFC PATCH 0/6] Introduce Copy-On-Write to Page Table
Message-ID: <YolHr1GwfA++i9jj@casper.infradead.org>
References: <20220519183127.3909598-1-shiyn.lin@gmail.com>
 <d1810538-9b4c-7f19-852f-7f6d255533c7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1810538-9b4c-7f19-852f-7f6d255533c7@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 06:07:27PM +0200, David Hildenbrand wrote:
> I'm missing the most important point: why do we care and why should we
> care to make our COW/fork implementation even more complicated?
> 
> Yes, we might save some page tables and we might reduce the fork() time,
> however, which specific workload really benefits from this and why do we
> really care about that workload? Without even hearing about an example
> user in this cover letter (unless I missed it), I naturally wonder about
> relevance in practice.

As I get older (and crankier), I get less convinced that fork() is
really the right solution for implementing system().  I feel that a
better model is to create a process with zero threads, but have an fd
to it.  Then manipulate the child process through its fd (eg mmap
ld.so, open new fds in that process's fdtable, etc).  Closing the fd
launches a new thread in the process (ensuring nobody has an fd to a
running process, particularly one which is setuid).
