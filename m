Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4AA59C10E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbiHVNzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235441AbiHVNz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:55:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9328399F9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lVeFJRWIBfLB9Kovtt0MlHcj+SnHSBTQYz2n5QaEFEw=; b=svDvkLsAAh8RAAqI2+1GdI5k/7
        QolHO/TzKus8nzztlhA3EAtLKDl0zDb8oCN4l3EKDr1Rjlg/OZqmNNroD7++ZDQZ1IV126tAYO309
        TtNwP2M94CrU3dplysVFL4zBdFsocUG5TMyq8rDET1fQBNVswqYB47etCNIhnSwfarXAWGaF4HJMp
        kuG5bjecHtg/gKEe/GEcDXKCjCD80YS68Ti8NdaIOshRuxdk+1By7qNP5vSiKOo8KtjEOCrbuIQOA
        ZirikzlBpEP0pU40puiMAKdxSqrv4nZrhOGanup4HtZvZRwKFgnQTSSBhlPN91Z/fmT8jQWa5z+/b
        cy2xOSOg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQ7th-00EKRd-VV; Mon, 22 Aug 2022 13:55:22 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 808E89804A3; Mon, 22 Aug 2022 15:55:20 +0200 (CEST)
Date:   Mon, 22 Aug 2022 15:55:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Jianfeng Gao <jianfeng.gao@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Subject: Re: [RESEND PATCH] perf/x86/intel: Fix unchecked MSR access error
 for Alder Lake N
Message-ID: <YwOKyBL7lNmyaFqs@worktop.programming.kicks-ass.net>
References: <20220818181530.2355034-1-kan.liang@linux.intel.com>
 <Yv9EVP6O9r867om4@worktop.programming.kicks-ass.net>
 <Yv9Kw21Wl/f6KJTk@worktop.programming.kicks-ass.net>
 <b54cd275-4fa6-9b5c-fdc2-858d2f7c1b46@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b54cd275-4fa6-9b5c-fdc2-858d2f7c1b46@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 09:24:57AM -0400, Liang, Kan wrote:
> I think the only issue should be the PMU name. The non-hybrid PMU name
> is "cpu". The hybrid PMU name is "cpu_$coretype". If we move the
> ALDERLAKE_N to the non-hybrid PMU, the PMU name will be changed from
> "cpu_atom" to "cpu". It will be different from the rest of
> {ALDER,RAPTOP}LAKE.
> 
> Also, I think we have to update the perf tool for the events because of
> the PMU name change.
> 
> But I guess it should be OK, since the ALDERLAKE_N was just added and we
> know its an Atom-only system.

cpu/caps/pmu_name should be 'Gracemont', which is exactly like all the
other !hybrid setups. Surely perf-tools already knows about this
pattern.

IOW, if you need to change perf-tools for this, someone did something
wrong somewhere.

(also, I just noticed, 'Tremont' is the *only* PMU that has a
capitalized name, perhaps we don't want Gracemont to follow but instead
fix tremont if that is still possible)
