Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1096753000D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 02:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348498AbiEVAdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 20:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348180AbiEVAcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 20:32:39 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C0A40A26
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 17:32:35 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id q203so12180802iod.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 17:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=doVlcQ6Xlwn2BqCTeY/iG09ipnCZzy9t3u/uMA+1XFU=;
        b=rXoH1vIlolKTcPa7XyPoQrChIH0W6X5hmQjuJx0KajKXf88oC9gsolgD1vM/3SDwtO
         KXp+4BffG/nUhOQ7WUIjHGwgqxKMIPaG7CqYHCWPtxHWZZMTtESo4MyAvC5Q0MN4Bw8W
         BpuFXH+vpHdAxYC3GXEbEzaCEPfOscQuRN0Q3PGWONxd0Xvd/lpeK3uxlLK05NQJkgRE
         Q32LKVwDrXeFkAaVbL+y258ggOHaOSkbqf+uy6VDWksjVVy4Hv0ywnW4NXrWOIEWyUi1
         vczwXnuDN43CPTg++j/C9QPxBQxI45ixSnGD/1UIzmK/qd+mFQmaDxKwMymOURD3iutk
         bZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=doVlcQ6Xlwn2BqCTeY/iG09ipnCZzy9t3u/uMA+1XFU=;
        b=SpGA3qcv+gujswvHMCHNwulnPsMKZqaTqLhPf2v4XhEBJQxejGP679wa/wDuNJExMY
         uDHjUI+qDDuGRwEiAPv74TnOVeywXEhsogwjKgIho2SH2L47gKHtY3PwoKN0QA3aAUwm
         g1d3R6U1qYBAlskBwaT0mesKk5Snkz6c1ZpV6/ZwKuK6OQ6dZFlc6uSLHV0rTuX9V2dO
         hY3c9CvYsaz22iDfoTqQPmBYTLF7BQYNqH5vAZTjyThlfYiLf9LS1J1MJ14GmZeqdjSn
         30z3kabn46kKXPn43bZ2GbgF5JS11yO5vTBtoTd4rVTUbRr/PH5R1iiAsxe0lFT5ltM3
         fncQ==
X-Gm-Message-State: AOAM532k5ueEpUvoiD+cPdEewpAaloGM2BJrOAQzBMmErEmduzbVVzk+
        xFtllnPkk6Ye4PhnAzymlLShMA==
X-Google-Smtp-Source: ABdhPJyXsa5e5p8ofFsd6pLkt2bgKU0IrEydH4ftdbr15h1s+8SWttkScVwWZvGizVvPjJPscGqlQw==
X-Received: by 2002:a05:6638:34a4:b0:32b:b205:ca82 with SMTP id t36-20020a05663834a400b0032bb205ca82mr8167007jal.165.1653179555689;
        Sat, 21 May 2022 17:32:35 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id g8-20020a02c548000000b0032b5e78bfcbsm1757115jaj.135.2022.05.21.17.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 17:32:35 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mka@chromium.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 9/9] net: ipa: use data space for command opcodes
Date:   Sat, 21 May 2022 19:32:23 -0500
Message-Id: <20220522003223.1123705-10-elder@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220522003223.1123705-1-elder@linaro.org>
References: <20220522003223.1123705-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 64-bit data field in a transaction is not used for commands.
And the opcode array is *only* used for commands.  They're
(currently) the same size; save a little space in the transaction
structure by enclosing the two fields in a union.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi_trans.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/gsi_trans.h b/drivers/net/ipa/gsi_trans.h
index 99ce2cba0dc3c..020c3b32de1d7 100644
--- a/drivers/net/ipa/gsi_trans.h
+++ b/drivers/net/ipa/gsi_trans.h
@@ -60,8 +60,10 @@ struct gsi_trans {
 	u8 used;			/* # entries used in sgl[] */
 	u32 len;			/* total # bytes across sgl[] */
 
-	void *data;
-	u8 cmd_opcode[IPA_COMMAND_TRANS_TRE_MAX];
+	union {
+		void *data;
+		u8 cmd_opcode[IPA_COMMAND_TRANS_TRE_MAX];
+	};
 	struct scatterlist *sgl;
 	enum dma_data_direction direction;
 
-- 
2.32.0

