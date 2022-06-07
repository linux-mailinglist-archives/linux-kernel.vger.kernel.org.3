Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2AB54016F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245543AbiFGObj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244421AbiFGObc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:31:32 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AFCCE5C9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:31:29 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1nyaEv-0008Ra-8h; Tue, 07 Jun 2022 16:31:25 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, mick@ics.forth.gr,
        samuel@sholland.org, cmuellner@linux.com, philipp.tomsich@vrull.eu,
        hch@lst.de, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 0/2] riscv: Add macro for multiple nop instructions
Date:   Tue,  7 Jun 2022 16:30:57 +0200
Message-Id: <20220607143059.1054074-1-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some cases need multiple nop instructions and arm64 already has a
nice helper for not needing to write all of them out but instead
use a helper to add n nops.

So add a similar thing to riscv and convert the T-Head PMA
alternative to use it.


Heiko Stuebner (2):
  riscv: introduce nops and __nops macros for NOP sequences
  riscv: convert the t-head pbmt errata to use the __nops macro

 arch/riscv/include/asm/asm.h         | 15 +++++++++++++++
 arch/riscv/include/asm/barrier.h     |  2 ++
 arch/riscv/include/asm/errata_list.h |  8 +-------
 3 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.35.1

