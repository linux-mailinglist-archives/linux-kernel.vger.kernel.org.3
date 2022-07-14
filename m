Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCA657410D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 03:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbiGNB4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 21:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiGNB4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 21:56:04 -0400
Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90C6F13E2C;
        Wed, 13 Jul 2022 18:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=196ux
        RHoHvSBw03mMM4kQOPXzUxsgm0Z0sGUSncCKU4=; b=eQkPjbZ8Y96f97fjnMy8w
        JMlAAdazgjVz6xmKV7WWhAQo2ftNLjbpzgjHfiOs2iX4gSrMe/OkWnFnXqu4znRU
        c9v7nKJ3UGnaGk6D9reb2ThCuJBSUx+pYx++LuybHRPIVNho9wP+rxnTfzKRmMCh
        ryaVwdeZB4NzIBsYUK0jJs=
Received: from localhost.localdomain (unknown [111.48.58.12])
        by smtp11 (Coremail) with SMTP id D8CowAAHgfyNd89i1NsDMw--.16429S2;
        Thu, 14 Jul 2022 09:55:31 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH] lib/lzo/lzo1x_compress.c: replace ternary operator with min() and min_t()
Date:   Thu, 14 Jul 2022 09:54:41 +0800
Message-Id: <20220714015441.1313036-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowAAHgfyNd89i1NsDMw--.16429S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrW7Xw18Cw4rGr13XF45trb_yoW8XFy7pF
        1DGFyvqFWxtw17W3yxJwsFga47J398Ja1Iq39Igay7Was8JFn7Xr9xtF4DAFsxXFs3XasI
        y34DZr45Xw40yw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jTrWrUUUUU=
X-Originating-IP: [111.48.58.12]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbizRY9+1c7NfJz-QABs5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix the following coccicheck warning:

lib/lzo/lzo1x_compress.c:54: WARNING opportunity for min().
lib/lzo/lzo1x_compress.c:329: WARNING opportunity for min().

min() and min_t() macro is defined in include/linux/minmax.h. It avoids
multiple evaluations of the arguments when non-constant and performs
strict type-checking.

Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 lib/lzo/lzo1x_compress.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/lzo/lzo1x_compress.c b/lib/lzo/lzo1x_compress.c
index 76758e9296ba..9d31e7126606 100644
--- a/lib/lzo/lzo1x_compress.c
+++ b/lib/lzo/lzo1x_compress.c
@@ -50,9 +50,7 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
 
 		if (dv == 0 && bitstream_version) {
 			const unsigned char *ir = ip + 4;
-			const unsigned char *limit = ip_end
-				< (ip + MAX_ZERO_RUN_LENGTH + 1)
-				? ip_end : ip + MAX_ZERO_RUN_LENGTH + 1;
+			const unsigned char *limit = min(ip_end, ip + MAX_ZERO_RUN_LENGTH + 1);
 #if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && \
 	defined(LZO_FAST_64BIT_MEMORY_ACCESS)
 			u64 dv64;
@@ -326,7 +324,7 @@ static int lzogeneric1x_1_compress(const unsigned char *in, size_t in_len,
 	data_start = op;
 
 	while (l > 20) {
-		size_t ll = l <= (m4_max_offset + 1) ? l : (m4_max_offset + 1);
+		size_t ll = min_t(size_t, l, m4_max_offset + 1);
 		uintptr_t ll_end = (uintptr_t) ip + ll;
 		if ((ll_end + ((t + ll) >> 5)) <= ll_end)
 			break;
-- 
2.25.1

