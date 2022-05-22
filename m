Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AD952FFF2
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 02:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbiEVAcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 20:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiEVAcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 20:32:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C222DA8D
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 17:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b11yj7k2aWIJUC0HrAN1JE6uNRPyX/9gm1nWkGjLk8o=; b=lYHaz3uAV41tpTBPj8WDZh8ZPQ
        sFOmAQT7jhCNSrbgQhokByzyVkd++Ic4ak1j53Ov4P8TaQVc7wXPASxAdNJi2i3nGioAD6P5hssEp
        CZTjfna3vBly3tZNaIUELdmOvmK6ThyN75wky9w3yxyRRLMqfugtOr+U98BRM09tYmlMSaRIp2H+c
        gkxvYiN04zeBX1+i6WOeTOMIN+XJO0YigONeojJcb5spgWMT3o+n1kH+r51hERAeeaCV5JKyBtVS9
        3TlEOnaSU4v5zXTPkNTFZZEZJc2DileQIVzkYDEgioEdIzWTgS0xPiTnkmHvXZcSATjbfOq1cMZiW
        9orNnJtg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsZUs-00F1WZ-C7; Sun, 22 May 2022 00:31:02 +0000
Date:   Sun, 22 May 2022 01:31:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Chih-En Lin <shiyn.lin@gmail.com>,
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
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        linux-kernel@vger.kernel.org, Kaiyang Zhao <zhao776@purdue.edu>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Jim Huang <jserv.tw@gmail.com>
Subject: Re: [RFC PATCH 0/6] Introduce Copy-On-Write to Page Table
Message-ID: <YomERsAM3gF7XxRZ@casper.infradead.org>
References: <20220519183127.3909598-1-shiyn.lin@gmail.com>
 <d1810538-9b4c-7f19-852f-7f6d255533c7@redhat.com>
 <YolHr1GwfA++i9jj@casper.infradead.org>
 <64d0da08-6ffd-4bce-bc66-5097913937b4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64d0da08-6ffd-4bce-bc66-5097913937b4@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 03:19:24PM -0700, Andy Lutomirski wrote:
> I can see a rather different use for this type of shared-pagetable
> technology, though: monstrous MAP_SHARED mappings.  For database and some VM
> users, multiple processes will map the same file.  If there was a way to
> ensure appropriate alignment (or at least encourage it) and a way to handle
> mappings that don't cover the whole file, then having multiple mappings
> share the same page tables could be a decent efficiently gain.  This doesn't
> even need COW -- it's "just" pagetable sharing.

The mshare proposal did not get a warm reception at LSFMM ;-(

The conceptual model doesn't seem to work for the MM developers who were
in the room.  "Fear" was the most-used word.  Not sure how we're going
to get to a model of sharing page tables that doesn't scare people.
