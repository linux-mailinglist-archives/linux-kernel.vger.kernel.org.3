Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2204C63D9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 08:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbiB1Hgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 02:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiB1Hgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 02:36:31 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ECE48E6C;
        Sun, 27 Feb 2022 23:35:53 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id m22so10404142pja.0;
        Sun, 27 Feb 2022 23:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eNQzlZJkJsg681JtNsITrim/wO6tqCPKGyH2V036pnY=;
        b=N7JOakZSQSmEP1Oa+o2/fEb+6ZOVzaBYle/336KLveT44q1/ZB4rIoC6wBgXtYK2iR
         tzFcqAwy+S4hQdpnkrtnjIlMtCllyPvHP21iQb9heF81JL9Czlb8FFAXw9MbgWlXCt7v
         +5BHJoi/gNxoD8woPdGeXQ6vOcEvjVQoAUZidAZzUiRMwGAETGcgHSs/ppAmY/Wr7X3l
         9/mQJ9y3tNKsmMtJkJuw4YcUTBEa1mKrXmIIq9r9G/wNsNqny/YL76/00/0USnxSQa/y
         HMaBzCLWjT9n6n2duvl4YXSncHL2z2n8s8P00rLalRv8bYDyslXOGUj2lCecNeJxva98
         z6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eNQzlZJkJsg681JtNsITrim/wO6tqCPKGyH2V036pnY=;
        b=Hjd7KZnmCJ2qvYUmJQZaCwT8wm3K2TXeC5wEkcs9Vl+w2JbYrbDl8F8VOqG2ikMKKW
         8tY+ZfRpjiZdvHxK0N2eJA8tDUjLPYfadqr5afZkbjM6wm/mCRH+YC3udwSQ7Im3TdM/
         eHL4ycYUXtY3Sm4qvcSvS6mrl8LwiUKvJx79MNktqrmjmshJ0m9gXg5F2iIa+DKafiSo
         lXXfzZv/OdMvfmFIaJlOmt3nqtUxCgPiHYWqsv6cJOx/TgZYKCfFyknBeIIfyrDie5hu
         PyKzM7w1D3ei6qA0pWWr/QKMrVWikcFSg319TjrUNC71Vpw6u0eneDNe8qYCbTzS+cDs
         Iaeg==
X-Gm-Message-State: AOAM5300MOmVPYkIOL3/64eUU+9Mj6XVKoQxEK3uJJNQEiEtgE1UOR9p
        vBAWzalfptzDl2nVg1XjCHM=
X-Google-Smtp-Source: ABdhPJxRf6P1hGGf4GbwgPbFCRR3QL2lZa7eNo1FccD1GmTGtNvPjB9j1vcT0T9Eol/wtcFLwuuZDQ==
X-Received: by 2002:a17:90a:9ec:b0:1bc:50bc:e058 with SMTP id 99-20020a17090a09ec00b001bc50bce058mr15521918pjo.183.1646033752713;
        Sun, 27 Feb 2022 23:35:52 -0800 (PST)
Received: from slim.das-security.cn ([103.84.139.54])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a000a8200b004f1111c66afsm12127133pfl.148.2022.02.27.23.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 23:35:52 -0800 (PST)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     john@phrozen.org, tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] mips: ralink: fix a refcount leak in ill_acc_of_setup()
Date:   Mon, 28 Feb 2022 15:35:37 +0800
Message-Id: <20220228073537.31621-1-hbh25y@gmail.com>
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

of_node_put(np) needs to be called when pdev == NULL.

Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 arch/mips/ralink/ill_acc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/ralink/ill_acc.c b/arch/mips/ralink/ill_acc.c
index 115a69fc20ca..f395ae218470 100644
--- a/arch/mips/ralink/ill_acc.c
+++ b/arch/mips/ralink/ill_acc.c
@@ -61,6 +61,7 @@ static int __init ill_acc_of_setup(void)
 	pdev = of_find_device_by_node(np);
 	if (!pdev) {
 		pr_err("%pOFn: failed to lookup pdev\n", np);
+		of_node_put(np);
 		return -EINVAL;
 	}
 
-- 
2.25.1

