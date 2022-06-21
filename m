Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA1C55301E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 12:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347764AbiFUKrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 06:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346961AbiFUKqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:46:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6BA29346;
        Tue, 21 Jun 2022 03:46:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FC5AB81761;
        Tue, 21 Jun 2022 10:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AEBC341C4;
        Tue, 21 Jun 2022 10:46:45 +0000 (UTC)
Date:   Tue, 21 Jun 2022 11:46:41 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     elver@google.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, arnd@arndb.de
Subject: Re: [PATCH v4 2/2] arm64: kcsan: Support detecting more missing
 memory barriers
Message-ID: <YrGhkSt/tYF1H84v@arm.com>
References: <20220523113126.171714-1-wangkefeng.wang@huawei.com>
 <20220523113126.171714-3-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523113126.171714-3-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 07:31:26PM +0800, Kefeng Wang wrote:
> As "kcsan: Support detecting a subset of missing memory barriers"[1]
> introduced KCSAN_STRICT/KCSAN_WEAK_MEMORY which make kcsan detects
> more missing memory barrier, but arm64 don't have KCSAN instrumentation
> for barriers, so the new selftest test_barrier() and test cases for
> memory barrier instrumentation in kcsan_test module will fail, even
> panic on selftest.
> 
> Let's prefix all barriers with __ on arm64, as asm-generic/barriers.h
> defined the final instrumented version of these barriers, which will
> fix the above issues.
> 
> Note, barrier instrumentation that can be disabled via __no_kcsan with
> appropriate compiler-support (and not just with objtool help), see
> commit bd3d5bd1a0ad ("kcsan: Support WEAK_MEMORY with Clang where no
> objtool support exists"), it adds disable_sanitizer_instrumentation to
> __no_kcsan attribute which will remove all sanitizer instrumentation fully
> (with Clang 14.0). Meanwhile, GCC does the same thing with no_sanitize.
> 
> [1] https://lore.kernel.org/linux-mm/20211130114433.2580590-1-elver@google.com/
> 
> Acked-by: Marco Elver <elver@google.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

I'll leave the series to Will to queue for 5.20.

Thanks.

-- 
Catalin
