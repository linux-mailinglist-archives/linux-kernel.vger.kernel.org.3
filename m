Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FA657B594
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbiGTLdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiGTLdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:33:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FCC54073
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CRVWYeTJ3z1mATMRacXFgv811HEmLtg6owA+ofAMlOc=; b=rAWWhbenvX3lCYIk5peTZAJ91c
        jfmQGbHx/DYjr2zhJVthsEFIJNo8SWyFR0Xl9bU16xkBp7TafZCk6RxBgS9EVDyrSpNatHiFJr/xL
        oW0w7Wf0t4rxdm+iYzgHe3kDziaBWaz+ekFnGZkD3CGUisxV0hZqtZWkXX6bPNtaZAswx4rnElWmv
        dxUKwfH8BwtiGsh044imKptuS5RZGyZfhqOXEvoSIMMMKoRCjdqw/bwV8PSZiuQs2k37l0jng45mI
        49FqRtpEYaswsu+kFq2mFew/Du+4nfbZVEpskiPsrblk/fPMoTthWv7LuvgTzPH44mWeOycI+zxpL
        7EAvET9g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oE7xI-005JX8-RB; Wed, 20 Jul 2022 11:33:29 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6880C980BBE; Wed, 20 Jul 2022 13:33:28 +0200 (CEST)
Date:   Wed, 20 Jul 2022 13:33:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     zengjx95@gmail.com
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org,
        Zeng Jingxiang <linuszeng@tencent.com>
Subject: Re: [PATCH] kernel/sched/cputime: Fix unused value in
 cputime_adjust()
Message-ID: <YtfoCAKfV8PXQz5h@worktop.programming.kicks-ass.net>
References: <20220720102956.1141634-1-zengjx95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720102956.1141634-1-zengjx95@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 06:29:56PM +0800, zengjx95@gmail.com wrote:
> From: Zeng Jingxiang <linuszeng@tencent.com>
> 
> Coverity warns uf an unused value:
> 
> assigned_value: Assign the value of the variable rtime to utime here,
> but that stored value is overwritten before it can be used.
> 568	if (stime == 0) {
> 569		utime = rtime;
> 570		goto update;
> 571	}
> 
> value_overwrite: Overwriting previous write to utime with
> the value of expression rtime - stime.
> 592	utime = rtime - stime;

Coverity is being daft, the compiler has a dead-store-elimination pass.

This way the code is more consistent / easier to ready.
