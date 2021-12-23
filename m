Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D450D47DDC5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 03:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345923AbhLWCdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 21:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238478AbhLWCc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 21:32:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDCCC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 18:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EzVP/dZtqQU1FzlkHiRz5+wLeP8nI61zLjwyWFb3v8c=; b=CHyrmdr3vv1ynhl0sTgu9a1WdX
        +Ict0UvKyiu8I7ijx+7/hsxByl0QZ1aFHfna01kG5p1pXG9TQSkncbejcIjbH/LkNBt5JB1dRXdho
        bZzGudxq9Gs/u28ha9ycC2gd7ddFdsJRdlkHXlTOm+cazvo0RvaJp6PO7DCETjlnlnPwk0aB8pADQ
        QREBeUlYspXZmO4OASF5lH79p9PxWR5cJYYbTRJse1b38//bNaeqTNc3cYjZa4kmR7QsIZttayROI
        jLWJL56ruNLPKuObfnDl+6WY6fV9dmJnuXubtazbyPXEn3C2xIlKsvJ7JTWUmhOzaqslMhypNWE5C
        9Q1eMWqA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0DuN-003tiO-Lb; Thu, 23 Dec 2021 02:32:43 +0000
Date:   Thu, 23 Dec 2021 02:32:43 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] memcg: add per-memcg vmalloc stat
Message-ID: <YcPfy6PwapNz0Hz/@casper.infradead.org>
References: <20211222052457.1960701-1-shakeelb@google.com>
 <YcPYz4N0sXEVFaJA@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcPYz4N0sXEVFaJA@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 06:02:55PM -0800, Roman Gushchin wrote:
> It's a bid sad that this counter will partially intersect with others
> (e.g. percpu and stack), but I don't see how it can be easily fixed.

If it's worth fixing, we could add a VM_NO_ACCT flag?
