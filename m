Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66E84CAEAB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240659AbiCBT0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239806AbiCBT0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:26:19 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493FEC12F0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:25:36 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B41C23F5FF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646249132;
        bh=15HOmnObJXsVXxZJ5x/3DtxcDfRhMgZoa5zrHrITnNA=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=m2iWuTsbzZ0fn/Kxc87HP8Lc1/jvXzwP/jkvWD8zKwW1boaOo5y1hRgPW1wGYmJcc
         ttXoRtM60lZ+cu1wGeS7r/MVffgFYd9DIMCN3etZVkNutEyKLBYdUnoIj7lckWI5MS
         Vu4ER0iEbVek0XQiQqJewXSgWJvoNqnya3mMAyEos4G0XvvaLnQqPMxQDEDiXmWxSg
         T/1nrCvTJuyNgnKVDC+liZ2RnE3c00Ai8xz8Obh3S+J2LsFd1Pyovca8QNQIY5EG1r
         EBmQsy4uBTPm1Q2626iVkSCa+0/YKmyRStvRGLcwce4WMD2b59yV2Otv5idpMFyUqq
         T1fEWaz8j53hQ==
Received: by mail-ej1-f70.google.com with SMTP id nb1-20020a1709071c8100b006d03c250b6fso1486860ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 11:25:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=15HOmnObJXsVXxZJ5x/3DtxcDfRhMgZoa5zrHrITnNA=;
        b=rFOwvijZfdKJPMIZ5CWQDiwa1foS43FhTgHhki/Q7NeWni7Mr7scJOWas7ERPV6oOc
         qqIaVp4J+MeR+bIiPjmRUETRb3hHoOJ9dSKVw43q5XligDeBLsVOAYSqVRMMD2Yy6Lmv
         +WATV1wLCxmqqBpKBQ/IuBXL7id8zyJFvvhEaR/fvp/J0GHh35MVM+UWKTGq6MD+dyrL
         ECbw+K0bWgjQCAeIEweN59Xpf7emj6Ub1jOie+Ty0jHKZheRnml2QdUkq0aKmKjs+tKJ
         GFZmh2LT5v5rZhSUVqRUVeccyG/4aP4SPW5G1UtYGP6xRix71pi71VDQfQSGLvk2gIQn
         jdSw==
X-Gm-Message-State: AOAM533+YP9Y+yu99eVJaPbDJE/t7c+c5Qce266lBZdKcPsCiEj137Y+
        dEspijhikES6ldfQNp2L4wMRQ6iyKzyUducBjWOmgrjSMfuL9HsXhkT2CaUfupQm/6odfGQ6IIb
        uI9ECAifw2uIlAM9uPGnIhxaWzWIhHfgH1ulVGcnAIA==
X-Received: by 2002:a17:906:7751:b0:6ce:e3c:81a6 with SMTP id o17-20020a170906775100b006ce0e3c81a6mr23328454ejn.278.1646249132425;
        Wed, 02 Mar 2022 11:25:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzoNWOZ7D/uCsO1FWpSxrBelZ9YFjgouGbue8Nl1lS/Y1LnCK8P6xOlohDZjyDgtT/p5sfpXA==
X-Received: by 2002:a17:906:7751:b0:6ce:e3c:81a6 with SMTP id o17-20020a170906775100b006ce0e3c81a6mr23328438ejn.278.1646249132223;
        Wed, 02 Mar 2022 11:25:32 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id i14-20020a50cfce000000b00415b0730921sm1482765edk.42.2022.03.02.11.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 11:25:31 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 4/6] nfc: llcp: use test_bit()
Date:   Wed,  2 Mar 2022 20:25:21 +0100
Message-Id: <20220302192523.57444-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220302192523.57444-1-krzysztof.kozlowski@canonical.com>
References: <20220302192523.57444-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

