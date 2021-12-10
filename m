Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC8646FCAD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 09:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbhLJIZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbhLJIZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:25:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FC3C061746;
        Fri, 10 Dec 2021 00:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GopIij0BzU8QEXq7yj6L1CinZaI6/cuY3bDW5pw222A=; b=F/o31sxFTsrtg2zfzbX+IuThCy
        vNr9S3QP17ySgsripnuSAiqM2CVTPdXQDKH8O7Jacsxo8cOjv2rzmpX/EJdbBLHZIWNChkWJEQFU0
        hO9Q/2w+V/+P+mPaicovylNNMIQ+AmizhbUxTvn8OtpyEO8WNiAxyJTXhw4456VJ1R94yNpqdN1pp
        nXSaDMBQEytS1HgxeL8GYxgCK8EaDTeqXkWWHgXqqC7iNgReQcQiFEfXPgFiM7JizXBVMwsAemUtx
        mfST4Z3En5ZdepblWeQ/stx0bUNISUoKTnpYr0sDaU2YJv+9ApadzKF5vWRpUrobV2XtkBj4XuTPJ
        vfplG+Uw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvb9p-00A9bg-5r; Fri, 10 Dec 2021 08:21:34 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7C3789817E0; Fri, 10 Dec 2021 09:21:33 +0100 (CET)
Date:   Fri, 10 Dec 2021 09:21:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, acme@kernel.org,
        jolsa@kernel.org, namhyung@kernel.org, ak@linux.intel.com,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        yao.jin@linux.intel.com, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, kan.liang@linux.intel.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        paulus@samba.org
Subject: Re: [PATCH 1/4] perf: Add new macros for mem_hops field
Message-ID: <20211210082133.GP16608@worktop.programming.kicks-ass.net>
References: <20211206091749.87585-1-kjain@linux.ibm.com>
 <20211206091749.87585-2-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206091749.87585-2-kjain@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 02:47:46PM +0530, Kajol Jain wrote:
> Add new macros for mem_hops field which can be used to
> represent remote-node, socket and board level details.
> 
> Currently the code had macro for HOPS_0, which corresponds
> to data coming from another core but same node.
> Add new macros for HOPS_1 to HOPS_3 to represent
> remote-node, socket and board level data.
> 
> For ex: Encodings for mem_hops fields with L2 cache:
> 
> L2			- local L2
> L2 | REMOTE | HOPS_0	- remote core, same node L2
> L2 | REMOTE | HOPS_1	- remote node, same socket L2
> L2 | REMOTE | HOPS_2	- remote socket, same board L2
> L2 | REMOTE | HOPS_3	- remote board L2
> 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
