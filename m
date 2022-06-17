Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF3154F848
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381920AbiFQNW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiFQNW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:22:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E305EBEE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 06:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MDR12awW51Ll0dBLqMaR6ReVFOSITZQ6xw6in44GvX0=; b=FJuRoKamFQBxRuRHYyHn7LY1b/
        kmD3gZeeSSnjNFJ8uvWhRC5Z3kolqsE1354U0RYcPee5cBY81SBmQ0+FgKvaKCDKe5MLXrm8yOiys
        6aIQOF5lFqkr952B0c9jmzUwEQ7aenTrk+5IgLXLkcVJxuSlNLEIMHmi9Nhj7DFCyAXOKR2oJBH7L
        zKUT4SfQz7wCR8wbDZOF3ObNVo96hExCeFMM/DXaEcbjjGUaK6wsdS7dv/paHh/6gKGWrTA8n2q6o
        0PxePUoRFR3Vz6hWGidhV8YhQDZF1nxDA6WT8aD+ZRHlvqyu2lrqF6wlyoad6OOtCnStewqNhuOlf
        hHW6AUPg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2BvQ-008hHY-Ct; Fri, 17 Jun 2022 13:22:12 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8DB749816B5; Fri, 17 Jun 2022 15:22:10 +0200 (CEST)
Date:   Fri, 17 Jun 2022 15:22:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Jun <chenjun102@huawei.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, will@kernel.org,
        xuqiang36@huawei.com
Subject: Re: [PATCH 1/1] lockdep: pass curr_inner to
 print_lock_invalid_wait_context
Message-ID: <YqyAAvSw3+0GyHhg@worktop.programming.kicks-ass.net>
References: <20220616134042.130002-1-chenjun102@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616134042.130002-1-chenjun102@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 01:40:42PM +0000, Chen Jun wrote:
> Same information (task_wait_context(curr)) is printed twice.

Yes, because at that point the inner and outer context are the same.

> curr_inner in check_wait_context is what we need.

IIRC it simply prints the task_wait_context as a starting point, the
lockdep_print_held_locks() should include the contexts for each of
those, after which you can compute the resulting value.

IOW, the information is complete.

