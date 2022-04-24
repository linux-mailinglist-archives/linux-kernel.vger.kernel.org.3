Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F80550D04A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 09:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238588AbiDXHrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 03:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238571AbiDXHr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 03:47:27 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FEC17D48E
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 00:44:26 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id bg25so6789953wmb.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 00:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y6d3QvwCWUkOHo4Nv6Umw+CYKaT+QPo1Bwdbb14LmYU=;
        b=m/IUbfawZHI/czKAqYEd1rwhTJsIsd5jB2srww5IrZZk92bRIA86BFZ2yFtqa4f/mI
         5moQLajc8hy9UCZMm5K7GMPgUONwOpugYnHtsZqXG4j3J8t15KhBJubDLNLnT5wUlZgA
         ZT3dcla/0GAZlsoJ7tPpfqOuz4icjnToqdpd/dBuJAzMlfsu+HTBubBlqvYgWAuXGeX/
         DyyfQgybIrZgbMt20fFethTZZoWov99uRlqnsgNbNbsdbeRZFUMmRKgKXSI8QhOJ07XN
         6gJpK7I/X/nN6ejrFh7h4vnEysu/uz+6o3/rlJGsYBh4cahMEOYSgSDxN324W5JNojqv
         AmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y6d3QvwCWUkOHo4Nv6Umw+CYKaT+QPo1Bwdbb14LmYU=;
        b=NZhKe+Y8EZC8kfO7Db1RDkl4ddBBsozSkFc/ket1YRsC0VhOKqY2AFrfZ/Cu8j9Pb8
         G2RRLcDR9mpOgaPrNYsVKBvlxYppOJps+LAwY+/DL6Ya07xnRgoc4q9mHfLVEMBJ3f02
         9UwIDXmVDk2NOMCloFFRKB6m56srAshGmQV5hkO6XPtJxUMMlJPC+mFFZerFHY9CarXw
         gtYRLjrXkXhA2L+RP0ZPJIr6uZvKaM3nhDOwad1S3PXZTBKzOpFQOiNQZdovZsyc0S4N
         aHemCJzejwENI7WG0UnIxejm07ujEoLKJbiD6XtdeP0rVRaqgSTvcC5rpn3ClUF3Np+a
         iQJA==
X-Gm-Message-State: AOAM531vrE2Hpi5tZfqIzpe5tpfkXx4CxAvPsQEQWqE0SFbkXP5PyJte
        Gs2RQ57L9VxQPTb2meBtRIDPD8jbqGE=
X-Google-Smtp-Source: ABdhPJwk3Mjh5EeGOh6zHL2gt37HSwzmr44mKBs4YzRN66Opb7ijOGJokkt9Tti7VEilOraOqU9OuA==
X-Received: by 2002:a05:600c:4e4a:b0:392:88e1:74a7 with SMTP id e10-20020a05600c4e4a00b0039288e174a7mr20767339wmq.174.1650786264720;
        Sun, 24 Apr 2022 00:44:24 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id k23-20020adfb357000000b0020ad7c36332sm1479001wrd.110.2022.04.24.00.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 00:44:24 -0700 (PDT)
Date:   Sun, 24 Apr 2022 09:44:22 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] staging: vt6655: Replace two VNSvInPortD with
 ioread64_lo_hi
Message-ID: <db5ba681cea27de815b172f8b93a8fd1efa30e99.1650784817.git.philipp.g.hortmann@gmail.com>
References: <cover.1650784817.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1650784817.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace two macros VNSvInPortD (32 Bit reads) with one ioread64_lo_hi.
The names of macro and the arguments use CamelCase which is not
accepted by checkpatch.pl

Since there are more than one checkpatch issue per line,
more steps are rquired to fix.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
Used this code for testing:
	VNSvInPortD(iobase + MAC_REG_TSFCNTR, (u32 *)pqwCurrTSF);
	VNSvInPortD(iobase + MAC_REG_TSFCNTR + 4, (u32 *)pqwCurrTSF + 1);
	dev_info(&priv->pcid->dev, "CARDbGetCurrentTSF *pqwCurrTSF: %llx", *pqwCurrTSF);
	dev_info(&priv->pcid->dev, "CARDbGetCurrentTSF temp_ph: %llx",
			 ioread64_lo_hi(iobase + MAC_REG_TSFCNTR));
output:
[  +0.000085] vt6655 0000:01:05.0: CARDbGetCurrentTSF *pqwCurrTSF: 117e7e
[  +0.000005] vt6655 0000:01:05.0: CARDbGetCurrentTSF temp_ph: 117e7e
[  +0.000009] vt6655 0000:01:05.0: CARDbGetCurrentTSF *pqwCurrTSF: 39756d7f
[  +0.000005] vt6655 0000:01:05.0: CARDbGetCurrentTSF temp_ph: 39756d7f
[  +0.000009] vt6655 0000:01:05.0: CARDbGetCurrentTSF *pqwCurrTSF: 39756d8d
[  +0.000004] vt6655 0000:01:05.0: CARDbGetCurrentTSF temp_ph: 39756d8d
---
 drivers/staging/vt6655/card.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 022310af5485..5da25140ed4b 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -30,6 +30,7 @@
 #include "desc.h"
 #include "rf.h"
 #include "power.h"
+#include <linux/io.h>
 
 /*---------------------  Static Definitions -------------------------*/
 
@@ -753,8 +754,7 @@ bool CARDbGetCurrentTSF(struct vnt_private *priv, u64 *pqwCurrTSF)
 	}
 	if (ww == W_MAX_TIMEOUT)
 		return false;
-	VNSvInPortD(iobase + MAC_REG_TSFCNTR, (u32 *)pqwCurrTSF);
-	VNSvInPortD(iobase + MAC_REG_TSFCNTR + 4, (u32 *)pqwCurrTSF + 1);
+	*pqwCurrTSF = ioread64_lo_hi(iobase + MAC_REG_TSFCNTR);
 
 	return true;
 }
-- 
2.25.1

