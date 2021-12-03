Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC924673DB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 10:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379532AbhLCJXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:23:10 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36552 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351316AbhLCJXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:23:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD76062999
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 09:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1266C53FCB;
        Fri,  3 Dec 2021 09:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638523181;
        bh=w6AlOF3oWeB7nNJxnw3g2UuX2DMssLXJreRdBzLlnrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=E9jsGd7sQZwp8MDpZ99QJDa7hmQxepdMiHV78wkuu0h1m93j0OK9lfuQRHOtC1hz6
         OC/ipdCuIlynSu+VhAUgnaphHRWYvgatGU0p3DDg3PLIXvvIY0uKafr65eROdmDqEc
         c2jhwBrMPrbMSdm16q/e/jpxz/7c1tgIX8GtBMy7/AIHiatxHCpLD0NMlI8UuZskIl
         G8Tn5Hkmg8ZMFbKSznfzVJZyhwRFjmUBBuYRpGIbhme1k4EvRRiw3GiZYT+Wz5mbou
         YZ5OLo2Lj19eJckw0atUcSHCGYDE44U/G/YMALiD5QiTKWkvw8un3vT5zZWuc44gPf
         5hxk35K+brDYQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Xin Hao <xhao@linux.alibaba.com>, sj@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND MERGE REQUEST] mm/damon: move damon_rand() definition into damon.h
Date:   Fri,  3 Dec 2021 09:19:36 +0000
Message-Id: <20211203091936.19804-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211202151213.6ec830863342220da4141bc5@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2021 15:12:13 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Thu,  2 Dec 2021 15:58:59 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
> 
> > damon_rand() is called in three files:damon/core.c, damon/
> > paddr.c, damon/vaddr.c, i think there is no need to redefine
> > this twice, So move it to damon.h will be a good choice.
> 
> Fair enough.
> 
> > +/* Get a random number in [l, r) */
> > +#define damon_rand(l, r) (l + prandom_u32_max(r - l))
> 
> This shouldn't be implemented as a macro, for all the usual reasons
> (typechecking, side-effects, ugliness, code-documentation site, etc).

Yes, agreed.

> 
> In particular, this expression references `l' twice, so calling
> 
> 	damon_rand(a++, b);
> 
> will increment `a' twice, surprise surprise.

Thank you for this nice explanation.

> 
> Can someone please send a followup patch to convert this (and any
> similar damon macros) into (probably static inlined) C functions?

Sure, I will do, unless someone shows interest here.


Thanks,
SJ
