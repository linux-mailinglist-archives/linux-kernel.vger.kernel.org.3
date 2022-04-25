Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C65050DAF1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbiDYISp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbiDYIRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:17:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146A35BE7D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q1Nxh0xOI6aJnlQ0pRsJPsD5YeurmS4B93CsQe5uacU=; b=VefYGGJrBhq1La3xk9/3KGyGk9
        lE3Si6pM001HhDSXmW9rijM2KMqxk9/L9IzCfP3KC+nLWKw9B0S0QHM9ybe2/PetAcW4VfpUoO/dV
        Dn75eslFguXutnVu6cNLv3rbDiE+z3IXegk9dozRr958JoBLZ2Gwjg5PV0l36/MZORx49D2nwqZXf
        7vdf+WC69bMnSCJPK0i04hmBJq6FbBe57gS3jQIzDUABM6e5vpyZVzSq5+TTYxoJjoXUoejEt2M4x
        lgfI+KT/BpC57mMAgWgoC5nkTcgJTPcSLVbW8mjquE8AJO7Tz4N/O5inqI622KhpWnrmVSP/Tqzzb
        TEdB3f9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nitrI-008Usr-Pc; Mon, 25 Apr 2022 08:14:13 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C200A980362; Mon, 25 Apr 2022 10:14:10 +0200 (CEST)
Date:   Mon, 25 Apr 2022 10:14:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Cruz Zhao <CruzZhao@linux.alibaba.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/core: Skip sched_core_fork/free() when core
 sched is disabled
Message-ID: <20220425081410.GA2731@worktop.programming.kicks-ass.net>
References: <1650831454-101777-1-git-send-email-CruzZhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650831454-101777-1-git-send-email-CruzZhao@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 04:17:34AM +0800, Cruz Zhao wrote:
> As __put_task_struct() and copy_process() are hot path functions,
> the call of sched_core_fork/free() will bring overhead when core
> sched is disabled, and we skip them in these cases.

Only if you have profile data.. mostly these functions do whole lot of
nothing.
