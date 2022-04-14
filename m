Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2626500B23
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242296AbiDNKde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiDNKd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:33:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E232354186
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:31:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 722AAB82893
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CD5C385A9;
        Thu, 14 Apr 2022 10:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649932261;
        bh=anlZExuz/RXUpLpMBn9p6PwQT+FCiIUgNRUHvHy6288=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wpx5v7klIT/k74ydnZ5+cTvjax9JDVP1wgsofhEur3Hi0gHlxURy5AS37Pr0lO7HV
         aXAM/0qVQRakT9t6m4mKV+61iangNeqtTGPT3v1mfc6JKmoSnanBbLAeCk33TzLsvC
         K8Me60uQnCKb63y9wKIMAP2IGoloakUdVuN4iwN28SLCEDWmQ79JwWynb5ro/bPiSL
         1XKWKziRmbhuWmgc7L7jLnE0TjWmG/Vav5RgPwhGUEro5NvdMCS3dlxs4tR5I/+08+
         +pJwW+E/aVt/xRtA9eaN7ayBdgJq5ku+XW18+54BXEdMVSzftQQz8ZfbNqM776y3K3
         QSs1PT9HVd9aQ==
From:   Will Deacon <will@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: Improve HAVE_DYNAMIC_FTRACE_WITH_REGS selection for clang
Date:   Thu, 14 Apr 2022 11:30:52 +0100
Message-Id: <164992995404.58572.4358662722112998061.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220413181420.3522187-1-nathan@kernel.org>
References: <20220413181420.3522187-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 11:14:21 -0700, Nathan Chancellor wrote:
> Will and Anders reported that using just 'CC=clang' with CONFIG_FTRACE=y
> and CONFIG_STACK_TRACER=y would result in an error while linking:
> 
>   aarch64-linux-gnu-ld: .init.data has both ordered [`__patchable_function_entries' in init/main.o] and unordered [`.meminit.data' in mm/sparse.o] sections
>   aarch64-linux-gnu-ld: final link failed: bad value
> 
> This error was exposed by commit f12b034afeb3 ("scripts/Makefile.clang:
> default to LLVM_IAS=1") in combination with binutils older than 2.36.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: Improve HAVE_DYNAMIC_FTRACE_WITH_REGS selection for clang
      https://git.kernel.org/arm64/c/45bd8951806e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
