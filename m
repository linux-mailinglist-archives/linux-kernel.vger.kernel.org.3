Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF15255894D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiFWTlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiFWTlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:41:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C408040930
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 12:31:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86726B82506
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 19:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E6FC341C7;
        Thu, 23 Jun 2022 19:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656012714;
        bh=hfn7MS7c60aS32wAZk+VBab7erUth+gMMmPjek20u6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nFPwT5TjxvKyH95nkrvHyOzx3Dfr74NOojDIej/rUolbCIiulRbJqg6uQEQnVwk6y
         4ebzuSmA+FMqfXT/aJqmuWcSPctzC2VjTxIywuKFHXNRJRC6aINqsZraqkKaWwe0T9
         WWa4yhyrSeymZuWH/tq9DAY83Qil9ZUjLd6LUuAxMvcwlP4268DIJymAlcrl+V1nKi
         HeCVhnnIqDs98NoxTeSv5B3e0/xISFzaYFW0XUp9+0RlRHBG9dJsoCngTMxjIJ5jBs
         TRHt5VLWHxD3JaFp5g9IGMIqWZ1tmo3fHmKXN5W6227tZsX/SVOSC8dEBDlr9/XIav
         W9nz4ZnJxmkrQ==
From:   Will Deacon <will@kernel.org>
To:     andrey.konovalov@linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: kasan: do not instrument stacktrace.c
Date:   Thu, 23 Jun 2022 20:31:32 +0100
Message-Id: <165599625020.2988777.9370908523559678089.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <c4c944a2a905e949760fbeb29258185087171708.1653317461.git.andreyknvl@google.com>
References: <c4c944a2a905e949760fbeb29258185087171708.1653317461.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 16:51:51 +0200, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Disable KASAN instrumentation of arch/arm64/kernel/stacktrace.c.
> 
> This speeds up Generic KASAN by 5-20%.
> 
> As a side-effect, KASAN is now unable to detect bugs in the stack trace
> collection code. This is taken as an acceptable downside.
> 
> [...]

Applied to arm64 (for-next/stacktrace), thanks! I had to fix conflicts
in both of the patches, so please can you take a quick look at the result?

[1/2] arm64: kasan: do not instrument stacktrace.c
      https://git.kernel.org/arm64/c/802b91118d11
[2/2] arm64: stacktrace: use non-atomic __set_bit
      https://git.kernel.org/arm64/c/446297b28a21

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
