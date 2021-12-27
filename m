Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E2E47FCAA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 13:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbhL0Mfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 07:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbhL0Mfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 07:35:46 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E54C06173E;
        Mon, 27 Dec 2021 04:35:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BAA6DCE0FF6;
        Mon, 27 Dec 2021 12:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4015C36AE7;
        Mon, 27 Dec 2021 12:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640608543;
        bh=5wQxYeJB7/dLdDA5xo4bBALbh/dwu0JreLF0QTgDcGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nBAE1trlg07VNS4T4HxMrQ93w7rf7On4jqqqqMiiQfGAZ4w0BcPCZx7v8Hq99nvLj
         Cfw/cneUePnpHPpcJ9hlTsgKdHMs8bzXa07tjLzgQQVW5YYWnfWyewy+RNcPRz/pEF
         amS5vUOBpJDd3fNqN1nnuwn5bQvN3Jyg1IgJ8dkk=
Date:   Mon, 27 Dec 2021 13:35:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     stable@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm/damon/dbgfs: protect targets destructions with
 kdamond_lock
Message-ID: <YcmzHCJYiYIMcyTH@kroah.com>
References: <20211226102632.836-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211226102632.836-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2021 at 10:26:32AM +0000, SeongJae Park wrote:
> commit 34796417964b8d0aef45a99cf6c2d20cebe33733 upstream.
> 
> DAMON debugfs interface iterates current monitoring targets in
> 'dbgfs_target_ids_read()' while holding the corresponding
> 'kdamond_lock'.  However, it also destructs the monitoring targets in
> 'dbgfs_before_terminate()' without holding the lock.  This can result in
> a use_after_free bug.  This commit avoids the race by protecting the
> destruction with the corresponding 'kdamond_lock'.
> 
> Link: https://lkml.kernel.org/r/20211221094447.2241-1-sj@kernel.org
> Reported-by: Sangwoo Bae <sangwoob@amazon.com>
> Fixes: 4bc05954d007 ("mm/damon: implement a debugfs-based user space interface")
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Cc: <stable@vger.kernel.org> # 5.15.x
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> This is a backport of a DAMON fix that merged in the mainline, for
> v5.15.x stable series.

Now queued up, thanks.

greg k-h
