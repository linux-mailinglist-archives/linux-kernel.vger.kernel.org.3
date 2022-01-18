Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DA7493019
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 22:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349293AbiARVrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 16:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbiARVq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 16:46:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBA2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 13:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o8OmDpmZwJ79TFW9weYPQvWllvtuDgUzn/OlUeFCC2k=; b=AtOJQ8qYFVQN9/o1R+g2yTBeJw
        t8JksLXBwJDcE3vigeGh6whgARjvfzSvxtz5i6xZ9/ixC4Vu1A9fj1y8J7TcXuvXrTPTH293A2+ns
        bZPV0SN0Nx+Ow+Eyi1WR6fIK6dDagBsXSDac7cWlBgbAstcotChhkyraCn9//sbMUyeJthLGTix4E
        5EBg9ujXs2FrYaM6OJ/dWD9cv+O2zITmbJQI4729mku8KDzFp32nRW4En8FHH9oYqgOT94lQFDdPx
        bMshun3BuLSgJxo4lqPRbq4ppyWo+D/SrIKSbswrTK3C2MR9I960YGHN6I3UD1UVq+ZCgLzhP7x/3
        FLTlLJ2A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9wJF-009ZJO-63; Tue, 18 Jan 2022 21:46:33 +0000
Date:   Tue, 18 Jan 2022 21:46:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
        longpeng2@huawei.com, arnd@arndb.de, dave.hansen@linux.intel.com,
        david@redhat.com, rppt@kernel.org, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Message-ID: <Yec1OZ0reX2EMXL7@casper.infradead.org>
References: <cover.1642526745.git.khalid.aziz@oracle.com>
 <eb696699-0138-33c5-ad47-bfca7f6e9079@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb696699-0138-33c5-ad47-bfca7f6e9079@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 01:41:40PM -0800, Dave Hansen wrote:
> On 1/18/22 1:19 PM, Khalid Aziz wrote:
> > - Starting address must be aligned to pgdir size (512GB on x86_64)
> 
> How does this work on systems with 5-level paging where a top-level page
> table entry covers 256TB?  Is the alignment requirement 512GB or 256TB?
>  How does userspace figure out which alignment requirement it is subject to?

The original idea was any power of two, naturally aligned, >= PAGE_SIZE,
but I suspect Khalid has simplified it for this first implementation.
