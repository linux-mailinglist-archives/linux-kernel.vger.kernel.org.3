Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEA2573D4C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 21:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbiGMTln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 15:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiGMTll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:41:41 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F005193C3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 12:41:40 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x91so15453463ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 12:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JlnibxcVeuTrhNTEEnDRxSqv9Basa+SCy0cDueYCtlc=;
        b=jBAPtS4Ht/YA1HgAGo6nJNH/Chk8wnobIGUV0wDT+rB+LpKCbeju35dcl6+RhymLiV
         GFi7Zn+xCibhgRWe6lKi+ZLx21m3/yO3hBHrFmpQ/eO4Cv9pwmML8RyqfMaGLZgOWckx
         yeswEmcWlkDjU4cTrCYv6KkfuEBLS+Q+zyu2Zo9QYMSiZzdaDZIE0fXi4ly7g6l5ewdd
         KRIH9eFv7yfvm06lxENNAW2jjMPdpEuR5t3zrF2AdWl4wN9k00x+c7FaauDrfOn1f7++
         GzhIwJ/NPXOqTFuwhcuaKCX8Lcgb5FmsvMuaLxtin630rcd2NFEQcrY1nMH1yuzmwTx+
         AkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JlnibxcVeuTrhNTEEnDRxSqv9Basa+SCy0cDueYCtlc=;
        b=1eP8DLqTrvOAfuifkkn5yznlPfkIqNgLG5Omn2ckngjy/B0FZC3R5j48s+Nxyf4afV
         JckeiibTqR6xkKdvQyDTVojndHaG7sclhAtG61XZ5b1taFM/JF5yOp81cTxrKfigQTU2
         foWRSnsChVKcCnFhMFlAdoSiMxvasF9cuq4fRkMVHYJ6vG+leFLNPrPR3jML/eEnboGL
         kcaEMLvTtKEPzOIXu7CZZIekNVzd84jMQ/60nS8VgFroqDcPNYF4rvC9ys6e36SPk03y
         bqnOFXEZgJ4n1pWxXD4/YnU8V43bWiVsWFfjAyzJ2weWr96iQSq6zghfK8XTGSWcZp/u
         j84Q==
X-Gm-Message-State: AJIora89t3RovfpwNI/s18GRY153JU0T3mEDO9vJNuTq1eizR2VIKeA9
        yahDHBA4s+4uTQ7Aw+VMq6Y=
X-Google-Smtp-Source: AGRyM1uSW0QI8pe9PbQC9T7YLuAeVqej2y5W9kIfl+NR68Fq3mFmeO9Fbwt/6+LesiTSKdhmzI1ZWg==
X-Received: by 2002:a05:6402:2802:b0:43a:9098:55a0 with SMTP id h2-20020a056402280200b0043a909855a0mr6995944ede.179.1657741298988;
        Wed, 13 Jul 2022 12:41:38 -0700 (PDT)
Received: from bhl6zntu.conti.de ([2a02:908:2525:6ea0:46bb:cacc:f548:7466])
        by smtp.gmail.com with ESMTPSA id i20-20020a170906a29400b0072a881b21d8sm5294390ejz.119.2022.07.13.12.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 12:41:38 -0700 (PDT)
From:   Wadim Mueller <wafgo01@gmail.com>
Cc:     Wadim Mueller <wafgo01@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH] checkstack: add riscv support for scripts/checkstack.pl
Date:   Wed, 13 Jul 2022 21:41:10 +0200
Message-Id: <20220713194112.15557-1-wafgo01@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/checkstack.pl lacks support for the riscv architecture. Add
support to detect "addi sp,sp,-FRAME_SIZE" stack frame generation instruction

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 scripts/checkstack.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index d2c38584ece6..d48dfed6d3db 100755
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -16,6 +16,7 @@
 #	AArch64, PARISC ports by Kyle McMartin
 #	sparc port by Martin Habets <errandir_news@mph.eclipse.co.uk>
 #	ppc64le port by Breno Leitao <leitao@debian.org>
+#	riscv port by Wadim Mueller <wafgo01@gmail.com>
 #
 #	Usage:
 #	objdump -d vmlinux | scripts/checkstack.pl [arch]
@@ -108,6 +109,9 @@ my (@stack, $re, $dre, $sub, $x, $xs, $funcre, $min_stack);
 	} elsif ($arch eq 'sparc' || $arch eq 'sparc64') {
 		# f0019d10:       9d e3 bf 90     save  %sp, -112, %sp
 		$re = qr/.*save.*%sp, -(([0-9]{2}|[3-9])[0-9]{2}), %sp/o;
+	} elsif ($arch =~ /^riscv(64)?$/) {
+		#ffffffff8036e868:	c2010113          	addi	sp,sp,-992
+		$re = qr/.*addi.*sp,sp,-(([0-9]{2}|[3-9])[0-9]{2})/o;
 	} else {
 		print("wrong or unknown architecture \"$arch\"\n");
 		exit
-- 
2.25.1

