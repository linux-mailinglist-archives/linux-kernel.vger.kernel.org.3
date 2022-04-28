Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C155512F4D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345024AbiD1JMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344972AbiD1JMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:12:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453B753E19
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Nr3EW08QcY2FGP18WwgBhQtNIE2zBp0aUeKcrHOynmM=; b=oywOchgoz1yVCmHP152iFQ65z9
        eTcv5VKYmC1Zf1NaA6nati1neDOaJSHiHEdvfnkoOtg8ilR7Shgv/XkhQDXU7F6BOO3CZiVT5MtFt
        YgkOQLEfnhDucY6Oi0/Z5gv91qMtuk9MO/quSySVQJrqgjpAu+oyLPTNLUd/SoMqCVo6Qln/jdoJO
        pVymNFE5nlVMiX3+8qPM37AK1mn1Nq+nWlCk3eBCWemwZAMH7rb80Oziwra2xbibrU2dPYvNQM1Uf
        8Umd3NytBiKm2mhO20dzbsM+hnWtzXFHiyPSx2NmUiZb5plj6sTcdASL/MB7a2PeNGSTDv+tVVg+E
        hniOlErg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nk08c-009JCw-Pp; Thu, 28 Apr 2022 09:08:39 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FC43981710; Thu, 28 Apr 2022 11:08:36 +0200 (CEST)
Date:   Thu, 28 Apr 2022 11:08:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>, tglx@linutronix.de
Subject: Re: [PATCH] task_work: allow TWA_SIGNAL without a rescheduling IPI
Message-ID: <20220428090836.GQ2731@worktop.programming.kicks-ass.net>
References: <543452ca-f82e-4f00-cd51-88bb9723a975@kernel.dk>
 <33a6de15-f487-b12b-8ffe-af978ebb03c3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33a6de15-f487-b12b-8ffe-af978ebb03c3@kernel.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 07:52:31PM -0600, Jens Axboe wrote:
> On 4/22/22 8:34 AM, Jens Axboe wrote:
> > Some use cases don't always need an IPI when sending a TWA_SIGNAL
> > notification. Add TWA_SIGNAL_NO_IPI, which is just like TWA_SIGNAL,
> > except it doesn't send an IPI to the target task. It merely sets
> > TIF_NOTIFY_SIGNAL and wakes up the task.

Could you perphaps elaborate on those use-cases? How do they guarantee
the task_work is ran before userspace?
