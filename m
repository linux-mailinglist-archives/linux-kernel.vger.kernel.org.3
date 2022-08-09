Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1BD58DF7B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 20:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244990AbiHISzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 14:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344944AbiHISzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 14:55:00 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FF81EC77;
        Tue,  9 Aug 2022 11:25:21 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id q1-20020a05600c040100b003a52db97fffso4334655wmb.4;
        Tue, 09 Aug 2022 11:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=iR1UBa3fcEjPoYYuaep1Tag2qx+Me802676/JFCG/W8=;
        b=RlcBaeE0yFOKt3O5Rf1v8YGF4SMX/8chz8AFe0CRJN7MGoARW32+tIrBCiNfcH4/Zz
         plzS9lCWLSIJh1z19JfG1VYGI9VfX3LhdVW5Xkwh6c3zoBMB9VW3GstRdAGnJBmpF7s9
         HUke9IV6euF5A6DUD9fV/SHZ9M+yZ3s1El4xyd+VQ1Kad7rjTT40FPrmJqItsyRTsZlP
         pd5SAPoi1VMuLTXxq++k/T2CTLLDkIe6RglpYABCXc0slfq8lbit6GY0V/8R5A3Tc+BG
         njXZa0WIG9exg/dDCN1O9V9fbU7XuUXx1kQgkCJVMvS8Zac0rRoa/iS5LTStnhwqd1HD
         WUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=iR1UBa3fcEjPoYYuaep1Tag2qx+Me802676/JFCG/W8=;
        b=iyntTRJ6MQPgSPD+fdYTkO8jd3oAydPMEiD/FtUjdkmuiVv0eUP6cT8xQrS2nWbkMq
         Ei19ZxRgn+hU/kSNzeUcbdpeoaZR/yzjysUM0Hz2YKqDK/6iThFyZY3yUdZhu+rKdEmU
         Wy59BE19SRy7E4k+goYwPVLD/BOIW5udxkKmLmfbtSDneVy1hjWIOezOmGIMOrA6H18b
         Qn/CtJTHfBijVSWuXaEzGWgmspZVb1c0G8NEj7f7Vbbxi6haR50q/thsGxg2+BLA2orT
         bTrah3PEJ//Z7+/2NTKsLF5DROts6/a1+hZ4jPbFDXe7N9yBxH2nKZaByzn0MxubQNyx
         dBOw==
X-Gm-Message-State: ACgBeo09P2iobFw3JK8MKPa5q8qJxvN95jh9igwhf4SUWwpNM2fVls6R
        BmSyNZAjuKnbQ8Gub64YotE=
X-Google-Smtp-Source: AA6agR7uXxer+8UdJWsF72Vp9SYWd/fJgbb6WwTEuzs97Thgx1Iz8Vl/nTOntrGu1D2zsxkDMxO+Ng==
X-Received: by 2002:a05:600c:4e92:b0:3a3:2a1c:d005 with SMTP id f18-20020a05600c4e9200b003a32a1cd005mr21887281wmq.170.1660069519727;
        Tue, 09 Aug 2022 11:25:19 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c4f4600b003a4eea0aa48sm18153154wmq.0.2022.08.09.11.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 11:25:19 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Hannes Reinecke <hare@suse.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: aic79xx: make read-only array tok_list static const
Date:   Tue,  9 Aug 2022 19:25:18 +0100
Message-Id: <20220809182518.3046935-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
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

Don't populate the read-only array tok_list on the stack but instead make
it static const. Also makes the object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/aic7xxx/aic79xx_osm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.c b/drivers/scsi/aic7xxx/aic79xx_osm.c
index 928099163f0f..4ed40e6c5522 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.c
@@ -1044,7 +1044,7 @@ ahd_parse_brace_option(char *opt_name, char *opt_arg, char *end, int depth,
 	int      instance;
 	int	 targ;
 	int	 done;
-	char	 tok_list[] = {'.', ',', '{', '}', '\0'};
+	static const char tok_list[] = {'.', ',', '{', '}', '\0'};
 
 	/* All options use a ':' name/arg separator */
 	if (*opt_arg != ':')
-- 
2.35.3

