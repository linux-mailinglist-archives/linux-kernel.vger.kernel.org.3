Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE3B465CBB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 04:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355198AbhLBDaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 22:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351677AbhLBDaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 22:30:10 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAEAC061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 19:26:48 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4508ECE2150
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 03:26:47 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5850160720;
        Thu,  2 Dec 2021 03:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1638415605;
        bh=8KZOWZJGOgSkrHiFbAw6h6sRhqlpQcq8fbP2QGbC3sU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V0PEsvLyxDQveVxsOAFOx+yEnhZQP7AE6vQ3pZK/vweSyBODJkWYxuALmP73hgsz2
         E6HrQb4OZPVtlmr4DhptKsfPs7G8cYfAk71rfg01usl2G/FucvS2QkFu0zGqSedcMH
         Oj3IYY1RLNIxNvM/eNXJCP6VCXEO0mUcOpoa1rFI=
Date:   Wed, 1 Dec 2021 19:26:43 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Bixuan Cui <cuibixuan@linux.alibaba.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, leon@kernel.org, w@1wt.eu,
        keescook@chromium.org
Subject: Re: [PATCH -next] mm: delete oversized WARN_ON() in kvmalloc()
 calls
Message-Id: <20211201192643.ecb0586e0d53bf8454c93669@linux-foundation.org>
In-Reply-To: <1638410784-48646-1-git-send-email-cuibixuan@linux.alibaba.com>
References: <1638410784-48646-1-git-send-email-cuibixuan@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Dec 2021 10:06:24 +0800 Bixuan Cui <cuibixuan@linux.alibaba.com> wrote:

> Delete the WARN_ON() and return NULL directly for oversized parameter
> in kvmalloc() calls.
> Also add unlikely().
> 
> Fixes: 7661809d493b ("mm: don't allow oversized kvmalloc() calls")
> Signed-off-by: Bixuan Cui <cuibixuan@linux.alibaba.com>
> ---
> There are a lot of oversize warnings and patches about kvmalloc() calls
> recently. Maybe these warnings are not very necessary.

Or maybe they are.  Please let's take a look at these warnings, one at
a time.  If a large number of them are bogus then sure, let's disable
the runtime test.  But perhaps it's the case that calling code has
genuine issues and should be repaired.


