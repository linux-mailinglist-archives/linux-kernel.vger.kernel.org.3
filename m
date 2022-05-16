Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCB65284DE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239225AbiEPNBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243713AbiEPNBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:01:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B12339B8A
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652706075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2uT7yQARA8zTV6HO5pae5HfOKv/Dq0SyPUtl99rYMNU=;
        b=QIouniY+Y6GwosInvf05bTZHmj1voz0EtwtVdap+zDyp2XVxVnCcpMLt9hCRKEQnatqvBH
        4s6EYXskpMcG+WRNEEuURXAWgWAhdpa7G+PaMWNFoj2Oj6WVi1K5pECTcoTqn83+M25SF/
        OleWOcefrTVII/IAXXaQM1kaylgI7Ws=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-ooSmTQ0YOBeuc8NlPJVJvA-1; Mon, 16 May 2022 09:00:53 -0400
X-MC-Unique: ooSmTQ0YOBeuc8NlPJVJvA-1
Received: by mail-qt1-f197.google.com with SMTP id o16-20020ac87c50000000b002f3b8cd6a7fso11375665qtv.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2uT7yQARA8zTV6HO5pae5HfOKv/Dq0SyPUtl99rYMNU=;
        b=yCiyHmZ5pDd8/Oq+BjU+SfXZC1el8oyAKwVfR/Th7WCT/kuHsjkdUVqA0EsdVsF/Db
         i/5DavJfFMAJbcdy9Taik5M22mtKEGxyH0btZgGtPKY2dy8IG1OWNcDNAoDqDOdy0IcI
         NRw/egrM8wAYI35vnDlz7QrczyIbgfDBJhnYo/LY7hX/PY4XAK5J+1gZUNcAKYgI3Rdk
         8NNjCGkH0V0DPuusquCfi5MJDX6DSbgn8h4tcpYiGMmIW4wO/NWwcYrRYmtGw6VMp0pd
         VkPoEp8roCHfEbRQEeXtERCOfY3WGhqX3isoZ/NfrRCtBSqjqJJqtAqXe16lnpzXyTNo
         LV2Q==
X-Gm-Message-State: AOAM533IHoS60OnCYXrA7kRRCNnYCcmzYsiN8EXejhRmpE0pu+booq1J
        MesESAYOO1ScoSIt9A80jR6B1GWXb72UhOvNbHPbkE/NSdCMNbbGxoNtQZJHk8oUrzuV+gtdiw1
        z2kR0YONtDpU15U9gDUaT4UbE
X-Received: by 2002:a05:622a:1007:b0:2f3:ce52:25cb with SMTP id d7-20020a05622a100700b002f3ce5225cbmr14709121qte.575.1652706052250;
        Mon, 16 May 2022 06:00:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNht8rGcaLaO05BcV93CYZW69Np2z7XC2tycEAx59FmOgMOIeugmyXFY/sA9nHZmHtxk6cqw==
X-Received: by 2002:a05:622a:1007:b0:2f3:ce52:25cb with SMTP id d7-20020a05622a100700b002f3ce5225cbmr14709098qte.575.1652706051876;
        Mon, 16 May 2022 06:00:51 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g18-20020a05620a13d200b0069fd9de088esm5485582qkl.93.2022.05.16.06.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 06:00:51 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, nathan@kernel.org,
        ndesaulniers@google.com, ricky_wu@realtek.com,
        kai.heng.feng@canonical.com
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] misc: rtsx: Set setting_reg2 before use.
Date:   Mon, 16 May 2022 09:00:47 -0400
Message-Id: <20220516130047.3887590-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clang build fails with
rts5261.c:406:13: error: variable 'setting_reg2' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
        } else if (efuse_valid == 0) {
                   ^~~~~~~~~~~~~~~~

setting_reg2 is set in this block
  if (efuse_valid == 2 || efuse_valid == 3) {
..
  } else if (efuse_valid == 0) {
    // default
..
  }
But efuse_valid can also have a value of 1.
Change the 'else if' to 'else' to make the second block the default.

Fixes: b1c5f3085149 ("misc: rtsx: add rts5261 efuse function")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/misc/cardreader/rts5261.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index 749cc5a46d13..f22634b14dc8 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -403,7 +403,7 @@ static void rts5261_init_from_hw(struct rtsx_pcr *pcr)
 			setting_reg1 = PCR_SETTING_REG4;
 			setting_reg2 = PCR_SETTING_REG5;
 		}
-	} else if (efuse_valid == 0) {
+	} else {
 		// default
 		setting_reg1 = PCR_SETTING_REG1;
 		setting_reg2 = PCR_SETTING_REG2;
-- 
2.27.0

