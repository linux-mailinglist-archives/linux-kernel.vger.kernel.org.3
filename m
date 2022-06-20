Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C91551031
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237755AbiFTGUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238623AbiFTGUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:20:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1770BE35
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 23:20:42 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so9321413pjz.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 23:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UbGxgyfmTUw0NnY5/Pu/ELaJtqQmXlFiXmZPB/RD9VQ=;
        b=BCKyHJKgJVC1YpEUicCh20DA21la9tgGHs7csj+SNh0FG56qi7jLZUaL3pFpprq6Z3
         bnQKbNYkEB7UG4kVXBfOkZUPEEda7pEA+ilcNi+40nrIUh1kfc+1L1XuMn3xoRwh0ldO
         mnA8YMLNGISombnZw4j9SSfmmsvBQElkAhn3vG8SLvUcmtrGpqBNowDi38CbD+DMk+iT
         Xree/joIIdceqgair8UYmQhPT8PgRYaqtPPoJvc/HukhY5/6TCFUuWT66fjapCZa6OjM
         XWsJAbGYv6F0/8FgbuzF0Eu2JUQVtfTqrlAGEd0ReQs81GFALv9ZxbB/sIfljpzgZHWi
         uMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UbGxgyfmTUw0NnY5/Pu/ELaJtqQmXlFiXmZPB/RD9VQ=;
        b=tCsQUZaxGiMeUK9I+Iy3hbWCGUNPLGDP2cz1ybSmDzgGP+Dgfb1IyDKRUJ/odNoQsg
         UGkAQQsr3i0Odjf1Z/KSuguw6xtLJ7sf9u8ZN8BzL2PVjEDt1hvYn9hzvHqIQ+qysc9J
         0Xc1AQm0b5yQglv/a1b9930cT9rdgNxQFGEylk+9Q88KyXZjH4udGF+GfhXeRjE13AfI
         5+mrkNI5WyMD12nXCbzsXmwxgYOu7+I+AO5NGQ1NfYz+/TIPSAzjXd3/Qj60/aAJKAQK
         UfZ5CxsVgufI/Sn2M6EWBugumfLbEsiL7l0GqVCF6LA4xGOlh29u1nIvS6Us1DzFD4yj
         T+PA==
X-Gm-Message-State: AJIora+N0pX2rBDCBBsArOcKPoCY+ujIa56efjg3SHJx1ZZNcy/NC1Qq
        L+Z0oLsBmznljf3ZEBg/fRYvYh0s0RM=
X-Google-Smtp-Source: AGRyM1u86HO7R76wzYwPXfjTHJphHnY93jRL+hnnaKmflAfyB2/6f+Ki6OjXtWaTt4NXmtjHu6hf7w==
X-Received: by 2002:a17:902:ccca:b0:168:a88f:4833 with SMTP id z10-20020a170902ccca00b00168a88f4833mr21979897ple.104.1655706042169;
        Sun, 19 Jun 2022 23:20:42 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id p13-20020a63950d000000b003fd9e4911f9sm8010469pgd.31.2022.06.19.23.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 23:20:41 -0700 (PDT)
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [PATCH v3 1/6] rslib: Fix incorrect documentation of rs_modnn()
Date:   Mon, 20 Jun 2022 14:20:10 +0800
Message-Id: <20220620062015.15612-2-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220620062015.15612-1-zhangboyang.id@gmail.com>
References: <20220620062015.15612-1-zhangboyang.id@gmail.com>
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

Previous documentation of rs_modnn() states simple arithmetic modulo
return a wrong result for values >= (3 * rs->nn). However, that is not
true. The rs_modnn() does the exactly same job as (x % rs->nn). This can
be proved from following loop invariants:

  while (x >= rs->nn) {
    x -= rs->nn; // (1)
    x = (x >> rs->mm) + (x & rs->nn); // (2)
  }

Let x0 denote the value of x before assignment. At (1), it is obvious
that x % nn == x0 % nn. At (2), because nn == ((1 << mm) - 1), we have

  x0 % nn == x0 % nn
  x0 % nn == (((x0 >> mm) << mm) + (x0 & nn)) % nn
  x0 % nn == ((x0 >> mm) * (nn + 1) + (x0 & nn)) % nn
  x0 % nn == ((x0 >> mm) * ((nn + 1) % nn) + (x0 & nn)) % nn
  x0 % nn == ((x0 >> mm) * 1 + (x0 & nn)) % nn   // let's assume nn > 1
  x0 % nn == ((x0 >> mm) + (x0 & nn)) % nn
  x0 % nn == x % nn

When the loop exits, it is obvious that 0 <= x < nn, so the return value
must equal to (x % rs->nn).

Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>
---
 include/linux/rslib.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/rslib.h b/include/linux/rslib.h
index 238bb85243d3..507fa14c03b2 100644
--- a/include/linux/rslib.h
+++ b/include/linux/rslib.h
@@ -116,8 +116,7 @@ void free_rs(struct rs_control *rs);
  *  rs->mm = number of bits per symbol
  *  rs->nn = (2^rs->mm) - 1
  *
- *  Simple arithmetic modulo would return a wrong result for values
- *  >= 3 * rs->nn
+ *  Calculate (x % rs->nn), without using a div instruction
 */
 static inline int rs_modnn(struct rs_codec *rs, int x)
 {
-- 
2.30.2

