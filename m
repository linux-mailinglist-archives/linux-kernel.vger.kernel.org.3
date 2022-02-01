Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30CE4A6226
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240786AbiBARRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:17:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40298 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240650AbiBARRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:17:38 -0500
Date:   Tue, 1 Feb 2022 18:17:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643735856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hy73OdlhSZ0HrbaPoUxKwF0Ga4Gfx564kViaTFoJd1g=;
        b=cHidEknYEpNzwn5aIoIfpAQwsy1x4wIZxK2wYXn2Wm5xs1hTixn0m6Q5n9YUT1IoUzwN2K
        FtIOyO9CWT/Djb6GhN0q4t9v/x9ER0MOK/REUVbYp8QSMEp4FKOETDX9dIfGK0ceOEEutt
        gDMBMQPjSiLn6LC5EyeHxzm9lbfkO7uD+P9/objW7OGJ0hHj2evuC3EJ2ktipLFc69btqI
        NSrwSOejuAvD6tjCU+SY6v1uji58k0y86hNyCg33lPPi4Gu7T1PdFOoi/OvQEhzmQn4XFT
        uDwycfA/f0RZ9JpUHwBNP8lcWfdEQRLqjcRBPrFV3b4eeYiLvzzQkvgscy3GWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643735856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hy73OdlhSZ0HrbaPoUxKwF0Ga4Gfx564kViaTFoJd1g=;
        b=Ou8PjLoUsnDDi8oWKzYTiFqaW3BBTAkqesQ75scQ4pytOoG2jb6yM3vFL/wI86YhZVFOOk
        WviLe35kROBKXxCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 00/35] Speculative page faults
Message-ID: <YflrLpx3gpRMcu6p@linutronix.de>
References: <20220128131006.67712-1-michel@lespinasse.org>
 <20220131171434.89870a8f1ae294912e7ff19e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220131171434.89870a8f1ae294912e7ff19e@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-31 17:14:34 [-0800], Andrew Morton wrote:
> On Fri, 28 Jan 2022 05:09:31 -0800 Michel Lespinasse <michel@lespinasse.org> wrote:
> > The next step is to walk down the existing page table tree to find the
> > current pte entry. This is done with interrupts disabled to avoid
> > races with munmap().
> 
> Sebastian, could you please comment on this from the CONFIG_PREEMPT_RT
> point of view?

I applied the series on top of RT and gave it shot. Nothing out of the
ordinary happened so that is good.

From browsing through the code:
- speculative_page_walk_begin() seems to disable interrupts.
  There is a spin_trylock() invocation in that area. That is okay since
  it is never invoked from in_IRQ(). But there should not be any regular
  spin_lock() in such a section.

- We do have a seqcount API. So instead of mmap_seq_read_start() one
  could use raw_read_seqcount(). The lockdep bits would also check if
  the associated lock (in this case mmap_lock) is held in the write
  path.

- The read side (mmap_seq_read_start()) does not attempt to stabilize
  the counter (waiting for even) which is good. Otherwise special care
  would be needed ;)

Sebastian
