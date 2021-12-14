Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D2B4741B7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 12:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhLNLnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 06:43:00 -0500
Received: from gentwo.de ([161.97.139.209]:58832 "EHLO gentwo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233644AbhLNLm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 06:42:59 -0500
Received: by gentwo.de (Postfix, from userid 1001)
        id 1C483B0024C; Tue, 14 Dec 2021 12:42:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 19CD9B00127;
        Tue, 14 Dec 2021 12:42:58 +0100 (CET)
Date:   Tue, 14 Dec 2021 12:42:58 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.org>
X-X-Sender: cl@gentwo.de
To:     Marcelo Tosatti <mtosatti@redhat.com>
cc:     Mel Gorman <mgorman@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@gentwo.de>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, peterz@infradead.org, nilal@redhat.com,
        linux-rt-users@vger.kernel.org, vbabka@suse.cz, ppandit@redhat.com
Subject: Re: [PATCH v2 3/3] mm/page_alloc: Remotely drain per-cpu lists
In-Reply-To: <20211214105823.GA53878@fuller.cnet>
Message-ID: <alpine.DEB.2.22.394.2112141239550.371576@gentwo.de>
References: <20211103170512.2745765-1-nsaenzju@redhat.com> <20211103170512.2745765-4-nsaenzju@redhat.com> <20211203141306.GG3301@suse.de> <20211209174535.GA70283@fuller.cnet> <20211210105549.GJ3301@suse.de> <20211214105823.GA53878@fuller.cnet>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2021, Marcelo Tosatti wrote:

> > downside is that there will be a performance penalty if an application
> > running on a NOHZ_FULL CPU is page allocator intensive for whatever
> > reason.  However, I guess this is unlikely because if there was a lot
> > of kernel activity for a NOHZ_FULL CPU, the vmstat shepherd would also
> > cause interference.
>
> Yes, it does, and its being fixed:
>
> https://lkml.org/lkml/2021/12/8/663
>
> Honestly i am not sure whether the association between a nohz_full CPU
> and "should be mostly in userspace" is desired. The RCU solution
> would be more generic. As Nicolas mentioned, for the usecases in
> questions, either solution is OK.
>
> Thomas, Frederic, Christoph, do you have any opinion on this ?

Applications running would ideally have no performance penalty and there
is no  issue with kernel activity unless the application is in its special
low latency loop. NOHZ is currently only activated after spinning in that
loop for 2 seconds or so. Would be best to be able to trigger that
manually somehow.

And I would prefer to be able to run the whole system as
NOHZ and have the ability to selectively enable the quiet mode if a
process requires it for its processing.


