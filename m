Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B72A502698
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 10:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351354AbiDOIWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 04:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238683AbiDOIWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 04:22:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C97B140CC;
        Fri, 15 Apr 2022 01:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hi4xrZ5yZIHwLBnZX8ub/KAkLFYSwqOA4HWjNcaia5k=; b=Qa2CJf0ce3j7I87Yql9/UBsUF2
        qJda9BAv0h4SYyh3zby8qvTvzBIQ2ZAHy6gJd+z7OG/Fzd9MyRZC4XflGybGsxFzS6Mb0feMRcJLD
        PgklKZfP1BNqpw58r3fqkM/aFKTpmur2U3JAK9wPmtdXmY++8gIBqh5gX9uHJl8xnEWN4n5snVyZ6
        2gvEL8mCIBWSHfIhTKo37Hv+KVUMC8Fe7WyzIaFZxyAGGnKBXgjn7OO1lKum1JZWSFIgCzUDDpPzo
        MHqE/3orkOe9pGOQo8T7IT0av3RMAo/zYynzmTzJIlr6ad4Aut1em6HZBfbtYWOEcymtXhf+wDHkB
        WcBk3x0A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfHB9-00Fxui-4U; Fri, 15 Apr 2022 08:19:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 813263001AE;
        Fri, 15 Apr 2022 10:19:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 56BA7202508B9; Fri, 15 Apr 2022 10:19:41 +0200 (CEST)
Date:   Fri, 15 Apr 2022 10:19:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC V2 1/8] perf: Consolidate branch sample filter helpers
Message-ID: <YlkqnfRm0E0XHTd3@hirez.programming.kicks-ass.net>
References: <20220412115455.293119-1-anshuman.khandual@arm.com>
 <20220412115455.293119-2-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412115455.293119-2-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 05:24:48PM +0530, Anshuman Khandual wrote:
> Besides the branch type filtering requests, 'event.attr.branch_sample_type'
> also contains various flags indicating which additional information should
> be captured, along with the base branch record. These flags help configure
> the underlying hardware, and capture the branch records appropriately when
> required e.g after PMU interrupt. But first, this moves an existing helper
> perf_sample_save_hw_index() into the header before adding some more helpers
> for other branch sample filter flags.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
