Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96D24EE476
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 01:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242794AbiCaXJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 19:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242767AbiCaXJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 19:09:07 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32115241A13;
        Thu, 31 Mar 2022 16:07:19 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id c10so2244011ejs.13;
        Thu, 31 Mar 2022 16:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dbd+FeFljOdDtTjz0SE9OURXlnjXbAIwzSzKI/SK8Hs=;
        b=oPmqCMSQjmk62BS1YZ2/0YxmoKih7cVsZOjbV01H/cpzCZXanTD3d+oAcdX2qAT8Oo
         OJ6zmB/cbMgqWwCjTZX9YHglYfvNyKkXL0dBQkpvJ6bOSJwen1FY9tRttbCFwqBF6TzO
         RNlET5odbw5xuBYazYYMj+FmmmY80K9h7Ow3n/vLJdKOBgKwTKSfoRwHd+yrX7i06b4H
         kHN3WV21ODDDom6U3LE578k/SU6cdEFz8PPfbV9MG3nFI9F3iaf96ynZYO5hLR//USCT
         MEBACGkXBQ+aaKwzYBllBhXZ5d97CXEhh/L0cJjrvxe1Y7Hn1Uod9pfnWatBNNsyDhCY
         LMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dbd+FeFljOdDtTjz0SE9OURXlnjXbAIwzSzKI/SK8Hs=;
        b=pvLXYK9V8cE20/5OJHtbSZg86WHYzVjhMt6b7SCbmhuhL/1ojAARojB5F+QFnXhSxu
         JcJ6Z8yfLoNFVikq5L/ZieHF9S56qdz6N6RPGACH3fVf2R3GwwyboYKvusPgzMKW533W
         M71LvSdisDSi1PiNLiY+EomSp6YOzJjT1XDsO11zrZm9mzHVV7X72p6VMTF331Fr9Ewo
         KkUa/DF5/VCAJkenS3o92dsP9fgVula12/bXvDtUczZ/hH1qq2fRt+3kS1ZbZQUhnvYv
         OxA6b+oB/R6VwK0oN9sPNioEtcXmZM9En1Zib4hL/eWugUs6JmxgGTlEEasfTx5HdfO1
         wMZA==
X-Gm-Message-State: AOAM533Wpo7+f58m/kIE7+LKhGo+DGJACP5z9caSP5Tj3ODlN2BTt/dZ
        q6jfhYNb2tzgBPAwdKKX4rU=
X-Google-Smtp-Source: ABdhPJyrF6FjKgnMDnGC1tbIqIH9Sh1hVWToOj0/1UDT7ZU9e3El36RtthXnxRjHHqBDctFTTptAsQ==
X-Received: by 2002:a17:906:2a85:b0:6ce:36bd:bcd9 with SMTP id l5-20020a1709062a8500b006ce36bdbcd9mr6819245eje.318.1648768037754;
        Thu, 31 Mar 2022 16:07:17 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id p12-20020a17090635cc00b006e055c9c91esm297131ejb.101.2022.03.31.16.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 16:07:17 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: [PATCH 3/3] iio: sysfs-trigger: replace usage of found with dedicated list iterator variable
Date:   Fri,  1 Apr 2022 01:06:32 +0200
Message-Id: <20220331230632.957634-3-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220331230632.957634-1-jakobkoschel@gmail.com>
References: <20220331230632.957634-1-jakobkoschel@gmail.com>
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

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/iio/trigger/iio-trig-sysfs.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/trigger/iio-trig-sysfs.c b/drivers/iio/trigger/iio-trig-sysfs.c
index 2a4b75897910..f1a8704e6cc1 100644
--- a/drivers/iio/trigger/iio-trig-sysfs.c
+++ b/drivers/iio/trigger/iio-trig-sysfs.c
@@ -176,16 +176,15 @@ static int iio_sysfs_trigger_probe(int id)
 
 static int iio_sysfs_trigger_remove(int id)
 {
-	bool foundit = false;
-	struct iio_sysfs_trig *t;
+	struct iio_sysfs_trig *t = NULL, *iter;
 
 	mutex_lock(&iio_sysfs_trig_list_mut);
-	list_for_each_entry(t, &iio_sysfs_trig_list, l)
-		if (id == t->id) {
-			foundit = true;
+	list_for_each_entry(iter, &iio_sysfs_trig_list, l)
+		if (id == iter->id) {
+			t = iter;
 			break;
 		}
-	if (!foundit) {
+	if (!t) {
 		mutex_unlock(&iio_sysfs_trig_list_mut);
 		return -EINVAL;
 	}
-- 
2.25.1

