Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4657551E93B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 20:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387830AbiEGSiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 14:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiEGSiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 14:38:05 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056302FFF2;
        Sat,  7 May 2022 11:34:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x18so14138553wrc.0;
        Sat, 07 May 2022 11:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KQVod+LIsL2dmZvlmndlBF3HF+IRF2gal3cYOuUcsuc=;
        b=gg9+N19hUZK3SAO4/zkjI2MpjxT8l7+NWmXgp6ZIrrIliOLEmfkhEp2njPbvxW3HXP
         5RgqjdntbRCvqxXSjgpS+N5ncB0a90TkZ6dNXFZWXjnLWBhYYXyNmRCJ+Nk0VSfbtJqr
         4kOXP4DctvbayOMWwdeeGvriYKLxnTuIhhNCNdmVzPuFIvBK17CEXew3eeS91z0lw7Nf
         6bX0YVuf76r+h7/ybhvAyjBK+QBMQv3AHK+KzqxP9iioRPziS9Dh6d1MkIPBoBo9bvyh
         uYqreKxigjgO+srtGQaFVZIa7A+jedUVZlQ+qw2j/8HgVQkn3dOVdDDdHYVXLpDiUsxV
         bMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KQVod+LIsL2dmZvlmndlBF3HF+IRF2gal3cYOuUcsuc=;
        b=t1MHRc6z/yTo4OYv1RuwjHP1mIZgmqvAYrZ3zGNXzvZZsy7C1Bv43dqWugqIoy7ilD
         rgX7khhDerRVZCqDiOd2VCzflioJcvm12nXO9Y4gcI/HRo/fdyCrSi4plE8NpbARdx+S
         4riVZ13TXPHChgE+SNCV/o0ZuPNevqk++tmHKA7tAtOYzKonWPp5tCAb+8Btri48+dRV
         3kP+Sf1+xnqVx3yhGXuULj+7yVHkoVm5IP04TKFfn71vLP/fzidlUemsKYSvkuK6d4eD
         CutqaUglBR4n+CMjb4SOaYRMP1gy1374ewpguo3/aozFshNJ/JgZvEEdGVYzmahT5ee9
         LOYw==
X-Gm-Message-State: AOAM533qO5M9U6rg3qS5KrRB9zq2j41EVeGXDhNZ0MN98El1VmceYhDy
        BdGZQl514/SLCuN3V+bXot4=
X-Google-Smtp-Source: ABdhPJx3Q40DD0GCOXiXnFeZWHGSMIzWaLXzzWc0Le3e9YjapKmr+0+wCmccOvPBxyqn0axEooEe6w==
X-Received: by 2002:a5d:5846:0:b0:20c:7407:5fa1 with SMTP id i6-20020a5d5846000000b0020c74075fa1mr7368426wrf.116.1651948455622;
        Sat, 07 May 2022 11:34:15 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c465200b003942a244f4esm11726417wmo.39.2022.05.07.11.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 11:34:15 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192u: make const array queuetopipe const, reduces object code size
Date:   Sat,  7 May 2022 19:34:14 +0100
Message-Id: <20220507183414.26633-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Don't populate the const array queuetopipe on the stack, instead make it
static.  Also makes the object code smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index ce807c9d4219..2ca925f35830 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2537,7 +2537,7 @@ static short rtl8192_init(struct net_device *dev)
 	}
 #else
 	{
-		const u8 queuetopipe[] = {3, 2, 1, 0, 4, 4, 0, 4, 4};
+		static const u8 queuetopipe[] = {3, 2, 1, 0, 4, 4, 0, 4, 4};
 
 		memcpy(priv->txqueue_to_outpipemap, queuetopipe, 9);
 	}
-- 
2.35.1

