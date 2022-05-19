Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B8F52DB33
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242644AbiESR0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242663AbiESRZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:25:14 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E83AF1C3;
        Thu, 19 May 2022 10:25:10 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id j6so5682712pfe.13;
        Thu, 19 May 2022 10:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T/71y4H0I4tJDzEESJX0yVgmBrZLbwRkc6IKYDc6cJQ=;
        b=FNeKL719/JSvBNGGdlxYJrA++Pqq2AgXDBKMjEHguJLVlJF/71rwvQzK/58eD+ilYz
         1hSU78Lyg69ebMTAqvNqtbbxK7VCSIEGgkfiHGqQnky43Nz08btAj78Jegp3YSTYfoME
         NTi7ADeDSjO3y05gXnLjuF1oQyymuRHEFnpJTlrRWZiIxFT0ZjvrHAD+DNqliS+9hMwV
         KiztEkiGOMbmQaMQfdbx0Ewk31VGeVpvOWXiK0xgHqlNTvz97i7Z6OHBB9+UxVDTducT
         ncQ7PyrFuYWLsGsHpq0SlJaSgIzYWuQkctoju9ro+b2clTsKwQhLELeFU8G2iQzEfV4f
         +Qwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T/71y4H0I4tJDzEESJX0yVgmBrZLbwRkc6IKYDc6cJQ=;
        b=h2XMIk4g8BZd2czELH8/cRoBmMjF1CnPRdcZxhYkb8YvquzavpUXaKnx8CMC4G7PqF
         lgP4+g+z3DJk+j3ECYsz3D41nKI73XrDah3LWlu2qLB+A3yPK48/ssAWAlz07emv+Pg+
         LETAqUX/M+LAujw4aYDJFqyQfvrBP5b1qx29RNmcHqYN+vNFI5NVbamCYjQgfRm++6ug
         KhkJeliOwGkUNxfWoFFSnYhYStgeLNVp1iCas4vCMPAGdH9PXl3vvPuPpVLbhAAJcnpc
         Kj+A/i3drbg17lW2zZC9mBnSErS5Ty0cHw9b6kTgaMR/in4QMlMBpC+bwehf9AhLNCMM
         J5cA==
X-Gm-Message-State: AOAM53012or8PR8R/SaPz6Intne/wOgVIIGUeAsnGK7T9WQBGlSbPuzU
        AINtmVu2Oygp8/sR+P1L0dS0FTWLTc0x
X-Google-Smtp-Source: ABdhPJynGDjof146Uv8mxfj7qsya6dFrrvJU47qw8CwICqf8Ilv6hZa/vLYj0yeXSEPe63TM26xXeg==
X-Received: by 2002:a65:6205:0:b0:3f5:d436:5446 with SMTP id d5-20020a656205000000b003f5d4365446mr4703783pgv.532.1652981109886;
        Thu, 19 May 2022 10:25:09 -0700 (PDT)
Received: from zaphod.evilpiepirate.org (068-119-229-002.res.spectrum.com. [68.119.229.2])
        by smtp.gmail.com with ESMTPSA id y4-20020a655a04000000b003c6ab6ba06csm3859126pgs.79.2022.05.19.10.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:25:09 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: [PATCH v2 15/28] vsprintf: Refactor fourcc_string()
Date:   Thu, 19 May 2022 13:24:08 -0400
Message-Id: <20220519172421.162394-16-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220519172421.162394-1-kent.overstreet@gmail.com>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
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

 - We're attempting to consolidate printf_spec and format string
   handling in the top level vpr_buf(), this changes fourcc_string() to
   not take printf_spec

 - With the new printbuf helpers there's no need to use a separate stack
   allocated buffer, so this patch deletes it.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 lib/vsprintf.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index dd4bbb28e7..3d17ddad31 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1702,17 +1702,15 @@ void netdev_bits(struct printbuf *out, const void *addr,
 
 static noinline_for_stack
 void fourcc_string(struct printbuf *out, const u32 *fourcc,
-		   struct printf_spec spec, const char *fmt)
+		   const char *fmt)
 {
-	char output_buf[sizeof("0123 little-endian (0x01234567)")];
-	struct printbuf output = PRINTBUF_EXTERN(output_buf, sizeof(output_buf));
 	unsigned int i;
 	u32 val;
 
 	if (fmt[1] != 'c' || fmt[2] != 'c')
-		return error_string_spec(out, "(%p4?)", spec);
+		return error_string(out, "(%p4?)");
 
-	if (check_pointer_spec(out, fourcc, spec))
+	if (check_pointer(out, fourcc))
 		return;
 
 	val = *fourcc & ~BIT(31);
@@ -1721,18 +1719,17 @@ void fourcc_string(struct printbuf *out, const u32 *fourcc,
 		unsigned char c = val >> (i * 8);
 
 		/* Print non-control ASCII characters as-is, dot otherwise */
-		__pr_char(&output, isascii(c) && isprint(c) ? c : '.');
+		__pr_char(out, isascii(c) && isprint(c) ? c : '.');
 	}
 
-	pr_str(&output, *fourcc & BIT(31) ? " big-endian" : " little-endian");
+	pr_str(out, *fourcc & BIT(31) ? " big-endian" : " little-endian");
 
-	__pr_char(&output, ' ');
-	__pr_char(&output, '(');
-	special_hex_number(&output, *fourcc, sizeof(u32));
-	__pr_char(&output, ')');
-	printbuf_nul_terminate(&output);
+	__pr_char(out, ' ');
+	__pr_char(out, '(');
+	special_hex_number(out, *fourcc, sizeof(u32));
+	__pr_char(out, ')');
 
-	string_spec(out, output_buf, spec);
+	printbuf_nul_terminate(out);
 }
 
 static noinline_for_stack
@@ -2340,7 +2337,8 @@ void pointer(struct printbuf *out, const char *fmt,
 		netdev_bits(out, ptr, fmt);
 		return do_width_precision(out, prev_pos, spec);
 	case '4':
-		return fourcc_string(out, ptr, spec, fmt);
+		fourcc_string(out, ptr, fmt);
+		return do_width_precision(out, prev_pos, spec);
 	case 'a':
 		address_val(out, ptr, fmt);
 		return do_width_precision(out, prev_pos, spec);
-- 
2.36.0

