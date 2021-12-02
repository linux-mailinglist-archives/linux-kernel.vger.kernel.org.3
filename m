Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACDC466D80
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 00:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356434AbhLBXPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 18:15:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36936 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244721AbhLBXPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 18:15:41 -0500
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93BB8B823BC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 23:12:17 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1626604AC;
        Thu,  2 Dec 2021 23:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1638486735;
        bh=DRD1qhyfdURHJ4AsAhOH6i7DOxCBkCGrkCjxjX5eqdk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HEvI+wcsBE/muLl9E2CdtsLJVUun+zLPs6VwoNcKMIgCH1nYIcR6hifvPDCVNFqnZ
         TXCVJDUD+O+/e8vy6tqbGrpvZmzCWltptMM6xZgrYMkuL/wIsRG9IRvgwDlvLf05cB
         KbkVdMhAq4T6i39u90akBTjh+Uqc3WPcv1VONv78=
Date:   Thu, 2 Dec 2021 15:12:13 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sj@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND MERGE REQUEST] mm/damon: move damon_rand()
 definition into damon.h
Message-Id: <20211202151213.6ec830863342220da4141bc5@linux-foundation.org>
In-Reply-To: <20211202075859.51341-1-xhao@linux.alibaba.com>
References: <20211202075859.51341-1-xhao@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Dec 2021 15:58:59 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> damon_rand() is called in three files:damon/core.c, damon/
> paddr.c, damon/vaddr.c, i think there is no need to redefine
> this twice, So move it to damon.h will be a good choice.

Fair enough.

> +/* Get a random number in [l, r) */
> +#define damon_rand(l, r) (l + prandom_u32_max(r - l))

This shouldn't be implemented as a macro, for all the usual reasons
(typechecking, side-effects, ugliness, code-documentation site, etc).

In particular, this expression references `l' twice, so calling

	damon_rand(a++, b);

will increment `a' twice, surprise surprise.

Can someone please send a followup patch to convert this (and any
similar damon macros) into (probably static inlined) C functions?

