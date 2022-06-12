Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FB154796A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 11:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbiFLJAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 05:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbiFLJAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 05:00:44 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993B4517FF
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 02:00:37 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id a15so3704917wrh.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 02:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DtboLJnQWlaQx3cZn/5rtwDm8UnHa+IXUF0Drf8tf3c=;
        b=cr93iVQUbdBVCRI6c2GBMIxrKddY7Fx5VpjMCKS70SP0k7Oaz4l5ex5HXzKO7ThBgL
         8qaWw+ktuAEQxYMG1k3ZIbbZpJ2ZqhRKTj+L0lGBnbYTL3blvzDvdZqscET7qs3md+q4
         vwhG7ShyCieA5DF/O4ym8nSdvXFeSa2wDJ9VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DtboLJnQWlaQx3cZn/5rtwDm8UnHa+IXUF0Drf8tf3c=;
        b=8LUscIJAucslQiYNiBD7BLCfDCqsmYEFvOrhTrCS7k7ZrwUsAgsP1lX29HkFjlZcIS
         ait0wrVLRl2hT6boOO/u0D0mjIz7V+D0Y5Jo7h5P75uR2CAx0KBUqb+TU2WtmToESbdh
         S7+cYNwUxcC18jBUHupxGvp21SI/e2l9ixYKa7i7WKjTMGbyE04slGhVQsp7MNWnBmlq
         FX/d/tucHMFHLIrYlQsq35EgzpTHNTJV6g1alGv3nI3isGGqunsNwsYfxYmcJT5rMs/G
         uiqZ9xHtAUukVenFVPqC/Ismn1yba2uScS/QPuWZqc75YLS3nUdwWa7X54dqVh/Xbbx3
         YF8g==
X-Gm-Message-State: AOAM5329nrrooR8KWMckzpwHnMxqL6yZ2onbayodaCcsMp5Pqg51gdgX
        /HrAAzsDxRgFpYC4baHz+0zJIQ==
X-Google-Smtp-Source: ABdhPJzOh6DJzmbgNNA/kSYpX0YaIat9g7wOlQtREkJUQ3J+bznP3DbPy7OfehfCY6oDmCLaRHJJ4g==
X-Received: by 2002:a5d:64ac:0:b0:211:7f3b:a0d4 with SMTP id m12-20020a5d64ac000000b002117f3ba0d4mr52839238wrp.490.1655024437221;
        Sun, 12 Jun 2022 02:00:37 -0700 (PDT)
Received: from localhost.localdomain ([178.130.153.185])
        by smtp.gmail.com with ESMTPSA id d34-20020a05600c4c2200b0039c5b4ab1b0sm4798603wmp.48.2022.06.12.02.00.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2022 02:00:35 -0700 (PDT)
From:   Joe Damato <jdamato@fastly.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Cc:     Joe Damato <jdamato@fastly.com>
Subject: [RFC,iov_iter v2 2/8] iov_iter: Introduce iter_copy_type
Date:   Sun, 12 Jun 2022 01:57:51 -0700
Message-Id: <1655024280-23827-3-git-send-email-jdamato@fastly.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655024280-23827-1-git-send-email-jdamato@fastly.com>
References: <1655024280-23827-1-git-send-email-jdamato@fastly.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct iov_iter has a new member: iter_copy_type. This field holds a value
designating which type of copy to use: a regular temporal copy (ITER_COPY)
or a non-temporal copy (ITER_NOCACHE_COPY).

iov_iter initializers have been updated to set the default ITER_COPY
type.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 include/linux/uio.h | 17 +++++++++++++++++
 lib/iov_iter.c      |  6 ++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 739285f..59573ee 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -28,6 +28,12 @@ enum iter_type {
 	ITER_DISCARD,
 };
 
+enum iter_copy_type {
+	/* iter copy types */
+	ITER_COPY,
+	ITER_NOCACHE_COPY,
+};
+
 struct iov_iter_state {
 	size_t iov_offset;
 	size_t count;
@@ -35,6 +41,7 @@ struct iov_iter_state {
 };
 
 struct iov_iter {
+	u8 iter_copy_type;
 	u8 iter_type;
 	bool nofault;
 	bool data_source;
@@ -62,6 +69,11 @@ static inline enum iter_type iov_iter_type(const struct iov_iter *i)
 	return i->iter_type;
 }
 
+static inline enum iter_copy_type iov_iter_copy_type(const struct iov_iter *i)
+{
+	return i->iter_copy_type;
+}
+
 static inline void iov_iter_save_state(struct iov_iter *iter,
 				       struct iov_iter_state *state)
 {
@@ -95,6 +107,11 @@ static inline bool iov_iter_is_discard(const struct iov_iter *i)
 	return iov_iter_type(i) == ITER_DISCARD;
 }
 
+static inline bool iov_iter_copy_is_nt(const struct iov_iter *i)
+{
+	return iov_iter_copy_type(i) == ITER_NOCACHE_COPY;
+}
+
 static inline bool iov_iter_is_xarray(const struct iov_iter *i)
 {
 	return iov_iter_type(i) == ITER_XARRAY;
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 6dd5330..d32d7e5 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -511,6 +511,7 @@ void iov_iter_init(struct iov_iter *i, unsigned int direction,
 {
 	WARN_ON(direction & ~(READ | WRITE));
 	*i = (struct iov_iter) {
+		.iter_copy_type = ITER_COPY,
 		.iter_type = ITER_IOVEC,
 		.nofault = false,
 		.data_source = direction,
@@ -1175,6 +1176,7 @@ void iov_iter_kvec(struct iov_iter *i, unsigned int direction,
 {
 	WARN_ON(direction & ~(READ | WRITE));
 	*i = (struct iov_iter){
+		.iter_copy_type = ITER_COPY,
 		.iter_type = ITER_KVEC,
 		.data_source = direction,
 		.kvec = kvec,
@@ -1191,6 +1193,7 @@ void iov_iter_bvec(struct iov_iter *i, unsigned int direction,
 {
 	WARN_ON(direction & ~(READ | WRITE));
 	*i = (struct iov_iter){
+		.iter_copy_type = ITER_COPY,
 		.iter_type = ITER_BVEC,
 		.data_source = direction,
 		.bvec = bvec,
@@ -1208,6 +1211,7 @@ void iov_iter_pipe(struct iov_iter *i, unsigned int direction,
 	BUG_ON(direction != READ);
 	WARN_ON(pipe_full(pipe->head, pipe->tail, pipe->ring_size));
 	*i = (struct iov_iter){
+		.iter_copy_type = ITER_COPY,
 		.iter_type = ITER_PIPE,
 		.data_source = false,
 		.pipe = pipe,
@@ -1237,6 +1241,7 @@ void iov_iter_xarray(struct iov_iter *i, unsigned int direction,
 {
 	BUG_ON(direction & ~1);
 	*i = (struct iov_iter) {
+		.iter_copy_type = ITER_COPY,
 		.iter_type = ITER_XARRAY,
 		.data_source = direction,
 		.xarray = xarray,
@@ -1260,6 +1265,7 @@ void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count)
 {
 	BUG_ON(direction != READ);
 	*i = (struct iov_iter){
+		.iter_copy_type = ITER_COPY,
 		.iter_type = ITER_DISCARD,
 		.data_source = false,
 		.count = count,
-- 
2.7.4

