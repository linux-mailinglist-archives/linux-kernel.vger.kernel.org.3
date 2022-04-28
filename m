Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D95513001
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344970AbiD1JbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346967AbiD1J2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:28:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658BE7C148
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pAUQNOu/Xvx7sFYGMIzT4ewYo8Q7kV8gZxOmlw0y+YM=; b=jqnHwtfwPzIMOxRJieRwoVN/LW
        /DxvM9UQ768YHGbiJBLdVw9xqqWNmPGGbOcxAgDHztVX04XSnvNkIhMBzhxEzVn5XBaLXtbcE4toA
        05ALgAGxnAIh4J0a37Q2e+i3/wF6PFpmt0GPpUPtb5t56uL4XEg2BhC5lrS9f3Ot1gCnlPooNreNv
        v36cre5Gr3G2xyncU0RmtlhIlIuEDsnrjstUTxcQJfnJuwBPo5jdDc3kUzTFz4OL8wjB/8M1G2MJr
        V8fKp5e7NNXwKN0Efbbru9omO9wpAitwKm6jEiKHaR6HfhFaCg7ws6DZMYhxObotHq9+3nwDgd2E4
        qh7gWbuQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nk0OF-009JKd-N5; Thu, 28 Apr 2022 09:24:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D7B51300C88;
        Thu, 28 Apr 2022 11:24:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B93B22029F872; Thu, 28 Apr 2022 11:24:45 +0200 (CEST)
Date:   Thu, 28 Apr 2022 11:24:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jun Miao <jun.miao@intel.com>
Cc:     elver@google.com, dvyukov@google.com, ryabinin.a.a@gmail.com,
        bigeasy@linutronix.de, qiang1.zhang@intel.com,
        andreyknvl@gmail.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH v2] irq_work: Make irq_work_queue_on() NMI-safe again
Message-ID: <YmpdXfJswI9rlG3w@hirez.programming.kicks-ass.net>
References: <20220427135549.20901-1-jun.miao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427135549.20901-1-jun.miao@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 09:55:49PM +0800, Jun Miao wrote:
> We should not put NMI unsafe code in irq_work_queue_on().

Why not, irq_work_queue_on() is not NMI safe. Only irq_work_queue() is.

