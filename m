Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E99A52F384
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241113AbiETS6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238453AbiETS4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:56:04 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704DBBEE
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:55:47 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id o190so9597469iof.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=doVlcQ6Xlwn2BqCTeY/iG09ipnCZzy9t3u/uMA+1XFU=;
        b=fZZsDJJrboSe4IKnxyoJSpV9nG4DIyCBw3i1qGKRzT7ZyiZ1D6SRzHzdAfSeT7Rb87
         amgtbD5Podj6C7xp1Ep+hPQFdnknmfUd3RT7e0Mnic403zG21KF36hamsWtXSxPgwU2c
         IkWJB99HnUAN+K2XjKEiuPEASJytbu72xcDNcKlXxxZMhLw7kJX+oDn55Y4OdAt93faG
         C9Umg0D8N+zZ/eafFOtyQPWof8qCx2L33IkBToZ6seDrmLFt6LeR60Cg3PbklmpgooKD
         Sli0cLr9i2Ua4SMxAQhU+Q0Fkb899oRCgXOMNu9K4AfEtw5j2QYO4ck7mgwGpq+PXG8k
         3Xvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=doVlcQ6Xlwn2BqCTeY/iG09ipnCZzy9t3u/uMA+1XFU=;
        b=dqMvN84IoaZUCAzvl9MwXV//37URRrOcL0S2lQFvJPa+6klhpOAWjeMrehO1mSGrg/
         6VMNqF6yWzSrNA/IETe+ECphM+gepavsbb4OopLouovEREEsChF1Bm7SVEbJKf480IDY
         3Zm06QM4YXsRgvmI+eGowxGB4KTTQjnDmcOQb5lBltycrSR8xc7feLc2JUYydPojiPLp
         RM/oqemuvqi7+iVLBPxFruO+KLuizmegWIr0D5eQr1RDLBWkkfkr3VQAK4g9d5tTcxJ3
         +fK06QOh52jdbZa971MxmXviGt/iJKVWhPRt7ofZheqIvBiMQGTHTL9iKC2Dak34xz8Z
         EdRQ==
X-Gm-Message-State: AOAM532kVUqtFhUEPmRNn7QsxRuRZ8p8M3gaDvFOWoDyYzyeTPrZKCk5
        da/UA+bS8oGF7kr60lkSgpRmYQ==
X-Google-Smtp-Source: ABdhPJy6V1vTe1zz3jCZ5jBx46z3InfbrmSKe+OrxZ52VboJkNW4lCWa/9QEfijW+NblkRpqme+Wuw==
X-Received: by 2002:a02:6619:0:b0:32e:25b7:d9ed with SMTP id k25-20020a026619000000b0032e25b7d9edmr6108523jac.30.1653072946839;
        Fri, 20 May 2022 11:55:46 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id a6-20020a056638058600b0032b3a7817acsm871958jar.112.2022.05.20.11.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:55:46 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mka@chromium.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 8/8] net: ipa: use data space for command opcodes
Date:   Fri, 20 May 2022 13:55:33 -0500
Message-Id: <20220520185533.877920-9-elder@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220520185533.877920-1-elder@linaro.org>
References: <20220520185533.877920-1-elder@linaro.org>
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

