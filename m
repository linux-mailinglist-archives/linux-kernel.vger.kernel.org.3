Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6370F50DCFC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbiDYJnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241504AbiDYJmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:42:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CFD1A801
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FzeLoq6Z9/8RdG24cy3IuWz/e+Pv2gwxZNw0m+8OPi8=; b=CoW/TX5HGNzrEL01WnKgtsQTR8
        Jpjm9/rZxVf9oBbENDYrXEhs6zGovvyFpMUxbUd1FLpAVV7RIqyjAeyF2ocA9j8BjI8pYXPaxQbm3
        hwNjzDDTLHE4Vq3X+J14Oc6M+YQ/xXVMrb3y5Kbs3qsWTu8VaHbPNqS6giDlh0VVeoyeGRLO+iIIF
        h2Dqef6frpV2cMfYCPzguPPDeE/JGhSnrSeU2R4X6+HUItMAgzlVeiLn1Oeik2IiYoHevcknZiSNZ
        7DL37K0BrAtAvckpx7iMe4Kc74wPHudr5olMt40Byd1XexaZz1S1/xOAwkHvztXtVQtgBqEsOrJPU
        haqM7A3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nivA3-008VlN-Ai; Mon, 25 Apr 2022 09:37:39 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8BF2D980BF1; Mon, 25 Apr 2022 11:37:37 +0200 (CEST)
Date:   Mon, 25 Apr 2022 11:37:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Donghai Qiao <dqiao@redhat.com>
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        heying24@huawei.com, andriy.shevchenko@linux.intel.com,
        axboe@kernel.dk, rdunlap@infradead.org, tglx@linutronix.de,
        gor@linux.ibm.com, donghai.w.qiao@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/11] smp: use smp_call_private() fron irq_work.c and
 core.c
Message-ID: <20220425093737.GH2731@worktop.programming.kicks-ass.net>
References: <20220422200040.93813-1-dqiao@redhat.com>
 <20220422200040.93813-7-dqiao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422200040.93813-7-dqiao@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 04:00:35PM -0400, Donghai Qiao wrote:
> irq_work.c and core.c should use the cross interface rather than
> using a unpublished internal function __smp_call_single_queue.

They should do no such thing, using an unpublished/private interface was
on purpose. Nobody else should be able to do these things.
