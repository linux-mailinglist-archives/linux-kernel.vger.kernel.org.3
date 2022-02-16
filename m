Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7E74B7E17
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344002AbiBPDHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 22:07:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237823AbiBPDHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:07:01 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD2D2A270;
        Tue, 15 Feb 2022 19:06:49 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id ca12so895610qtb.4;
        Tue, 15 Feb 2022 19:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lWbWPRpljqyxUHO/4PPZALOIacGNZAKBTnuOLqqWIhs=;
        b=Jbs61Yb2r2ZUEIR9A1UgOmQ9u4kR0q9hl/FV0ymx/e9E+nTqShQq/RLj/5lDCk1ib1
         tOqkro+vkfo26b0R5PUPe/bPO+0KujlmRMMsaNOUFaD+/nVKVogL/m3J8g7luuMswJ0Z
         cC5xbasFfHLherFK8eQ6P6I74iJBspgHFqC25PZCdzX3sEm2VAOUGbD89IR6sWQjuI4R
         gKuFoThRa6c2BxfjlBiLVGQoEdbOGJCYr+QlcC+gBgNiCqqFfR+g/7qW212nKoiNTlNn
         /ZGr5JmidTkzTgMJsnAPE3MzfRXoJ7GMXEm4Eu4bT/ZanDe/kG82eDE/9oNTDabAg5Sc
         JX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lWbWPRpljqyxUHO/4PPZALOIacGNZAKBTnuOLqqWIhs=;
        b=DtQKCHspkgIo9bWm3BtgmlBCYIqpT5mK/5A70QPbvmp5X4F2YhapVU/lGQOxcl6NOS
         aCpx7G+DmU09Sv+2kdbKuXFf9mQ+3XzIt17/zXzZ7nwqoYdKeV1tpOEJ99XAEEiMHGJO
         SRa+elkfxUDq1goreFvjXLGFbM9vLz98ufhaxZiMiHnfxMFfST765i65asLIHSlV7Wh7
         /NjIrig5ySfS19w61w+QTwXkGSb7R4CPN44BQ94vyKYUaetKq15GCtZafc78LWBhi1EM
         8hmsTZ0aJdq1vVHfuVkLAONkPohtYcFd9r+kgxkPt8deOfdEB4qImt310UezI846JsMY
         4f2g==
X-Gm-Message-State: AOAM5332gpG5qZX5Boj2boy/CVnq1P9j2Ag7mwoAbsS9e+DqGcChQCnB
        dVQUE7t8Ul7UwDsmFdTCZPTC6fBzeFw=
X-Google-Smtp-Source: ABdhPJxofywMtYxXGkQSNPL94EkZi7+ZP0qtW5bAL+8Ub19FVxW4Q6TuoIJejiszbdQgnN72rw470g==
X-Received: by 2002:ac8:5bd1:0:b0:2d0:a800:21c1 with SMTP id b17-20020ac85bd1000000b002d0a80021c1mr735525qtb.446.1644980809109;
        Tue, 15 Feb 2022 19:06:49 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h13sm9717122qkp.77.2022.02.15.19.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 19:06:48 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     sathya.prakash@broadcom.com
Cc:     sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] message/fusion: use struct_size over open coded arithmetic
Date:   Wed, 16 Feb 2022 03:06:41 +0000
Message-Id: <20220216030641.1839422-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>

Replace zero-length array with flexible-array member and make use
of the struct_size() helper in kzalloc(). For example:

struct fw_event_work {
	...
	u8			retries;
	char			event_data[] __aligned(4);
};

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/message/fusion/mptsas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mptsas.c
index 4acd8f9a48e1..c6fb4fd75434 100644
--- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -5113,7 +5113,7 @@ mptsas_event_process(MPT_ADAPTER *ioc, EventNotificationReply_t *reply)
 
 	event_data_sz = ((reply->MsgLength * 4) -
 	    offsetof(EventNotificationReply_t, Data));
-	fw_event = kzalloc(sizeof(*fw_event) + event_data_sz, GFP_ATOMIC);
+	fw_event = kzalloc(struct_size(fw_event, event_data, event_data_sz), GFP_ATOMIC);
 	if (!fw_event) {
 		printk(MYIOC_s_WARN_FMT "%s: failed at (line=%d)\n", ioc->name,
 		 __func__, __LINE__);
-- 
2.25.1

