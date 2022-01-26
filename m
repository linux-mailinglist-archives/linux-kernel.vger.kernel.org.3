Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B97C49CBED
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241938AbiAZOMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbiAZOMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:12:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73097C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 06:12:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11AFB61749
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 14:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE388C340E3;
        Wed, 26 Jan 2022 14:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643206350;
        bh=PdD13NpHQIo3/NEcjNLN+uTWme5k/O++wX4lnajZwU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xpud2vg+AejkJT2px+KGeKsdG1ae+aYX9Ru4yyyjTdr+wAx/JMiPVnjjhiIz8DWCe
         9q9U3vX3ESpkdWx5urk8phTD9MLjPGXbJHoXTeutOk5+wLFG4J5CylEFYbcchR6POo
         VgwDhqfwEPraF6B185ILy2K5dP2C59mniHDAwQJjP+uF1sWM3pqfCcEJF8pDGM3zRg
         Ie/rzIDQ2cOs3rgdusoe79ypI9P27nfiT0IuudKiwBH8sM04YiwZC/+tNqt9UdknCE
         ldbYAcxpxsm+tGa3jsX/KSbFTWhTh1EquXomi0OGNpBmStzGYffso1KCfyDrHAf1IF
         JIlvUhxZ0r47w==
Date:   Wed, 26 Jan 2022 16:12:18 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        akpm@linux-foundation.org, longpeng2@huawei.com, arnd@arndb.de,
        dave.hansen@linux.intel.com, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Xu <peterx@redhat.com>
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Message-ID: <YfFWwjzSLsZ0aV6W@kernel.org>
References: <cover.1642526745.git.khalid.aziz@oracle.com>
 <20220125114212.ks2qtncaahi6foan@box.shutemov.name>
 <Ye/5yUyEqO0ws0G5@casper.infradead.org>
 <20220125135917.ezi6itozrchsdcxg@box.shutemov.name>
 <YfAEqzTeBJSIOKcA@casper.infradead.org>
 <20220125185705.wf7p2l77vggipfry@box.shutemov.name>
 <YfBIpmxvc0+mFByf@casper.infradead.org>
 <YfDIYKygRHX4RIri@casper.infradead.org>
 <e164d7f4-406e-eed8-37d7-753f790b7560@redhat.com>
 <YfFO6VyMTrW1bWuu@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfFO6VyMTrW1bWuu@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 01:38:49PM +0000, Matthew Wilcox wrote:
> On Wed, Jan 26, 2022 at 11:16:42AM +0100, David Hildenbrand wrote:
> > A while ago I talked with Peter about an extended uffd (here: WP)
> > mechanism that would work on fds instead of the process address space.
> 
> As far as I can tell, uffd is a grotesque hack that exists to work around
> the poor choice to use anonymous memory instead of file-backed memory
> in kvm.  Every time I see somebody mention it, I feel pain.

How file-backed memory would have helped for the major use-case of uffd
which is post-copy migration?

-- 
Sincerely yours,
Mike.
