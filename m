Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A225633C0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbiGAMyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiGAMyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:54:37 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AE33A720;
        Fri,  1 Jul 2022 05:54:36 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id ay10so315557qtb.1;
        Fri, 01 Jul 2022 05:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qf2IJbNq5eW3VuHqv6bkicUYgvnao7gcu8sVy6amOmo=;
        b=X85il7LjPAt9zWAB67Eobl/y7ZhG5q8tm61Ejq979W9cETHN0TRm3+Alwm3Kw0vLSX
         nAFJ3wePj05VbmPvuG5WFM+i/B+7YCsH3evgdCFdHIJvGd8EczuHQFfaTnAVv6+FXuDH
         KkuCHPgkpc6tmhlRaDSbxi5rD38YZRoG7Pvt8EdnjTGZE9ekzVhoHQPVtu0M9CffJcct
         1O45tqAScfM7PMu42n9eLHxrJtuar8toe32hlW1sKT88d+d08wNLYG07HtMoGZ3iGdmx
         frrYjvT6w8qBMkokOtKpsKGDF7pi1pkQgj1jEr6uTVY8JQyLhtSfM15gUnkX4HD2G7HM
         VvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qf2IJbNq5eW3VuHqv6bkicUYgvnao7gcu8sVy6amOmo=;
        b=bZwWFdcYVUp4mq0whrAWQNfTzvbigs6kw1AJnOwR9rxQF5KGMsLM631bIckk6UjHcU
         c4wMmH8Swr9SMKMpD5SMUMM1uMTGYItSrxT7Otr2Jyt8yNfhRunrl11E+vFetCEsx/fr
         7lU6dzO+Yfx7nx3qaeO/MV/IrgYxv6Gx1bs7CRf3K4f14AGm+5T35MDH9awIO2GIj9cn
         1BIuAonojMbirk3hHBVuRUAA8qm4PrBwxH9I97QmRGpCT34ZzHK1DImaWEFMJjJE6HAj
         2QrZBbLUNoGvD0/5GwUiatuzJDaVbXRd/+Lhi6ZL18dcTz8pcGV6Ksfd17P67B48Jnkh
         gcig==
X-Gm-Message-State: AJIora/Qt0LBgB7d5itNRONNjkzKABH/Uq2H0jKzya3qfp+BQGxdU9Ve
        evaCvv6IwOrB7PMXtmpsTyIGQCfwQIE=
X-Google-Smtp-Source: AGRyM1ttFUmBeYINzMtgxAB593d2CjAf/nUfjUgw68izLmGsHRH3ClZaKRtaiB2+ru8bhpuTqe4nrw==
X-Received: by 2002:a05:622a:58e:b0:317:c840:de91 with SMTP id c14-20020a05622a058e00b00317c840de91mr12491940qtb.245.1656680075497;
        Fri, 01 Jul 2022 05:54:35 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:f902:9816:653f:2f66])
        by smtp.gmail.com with ESMTPSA id t23-20020ac87397000000b0031beb4e060fsm7655979qtp.94.2022.07.01.05.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 05:54:35 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 1/8] arm: align find_bit declarations with generic kernel
Date:   Fri,  1 Jul 2022 05:54:23 -0700
Message-Id: <20220701125430.2907638-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220701125430.2907638-1-yury.norov@gmail.com>
References: <20220701125430.2907638-1-yury.norov@gmail.com>
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

ARM has their own implementation for find_bit functions, and function
declarations are different with those in generic headers. Fix it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/arm/include/asm/bitops.h | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.h
index 8e94fe7ab5eb..a83c1d9abbed 100644
--- a/arch/arm/include/asm/bitops.h
+++ b/arch/arm/include/asm/bitops.h
@@ -160,18 +160,22 @@ extern int _test_and_change_bit(int nr, volatile unsigned long * p);
 /*
  * Little endian assembly bitops.  nr = 0 -> byte 0 bit 0.
  */
-extern int _find_first_zero_bit_le(const unsigned long *p, unsigned size);
-extern int _find_next_zero_bit_le(const unsigned long *p, int size, int offset);
-extern int _find_first_bit_le(const unsigned long *p, unsigned size);
-extern int _find_next_bit_le(const unsigned long *p, int size, int offset);
+unsigned long  _find_first_zero_bit_le(const unsigned long *p, unsigned long size);
+unsigned long  _find_next_zero_bit_le(const unsigned long *p,
+					unsigned long size, unsigned long offset);
+unsigned long  _find_first_bit_le(const unsigned long *p, unsigned long size);
+unsigned long  _find_next_bit_le(const unsigned long *p,
+					unsigned long size, unsigned long offset);
 
 /*
  * Big endian assembly bitops.  nr = 0 -> byte 3 bit 0.
  */
-extern int _find_first_zero_bit_be(const unsigned long *p, unsigned size);
-extern int _find_next_zero_bit_be(const unsigned long *p, int size, int offset);
-extern int _find_first_bit_be(const unsigned long *p, unsigned size);
-extern int _find_next_bit_be(const unsigned long *p, int size, int offset);
+unsigned long _find_first_zero_bit_be(const unsigned long *p, unsigned long size);
+unsigned long _find_next_zero_bit_be(const unsigned long *p,
+					unsigned long size, unsigned long offset);
+unsigned long _find_first_bit_be(const unsigned long *p, unsigned long size);
+unsigned long _find_next_bit_be(const unsigned long *p,
+					unsigned long size, unsigned long offset);
 
 #ifndef CONFIG_SMP
 /*
-- 
2.34.1

