Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B646549D17
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240662AbiFMTMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351945AbiFMTK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:10:26 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3710B5044F;
        Mon, 13 Jun 2022 10:09:40 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 25DH9AWi022790;
        Tue, 14 Jun 2022 02:09:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 25DH9AWi022790
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1655140153;
        bh=UA9/fYJvchh2CGLlij799ZPBSTxPFYv5eF54/TVtR6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WWWI68zP5I/8k4ImNqC3654WYfwV9CnNSxCzHFwuucAF54sVRdAiBsjDs1rCYxJVk
         2vvtvtMzeqYAnpItw8GYekLzUyDb77BtI293WkdVMEcOj61c0H3PUyX5voBXq6lAsw
         8yWL3RGwsgKmYKCbBv8Qmow9YjS7iEAW1tLH4bXG7Fq2axmeN/+CXAjrOWwdUA3AVn
         ALeRgmAskZrhMNcWBXjKuF9lV4utKM0MJHRA9dih7nRuKHDh34ue+nnoMW6Riyfl/C
         G7PDH/GeX0e51CD81Sq9AGz2CVcVbgKEZMT1rdVMLv5PBnpKBklNNNZc3hOxVMlyTN
         da1vnWMVWUyCQ==
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
Subject: [PATCH 3/3] s390/purgatory: remove duplicated build rule of kexec-purgatory.o
Date:   Tue, 14 Jun 2022 02:09:02 +0900
Message-Id: <20220613170902.1775211-3-masahiroy@kernel.org>
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

This is equivalent to the pattern rule in scripts/Makefile.build.

Having the dependency on $(obj)/purgatory.ro is enough.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/s390/purgatory/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index 3e2c17ba04de..d237bc6841cb 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -48,7 +48,6 @@ OBJCOPYFLAGS_purgatory.ro += --remove-section='.note.*'
 $(obj)/purgatory.ro: $(obj)/purgatory $(obj)/purgatory.chk FORCE
 		$(call if_changed,objcopy)
 
-$(obj)/kexec-purgatory.o: $(obj)/kexec-purgatory.S $(obj)/purgatory.ro FORCE
-	$(call if_changed_rule,as_o_S)
+$(obj)/kexec-purgatory.o: $(obj)/purgatory.ro
 
 obj-y += kexec-purgatory.o
-- 
2.32.0

