Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8E0465CC2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 04:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355202AbhLBDhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 22:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbhLBDhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 22:37:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4354C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 19:34:12 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D1D4B8221A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 03:34:11 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E636860462;
        Thu,  2 Dec 2021 03:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1638416050;
        bh=GFhA6a6jxPu8jPXpjfkYA7r+8JEEnY9B1Rox7fKpTvM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RV5LMnFWUKiSVzxMKibLzhfCYq+/UMPHoBGucBm0TwHD30C0ar533yVyE7LXpF8r0
         F05fCGLGiBANnHtpsmYaMLaXdVVeisS3q7R9M+j/v7fo+9hFFf8iveB55QhQoZD/kf
         SYIabqVNBkOBCWdL5u9I07zzt+U8t3rMPWMMj74M=
Date:   Wed, 1 Dec 2021 19:34:08 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix the type of a parameter
Message-Id: <20211201193408.49c88f8281d14fb2c61f9ee6@linux-foundation.org>
In-Reply-To: <20211201181236.2315-1-caoyixuan2019@email.szu.edu.cn>
References: <20211201181236.2315-1-caoyixuan2019@email.szu.edu.cn>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Dec 2021 02:12:36 +0800 Yixuan Cao <caoyixuan2019@email.szu.edu.cn> wrote:

> The type of "last_migrate_reason" in struct page_owner is short.
> However, the type of "reason" in the argument list of following functions
> __set_page_owner_migrate_reason
> set_page_owner_migrate_reason
> 
> is int, which is inconsistent.

Well.

I'd say "no", because `int' is a natural type and the packing of that
scalar into a `short' is an expedient little space-saving hack (ie, an
"implementation detail") which should be hidden from callers rather
than propagated back up the call stack.

However, all these `int's should be of type `enum migrate_reason'.  And
the lowest-level hack of stuffing that enum into a `short' should
remain an implementation detail, hidden from callers.

