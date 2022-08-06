Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7942A58B6C7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 18:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbiHFQZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 12:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiHFQZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 12:25:30 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171BCF5B4
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 09:25:26 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id w10so5162339plq.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 09:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=UbGxgyfmTUw0NnY5/Pu/ELaJtqQmXlFiXmZPB/RD9VQ=;
        b=HkHVd3hlXKYP2R+Mk2Pd6mQCloOY1m4EmdMyhrH26cSEUUAiV2mnYf+zdC8MVUqkTP
         oxASsq1/rht3Ub3fKW+wJRv8oyY/QmeZ0DcOW6KR6SUv5FurMf8OdMr0sLjOXxMTzzXa
         r5HnPCO2dkvKZ0SV8yiZfMjZVLzBGgmKj7FJN7Su1wqcXggFr3kVsKTHL8Em03nVYOAf
         /rJadZIvC8REvQxEEeUTDFcqVMb2t1rPLdpFuWBhgiH8GkYrlcaSvspoQ2vyKNGgKTeY
         PmfrxKA6c6Lh0vENmq5pAud2L7vENuXpOglTWDlCIUEHGzSY/bow6AiP+pSs+6ZLagJ9
         lEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=UbGxgyfmTUw0NnY5/Pu/ELaJtqQmXlFiXmZPB/RD9VQ=;
        b=JBWrwYD+nAdA92pPXqZwmu4GDs22SY+PgPf/rVGtEKovOeA7ml+CndaOeiYggZcd7P
         h7m23P177Dn2H+FH2jinto4gMbgxmEacMJ+xQVYCkG0zTimyBbLYe3AksfN0wvbuCBtm
         qSIn1TndTWiRJpd/YsmChohPpd5SrKd4VF5B3+GIKsMY1BoIRrqXubs9zNgNlirnkSaB
         3+5186IooAm7qYG0YS0LV0vERB/bbsCYxHB4KplZfYZVn+jGmvNiKJpTvc1lcPJ241Ce
         WgeFkaHyY2et3AM90ExsKeX9TkgLx1RFqZiK84/RgCG/Vu6F0IHXIkeCmSMk5ncsYIR/
         YOSQ==
X-Gm-Message-State: ACgBeo2l22tf9VJl7IRmUBdhE5QO6+xPO3uHyh8Njpi5AEvxwj0ORHKt
        mZMQGk53/uOKixM/lGkEFrYxcbyI25DamA==
X-Google-Smtp-Source: AA6agR5yVyVKy+WlmRPtgWkf0lsgZfGXMX54t/jfTMb09y973IKoLoy5hBWIn0eoel118MLO+t+QMQ==
X-Received: by 2002:a17:902:be16:b0:170:8ebf:204c with SMTP id r22-20020a170902be1600b001708ebf204cmr3102308pls.47.1659803125608;
        Sat, 06 Aug 2022 09:25:25 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id s1-20020a17090a2f0100b001f04479017fsm4990927pjd.29.2022.08.06.09.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 09:25:25 -0700 (PDT)
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [PATCH RESEND V3 1/6] rslib: Fix incorrect documentation of rs_modnn()
Date:   Sun,  7 Aug 2022 00:25:05 +0800
Message-Id: <20220806162510.157196-2-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220806162510.157196-1-zhangboyang.id@gmail.com>
References: <20220806162510.157196-1-zhangboyang.id@gmail.com>
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

