Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944E54CECDF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 18:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbiCFRxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 12:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbiCFRwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 12:52:35 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDD7527D6;
        Sun,  6 Mar 2022 09:51:33 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id w4so14454949edc.7;
        Sun, 06 Mar 2022 09:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7L/xs4fx6+L+Psy2Q24Oz42Aj8LhoH2R3t77ruSAieQ=;
        b=VD93FV3zAZ9mxWdMMOnPObLl522sLSooKrrpc/8aSIViodCPTPH1h8uMcDp/Js704J
         X5P1/in71tJ6NTm+pijd2XRPN/eytV7XscDN94Z5c0MgKFgdBHYkXIYMY/lmHu/iUvs6
         b6Uc6glX0ewfqsqVp2BjswgX+7MBmagZaYi7tJ2e1AWUNPg4wcKMuRu7VYmDYG6h5Muv
         +fTIRWHLg9uQ43zDw/y2G2nkEHProJ6dlOYh8k87JATXogeoYAIShY0IuI5CwaFhZ5y7
         D4GK1I7CMN+z6k9f13aOOZ+9cf9iZ4jisNYZh2sMOwMb3KCUOTPV3XAgMk/MuZH6zHap
         JU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7L/xs4fx6+L+Psy2Q24Oz42Aj8LhoH2R3t77ruSAieQ=;
        b=qWfHgNCaVtE9Rqgm0zttnDubzxxqmSSbjith8GDXy4XdIygIg/cX71h7r1xKjLnY6W
         F2dbt0cxagyZGvLL56AIHWcvLGGv6krppsJrVpIWO1g9OlNG4sd6oh5FyK+9YpD3Zfa+
         bQYPRoD14fW9Ey4W9ko6AKvf2tC/WPdbBo9bqyiUjYO6EjSyaQ9hvOZPvgNQlxe0gmTg
         Rt0UV8j9on52X3dDhL9NtjvOs3oTpnQy5usSqRTfzlt2CoOWbJRHkl9oILEzRGX6u5he
         +WwA3ZJ8KAoc8Who6zvZpXzRrBL2DmqAEaUDCg9N1m8bqDZayxNxEzI4ZcBcLd0sHAEE
         stTA==
X-Gm-Message-State: AOAM530aikbGA77UPqQJ9YvhmIB6KXme8JHezhIGwD1lw6BBceBD40OP
        /As+ybeOKpwyBGcAn/dcWeA=
X-Google-Smtp-Source: ABdhPJzik5qGEaWXA/mY5pY2E48KOsS17nIJHMdyugphkWCPmVeey2cfjVdgaH3vxXegNIVnq8fSCw==
X-Received: by 2002:aa7:c946:0:b0:416:226f:f8a6 with SMTP id h6-20020aa7c946000000b00416226ff8a6mr6569335edt.360.1646589091947;
        Sun, 06 Mar 2022 09:51:31 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id 20-20020a17090601d400b006caff964e30sm4052606ejj.19.2022.03.06.09.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 09:51:31 -0800 (PST)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Greg Kroah-Hartman <greg@kroah.com>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Al Cooper <alcooperx@gmail.com>, Li Yang <leoyang.li@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-usb@vger.kernel.org (open list:USB GADGET/PERIPHERAL SUBSYSTEM),
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: [PATCH 18/26] usb: gadget: legacy: remove using list iterator after loop body as a ptr
Date:   Sun,  6 Mar 2022 18:50:26 +0100
Message-Id: <20220306175034.3084609-19-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220306175034.3084609-1-jakobkoschel@gmail.com>
References: <20220306175034.3084609-1-jakobkoschel@gmail.com>
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

If the list does not contain the expected element, the value of
list_for_each_entry() iterator will not point to a valid structure.
To avoid type confusion in such case, the list iterator
scope will be limited to list_for_each_entry() loop.

In preparation to limiting scope of a list iterator to the list traversal
loop, use a dedicated pointer to point to the found element [1].
Determining if an element was found is then simply checking if
the pointer is != NULL instead of using the potentially bogus pointer.

Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/usb/gadget/legacy/hid.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/legacy/hid.c b/drivers/usb/gadget/legacy/hid.c
index 3912cc805f3a..b7f1ff2ce951 100644
--- a/drivers/usb/gadget/legacy/hid.c
+++ b/drivers/usb/gadget/legacy/hid.c
@@ -134,7 +134,7 @@ static int hid_bind(struct usb_composite_dev *cdev)
 {
 	struct usb_gadget *gadget = cdev->gadget;
 	struct list_head *tmp;
-	struct hidg_func_node *n, *m;
+	struct hidg_func_node *n = NULL, *m, *tmp_n;
 	struct f_hid_opts *hid_opts;
 	int status, funcs = 0;
 
@@ -144,18 +144,19 @@ static int hid_bind(struct usb_composite_dev *cdev)
 	if (!funcs)
 		return -ENODEV;
 
-	list_for_each_entry(n, &hidg_func_list, node) {
-		n->fi = usb_get_function_instance("hid");
-		if (IS_ERR(n->fi)) {
-			status = PTR_ERR(n->fi);
+	list_for_each_entry(tmp_n, &hidg_func_list, node) {
+		tmp_n->fi = usb_get_function_instance("hid");
+		if (IS_ERR(tmp_n->fi)) {
+			status = PTR_ERR(tmp_n->fi);
+			n = tmp_n;
 			goto put;
 		}
-		hid_opts = container_of(n->fi, struct f_hid_opts, func_inst);
-		hid_opts->subclass = n->func->subclass;
-		hid_opts->protocol = n->func->protocol;
-		hid_opts->report_length = n->func->report_length;
-		hid_opts->report_desc_length = n->func->report_desc_length;
-		hid_opts->report_desc = n->func->report_desc;
+		hid_opts = container_of(tmp_n->fi, struct f_hid_opts, func_inst);
+		hid_opts->subclass = tmp_n->func->subclass;
+		hid_opts->protocol = tmp_n->func->protocol;
+		hid_opts->report_length = tmp_n->func->report_length;
+		hid_opts->report_desc_length = tmp_n->func->report_desc_length;
+		hid_opts->report_desc = tmp_n->func->report_desc;
 	}
 
 
-- 
2.25.1

