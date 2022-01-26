Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186B549D5EC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiAZXJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiAZXJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:09:57 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225D4C06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:09:57 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id 200so1084163qki.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=IVxNWH/QKGOB3lBXSiTvC5/myLAVD8oMrbCJbkN8fLI=;
        b=lwW5yJNzRuS7LA0HVMmPlkxlFXrgLJLHSmf++01SgGkwUYEjuu3hhD7Pas0rcQaY8C
         Mj+m8EWSylqe08j5KDrsT51qFkms+qhF14tzMeUxBgrtBaGzu7fgqLdpbTiFYDho4pgh
         Bv+VeiLJxs+z41wBFEwZMSgZIJQVX1QeOMHCAx3E7A1siJcyImMcYbOoltgc3pv8oqXa
         VLC/imZ1nAvWGajj0Yk/yJXRVPl/7iuaKrgG7+cOvkY2MEOKrZX50WdcZwea6yw4Ihsy
         DLuN3KHFg7eTPJWUtnFPi4dOYiyrn8O1qFafJ4Fk4hRCLmHIrXGOr9kjqgctyR4ChLHw
         4WeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=IVxNWH/QKGOB3lBXSiTvC5/myLAVD8oMrbCJbkN8fLI=;
        b=M/YuEBawprDtuQYO+KXV/TTNFAQu+3Qiz3VGyz0VF3sLzFCqjt9HQNUk1kstkRekdN
         KugvNYza4Sz8rwPIqkNcSG4lLVvwEwXV9rVQHM0RaJhN8EnU6MN0ah3bL1YI/4ZI4j84
         R0JltyaEKsltxaB0timUTRObm8hGuieqXX9hkUPUXFXe1qCiDsa8ILKuoC5kVLhdpaPo
         q0xpqgGGoefRA+EhL9SzGfU4A5qL/yJxDjjCaeGDVqhuqx3pp2YsZg2V2LdhYRKP0Ftj
         hAJI/85m3XnLRKLxQjLopgR0o/I6dR+7Q6jZRRoSrbI4Bqin8/mwAlXsIFJYLVbSeBfn
         D+EA==
X-Gm-Message-State: AOAM531OOmwufXwbhU4zZrz0wti4zhIziU1hqD7pG0I7nSys29NROQKd
        az539z7cF2oYsqb7M4xoMZ6IZQ==
X-Google-Smtp-Source: ABdhPJx0PSz7sx70cDEfKSN/XtlqIkthxJ42AWV4poLFgw2ZAXxGtaO8trHaQfIunIbj5iJyvr+gZw==
X-Received: by 2002:a37:9f45:: with SMTP id i66mr785036qke.205.1643238596073;
        Wed, 26 Jan 2022 15:09:56 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i13sm475717qko.91.2022.01.26.15.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 15:09:55 -0800 (PST)
Date:   Wed, 26 Jan 2022 15:09:43 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     NeilBrown <neilb@suse.de>
cc:     Christoph Hellwig <hch@infradead.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/23] MM: extend block-plugging to cover all swap reads
 with read-ahead
In-Reply-To: <164323362698.5493.8309546969459514762@noble.neil.brown.name>
Message-ID: <eeec206a-d255-a3e4-ec1e-e51a13e5118c@google.com>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>, <164299611274.26253.13900771841681128440.stgit@noble.brown>, <Ye5UzEzvN8WWMNBn@infradead.org> <164323362698.5493.8309546969459514762@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022, NeilBrown wrote:
> On Mon, 24 Jan 2022, Christoph Hellwig wrote:
> > On Mon, Jan 24, 2022 at 02:48:32PM +1100, NeilBrown wrote:
> > > Code that does swap read-ahead uses blk_start_plug() and
> > > blk_finish_plug() to allow lower levels to combine multiple read-ahead
> > > pages into a single request, but calls blk_finish_plug() *before*
> > > submitting the original (non-ahead) read request.
> > > This missed an opportunity to combine read requests.

No, you're misunderstanding there.  All the necessary reads are issued
within the loop, between the plug and unplug: it does not skip over
the target page in the loop, but issues its read along with the rest.

But it has not kept any of those pages locked, nor even kept any
refcounts raised: so at the end has to look up the target page again
with the final read_swap_cache_async() (which also copes with the
highly unlikely case that the page got swapped out again meanwhile).

> > > 
> > > This patch moves the blk_finish_plug to *after* all the reads.
> > > This will likely combine the primary read with some of the "ahead"
> > > reads, and that may slightly increase the latency of that read, but it
> > > should more than make up for this by making more efficient use of the
> > > storage path.
> > > 
> > > The patch mostly makes the code look more consistent.  Performance
> > > change is unlikely to be noticeable.
> > 
> > Looks good:
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Thanks.
> > 
> > > Fixes-no-auto-backport: 3fb5c298b04e ("swap: allow swap readahead to be merged")
> > 
> > Is this really a thing?
> Maybe it should be.....
> As I'm sure you guessed, I think it is valuable to record this
> connection between commits, but I don't like it hasty automatic
> backporting of patches where the (unknown) risk might exceed the (known)
> value.  This is how I choose to state my displeasure.

I don't suppose your patch does any actual harm (beyond propagating a
misunderstanding), but it's certainly not a fix, and I think should
simply be dropped from the series.

(But please don't expect any comment from me on the rest:
SWP_FS_OPS has always been beyond my understanding.)

Hugh
