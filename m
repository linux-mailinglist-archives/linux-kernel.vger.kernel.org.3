Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C74E5AE50E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbiIFKLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbiIFKLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:11:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC3B1E3EC;
        Tue,  6 Sep 2022 03:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oyzRgO+160xovDVemVwmeVt1HmM9L/O1qSGDU54zVFc=; b=VvQ7TGRoxa2LP5V0+kVwtwEiJU
        uIrDlPOaIGlyizQuG+rTXLceNDZFIWfWT7K+uyYpbDtrtb7wyokt9jLFyTHkPtbh9hjEYdt2YRK1j
        oxOm6uhF253+4zAylyVRoQaR2/rE8urqf5ekxqNyFs29oUXuXMI5mdWr8xp2YDGNI89jrurWTtvhu
        QkmGuVH/UAWh6Gi10ou+Gp7n+XZHATqJ1B5QKS85MWvtFOwUicKtQn0Rdfl9xouCe1BmeYcE2dvFu
        /4DsygL9BXoekvIyF36yUNE/+4/O4kaR4myPbtx7Gj20ChXu5OktKN9ccYPW1rmqbR4MA0jV7GBDM
        uT3P99HA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVVW6-00A8BS-Uc; Tue, 06 Sep 2022 10:11:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B2E0F300348;
        Tue,  6 Sep 2022 12:09:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6BAFA2B656AD4; Tue,  6 Sep 2022 12:09:13 +0200 (CEST)
Date:   Tue, 6 Sep 2022 12:09:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf: Consolidate branch sample filter helpers
Message-ID: <YxccSZOGAwdiYrsj@hirez.programming.kicks-ass.net>
References: <20220906084414.396220-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906084414.396220-1-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 02:14:14PM +0530, Anshuman Khandual wrote:
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
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Hello Peter,
> 
> Could you please consider taking this patch along with others on the perf
> ABI series. This patch has been part of the original BRBE driver series,
> which will have one less patch to include going forward. Thank you.
> 
> - Anshuman
> 
> This applies on v6.0-rc4 but after applying the following patch series
> 
> https://lore.kernel.org/all/20220824044822.70230-1-anshuman.khandual@arm.com/
> 

Yeah, but it doesn't cleanly apply to tip/perf/core....

The conflict looks trivial, let me stomp on it to make it fit :-)
