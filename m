Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF2E5243CC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345678AbiELEBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiELEBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:01:43 -0400
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4983B54BDC
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:01:41 -0700 (PDT)
Received: from grover.jp (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 24C41CNO015198;
        Thu, 12 May 2022 13:01:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 24C41CNO015198
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652328073;
        bh=c91VK4cc0aPLndj0XrQbCZoVKMJvCFWmxnmbXXZqAk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U/6Eul6VIR1thO7eiwfiVRIFBQIlcFSE4oEVh6pEx5hLciDe9/3/UY1FG4Uo7K7QE
         Mhbb8miOMv+Bpkmc1z/ewDMAUHWB8WiDo79FhBjZH/oRTUHHiZ0pzMKwnGC/5XpYoC
         +/H2otoPallHcPZmpBGxLuS+ExDCnRfZoLWDxOxTvlugaKkEzgD3t2R3lw4khTy/dI
         E9Vu7KF+sh9GAJsj52b6kGzgIaEBmeXAgb1V/d+F2/AZ/1tISHqnDT+noI6JdDqyyE
         vzm3R4yLFqGHXD6WUDRrWkGdW+cjvW/X29+1KbhUFcX9cqphtVZ6GGqWXlcfU883+f
         ceP66TmZU3CTw==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/4] csky: do not add dts/ to core-y
Date:   Thu, 12 May 2022 12:59:01 +0900
Message-Id: <20220512035903.2779287-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220512035903.2779287-1-masahiroy@kernel.org>
References: <20220512035903.2779287-1-masahiroy@kernel.org>
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

This line was used for embedding a DT into vmlinux.

Since commit c4c14c3bd177 ("csky: remove builtin-dtb Kbuild"),
DT for csky is just a separate blob.

It is covered by the generic rule in the top Makefile:

  ifdef CONFIG_OF_EARLY_FLATTREE
  all: dtbs
  endif

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/csky/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/csky/Makefile b/arch/csky/Makefile
index 866805077636..4d72aca4069b 100644
--- a/arch/csky/Makefile
+++ b/arch/csky/Makefile
@@ -69,7 +69,6 @@ libs-y += arch/csky/lib/ \
 	$(shell $(CC) $(KBUILD_CFLAGS) $(KCFLAGS) -print-libgcc-file-name)
 
 boot := arch/csky/boot
-core-y += $(boot)/dts/
 
 all: zImage
 
-- 
2.32.0

