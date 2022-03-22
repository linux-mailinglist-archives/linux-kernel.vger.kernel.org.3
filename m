Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E7C4E3F17
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbiCVNEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbiCVNEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:04:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C8880205;
        Tue, 22 Mar 2022 06:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YLFI2fBZ0UWYJRw3Uru9b5P3P4hYSoc85pA5ka88n10=; b=WG22YZvtwG4Fo0YHKUXk/x5LvT
        lFgW3bQzbFblWqZeWJFx5sx76UKKVR6hoPv666ldogD3qgJNMvRyuUef8I2XkftU7K24rRE9aaSUz
        QXDIDxCe8cLUNP1FMWt4uvRa9LkVuUYZjEeJ8s4KMzjwA8ET6ytT7qz2yySk5eN2msqdCIsu50llw
        t+iYFPrmXM7KBxUE//awVNRDsIJ0++Yy7VyHf+/BWAEho3O8JDB0dTro8SdCbqba+EMpFzS2akRsu
        CCizPmJ+lXSfw+gplxhDUZrsP9fFsa0BAfUL0CIR/NJg+ZnCkrpnSbpNzdUarayxuUit+Z2ZqPTlo
        j2UGfTig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWeAE-00BbVD-Q5; Tue, 22 Mar 2022 13:03:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6CC8F30007E;
        Tue, 22 Mar 2022 14:03:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5B8272D273A0F; Tue, 22 Mar 2022 14:03:06 +0100 (CET)
Date:   Tue, 22 Mar 2022 14:03:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
Subject: Re: [PATCH v2 4/6] perf/core: Use stable cpuctx->cgrp when update
 perf cgroup time
Message-ID: <YjnJCr6QRtj6agJz@hirez.programming.kicks-ass.net>
References: <20220322120834.98637-1-zhouchengming@bytedance.com>
 <20220322120834.98637-5-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322120834.98637-5-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 08:08:32PM +0800, Chengming Zhou wrote:
> The current code use the changeable task->cgroups when update
> the perf cgroup time, which maybe not the active perf_cgroup
> that sched_in on the CPU.

How?!?

