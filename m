Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD2549B778
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581933AbiAYPTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:19:06 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35740 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343901AbiAYPQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:16:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8659A61677
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 15:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE21BC340E0;
        Tue, 25 Jan 2022 15:16:07 +0000 (UTC)
Date:   Tue, 25 Jan 2022 10:16:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, naoya.horiguchi@linux.dev,
        Ingo Molnar <mingo@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] mm/migration: Add trace events for base page and
 HugeTLB migrations
Message-ID: <20220125101606.3cfb5561@gandalf.local.home>
In-Reply-To: <Ye/7EWJ576hdkWDg@casper.infradead.org>
References: <1643080105-11416-1-git-send-email-anshuman.khandual@arm.com>
        <1643080105-11416-3-git-send-email-anshuman.khandual@arm.com>
        <Ye/7EWJ576hdkWDg@casper.infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 13:28:49 +0000
Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Jan 25, 2022 at 08:38:25AM +0530, Anshuman Khandual wrote:
> > +		TP_printk("addr=%lx, pte=%lx order=%d", __entry->addr, __entry->pte, __entry->order)  
> 
> In these days of increasingly advanced Rowhammer attacks, is it wise
> to let userspace know exactly which physical addresses are being
> used for virtual addresses?

Is it an issue if this is only available for privileged users?

With tracing, you can just create a kprobe to get the same information for
you as well, so this isn't giving a user anything they do not already have.

-- Steve
