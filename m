Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E19580466
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 21:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236544AbiGYTSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 15:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236547AbiGYTR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 15:17:57 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED041C938
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:17:57 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p1so2789793plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nc5mbsO5EttJg9jLfbncA0LC8WA877dNDwcrS6YgrRk=;
        b=YGNTSezmamE1TT1D0qah9lrebCAcP5hMFvzA1C51qcpj99nL5Dty7RDEpPoUuDlJCc
         ZS4Yh1J/3pdxcEITiF81+Qwk9HWEgF2NvKTNRQb8jCtGFSuv+j0UqReUu5F4xVzqgwXF
         WOnP/ikqDjbbBrwZuJrBaAG8U/iRU6DyYhRX8CCi3fmbFlkjFkboKCsmMIn3rW0FxMb6
         qWBA9kwVhdlzIAWRcQUTQbXRxmGLDCzhjGAMepi5fAsD6riRSMNupiIgQbtyMaR86IHE
         9ogteqHyRL9JD85ArX8hoa5poMe6PXVXbzBrUK7jhOmTF0aQCz6g/hdGuKUOMRWX/pos
         sj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nc5mbsO5EttJg9jLfbncA0LC8WA877dNDwcrS6YgrRk=;
        b=0sWnirJfH2mOKmIez8hW918oNks6k+QzOAG+JWdMghi1EywTSmyoUSk9g4XCeaysQj
         8MgmQvnwBc7EJrnMGf2tALZ5VNBv9B783sXy4uzd2Dsrcfv+jwmaaiVz7lUWMXwe/wsp
         tAP4gHoidP/Up25Ejb5FNSpJkaax50WRtZ3l+gBt/Y468U3X47aM5B+Cj7FmdM05RxTH
         ZE/aK2LN9knOJ7Sp0PwbrY9GGwnckWcmSBYFgVnz01XJ6Ur4om0/3vkXvdIxMpa26gS+
         bLlD93enbgQ5DAML48DMfH4Kz1vkf4ionNkt/OYfbZFlLNkE+xGpKy8ZkBowHZ09AtvI
         tdEA==
X-Gm-Message-State: AJIora9PubRKtibiCgtH4qXqZh3EbVtRQBUsr/IQAIELXXHtfg/geMBH
        eHtBlvxkg57SZY+z4nW21cUNxIfiPzA=
X-Google-Smtp-Source: AGRyM1tokQVnjdAkIgGb+KHxxfOdpkJirYK+Db287xsHtgvpecF+UVkPIkV897mcVVdjkpQbhEqOSg==
X-Received: by 2002:a17:902:8346:b0:16d:1fb6:3e9c with SMTP id z6-20020a170902834600b0016d1fb63e9cmr13031261pln.28.1658776676149;
        Mon, 25 Jul 2022 12:17:56 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:29f7:d008:e76a:7fb5])
        by smtp.gmail.com with ESMTPSA id y22-20020a170902b49600b0016c5306917fsm9608075plr.53.2022.07.25.12.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 12:17:55 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] drivers/nvme: fix pr_warn format string
Date:   Mon, 25 Jul 2022 12:17:51 -0700
Message-Id: <20220725191751.960838-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use %zu format instead of %lu to print variable of size_t type.
This fixes the following gcc build error on 32-bit targets:

  error: format '%lu' expects argument of type 'long unsigned int',
  but argument 3 has type 'size_t' {aka 'unsigned int'}

Fixes: 71ebe3842ebe ("nvmet-auth: Diffie-Hellman key exchange support")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 drivers/nvme/target/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index bf92435c783c..716a10ca91d1 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -488,7 +488,7 @@ int nvmet_auth_ctrl_exponential(struct nvmet_req *req,
 		return -ENOKEY;
 	}
 	if (buf_size != ctrl->dh_keysize) {
-		pr_warn("ctrl %d DH public key size mismatch, need %lu is %d\n",
+		pr_warn("ctrl %d DH public key size mismatch, need %zu is %d\n",
 			ctrl->cntlid, ctrl->dh_keysize, buf_size);
 		ret = -EINVAL;
 	} else {
-- 
2.30.2

