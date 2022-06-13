Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2272A549D15
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241558AbiFMTMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351943AbiFMTK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:10:26 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370B85044E;
        Mon, 13 Jun 2022 10:09:40 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 25DH9AWh022790;
        Tue, 14 Jun 2022 02:09:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 25DH9AWh022790
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1655140152;
        bh=YbzE3+y/DI8jqW6zA18qkxBAdz5ZgsVhttgS5ZMF2tQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=th4X5pFb3hN4Tu6oxiwlowHy3+oU5WPFBAiS0sgwsqm7WLuh57+8zW/16USk7hxGY
         /fsCyQv8/YHvYBkgyD/26d/SGuTYmNZiyZ1DnsTrocRGIX30yS7xS5QpHSUOXg5mH9
         6NpgI58I1kGAmIDXZkNe8w3PqvLElbcz6G75uSAy92A2AcvCmVbLpuWfstNvHbhhTg
         ivOGXKovCaw56KQqAfLT84frsVjEYHdz5hM1AqmnoRKfYeBQ/xCfScsWsHLCKCodsg
         ZMvvP5Lf73Nmi3xYMJ53RzjTwGHKPlaldQi+zCza8vDDMm11AnXkpy+AXZMnW91ahz
         J8AFsEuhpCaBA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] s390/purgatory: hard-code obj-y in Makefile
Date:   Tue, 14 Jun 2022 02:09:01 +0900
Message-Id: <20220613170902.1775211-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220613170902.1775211-1-masahiroy@kernel.org>
References: <20220613170902.1775211-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purgatory/ directory is entirely guarded in arch/s390/Kbuild.
CONFIG_ARCH_HAS_KEXEC_PURGATORY is bool type.

$(CONFIG_ARCH_HAS_KEXEC_PURGATORY) is always 'y' when Kbuild visits
this Makefile for building.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/s390/purgatory/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index 360ada80d20c..3e2c17ba04de 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -51,4 +51,4 @@ $(obj)/purgatory.ro: $(obj)/purgatory $(obj)/purgatory.chk FORCE
 $(obj)/kexec-purgatory.o: $(obj)/kexec-purgatory.S $(obj)/purgatory.ro FORCE
 	$(call if_changed_rule,as_o_S)
 
-obj-$(CONFIG_ARCH_HAS_KEXEC_PURGATORY) += kexec-purgatory.o
+obj-y += kexec-purgatory.o
-- 
2.32.0

