Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B566059F4B2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbiHXID7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbiHXID5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:03:57 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F1786054
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:03:56 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id v4so14343760pgi.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=vLuqniAMwqY6ECfkYSPT1Bkq/cd7HE9h4EEKEFfMYEk=;
        b=WInXrY3qRgrPgpReqwCl4R8vLZ1EJa31NKnxJoyTy4qEipQsgpGYSdIVq1ejlCAPpN
         OlZbbEC+PBY5Ibu9LEGcwdwOWEAXizp8VI7vPIJWCTosW5UvtKi2r2oODfpXbsKzQ5Ik
         Oq1VaFSfGf/6SKvBA1ZqQyF523w+ERzFvUdztoRbFQrdLliOMaMjg3hUgtRcRwozPnO0
         BSwsDxGJ3fWMIQb/gNRFp2wL/WMH2r8vlIFG3jbrw2eFlkdHQf91UGyeaBgv2Lkn7jgA
         PS2gtDtIjimMqU4P3JItk4TavlGYQf7Y4b0RKxNmFjYlXFth/so5CW2VpfTvQjAuH1Hp
         9wiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=vLuqniAMwqY6ECfkYSPT1Bkq/cd7HE9h4EEKEFfMYEk=;
        b=hGoAS7ATPaAFqNzaZLMi79YUCcozEZoN1iUApWNrLROyBJA5ARdUfsUCgbSHQ4D+Ht
         JeTQNqph2rZ6TfoIUgcpWV4V++9YHhLeJ4jjRSU1FmY9W1DNXLVNbGCfNvR5PAb2M/6i
         T1k7XQCZq0kEQuWKKhr5Rv+zkQy1sQcruRZ3AbBONuRvsatDajxfhajj8+IssT6Mm2rm
         etUZXjXLO5iifY7JqbrYivUcKFJabe8HB3S7pVEK9lFsJnLvn4FxTmxeYkpRf2tAXPNk
         voe2rFvkF0tMItn8OQ8RI0LpAGdWoYNIQmDpnW9wVYI/N6mdnXHpGvsC737/7fog24Yx
         0CjQ==
X-Gm-Message-State: ACgBeo1+bnSqJjfVNVaVMYiF0gmaNe8x8endS+0nJfRLKixi5tp1waTg
        g68RsGt7paO7Gx9zlFMgl/M=
X-Google-Smtp-Source: AA6agR7MlcgjgtEOya/NAybABl6gcw7J21DmWRhCKXk8BHL8WvNnBdvkEdqRcGH18AtoUgBC6YY0fg==
X-Received: by 2002:a65:6e8f:0:b0:42a:c7d3:f2ed with SMTP id bm15-20020a656e8f000000b0042ac7d3f2edmr8386132pgb.209.1661328235880;
        Wed, 24 Aug 2022 01:03:55 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x187-20020a6263c4000000b0053656fdaf88sm8153571pfb.69.2022.08.24.01.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 01:03:55 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, paskripkin@gmail.com,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        martin@kaiser.cx, jhpark1013@gmail.com, makvihas@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] staging: r8188eu: remove unnecessary null check
Date:   Wed, 24 Aug 2022 08:03:50 +0000
Message-Id: <20220824080350.221614-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

container_of is never null, so this null check is
unnecessary.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 56c8bd5f4c60..d089da7e90e0 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1442,10 +1442,6 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 	pmlmepriv->pscanned = phead->next;
 	while (phead != pmlmepriv->pscanned) {
 		pnetwork = container_of(pmlmepriv->pscanned, struct wlan_network, list);
-		if (!pnetwork) {
-			ret = _FAIL;
-			goto exit;
-		}
 		pmlmepriv->pscanned = pmlmepriv->pscanned->next;
 		rtw_check_join_candidate(pmlmepriv, &candidate, pnetwork);
 	}
-- 
2.25.1
