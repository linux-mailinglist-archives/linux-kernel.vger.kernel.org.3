Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F435135AE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347728AbiD1Nxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbiD1Nxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:53:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86996362
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:50:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C3F2B82D0B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 13:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E66C385A9;
        Thu, 28 Apr 2022 13:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651153834;
        bh=lpXW7055S+mTrTHlyLLA0eB+NCa94ZOzWfpWLd/fvcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dp1/EdM2gducaCfo1aZYBYWNogr4eU6pawZUi1s51wQa5EroOvfHsoyXSZ7uuWO5X
         HpiT0bnngSpsf4ztXmMq1cfdCefPzzlBlqkRc5OgGD3biE0MahzbMtMsd2A9Sgs9Z3
         w3Mz3dSoDQCFfAcG+eRiUSU0HJxPCixVx8ZLe2vXIHKw47pp3yJXOdjNcLvx/dIA/g
         VSFYtZX/QexAzH8Z2cOyGVJvdqLS3PUdrBEoB56CLge9PKtZjl9tvKjhd1qOsL0ZLf
         2ky8OSmPV9GNKxQHVh60AHidyizKXqJ7KLlU3yXaQHp+hrsJoLPvE0yr+irtAQkGUV
         85FJiaFj/h0Rg==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Luis Machado <luis.machado@arm.com>,
        linux-kernel@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] elf: Fix the arm64 MTE ELF segment name and value
Date:   Thu, 28 Apr 2022 14:50:27 +0100
Message-Id: <165114222645.2893052.12842449930657953509.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220425151833.2603830-1-catalin.marinas@arm.com>
References: <20220425151833.2603830-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 16:18:33 +0100, Catalin Marinas wrote:
> Unfortunately, the name/value choice for the MTE ELF segment type
> (PT_ARM_MEMTAG_MTE) was pretty poor: LOPROC+1 is already in use by
> PT_AARCH64_UNWIND, as defined in the AArch64 ELF ABI
> (https://github.com/ARM-software/abi-aa/blob/main/aaelf64/aaelf64.rst).
> 
> Update the ELF segment type value to LOPROC+2 and also change the define
> to PT_AARCH64_MEMTAG_MTE to match the AArch64 ELF ABI namespace. The
> AArch64 ELF ABI document is updating accordingly (segment type not
> previously mentioned in the document).
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] elf: Fix the arm64 MTE ELF segment name and value
      https://git.kernel.org/arm64/c/c35fe2a68f29

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
