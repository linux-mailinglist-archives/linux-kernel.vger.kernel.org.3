Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F433461B6D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 16:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244583AbhK2P7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 10:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245088AbhK2P5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 10:57:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8CCC08EA4B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 06:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pTPDPWwnJNKhFksvBzJmMzgdWpyP2ONhKFxhLChr2xU=; b=cx8OKIC6WsqXu+TVnp2DUKEp1O
        SEiqDCxYwg03JHcxBMnKVd7PDecQCyvMfd83IH2rvXfaFFCWDaFUHmaEGG7FuYP2y7NJE12JQ4f3z
        mT/MXiGQ8ELMrIP/BsODNc+q72OMVkMMbVIbntFXBg53GR13zqv8Hse55DrKZTn/0Mmv484xSmf1G
        0Cq1lC3/W9BDRjeFYSZBJ3mpc2FMl3hTQ4UcdpOzIooZg3A4Y7Nc9mvTyEyqFJC5U5pcfSr3Y6p3s
        QEORrMnDGPP7wBHid3Wh7DHfiyV0jNFqgx4B/LFTZnqxswS3owOPFzxhDUSbI/6DhiguZpXBggm67
        vVaSOhyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrhFX-007pMz-Do; Mon, 29 Nov 2021 14:03:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 21F3030023F;
        Mon, 29 Nov 2021 15:03:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 04484200A1AFF; Mon, 29 Nov 2021 15:03:18 +0100 (CET)
Date:   Mon, 29 Nov 2021 15:03:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Len Brown <len.brown@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2 0/3] topology/sysfs: only export used sysfs attributes
Message-ID: <YaTdpsVCDQMlscON@hirez.programming.kicks-ass.net>
References: <20211129130309.3256168-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129130309.3256168-1-hca@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 02:03:06PM +0100, Heiko Carstens wrote:
> v2:
> As requested by Greg KH: avoid negative logic and use uppercase defines.
> 
> v1:
> Create die and cluster cpu topology sysfs attributes only if an
> architecture makes uses of it, instead of creating them always for all
> architectures with bogus default values.
> Also change the book and drawer cpu topology macros so they match all
> all other topology macros.
> 
> v1: https://lore.kernel.org/lkml/20211128212221.1069726-1-hca@linux.ibm.com/
> 
> Heiko Carstens (3):
>   topology/sysfs: export die attributes only if an architectures has support
>   topology/sysfs: export cluster attributes only if an architectures has support
>   topology/sysfs: rework book and drawer topology ifdefery
> 
>  Documentation/admin-guide/cputopology.rst | 33 +++++++++++------------
>  drivers/base/topology.c                   | 28 ++++++++++++++-----
>  include/linux/topology.h                  | 25 +++++++++++++++++
>  3 files changed, 62 insertions(+), 24 deletions(-)

Seems entirely reasonable to me,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
