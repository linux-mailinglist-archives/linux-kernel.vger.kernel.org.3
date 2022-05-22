Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BD05303E5
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 17:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346458AbiEVPo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 11:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiEVPoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 11:44:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABB73668B
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 08:44:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E08E861003
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 15:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64598C385AA;
        Sun, 22 May 2022 15:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653234262;
        bh=CPNC12uceBtIeQyvRUTPv/UYyC2ND+l4jhk3iSdDZH4=;
        h=From:To:Cc:Subject:Date:From;
        b=eG8Vd5gLFwRA/AUWAQKkSxcx5rGuM2sg3+5whCD0+EzCdhPETdXJXE2Zn5TYunoES
         oPrJsSZzjyO7EjxaqRfxnFP4JBYWmdLPfwc4A5qRzvP2gbgvKMzBOXHoJtoIQ2eC7I
         23VpxiZajsJkUU80RP/ym22/DbrqCuOhMKdRfCU7daipkrBi4W5XqWG8MnJY6D+dgZ
         0+eMNeTH7y8zjf6qiGCkQnUCdbolnShHeou42Twaoz/dDiC4FKwUa/CqLtobilNiRY
         97TFGKk+i+pT+a7hG6xSPrpmGk/CWSHxAGYYRhJAgIanHx6uBn7aPRVrBPlUopoOPE
         Q4qJ7yXymKDKA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] introduce unified static key mechanism for ISA ext
Date:   Sun, 22 May 2022 23:35:41 +0800
Message-Id: <20220522153543.2656-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

Currently, riscv has several extensions which may not be supported on all
riscv platforms, for example, FPU and so on. To support unified kernel
Image style, we need to check whether the feature is supported or not.
If the check sits at hot code path, the performance will be impacted a
lot. static key can be used to solve the issue. In the past, FPU
support has been converted to use static key mechanism. I believe we
will have similar cases in the future.

Since v1:
  - fix typo, thank Atish
  - remove riscv_isa_have_key_extension() instead use the isa ext keys
    directly as pointed out by Atish.

Jisheng Zhang (2):
  riscv: introduce unified static key mechanism for ISA extensions
  riscv: switch has_fpu() to the unified static key mechanism

 arch/riscv/include/asm/hwcap.h     | 25 +++++++++++++++++++++++++
 arch/riscv/include/asm/switch_to.h |  4 ++--
 arch/riscv/kernel/cpufeature.c     | 14 +++++++-------
 3 files changed, 34 insertions(+), 9 deletions(-)

-- 
2.34.1

