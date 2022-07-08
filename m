Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8C856C550
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238464AbiGHX1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 19:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237542AbiGHX1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 19:27:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91C4419BB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 16:27:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z9-20020a258689000000b0066e38ab7122so70555ybk.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 16:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Ve6oVejVoHe94bNa2F7Xf7bSBWGFdxZz7tlbGpk1Sxk=;
        b=sXKlEOSNgGd96A9Vg+CIJ3VEjTYQeqJKiO+SuHhf7ewn3AK6Lc5uWtw5Lj7V1uf2nc
         bqeJ38Jh7zdeUJR+VDKrPeqL8HDwi6vHPc87aX6OeJ2OQdWI5YovDZmXbpXvkkVOroRh
         VdCMbu5KniLAdZb+XkMbP0wWQPpunOGClKmWSYhmDdjKPmYKFhJBnjyiLKoAUCND6vL5
         NJ5qXBzKrEI2ZrFu5V+vpAaFUsEYJpGpAApF++2uTAD0j8iGe/bgS6bn7nuRTi0tCIBs
         zZthxEFhqHm/ttVj4kgZOPEFUf+RvcZTeSNlYXySTFk07uz2XyZE35h2hFgeNYa4PVHK
         rTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Ve6oVejVoHe94bNa2F7Xf7bSBWGFdxZz7tlbGpk1Sxk=;
        b=KMF+r+D3+5oKP2IznhKjkAc4CDhj3Qi7e/PxtK+DlTdFh3pjOKvFcPOxBKwU8piPhA
         ETMYDzYL/CNbl0eMhwofTtFfTeyLjQpgAiyTIdqzmxP+rLSFyjQdUlV72Pi7U+E1EmRt
         88H6wSv8RiU2jyuBy3bqVoY8FOetN9q/SoZds5wqs7IfbFAvVPtu/U9oKTqR2ABnDbgA
         vIOFr0shyd125JKMip/PvQPqpuurGcmmKbeqxsHywkTAeRLno6VrS7tqvckA1+r7afPP
         qQWgk2nsBVZaBhuEdaXb82Htd/Peh5u9VBA27OR4gPzM15mdJr2cgkipkyb18TTsjErW
         9o/w==
X-Gm-Message-State: AJIora+zz2yhWhmoRsMLGWaMx/Zd9a8Oo62IEu6/FRgGJZ2EWeeblSvH
        U5uod8qnskdQRkJu2CAI2vtshp/EqyquR/NE7Q==
X-Google-Smtp-Source: AGRyM1sNY7fz2EAZn6AtNHZP6fkSQ7jOV3bw7W8d1Zpe0HYuj7GqiA6qSNpMOcTQeY8C+RQkSDtbUWvJyGgIyt2yDw==
X-Received: from justinstitt.mtv.corp.google.com ([2620:15c:211:202:f21c:9185:9405:36f])
 (user=justinstitt job=sendgmr) by 2002:a0d:cbd8:0:b0:31d:a46:a1ee with SMTP
 id n207-20020a0dcbd8000000b0031d0a46a1eemr6802939ywd.201.1657322823258; Fri,
 08 Jul 2022 16:27:03 -0700 (PDT)
Date:   Fri,  8 Jul 2022 16:26:53 -0700
Message-Id: <20220708232653.556488-1-justinstitt@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH] amd-xgbe: fix clang -Wformat warnings
From:   Justin Stitt <justinstitt@google.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with Clang we encounter the following warning:
| drivers/net/ethernet/amd/xgbe/xgbe-dcb.c:234:42: error: format specifies
| type 'unsigned char' but the argument has type '__u16' (aka 'unsigned
| short') [-Werror,-Wformat] pfc->pfc_cap, pfc->pfc_en, pfc->mbc,
| pfc->delay);

pfc->pfc_cap , pfc->pfc_cn, pfc->mbc are all of type `u8` while pfc->delay is
of type `u16`. The correct format specifiers `%hh[u|x]` were used for
the first three but not for pfc->delay, which is causing the warning
above.

Variadic functions (printf-like) undergo default argument promotion.
Documentation/core-api/printk-formats.rst specifically recommends using
the promoted-to-type's format flag. In this case `%d` (or `%x` to
maintain hex representation) should be used since both u8's and u16's
are fully representable by an int.

Moreover, C11 6.3.1.1 states:
(https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1548.pdf) `If an int
can represent all values of the original type ..., the value is
converted to an int; otherwise, it is converted to an unsigned int.
These are called the integer promotions.`

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
For clarification, the first three parameters given to netif_dbg did NOT
cause a -Wformat warning. I changed them simply to follow what the
standard and documentation recommend.

 drivers/net/ethernet/amd/xgbe/xgbe-dcb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dcb.c b/drivers/net/ethernet/amd/xgbe/xgbe-dcb.c
index 895d35639129..c68ace804e37 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dcb.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dcb.c
@@ -230,7 +230,7 @@ static int xgbe_dcb_ieee_setpfc(struct net_device *netdev,
 	struct xgbe_prv_data *pdata = netdev_priv(netdev);
 
 	netif_dbg(pdata, drv, netdev,
-		  "cap=%hhu, en=%#hhx, mbc=%hhu, delay=%hhu\n",
+		  "cap=%d, en=%#x, mbc=%d, delay=%d\n",
 		  pfc->pfc_cap, pfc->pfc_en, pfc->mbc, pfc->delay);
 
 	/* Check PFC for supported number of traffic classes */
-- 
2.37.0.rc0.161.g10f37bed90-goog

