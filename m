Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFD74EE979
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 10:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344151AbiDAIFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 04:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244236AbiDAIFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 04:05:34 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C346862106;
        Fri,  1 Apr 2022 01:03:44 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id kd21so1463086qvb.6;
        Fri, 01 Apr 2022 01:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iigF8mZf5i0ikBPqRgdRRkmmEgwTtaij4Ng6hfEOlCQ=;
        b=ftdTOSnXccEyo1dXXR9tTbQVppJSoN5RXjbIIr/EbrENnzHLuN9lJwfUKrxOrHm3O/
         QnEXfsZjW+AQ8LPoBsdsiMNqN7FNsNsuyX6s7Ru38zJSlnRqR/L4b9TJ7wjzZdQTYkkC
         RU5DCf7qm9TPiWkLvjhh1LDCTDQ785zYPc+B1gzilKeBoig2fLqMF61w2qrGyL959ad9
         iMX7kz3SF3PEviq5DUSfwpo1+DW8AL4Ps72+YeHaXrcAIVDGTLdvg+tJd587rucjqw/q
         AAkuPAyIclnPyJIAQpXsi8h3N5KNkm/xybiyxRN51HnZ/FPmaboCZCEFImtW3J1AvDqZ
         G4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iigF8mZf5i0ikBPqRgdRRkmmEgwTtaij4Ng6hfEOlCQ=;
        b=DJP+gPmjnDzBWLRX2xxwKwabJG7hwjK3FiAehIw5mNeFxQmpycqrfv0XpoxHuNinoA
         6FaCHp4hfpt7Q5IXulGS0O9qoGFMxkaTI2zo0p7baV1ElVkR7Ean7DD17TdWfsa63FBI
         n9279B02KptnKLfTuWQ6vlgFutPBdqa+hJqUwIAUfwNt8McaC1aoOd0vKy6RsZL5whkb
         F7z0ZUmOVTfH8OWgJiyKusuwwsgg2fLb7woylrj03FpYwFxfHOnF86M5Kk9fDTNNg7mU
         R7wXiSN+Q6gvDJJexeTmmc/5DNAwNT3/jGvkwWF6qsgQI173B70KgRFAMWJ4Hi3lFZQ5
         WIog==
X-Gm-Message-State: AOAM532rdJ4geFybaMJFXoK8B9JbfMX8B6ZLlf6c5+J0+CV6VXWW/KN9
        rjWpnh39NFobVwmivbhXQC0rYdAuCxk=
X-Google-Smtp-Source: ABdhPJxngn1dIdK7Y2CsTXi9S2CvDhQnSZg9UI6fOapkkkuAr/xkbmo7jHaEEvp22b7sQqFhZN6RHg==
X-Received: by 2002:a05:6214:c6a:b0:443:6a15:5888 with SMTP id t10-20020a0562140c6a00b004436a155888mr7313538qvj.20.1648800223945;
        Fri, 01 Apr 2022 01:03:43 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w3-20020a05622a190300b002e1f084d84bsm1426120qtc.50.2022.04.01.01.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 01:03:43 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     mailhol.vincent@wanadoo.fr
Cc:     gregkh@linuxfoundation.org, lv.ruyi@zte.com.cn,
        cai.huoqing@linux.dev, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] usb: host: replace zero-length array with flexible-array member
Date:   Fri,  1 Apr 2022 08:03:37 +0000
Message-Id: <20220401080337.2407622-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

There is a regular need in the kernel to provide a way to declare
having a dynamically sized set of trailing elements in a structure.
Kernel code should always use “flexible array members”[1] for these
cases. The older style of one-element or zero-length arrays should
no longer be used[2].

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/usb/host/oxu210hp-hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/oxu210hp-hcd.c b/drivers/usb/host/oxu210hp-hcd.c
index b741670525e3..86f92aadeb0e 100644
--- a/drivers/usb/host/oxu210hp-hcd.c
+++ b/drivers/usb/host/oxu210hp-hcd.c
@@ -169,7 +169,7 @@ struct ehci_regs {
 #define FLAG_CF		(1<<0)		/* true: we'll support "high speed" */
 
 	/* PORTSC: offset 0x44 */
-	u32		port_status[0];	/* up to N_PORTS */
+	u32		port_status[];	/* up to N_PORTS */
 /* 31:23 reserved */
 #define PORT_WKOC_E	(1<<22)		/* wake on overcurrent (enable) */
 #define PORT_WKDISC_E	(1<<21)		/* wake on disconnect (enable) */
-- 
2.25.1

