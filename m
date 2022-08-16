Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E7E595A3C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbiHPLen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbiHPLd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:33:58 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE7A66A53
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:55:49 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l4so12122882wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=UwGclAPKpRElqSb0slB3YI1UbidqkoclQLHrUzSqvlg=;
        b=l/hcMAVKaPG6eBpWzxcJ+D86RTu1F1RNf1z1FDxlWs52NFbQP78T5n2830h/+N96dw
         rtTdIPTYo6N/902CMQLhwYGKpo7c2qhfPOPc0aTMyVcwk2T+XCKBFIuuG5coJiZW9qFF
         8+R05ypD4TX2lz0gcnosZTsZmSP2fU2/GE5BYN6T45Ja019z2tBMuNba+cm0a+6cruLV
         j2+kcbTzCPHkLOKshZaT1cDHabbz9AGW04mdroXDxwxchbTrSsJWpcaVoh8YzHJQ3y0S
         8ideVfspHwWwqN8E25VX+m3E5Ge4qUTBDtR05n/9FbfveAho27nIQlg8yZIHK2sB8Ldd
         S2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=UwGclAPKpRElqSb0slB3YI1UbidqkoclQLHrUzSqvlg=;
        b=cVy2//kirj3yQb34YfVvWH1xhBJy+ttKmw+81IQ3Zy9R1HfQtva5Vj9yaYsmlGOY+0
         wyBViSM7DvdzdKJBASQLTNUkI8HFsFhe1r3QFLj7NVP6bladK3mzFQr4XymWiDK6ghKA
         CVukIn0Vj8jINJbl/m+UJqDnD9te1ZmoEuIXKpXNpU3Q/1Q3OnD4pCgyBcFZKzMgDWQU
         aICATCXFt+vTCJjLjflAjCy6UknqfPN9nBTs4zvVIW0rYqdMW6vwe2stKq9CfTlWPvIT
         TzKre79DHgFOpEhWgdR/xMmQknOSGyGfMOkiv9+IJf9DNPAl4HyAgBzPd9anw9w0LPBf
         tjag==
X-Gm-Message-State: ACgBeo0DsWSep1WYKehgQ7Tyx/PPTNYpi0YDdJ9fQtECkBZqtpmCYW08
        z0qL3qLpbwSK6+hzBfZlkp6ewQ==
X-Google-Smtp-Source: AA6agR7ORNMHdMKLRnaII7L2dXayQffVP+aZiQzPFLcwMcmQl3BOgRIrdp/Bqn4+pG6d67LysnHONQ==
X-Received: by 2002:a5d:638b:0:b0:220:6e1a:8794 with SMTP id p11-20020a5d638b000000b002206e1a8794mr11440308wru.193.1660647347544;
        Tue, 16 Aug 2022 03:55:47 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id k2-20020a7bc402000000b003a32297598csm12362799wmi.43.2022.08.16.03.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 03:55:46 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] misc: fastrpc: Use USER_PD define in fastrpc_get_info_from_dsp
Date:   Tue, 16 Aug 2022 13:55:28 +0300
Message-Id: <20220816105528.3222763-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
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

There are defines for each type of protection domain now.
Use the USER_PD instead of magic value in fastrpc_get_info_from_dsp.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Amol Maheshwari <amahesh@qti.qualcomm.com>
---
 drivers/misc/fastrpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 93ebd174d848..8895ca593911 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1515,7 +1515,7 @@ static int fastrpc_get_info_from_dsp(struct fastrpc_user *fl, uint32_t *dsp_attr
 	args[1].ptr = (u64)(uintptr_t)&dsp_attr_buf[1];
 	args[1].length = dsp_attr_buf_len;
 	args[1].fd = -1;
-	fl->pd = 1;
+	fl->pd = USER_PD;
 
 	return fastrpc_internal_invoke(fl, true, FASTRPC_DSP_UTILITIES_HANDLE,
 				       FASTRPC_SCALARS(0, 1, 1), args);
-- 
2.34.1

