Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9382A4EE374
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241964AbiCaVvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbiCaVvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:51:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74471554A6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:49:43 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y10so825542edv.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7SP21vb4U1rgi2I4Q8AKkwyUmZpAKc0TGJVD/RSbaHI=;
        b=BDrMiG+XdSewJSHn6PkoOIbnz7uJb91+cpAZ/uEKfi7Sxj3G7NjqZnIklCa7yXE5lV
         Y9B6+aYw90o+blb++BPt9hBaAKyJcSm8sK2Oc0gT7NOCPBZsgocAP5oIUiEYDn+RPOaS
         n23mAnadGM+75XHonxATA2Z5W9xOiYh4taXnsTbFskEuEnYEOFW+RhRNBWF+NabAIb1c
         3HmU+eF3JQ5K5HH8MxY32AysIXTJZ80flZTY0KWc599tjuq6j7uBQJeyBgL+yNEGc0lI
         e4oT5bz2S5NqRN7i6UmKFeYXOPT+/HVdIlJtgE8oXsMFrHHfkYbkUYtHpSrPI39kFA76
         7gTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7SP21vb4U1rgi2I4Q8AKkwyUmZpAKc0TGJVD/RSbaHI=;
        b=yu9+0pik5E47H2+z5jLAPAdNk7N+QAw3V7x1TkZEKo0XWJ2unzkG+JfX6KDbspkXBH
         RIkQuzuq5Jy3cSitKA3mWLG3k2R/VF066bjf5jINtUlj5BvtlumHlc7p2V/r5prsXXd1
         qIEtxIb08anmJ5EQfEYbKQ+7RPaCwXVWyHOHoo+Z18i9kPSPHpDmwWccTx2Xt78UfK9l
         5JHGrxKu/mW7Cdwyqe46bv7I2NwtWsqEtBmEmwMjxFrl7HWPQY/d9RTFenL70iYcA3oR
         +bz483n5ANSDugcCE7AjrL+Wp4OgY5FrVvLU9kVVn930NSdXMdegITkIQYBLzmXMyKe0
         Evmw==
X-Gm-Message-State: AOAM5327NDv3DBdf1BKY5husj4RFIrSyMiAmVkJ6tcKoriox8FzkyLmJ
        cy8a2OkTFjyobBtvxgyRrRY=
X-Google-Smtp-Source: ABdhPJzYvS29RI7/ZwWrcF20ICBxr8z8BPXWcGAcX1cBrZb4I1YyWJANaeby1cRPg06DyjtvCFHoSg==
X-Received: by 2002:a05:6402:f1c:b0:41b:54d2:ef1b with SMTP id i28-20020a0564020f1c00b0041b54d2ef1bmr15939221eda.185.1648763382014;
        Thu, 31 Mar 2022 14:49:42 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id b8-20020a056402350800b00419407f0dd9sm311698edd.0.2022.03.31.14.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 14:49:41 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Russell King <linux@armlinux.org.uk>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH 1/3] ARM: ioremap: remove usage of list iterator for list_add() after the loop body
Date:   Thu, 31 Mar 2022 23:47:17 +0200
Message-Id: <20220331214719.881886-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to limit the scope of a list iterator to the list
traversal loop, use a dedicated pointer to point to the found element [1].

Before, the code implicitly used the head when no element was found
when using &pos->list. Since the new variable is only set if an
element was found, the list_add() is performed within the loop
and only done after the loop if it is done on the list head directly.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 arch/arm/mm/ioremap.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index aa08bcb72db9..417fd5ffa162 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -90,7 +90,7 @@ struct static_vm *find_static_vm_vaddr(void *vaddr)
 
 void __init add_static_vm_early(struct static_vm *svm)
 {
-	struct static_vm *curr_svm;
+	struct static_vm *curr_svm = NULL, *iter;
 	struct vm_struct *vm;
 	void *vaddr;
 
@@ -98,13 +98,17 @@ void __init add_static_vm_early(struct static_vm *svm)
 	vm_area_add_early(vm);
 	vaddr = vm->addr;
 
-	list_for_each_entry(curr_svm, &static_vmlist, list) {
-		vm = &curr_svm->vm;
+	list_for_each_entry(iter, &static_vmlist, list) {
+		vm = &iter->vm;
 
-		if (vm->addr > vaddr)
+		if (vm->addr > vaddr) {
+			curr_svm = iter;
+			list_add_tail(&svm->list, &iter->list);
 			break;
+		}
 	}
-	list_add_tail(&svm->list, &curr_svm->list);
+	if (!curr_svm)
+		list_add_tail(&svm->list, &static_vmlist);
 }
 
 int ioremap_page(unsigned long virt, unsigned long phys,

base-commit: f82da161ea75dc4db21b2499e4b1facd36dab275
-- 
2.25.1

