Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322C2498386
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243145AbiAXP1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbiAXP1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:27:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61B5C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 07:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FxT0fvTiG1ZWES/dHbuuGT9jetIKmcYAgeRuTAT+qns=; b=DvE0n/LIurw9q3NLQ/WXt9lf5B
        mGo5yLGsSQ0g1aWtV79v3Ezbi9mI00Ut94vA3MviH3rFaIZFkPcTCfALmMXNx6mCxhT0KCaSMpgaT
        wdjj9Dhs005TOYrWdhIBSzggcPhGOong4O1QNt3xlZkhYsPvSzxE4p2J9qmhq9yrBZu+fNkG2Msbm
        Kv/qVjAeIHMIStIC5EB2tM/oH+QQMqQI5Ja4JIVpeWSr6j7RjbObNP81e6+EKIhmBHRnKDA9l9H9E
        F+XEMrPigAC/Do2Fe4fjkkwGO2TQGgga96jgf/GSII8Y4zlliLI/z9EL7Iy2JzKj6XgnfrMpg+YgX
        4+4S6vvA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nC1Fe-000p5y-4V; Mon, 24 Jan 2022 15:27:26 +0000
Date:   Mon, 24 Jan 2022 15:27:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mark Hemment <markhemm@googlemail.com>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        longpeng2@huawei.com, arnd@arndb.de, dave.hansen@linux.intel.com,
        david@redhat.com, rppt@kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Message-ID: <Ye7FXkkHjOtHNxLp@casper.infradead.org>
References: <cover.1642526745.git.khalid.aziz@oracle.com>
 <CANe_+UhrcQO0mwB2KJtm69+MDVJuD-r5Cbyqt8AkWdtfY55CCQ@mail.gmail.com>
 <ef356f12-5eef-a92e-a816-ab853f2d369a@oracle.com>
 <CANe_+Ui4x7xz_QtG1iXr6J3dbKyja3-T=2tTTg+yqsacrTUYNw@mail.gmail.com>
 <f0939948-51c4-eacb-0b20-dd31e0a8b92c@oracle.com>
 <CANe_+Uiw1mSnFFBW3n5qBJ+V9EDaqY1PAEXFTXF9mkwM73x0-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANe_+Uiw1mSnFFBW3n5qBJ+V9EDaqY1PAEXFTXF9mkwM73x0-Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 03:15:36PM +0000, Mark Hemment wrote:
> From the code sample in your initial email (simplified), where a
> process creates a msharefs file with the anonymous mmap()ed region to
> be shared;
>     addr = mmap(RDWR, ANON);
>     mshare("testregion", addr, len, CREAT|RDWR|EXCL, 0600);
> 
> Now, consider the case where the mmap() is named (that is, against a
> file).  I believe this is the usecase for Oracle's SGA.
> My (simplified) code for msharing a named file ("SGA") using your
> proposed API (does not matter if the mapping is PRIVATE or SHARED);
>     fd = open("SGA", RDWR);
>     addr = mmap(RDWR, ..., fd);
>     mshare("SGA-region", addr, len, CREAT|RDWR|EXCL, 0600);

Don't think of an mshared region as containing only one file.
It might easily contain dozens.  Or none at the start.  They're
dynamic; the mshare fd represents a chunk of address space, not
whatever is currently mapped there.

> If the permissions (usr/grp+perms+ACL) between the "SGA" file and the
> "SGA-region" msharefs are different, then it is very likely a serious
> security issue.

Only in the same sense that an application might open() a file that it
has permission to access and then open a pipe/socket to a process that
does not have permission and send the data to it.

