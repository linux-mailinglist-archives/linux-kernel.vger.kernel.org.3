Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858E54EE473
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 01:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242780AbiCaXJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 19:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242752AbiCaXJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 19:09:06 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74484241A0B;
        Thu, 31 Mar 2022 16:07:18 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r13so2341321ejd.5;
        Thu, 31 Mar 2022 16:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tq6felZrVZ9OJWr5Zlb/qFgwlSaptzfYLpBsT8+rZ38=;
        b=VVN9eOsHfWaNm51McvRFnSTZvSAdYphiV2X9W8Nh1okB64o6u5Ld54RYqzI6F1XMjg
         lW47piFIJURUfOzCnYPMdqtGqDYUchTMV48l+RB2X0CNa/UW6nkaIfgFoi3PQ61k+B9q
         9+qAG3U/7eRB/Syi1WdwM7jkrZ0ZIkPcSGfOCiRmkyjcKo50ZsQCZGnOBaYIztQVzfFE
         H25AOVZF/zw8HasSesB2/H6juHQ+gSaxiWMrPkxMQUyQZbUplMg3p7Gy4Z7K6JDrAKL9
         XSnOTVud7AJBUv6MEh1zDn1c9iTYLVUG1C//Pa9WqAhNVIro/5yLJzG2fzUrEPV+ueM6
         qbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tq6felZrVZ9OJWr5Zlb/qFgwlSaptzfYLpBsT8+rZ38=;
        b=A9o/Q+vPWsAFHbLtVN0fqJBqrj9epbwIODnL+EUfns8DuRqJL1o78iBDxiUBsr4Bz+
         CWVk5pMNHyGjKQ2ZW2Mx2yddQ0F4BlweigD3WhKnSfGrjGBNxoIX/f3+VWc9uHbi0p54
         tGPIztmmLRlfeHlMGxYHFvdV5Gnkk4OrJ4OInvts5HvSw8x+kkZa6/liFCl8Z2h4wnYH
         MITuQ4yrlv1QJIUNNFY1uAdax1irgiMYZD9qrbRFs/SlOFYYIZv2UeTwQvnTOZegvy44
         JGpzmhhoC5qOwMbdWk5RjO80u4JwBJyUE0HWXxZ8PXMsgDT/ROn9LDQwiI5kfrST66gt
         doJg==
X-Gm-Message-State: AOAM531ThE0EDChKNVD2VNSQSvf+JFn7JkXcnEjG3RZCc2LRbD4yub0h
        h67ocSDihzbcK6lW/6mATXc=
X-Google-Smtp-Source: ABdhPJwjUlMDCoWE9kl9gNy0jVgXn+nwjD8zZMvHsRGS5fR8q+vsfK7b8lcQbMyjTPRvlpQAQ1LYIQ==
X-Received: by 2002:a17:907:3e99:b0:6db:6c1c:d9d9 with SMTP id hs25-20020a1709073e9900b006db6c1cd9d9mr6835447ejc.688.1648768037035;
        Thu, 31 Mar 2022 16:07:17 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id p12-20020a17090635cc00b006e055c9c91esm297131ejb.101.2022.03.31.16.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 16:07:16 -0700 (PDT)
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
Subject: [PATCH 2/3] iio: ssp_sensors: replace usage of found with dedicated list iterator variable
Date:   Fri,  1 Apr 2022 01:06:31 +0200
Message-Id: <20220331230632.957634-2-jakobkoschel@gmail.com>
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
 drivers/iio/common/ssp_sensors/ssp_spi.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index 769bd9280524..f32b04b63ea1 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -331,12 +331,11 @@ static int ssp_parse_dataframe(struct ssp_data *data, char *dataframe, int len)
 /* threaded irq */
 int ssp_irq_msg(struct ssp_data *data)
 {
-	bool found = false;
 	char *buffer;
 	u8 msg_type;
 	int ret;
 	u16 length, msg_options;
-	struct ssp_msg *msg, *n;
+	struct ssp_msg *msg = NULL, *iter, *n;
 
 	ret = spi_read(data->spi, data->header_buffer, SSP_HEADER_BUFFER_SIZE);
 	if (ret < 0) {
@@ -362,15 +361,15 @@ int ssp_irq_msg(struct ssp_data *data)
 		 * received with no order
 		 */
 		mutex_lock(&data->pending_lock);
-		list_for_each_entry_safe(msg, n, &data->pending_list, list) {
-			if (msg->options == msg_options) {
-				list_del(&msg->list);
-				found = true;
+		list_for_each_entry_safe(iter, n, &data->pending_list, list) {
+			if (iter->options == msg_options) {
+				list_del(&iter->list);
+				msg = iter;
 				break;
 			}
 		}
 
-		if (!found) {
+		if (!msg) {
 			/*
 			 * here can be implemented dead messages handling
 			 * but the slave should not send such ones - it is to
-- 
2.25.1

