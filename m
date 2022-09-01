Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0595A9BFA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbiIAPoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbiIAPoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:44:18 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB3F72FFC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:44:17 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id og21so35572048ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 08:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=jbUUbn6xBzZd7j5ZqfqvA6Ey7A3ETCPriOiqhA/qkHA=;
        b=e3b00MlFma6liGQaarM70G3/5zFPDlvJyUrB2qnIjGXHN17p8oEmGBAHa8AoIN7JDX
         HOvlPAmTLZLkn3GdmRMI0n1kx2I1ngYT2jKNv43pTtqPdy2rMkUDll8BUpAWr3G/LnKv
         6qoJfPhsTQX3wfWmgjAciZN8XewNltgYYxwi5oIPzslT8KOn7HYSnPN13kvCoNoMaEMB
         2b/bpPSm6x/yw3K1jgkM/o4fOesp6fgbKOZvmtVeSy5VP2pAwC5KLQWgG1oWp+8fIWdu
         vSKRycQ7y1UCoH6+8jDO13EMSexx/EshsNN3ukOUWzRpUnSlKE2OZImxtRqQV+MXa2o8
         GjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=jbUUbn6xBzZd7j5ZqfqvA6Ey7A3ETCPriOiqhA/qkHA=;
        b=AgqrKOMXnuXl8SEdDwXsihRfwUW2RU7JMIrexqmEMCmQ73lPePGVjLdP+u+b7K5jyb
         IsHckz0or+zrEg/O2uDJ7iWeTNcSIGds9jIuSdmNPB5kPBZnFdSF1wgXhSyhJ2IbCnun
         66XJxkOInTj6FkGvLEvUjdtwCP6hO5GTgrCVCkkqsKnjRJsnrpiSYwGRE2Vk+wwWFs7i
         G7/Ejby9/XLJpfRuTTQzBf/uzEFmkYx9cNy8thPyMCvN/OKFVqjdgs+Hbwvqlcok7Msb
         7JHSMj0in3I/YSx1IG/CmcT2mmkw21HTZgQRV8RlieH2Q78L7XaGeCPWBEbb6sBF4xss
         ukjQ==
X-Gm-Message-State: ACgBeo324CBc2/LdS7w4Ay6EE4dWRL7GNPviHr/kOLw4eGxusTWnGKxS
        c9YNyHTBlzbrAEuTWaqqEu4=
X-Google-Smtp-Source: AA6agR6lAq4C798R8uHf3uTQfD3A7XLABoTzBW9PEWsOSi140q8G5AWvZ5RyZ6XknTxk0jOZxcz2rw==
X-Received: by 2002:a17:907:7e8c:b0:73d:85ec:46c with SMTP id qb12-20020a1709077e8c00b0073d85ec046cmr22845510ejc.257.1662047055743;
        Thu, 01 Sep 2022 08:44:15 -0700 (PDT)
Received: from localhost.localdomain (host-87-1-103-238.retail.telecomitalia.it. [87.1.103.238])
        by smtp.gmail.com with ESMTPSA id g6-20020a170906198600b0073dc6def190sm8576682ejd.158.2022.09.01.08.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 08:44:14 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 1/2] misc/xilinx_sdfec: Call kunmap() on pages mapped with kmap()
Date:   Thu,  1 Sep 2022 17:44:07 +0200
Message-Id: <20220901154408.23984-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901154408.23984-1-fmdefrancesco@gmail.com>
References: <20220901154408.23984-1-fmdefrancesco@gmail.com>
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

Pages in an array are mapped in a loop but, after the code is done with
the virtual addresses, these pages are never unmapped.

Therefore, call kunmap() to unmap pages[i].

Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/misc/xilinx_sdfec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index d6e3c650bd11..4b1d82ae7312 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -645,6 +645,7 @@ static int xsdfec_table_write(struct xsdfec_dev *xsdfec, u32 offset,
 			reg++;
 		} while ((reg < len) &&
 			 ((reg * XSDFEC_REG_WIDTH_JUMP) % PAGE_SIZE));
+		kunmap(pages[i]);
 		unpin_user_page(pages[i]);
 	}
 	return 0;
-- 
2.37.2

