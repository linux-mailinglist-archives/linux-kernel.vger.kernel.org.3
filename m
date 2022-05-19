Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C57D52D726
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240615AbiESPMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240526AbiESPMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:12:25 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C9CC9EFB
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:12:24 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id m6so6089006iob.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6+Fem4lozWtl3MTEsgHhD7kgm6g1Bv+TgSucDp8qwU4=;
        b=r8lduLPLV/+WJPs6xI0z67kdZYr4bhBq7UBDVx0J2I2/QhR92iwg/faGLrSIQp+SVc
         oPqcaYoq8nQwo3b727CCcKbujGQw8gtgmSR8zdRhRFgzrjxAm0nwezkpDCMjGN8cC3Tj
         gr2UnFJuvASHof5uaMd7mQ6nOJYcKFfwYi8fwh+K94DO4eluJqd53qqbAACScC+Gy/2r
         UF+d3O0iP/pqmA3smXJjUQyQOkDEWp1e5C8FRqD74EMDkR6fKblLTMwIqKqEBEC4mqHc
         vQtQsSoikiNSAJ0i+bynrEb5QLUJnx1GXrkYtL1GZPI8IMARs5QUtVqB6bjdpmX1jKbs
         XG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6+Fem4lozWtl3MTEsgHhD7kgm6g1Bv+TgSucDp8qwU4=;
        b=Ng1XkU2P/h5/3i1VUfPKzgru0LF23Pu3ciE3dPR7P0x3TykSLBq38RZE00mWIBajBW
         t9/jFbM4vA3F7L5FTSKsc+LBoSPvwPKd0t4dLP87cHpe1dSzxefHHZyx/6EESDEYZ0lt
         +yZKN/NFmJwQJH0/BwvDhFGzFK+rCLHYfGa+b7Me6ELUBxB2m0DOkGLX/K0OYF25TbWa
         bmrhikihIH7naMRG5SSPCeQU524LE/r8RGsq9cPfXg0koMYmczzvagZA2ZnycU0+nkCS
         9zMVuSJBQl7QOX992mRb0TqBfyWCjpCzb05XzivJpBYddD9+R6MrRpUl82ihWQrmXAE4
         p3Ig==
X-Gm-Message-State: AOAM532f0LTHnfZJdXlVuN5iyNGk5OP5Ff5ahCEgE/wGGJSv0OXgj1MB
        2Z0Qy1iRNk6FyvwduCe5SmiIABIJEeYKvA==
X-Google-Smtp-Source: ABdhPJxBWtqaGJIJb1L/gDMiDvisXZovCsnyBQNBra6+I7P0WT7dPYuwficRbqp0p8zoo1epJtVNzQ==
X-Received: by 2002:a6b:5017:0:b0:65b:aa4:96cf with SMTP id e23-20020a6b5017000000b0065b0aa496cfmr2820248iob.47.1652973144210;
        Thu, 19 May 2022 08:12:24 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id g6-20020a025b06000000b0032e271a558csm683887jab.168.2022.05.19.08.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 08:12:23 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mka@chromium.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/7] net: ipa: ignore endianness if there is no header
Date:   Thu, 19 May 2022 10:12:13 -0500
Message-Id: <20220519151217.654890-4-elder@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220519151217.654890-1-elder@linaro.org>
References: <20220519151217.654890-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we program an RX endpoint to have no header (header length is 0),
header-related endpoint configuration values are meaningless and are
ignored.

The only case we support that defines a header is QMAP endpoints.
In ipa_endpoint_init_hdr_ext() we set the endianness mask value
unconditionally, but it should not be done if there is no header
(meaning it is not configured for QMAP).

Set the endianness conditionally, and rearrange the logic in that
function slightly to avoid testing the qmap flag twice.

Delete an incorrect comment in ipa_endpoint_init_aggr().

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index e133eb2bebcfb..3fcd7c64c9bba 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -587,19 +587,23 @@ static void ipa_endpoint_init_hdr_ext(struct ipa_endpoint *endpoint)
 	struct ipa *ipa = endpoint->ipa;
 	u32 val = 0;
 
-	val |= HDR_ENDIANNESS_FMASK;		/* big endian */
+	if (endpoint->data->qmap) {
+		/* We have a header, so we must specify its endianness */
+		val |= HDR_ENDIANNESS_FMASK;	/* big endian */
 
-	/* A QMAP header contains a 6 bit pad field at offset 0.  The RMNet
-	 * driver assumes this field is meaningful in packets it receives,
-	 * and assumes the header's payload length includes that padding.
-	 * The RMNet driver does *not* pad packets it sends, however, so
-	 * the pad field (although 0) should be ignored.
-	 */
-	if (endpoint->data->qmap && !endpoint->toward_ipa) {
-		val |= HDR_TOTAL_LEN_OR_PAD_VALID_FMASK;
-		/* HDR_TOTAL_LEN_OR_PAD is 0 (pad, not total_len) */
-		val |= HDR_PAYLOAD_LEN_INC_PADDING_FMASK;
-		/* HDR_TOTAL_LEN_OR_PAD_OFFSET is 0 */
+		/* A QMAP header contains a 6 bit pad field at offset 0.
+		 * The RMNet driver assumes this field is meaningful in
+		 * packets it receives, and assumes the header's payload
+		 * length includes that padding.  The RMNet driver does
+		 * *not* pad packets it sends, however, so the pad field
+		 * (although 0) should be ignored.
+		 */
+		if (!endpoint->toward_ipa) {
+			val |= HDR_TOTAL_LEN_OR_PAD_VALID_FMASK;
+			/* HDR_TOTAL_LEN_OR_PAD is 0 (pad, not total_len) */
+			val |= HDR_PAYLOAD_LEN_INC_PADDING_FMASK;
+			/* HDR_TOTAL_LEN_OR_PAD_OFFSET is 0 */
+		}
 	}
 
 	/* HDR_PAYLOAD_LEN_INC_PADDING is 0 */
@@ -759,8 +763,6 @@ static void ipa_endpoint_init_aggr(struct ipa_endpoint *endpoint)
 
 			close_eof = rx_data->aggr_close_eof;
 			val |= aggr_sw_eof_active_encoded(version, close_eof);
-
-			/* AGGR_HARD_BYTE_LIMIT_ENABLE is 0 */
 		} else {
 			val |= u32_encode_bits(IPA_ENABLE_DEAGGR,
 					       AGGR_EN_FMASK);
-- 
2.32.0

