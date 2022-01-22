Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40ECE496C25
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 12:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbiAVLbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 06:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiAVLbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 06:31:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B961C06173B;
        Sat, 22 Jan 2022 03:31:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4207FB81B92;
        Sat, 22 Jan 2022 11:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5D6C004E1;
        Sat, 22 Jan 2022 11:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642851108;
        bh=HtNO+2aP+hLfR7kko7wp4Sh1BYzwP5JmAlneWcplnlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yi7ITWAnt+8dIrwl6C4im5eAypjXA/ysWibCASfh2lF///wsibYvltLEkR2uVV++M
         DE0PXCWSxlkgwa1sYXLX8S41VAJAw4vA2oTHtEt0BWe6ar5pz6g+vnFgsypU7ItHiF
         4EG1xnZPFooWqParakQndHAxNLDxezSkzXX6wGFAb4S2eqhTyr1FKoIRDDddqm2tqW
         jhyreAmxp32DozdV8XxMcWlp92WxcwCYuCX+HxWOnmgugJ+KEUnHJSaoxI/ngtLI3s
         YHxasM/F8inDn+rd6iC82d7jpC1X23nhCJyKp5zMaqyKGm++AP8+FuMOvx1j2K8imU
         5kDV3OVB0Iu9g==
Date:   Sat, 22 Jan 2022 13:31:38 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        longpeng2@huawei.com, arnd@arndb.de, dave.hansen@linux.intel.com,
        david@redhat.com, surenb@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Message-ID: <YevrGs3WE7ywB+lH@kernel.org>
References: <cover.1642526745.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1642526745.git.khalid.aziz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(added linux-api)

On Tue, Jan 18, 2022 at 02:19:12PM -0700, Khalid Aziz wrote:
> Page tables in kernel consume some of the memory and as long as
> number of mappings being maintained is small enough, this space
> consumed by page tables is not objectionable. When very few memory
> pages are shared between processes, the number of page table entries
> (PTEs) to maintain is mostly constrained by the number of pages of
> memory on the system. As the number of shared pages and the number
> of times pages are shared goes up, amount of memory consumed by page
> tables starts to become significant.
> 
> Some of the field deployments commonly see memory pages shared
> across 1000s of processes. On x86_64, each page requires a PTE that
> is only 8 bytes long which is very small compared to the 4K page
> size. When 2000 processes map the same page in their address space,
> each one of them requires 8 bytes for its PTE and together that adds
> up to 8K of memory just to hold the PTEs for one 4K page. On a
> database server with 300GB SGA, a system carsh was seen with
> out-of-memory condition when 1500+ clients tried to share this SGA
> even though the system had 512GB of memory. On this server, in the
> worst case scenario of all 1500 processes mapping every page from
> SGA would have required 878GB+ for just the PTEs. If these PTEs
> could be shared, amount of memory saved is very significant.
> 
> This is a proposal to implement a mechanism in kernel to allow
> userspace processes to opt into sharing PTEs. The proposal is to add
> a new system call - mshare(), which can be used by a process to
> create a region (we will call it mshare'd region) which can be used
> by other processes to map same pages using shared PTEs. Other
> process(es), assuming they have the right permissions, can then make
> the mashare() system call to map the shared pages into their address
> space using the shared PTEs.  When a process is done using this
> mshare'd region, it makes a mshare_unlink() system call to end its
> access. When the last process accessing mshare'd region calls
> mshare_unlink(), the mshare'd region is torn down and memory used by
> it is freed.
> 
> 
> API Proposal
> ============
> 
> The mshare API consists of two system calls - mshare() and mshare_unlink()
> 
> --
> int mshare(char *name, void *addr, size_t length, int oflags, mode_t mode)
> 
> mshare() creates and opens a new, or opens an existing mshare'd
> region that will be shared at PTE level. "name" refers to shared object
> name that exists under /sys/fs/mshare. "addr" is the starting address
> of this shared memory area and length is the size of this area.
> oflags can be one of:
> 
> - O_RDONLY opens shared memory area for read only access by everyone
> - O_RDWR opens shared memory area for read and write access
> - O_CREAT creates the named shared memory area if it does not exist
> - O_EXCL If O_CREAT was also specified, and a shared memory area
>   exists with that name, return an error.
> 
> mode represents the creation mode for the shared object under
> /sys/fs/mshare.
> 
> mshare() returns an error code if it fails, otherwise it returns 0.

Did you consider returning a file descriptor from mshare() system call?
Then there would be no need in mshare_unlink() as close(fd) would work.
 
> PTEs are shared at pgdir level and hence it imposes following
> requirements on the address and size given to the mshare():
> 
> - Starting address must be aligned to pgdir size (512GB on x86_64)
> - Size must be a multiple of pgdir size
> - Any mappings created in this address range at any time become
>   shared automatically
> - Shared address range can have unmapped addresses in it. Any access
>   to unmapped address will result in SIGBUS
> 
> Mappings within this address range behave as if they were shared
> between threads, so a write to a MAP_PRIVATE mapping will create a
> page which is shared between all the sharers. The first process that
> declares an address range mshare'd can continue to map objects in
> the shared area. All other processes that want mshare'd access to
> this memory area can do so by calling mshare(). After this call, the
> address range given by mshare becomes a shared range in its address
> space. Anonymous mappings will be shared and not COWed.
> 
> A file under /sys/fs/mshare can be opened and read from. A read from
> this file returns two long values - (1) starting address, and (2)
> size of the mshare'd region.

Maybe read should return a structure containing some data identifier and
the data itself, so that it could be extended in the future.
 
> --
> int mshare_unlink(char *name)
> 
> A shared address range created by mshare() can be destroyed using
> mshare_unlink() which removes the  shared named object. Once all
> processes have unmapped the shared object, the shared address range
> references are de-allocated and destroyed.
> 
> mshare_unlink() returns 0 on success or -1 on error.

-- 
Sincerely yours,
Mike.
