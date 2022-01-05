Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A68C484D08
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 05:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbiAEEEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 23:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiAEEEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 23:04:50 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6DAC061761;
        Tue,  4 Jan 2022 20:04:50 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id lr15-20020a17090b4b8f00b001b19671cbebso5177188pjb.1;
        Tue, 04 Jan 2022 20:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GGDVM9Wmq4oFLcjiD+ySmGciIMxv/fBGZw2/BdEaUGE=;
        b=SIytwWHi4AAwUUm+hpPuiYo7vy2diwozJjfbBN9t53Fbzd0SzKRy9ZcahgchpObJCI
         7qKt2eRiFEkVU0PiGyVD8U7d0Dp3DbAG+JJaOJT5BOqVK34Pv5s20ONcs9Z8ecG03u3O
         ZAUaoGlUbUUaPMlR1aEvIXi2jMwKStA6LCFddp7rRcKPCdJO/kcVvzpUimaIrsNATqUH
         PgpbdQib243cEtr9GGlHFypCcdsizTFYWdIwqcLil6YUiu3bwhqkuPsZgn3c9z2/zzW+
         AemyeyXbeuaR9Au/a4p0c9eZZ3nuNMYspmAdhy+vZv2/hwKqol8Mc5XiA+Ko5e7Ii+It
         xqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GGDVM9Wmq4oFLcjiD+ySmGciIMxv/fBGZw2/BdEaUGE=;
        b=wrMI4t5qw3aQo1aY+vWb/JXtH+5VnOW95gYCEuPnCNdtYKGxuUWVDXXPlky2lYBAwb
         /EKm13gbYsJhVJbPv1g1ax5KN53nTw2ouLcJ0HYcrmG9dMWempbqKRAnANqoaraD+zYT
         cDNIMWNyjZ3EFPygCKE02Ze7W+KZAFZ5IiyQ8QVLJ48GmBF8aHfHBtylHrjOvKDupkjf
         iNCPkVteIqT836H2+ymRUs47/fPvL5CYaMtkzEFxAzDlp1wR4iMYuaCWjUtn+BAaPNGS
         167IIFmquTcl8RT3bDVwBe+VdICAFUWS/d7j1baS8WEVra6SCVCauBEnTCw0unD3wXml
         TTdg==
X-Gm-Message-State: AOAM533BRVGQNFAFv/sZs8EtOtEnxdg5jbY5XloN15dFIuiXymY6fK8n
        GsLrXuKiRHqIAPukxxtBYFWaf0wKPVjgIeQL
X-Google-Smtp-Source: ABdhPJwU4Typ1gh9eX1es3vr2UbLkFVU2nvcsrKxujawUhwVIBe7+uRRN5qyDGGARCN0BWdbJJbQ3g==
X-Received: by 2002:a17:902:70c9:b0:149:76f1:47dc with SMTP id l9-20020a17090270c900b0014976f147dcmr42963945plt.130.1641355489927;
        Tue, 04 Jan 2022 20:04:49 -0800 (PST)
Received: from localhost.localdomain (39-10-37-45.adsl.fetnet.net. [39.10.37.45])
        by smtp.gmail.com with ESMTPSA id q19sm44334800pfk.153.2022.01.04.20.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 20:04:49 -0800 (PST)
From:   Wei Ming Chen <jj251510319013@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
        balbi@kernel.org, maze@google.com,
        Wei Ming Chen <jj251510319013@gmail.com>
Subject: [PATCH] usb: gadget: function: Fix returning incorrect PNP string
Date:   Wed,  5 Jan 2022 12:04:39 +0800
Message-Id: <20220105040439.3182-1-jj251510319013@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There will be 2 leading bytes indicating the total length of
the PNP string, so I think we should add value by 2, otherwise
the PNP string copied to user will not contain the last 2 bytes

Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
---
 drivers/usb/gadget/function/f_printer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index abec5c58f525..3fb00fd0b5ee 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -1005,9 +1005,11 @@ static int printer_func_setup(struct usb_function *f,
 				break;
 			}
 			value = strlen(dev->pnp_string);
+			memcpy(buf + 2, dev->pnp_string, value);
+
+			value += 2;
 			buf[0] = (value >> 8) & 0xFF;
 			buf[1] = value & 0xFF;
-			memcpy(buf + 2, dev->pnp_string, value);
 			DBG(dev, "1284 PNP String: %x %s\n", value,
 			    dev->pnp_string);
 			break;
-- 
2.25.1

