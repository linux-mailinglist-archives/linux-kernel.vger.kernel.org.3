Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0028561F48
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbiF3PcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbiF3PcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:32:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1093B00D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 08:32:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE7DAB82BD1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 15:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37AFC34115;
        Thu, 30 Jun 2022 15:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656603119;
        bh=qbZJbSa8lQwxYorl/dCGnDiEWfOBAhdj2CRrnnSbJfU=;
        h=From:To:Cc:Subject:Date:From;
        b=l2JhklebOUOdCVGA1lDmFYVa4jWZzEcGdGXEV2UDwZ8DOlzglNliJkVhZTCgzhxTu
         g6E2RZkBzY7VLFK/c2ff6yxgsEd7EYTkraW+Q1leXffAEHM0hSSkiF5ZPKGz4Dlek5
         3abaog3N64Wzmeon8GA+wu8s1aXoC9wTBAHWcyL/OrT/L9dUCoPCy4dXSnbiVujsXW
         T6BXl4Hhc5ndvf3GfPd31Orzvz8rBF8pACgwgre9+Te27NwP33mE2ac9RlGstwF/0o
         I7peIIRC1ATSNaL6AKGGGjOF7jkO4zIa/T/ban6zqOuDGR6axcEbl9nuuYu6SdpTmC
         DK2euDXfiaVwQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linudx.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/2] arm64: vdso32: Small fixes for ld.lld 11 and CONFIG_DEBUG_INFO
Date:   Thu, 30 Jun 2022 08:31:19 -0700
Message-Id: <20220630153121.1317045-1-nathan@kernel.org>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This small series fixes two issues I noticed with the orphan section
warnings in the 32-bit vDSO. See the individual commits for the boring
details.

They are based on for-next/vdso. I compiled with LLVM 11, LLVM 15, and
GCC 12.1.0 + binutils 2.38 with no additional warnings/errors.

Nathan Chancellor (2):
  arm64: vdso32: Shuffle .ARM.exidx section above ELF_DETAILS
  arm64: vdso32: Add DWARF_DEBUG

 arch/arm64/kernel/vdso32/vdso.lds.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


base-commit: 4274929c7ee6f442c3f89c5da64d112a9de4a6ba
-- 
2.37.0

