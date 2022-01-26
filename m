Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC01049CC28
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242063AbiAZOTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:19:11 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42618 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiAZOTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:19:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE2456175F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 14:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF39C340E3;
        Wed, 26 Jan 2022 14:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643206748;
        bh=W1L1pIumJOUK3UmO17es5PZtmpZRwBpcqUO2tjQQsOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ty+pUTnTqWyQhlRMY7OVCiRaETM2+ONRVT2XgXXmf/JdmDt5cZo42Y9NdrHGd8ddd
         OXJ0KLgFwgVfvy96AwMMO9dDJnBRGQJrGwnBGR62anfiXql15veBoIyM7cKV8/hwF8
         1K0W8YppLfAUSNXDHi1zNEOn1CTjJK9xjYkHsbVonsk4kEcJeT5xLWzBfpFkV35ekJ
         GIU0oN1VkJ0TgJlSFzuYIBfVGS0P0eNGFNivhEsSDP+NvKTMSReRs+Dmj2itLuXv1U
         BcMZLbjXtRmwJE3LtffGZ0gpJ4DiUhO8m1NIfcYDZASAvLvFt3jwQHRYbQF4O9AmbA
         +sz+PlewMlQQQ==
Date:   Wed, 26 Jan 2022 16:18:57 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        akpm@linux-foundation.org, longpeng2@huawei.com, arnd@arndb.de,
        dave.hansen@linux.intel.com, david@redhat.com, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Message-ID: <YfFYUWOieZw9wap7@kernel.org>
References: <cover.1642526745.git.khalid.aziz@oracle.com>
 <20220125114212.ks2qtncaahi6foan@box.shutemov.name>
 <Ye/5yUyEqO0ws0G5@casper.infradead.org>
 <20220125135917.ezi6itozrchsdcxg@box.shutemov.name>
 <YfAEqzTeBJSIOKcA@casper.infradead.org>
 <20220125185705.wf7p2l77vggipfry@box.shutemov.name>
 <YfBIpmxvc0+mFByf@casper.infradead.org>
 <YfDIYKygRHX4RIri@casper.infradead.org>
 <20220126134247.fadtwbvyknh3ejpe@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126134247.fadtwbvyknh3ejpe@box.shutemov.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 04:42:47PM +0300, Kirill A. Shutemov wrote:
> On Wed, Jan 26, 2022 at 04:04:48AM +0000, Matthew Wilcox wrote:
> > On Tue, Jan 25, 2022 at 06:59:50PM +0000, Matthew Wilcox wrote:
> > > On Tue, Jan 25, 2022 at 09:57:05PM +0300, Kirill A. Shutemov wrote:
>
> > So how about something like this ...
> > 
> > int mcreate(const char *name, int flags, mode_t mode);
> > 
> > creates a new mm_struct with a refcount of 2.  returns an fd (one
> > of the two refcounts) and creates a name for it (inside msharefs,
> > holds the other refcount).
> > 
> > You can then mmap() that fd to attach it to a chunk of your address
> > space.  Once attached, you can start to populate it by calling
> > mmap() and specifying an address inside the attached mm as the first
> > argument to mmap().
> 
> That is not what mmap() would normally do to an existing mapping. So it
> requires special treatment.
> 
> In general mmap() of a mm_struct scares me. I can't wrap my head around
> implications.
> 
> Like how does it work on fork()?
> 
> How accounting works? What happens on OOM?
> 
> What prevents creating loops, like mapping a mm_struct inside itself?
> 
> What mremap()/munmap() do to such mapping? Will it affect mapping of
> mm_struct or will it target mapping inside the mm_sturct?
> 
> Maybe it just didn't clicked for me, I donno.

My understanding was that the new mm_struct would be rather stripped and
will be used more as an abstraction for the shared page table, maybe I'm
totally wrong :)
 
> > Maybe mcreate() is just a library call, and it's really a thin wrapper
> > around open() that happens to know where msharefs is mounted.
> 
> -- 
>  Kirill A. Shutemov

-- 
Sincerely yours,
Mike.
