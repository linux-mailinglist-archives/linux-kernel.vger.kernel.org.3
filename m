Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97324477B10
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240502AbhLPRwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbhLPRwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:52:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CB6C061574;
        Thu, 16 Dec 2021 09:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DADdGUxzAsbDwy/9e9rcW4u4eWcJjJmc808Tuzh8V0s=; b=uwsmcelTvjFOlWnYxY+xk6CbVf
        1IfRraipcosSJL5NLaEfhF6kGQPy69aEyAIKHj18GDBahDpqX+kD7jAMkVIH2g0BlslUPc8+Tivdi
        Yc6hQQIjdRvkyzV7tlPm3iS1tMmzd/IGBdG1niDmGPPPT/w7SyB6INDN1Yoj7jM2YLH4xXXXJphNV
        EXUZNqFSK7Yw7GoX5/WaelB1hGELza9QZZQ9Dzj6JDkCUL1O/59GWWbloWrt3rsCAhgjgKJR6vaQC
        vbzt1zcWEQM8uLBV4aouQhCy3n6r/M2/ASn/mWSjFCPUPAk3YS7n1Xa8/U+XWzoZu5nZ4mEJ2w/Ue
        qVNfN6sA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxuvB-0071wp-CV; Thu, 16 Dec 2021 17:52:01 +0000
Date:   Thu, 16 Dec 2021 09:52:01 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Miko Larsson <mikoxyzzz@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] zram: zram_drv: replace strlcpy with strscpy
Message-ID: <Ybt8wY3U2ETjQijH@infradead.org>
References: <20211215192128.108967-1-mikoxyzzz@gmail.com>
 <20211215192128.108967-3-mikoxyzzz@gmail.com>
 <YbsRlDYT2BfgrXRX@infradead.org>
 <20211216160021.1b9e6d87@zenorus.myxoz.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216160021.1b9e6d87@zenorus.myxoz.lan>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 04:00:21PM +0100, Miko Larsson wrote:
> Thanks for the heads-up! That only seems to apply to the assignment of
> 'file_name'. The usage of strscpy seems to be correct in the other two
> cases, though (since they're char arrays.) I suspect I might be wrong
> though, since my knowledge of C is shabby at best.

The second one also sounds like a case for memdup_nul.  That adds a
memory allocation, but it keeps all the checking nicely encapsulated,
and the last one should be fine with a plain old mempcy.
