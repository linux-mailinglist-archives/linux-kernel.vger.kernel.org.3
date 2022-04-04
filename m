Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B294F17F0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378431AbiDDPJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378221AbiDDPJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:09:25 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F3F38BE7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 08:07:28 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p10so17812501lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 08:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l4K0SPmrnpSn+fuUk7g4we7BJ74/J43n2XWdTPtmJBY=;
        b=Ad07ZzvunE3vZQtLzo5oDTRUrzKUmJcuBL0FbcbaEl0KGYWarSn0QKuZZQYbwuSSuZ
         wtcBtSCHTQCgVtySsb2f4cNXXgfmVXK9iMYOf7MZ8y2nj2EgEjxwxeNHht4iVplfXfs/
         nUa+TtF0GebuFRkL+TKr16ROoQMr5Yz3by+75gob+fzrIq9suL3OQa6U983SQWsxerHL
         bVKih6bEwFv0tyn/gswydnIFA9qXCvebjlDigAgglaUW4OGpSYAjXGPZrj5u3ErtP7AF
         P7gtJ6ROBlM1en4GGhJ2seEKlMov16qqLwWSW0E22p+H8rehyhyy8EXaywJ9Xd5E5+i5
         CZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l4K0SPmrnpSn+fuUk7g4we7BJ74/J43n2XWdTPtmJBY=;
        b=I6XUGr5xX0CJpNYCDrnQxRE2T0mjAXqmEtVm7tD+MJY5wjcq/QaT8rdWIJumGs4WCH
         qmKuerdpKoYog4pDW7yc5gXYtHs7MZL+2YdG3zs3D8sjy/ZjytXAA43T6fOWb2c9K273
         jdLmoxK+WSpBaq0sOx+vmQJHpPAl7yELBydDD3Y48RFcxuW4Zl3o4bM6ibhrmIhmk4e3
         OTfYldZzpOpD3C7lvcxnc9fRwzcgO1DBT+tNVlOX6t3qtvCOBhFJK2CoqCA31Earho1z
         1DcFWiBKNtGaWIR7w2Lh8bl51gixt674JZsu7s4Oi4Rjm/IaF1i9We4fr8h2VQIxqXNT
         D3tw==
X-Gm-Message-State: AOAM530eT6KVK+LZT37OOuM27hEn/gfRk6zIFLMLdVzaiHccnXxwj48i
        fl5rMaNSFWOZngK5Mr6xohE=
X-Google-Smtp-Source: ABdhPJwRKTX9sNlZWMzdB6xUQCUTu18lQdxp4IePtSAY9nUucUvvosWFtS7ZPo9Md4LR3rZGocfQTg==
X-Received: by 2002:a05:6512:280d:b0:44f:5af8:1958 with SMTP id cf13-20020a056512280d00b0044f5af81958mr76653lfb.533.1649084846725;
        Mon, 04 Apr 2022 08:07:26 -0700 (PDT)
Received: from freyja.wlan (dzx1kfyjwg96s--vr8cxy-3.rev.dnainternet.fi. [2001:14ba:a4ea:8200:f22f:74ff:fe2e:e0a6])
        by smtp.gmail.com with ESMTPSA id bi2-20020a0565120e8200b0044826a117bcsm1163279lfb.44.2022.04.04.08.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 08:07:26 -0700 (PDT)
From:   Jan Varho <jan.varho@gmail.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org, Jan Varho <jan.varho@gmail.com>
Subject: [PATCH] random: fix add_hwgenerator_randomness entropy accounting
Date:   Mon,  4 Apr 2022 18:04:42 +0300
Message-Id: <20220404150442.934496-1-jan.varho@gmail.com>
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

add_hwgenerator_randomness tries to only use the required amound of input
for fast init, but credits all the entropy if even a byte was left over.

Fix by not crediting entropy if any input was consumed for fast init.

Signed-off-by: Jan Varho <jan.varho@gmail.com>
---
 drivers/char/random.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 1d8242969751..fb20178f1044 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1141,12 +1141,10 @@ void add_hwgenerator_randomness(const void *buffer, size_t count,
 				size_t entropy)
 {
 	if (unlikely(crng_init == 0 && entropy < POOL_MIN_BITS)) {
-		size_t ret = crng_pre_init_inject(buffer, count, true);
-		mix_pool_bytes(buffer, ret);
-		count -= ret;
-		buffer += ret;
-		if (!count || crng_init == 0)
+		if (crng_pre_init_inject(buffer, count, true) > 0) {
+			mix_pool_bytes(buffer, count);
 			return;
+		}
 	}
 
 	/*
-- 
2.25.1

