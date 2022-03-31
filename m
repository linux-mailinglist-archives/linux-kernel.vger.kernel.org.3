Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFF24EE475
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 01:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242768AbiCaXJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 19:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242262AbiCaXJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 19:09:05 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F05241A13;
        Thu, 31 Mar 2022 16:07:17 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g22so1018459edz.2;
        Thu, 31 Mar 2022 16:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gwff2ScMyduRFsgNLSOrbaYErL2LHR4WqzSPtFakqCI=;
        b=E4dRxHk3X5Xz6uhDp52u6jrJvE/XjTHOkNGNPYHzoNyNyghBE6nTVogfQ8NX+WJRF+
         t250rCKrgxpbGxzg+KY3hCGGnyGjZW2o0WU8L5QRafo1cSwGkkZG2NmusPL+7kFSM836
         8mgGNyoSS3NL003Il3/2o6f6brvr7F5JEWStaxaRFe/ZPx1dPwTy/JQiJAQutw9xJoYp
         EBB5mHEYQvZ6GtHlE1eU3j7oIMutmWsUCelULppAPxeHaaErMOhmabxp1MtFlGFzehh9
         akogZ7C7SNqduYGp7+ECJcENz8e8I/rXSycU1PohiljVQPp/hwv8AKQelfnjOx5bKHdb
         Vk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gwff2ScMyduRFsgNLSOrbaYErL2LHR4WqzSPtFakqCI=;
        b=D2DHqVMHqq3oWjQCXrFjey82bZusKAc4DjlO3+tgUBZm+vN8qRwHnh4qZXg4kCodVL
         VpNrV+QpDcRCtFW3F0+GZZwJYBAg0d449cnCwcYXmjESQN0qs1Gx3P6wj+1iKxPXgqm7
         3AOwh49tND5PdJjOKYQSQhFz5OnyY+JUhc3vf4OdOXYNLxxS+BHYB3KrXOzE0wU49IIv
         PqmGCGdCUUPtzzlhl1XN1YHtGy6VcFez+jCWMWDvoRnFDXEyD7WUlMbMKVX6l8DDWqJt
         FUUlCWwVDvBrFgKxpNzRWJifJbhkUvtR7QgX05HxCq3XtySo3vgL1Vh5qX4+kPgtYc6H
         bPRw==
X-Gm-Message-State: AOAM530cTS2cv+ksk1hmeIBLGtdb6yRvwrk8gKocb9sy1vpdyJiG/qbC
        4Azle9G1l7/mWbH9l4j/ujo=
X-Google-Smtp-Source: ABdhPJycWqtrvPwUIXmTfiMnkiB4sefH2ALh1PxluMvc+KyauHkt1vUUhyB2uVulSaxCw+9lqe4GTA==
X-Received: by 2002:a05:6402:2219:b0:418:ed4e:f999 with SMTP id cq25-20020a056402221900b00418ed4ef999mr18450252edb.121.1648768036169;
        Thu, 31 Mar 2022 16:07:16 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id p12-20020a17090635cc00b006e055c9c91esm297131ejb.101.2022.03.31.16.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 16:07:15 -0700 (PDT)
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
Subject: [PATCH 1/3] iio: buffer: remove usage of list iterator variable for list_for_each_entry_continue_reverse()
Date:   Fri,  1 Apr 2022 01:06:30 +0200
Message-Id: <20220331230632.957634-1-jakobkoschel@gmail.com>
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

In preparation to limit the scope of the list iterator variable to the
list traversal loop, use a dedicated pointer to iterate through the
list [1].

Since that variable should not be used past the loop iteration, a
separate variable is used to 'remember the current location within the
loop'.

To either continue iterating from that position or start a new
iteration (if the previous iteration was complete) list_prepare_entry()
is used.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/iio/industrialio-buffer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 208b5193c621..151a77c2affd 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1059,7 +1059,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 	struct iio_device_config *config)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-	struct iio_buffer *buffer;
+	struct iio_buffer *buffer, *tmp = NULL;
 	int ret;

 	indio_dev->active_scan_mask = config->scan_mask;
@@ -1097,8 +1097,10 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,

 	list_for_each_entry(buffer, &iio_dev_opaque->buffer_list, buffer_list) {
 		ret = iio_buffer_enable(buffer, indio_dev);
-		if (ret)
+		if (ret) {
+			tmp = buffer;
 			goto err_disable_buffers;
+		}
 	}

 	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
@@ -1125,6 +1127,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 					     indio_dev->pollfunc);
 	}
 err_disable_buffers:
+	buffer = list_prepare_entry(tmp, &iio_dev_opaque->buffer_list, buffer_list);
 	list_for_each_entry_continue_reverse(buffer, &iio_dev_opaque->buffer_list,
 					     buffer_list)
 		iio_buffer_disable(buffer, indio_dev);

base-commit: f82da161ea75dc4db21b2499e4b1facd36dab275
--
2.25.1

