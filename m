Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D4B4935DF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 08:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352266AbiASHxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 02:53:18 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:38526
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352208AbiASHxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 02:53:10 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 14DE33F1E9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642578789;
        bh=15HOmnObJXsVXxZJ5x/3DtxcDfRhMgZoa5zrHrITnNA=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=AO2MQZdS/ppyjRLhXPH2h3JnRmw5ykCYePVs7I+pVqdPVu0yr1PNzXUmvWuVbq1zJ
         Hnfb20O2MdWAGTK387bJP/b27WNPOXWtnnPiME+5fOQLn9qzHDrWd7j1JcD/hPL/U9
         pVNMqTr9JFY+6pMIryTXjiy0QJ/jAO9iZ/izoreKJKuetPxuzYomLlDcbvYnvfahTu
         MVKCjuDRjVi4zvGitkwHC6u/9EIW9ZuPuZ2JI+i/R3c2uNPAh5DwBVOMxDN0CBdYri
         BH/OwsME1A/JBO8u1MHjW6Qg+73/dyS3S+ABbRZA7Wae5LsAovXDnCdCs8G9eOxZOs
         mKPfnun1HAmEg==
Received: by mail-ed1-f72.google.com with SMTP id z6-20020a50eb46000000b00403a7687b5bso1501035edp.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 23:53:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=15HOmnObJXsVXxZJ5x/3DtxcDfRhMgZoa5zrHrITnNA=;
        b=uymi8fn72SNV7vjJIsMYGg24/unHQHLWqqSZCzlOUxfoE580cmeJQEbH7VlKafE2sw
         ZD1nO/kHCgQGW0QouwHlRe9zSmiyCpmQ4hisomjJDt2loTFlTGZsVKgcUePNEvmi3H4n
         9gD5R1lMrTCX3C3Ij7nyCxYTmVxl9q8fOiPyPP27gEcmI7WocpVW1ipJxY+/AMhsuBl6
         HJ/VlDdqRGfUSuz6b7Ydm7LDHqMl5WtGgj6NWXo38gdL1FDlry+QxqdKDAZIiELCzW0f
         iRLHzsI6u2qDDjMjTjI0sj6lxfmyf6k3edaroAHAXPd/TwwQdQyP3Nu+NYm/SLSh90ys
         q4/Q==
X-Gm-Message-State: AOAM531SkTwXj5AlWMDQfqlU9axHo5inXRrebkC9+ihvxN1ec7sI6Z0P
        MIgHiHtbQiXji6HXlxj9pVXfG1i74eF+4+n0SU3vZM+j1HIgjYwH+3+HE/IZuIl2qiOejxb5Qhg
        qAzBh8Pt3X3cUvvzpOShMGCEdFhkoBTXQBVRF1C38cQ==
X-Received: by 2002:a17:906:314f:: with SMTP id e15mr24089113eje.658.1642578788655;
        Tue, 18 Jan 2022 23:53:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyvebYbkc+sDSvj+IhZAZlbGMQ8r2BM5qm9B1lRUqpsvTkhNAMQvZayhml1fBn9wG0q6LpOgQ==
X-Received: by 2002:a17:906:314f:: with SMTP id e15mr24089106eje.658.1642578788503;
        Tue, 18 Jan 2022 23:53:08 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id w17sm805286edr.68.2022.01.18.23.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 23:53:08 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] nfc: llcp: use test_bit()
Date:   Wed, 19 Jan 2022 08:52:59 +0100
Message-Id: <20220119075301.7346-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220119075301.7346-1-krzysztof.kozlowski@canonical.com>
References: <20220119075301.7346-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use test_bit() instead of open-coding it, just like in other places
touching the bitmap.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 net/nfc/llcp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 5ad5157aa9c5..b70d5042bf74 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -383,7 +383,7 @@ u8 nfc_llcp_get_sdp_ssap(struct nfc_llcp_local *local,
 			pr_debug("WKS %d\n", ssap);
 
 			/* This is a WKS, let's check if it's free */
-			if (local->local_wks & BIT(ssap)) {
+			if (test_bit(ssap, &local->local_wks)) {
 				mutex_unlock(&local->sdp_lock);
 
 				return LLCP_SAP_MAX;
-- 
2.32.0

