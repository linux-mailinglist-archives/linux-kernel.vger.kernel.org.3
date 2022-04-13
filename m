Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AC04FF8C5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbiDMOTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbiDMOTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:19:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F253F6213D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649859419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+hJqhkv6yogz+6Hfzk1EAtlFY9614J4i92uMnjq/jKE=;
        b=YCiFkcJ5r8GQjmbq70gZahBkZ2Zzh2u3D6VVPf2r1A1yUmnfIFQu1AJzt6lmlvRa2+BPQA
        RbclYUIB4YLRly9NFEJk9pbTRCPZPr3akV3E4+mXYKHWHBbDzOD7tidDlOCN5DYNcUA+L8
        xb5FJ4y+lDs21OGu2SGOvM1/c+MnStI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-lzHE3xzkP46J6xEjECc9Dg-1; Wed, 13 Apr 2022 10:16:55 -0400
X-MC-Unique: lzHE3xzkP46J6xEjECc9Dg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 827141066543;
        Wed, 13 Apr 2022 14:16:55 +0000 (UTC)
Received: from rules.brq.redhat.com (unknown [10.40.208.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F0569D4C;
        Wed, 13 Apr 2022 14:16:51 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     vdronov@redhat.com, Sunil Goutham <sgoutham@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Joseph Longever <jlongever@marvell.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hwrng: cn10k - Optimize cn10k_rng_read()
Date:   Wed, 13 Apr 2022 16:16:05 +0200
Message-Id: <20220413141606.8261-2-vdronov@redhat.com>
In-Reply-To: <20220413141606.8261-1-vdronov@redhat.com>
References: <20220413141606.8261-1-vdronov@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function assumes that sizeof(void) is 1 and arithmetic works for
void pointers. This is a GNU C extention and may not work with other
compilers. Change this by using an u8 pointer.

Also move cn10k_read_trng() out of a loop thus saving some cycles.

Fixes: 38e9791a0209 ("hwrng: cn10k - Add random number generator support")
Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
 drivers/char/hw_random/cn10k-rng.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/char/hw_random/cn10k-rng.c b/drivers/char/hw_random/cn10k-rng.c
index 35001c63648b..dd226630b67d 100644
--- a/drivers/char/hw_random/cn10k-rng.c
+++ b/drivers/char/hw_random/cn10k-rng.c
@@ -90,6 +90,7 @@ static int cn10k_rng_read(struct hwrng *hwrng, void *data,
 {
 	struct cn10k_rng *rng = (struct cn10k_rng *)hwrng->priv;
 	unsigned int size;
+	u8 *pos = data;
 	int err = 0;
 	u64 value;
 
@@ -102,17 +103,20 @@ static int cn10k_rng_read(struct hwrng *hwrng, void *data,
 	while (size >= 8) {
 		cn10k_read_trng(rng, &value);
 
-		*((u64 *)data) = (u64)value;
+		*((u64 *)pos) = value;
 		size -= 8;
-		data += 8;
+		pos += 8;
 	}
 
-	while (size > 0) {
+	if (size > 0) {
 		cn10k_read_trng(rng, &value);
 
-		*((u8 *)data) = (u8)value;
-		size--;
-		data++;
+		while (size > 0) {
+			*pos = (u8)value;
+			value >>= 8;
+			size--;
+			pos++;
+		}
 	}
 
 	return max - size;
-- 
2.35.1

