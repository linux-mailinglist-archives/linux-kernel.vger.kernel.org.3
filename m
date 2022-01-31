Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514574A5067
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350846AbiAaUoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240076AbiAaUoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:44:00 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2356C06173D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:43:59 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id v74so13923063pfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dvY93mLK+gCkLFyqPjkC7SO502H46e/BmHAFAde7pmA=;
        b=VnaPaLUE79ByM8yxlggAAFwqCLbFIwHYSnwowqWnqMYsC3OgGiS1ToIUXd8N7wK5WS
         dIFaCM5pOMfQ1J/hUl7v9c5JoiyS6MZaxuMQw2gMtg7ucEwuKSG9xdMypFTCXm3IDQoA
         7CeWl1HJ3RfJ+RvxNluYPe/tjQw4aj7Gfleog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dvY93mLK+gCkLFyqPjkC7SO502H46e/BmHAFAde7pmA=;
        b=QBBLOw+h+rMjmxpfhuIqWetMxNnJPEJutDC7vrklxqlnmfts7mNz9SdCOws/Bo2SwB
         I+Kp3hTbp9NloXSjwjUq3H+VlTX8JBwJioEcSqhz7Wl2/aMQXvF+7GbiCDf9MpZ/RqoK
         zjC5CdPaan//TCHwhPZI3W+Ve19dVW/9vEoLSTDmBFEhiL7KMbqBzNIumCCG/Vn5tS6r
         E8LUPwJ1UIbFmXQihVJ+qlLCNIpvdKH64ioWiQNFsN37KewctsEMpvxR/PLksIuQe86P
         iyJfWb2zvDZAY/5O19WlttitKmde1qddV5JqhtALnqHtWgjX8xGA69t0HbEKhIpJhZzh
         1HJQ==
X-Gm-Message-State: AOAM532lgtkIRy2oukmXap39WbJiU5B0XK1F9ITyUz8p9FMx2k3ZZVRk
        fUCYL41qg/T7gohjdKGqtZONow==
X-Google-Smtp-Source: ABdhPJyMZ/cWvABsZIf40YJbzvSbf2yYk+yDlKZi9uzmJOn1juWqB1Qh+dV/l9giNKX/hZOoOf0/PA==
X-Received: by 2002:a63:9346:: with SMTP id w6mr18350241pgm.65.1643661839508;
        Mon, 31 Jan 2022 12:43:59 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h18sm19549618pfh.51.2022.01.31.12.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 12:43:59 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
        Ingo Molnar <mingo@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] linux/const.h: Explain how __is_constexpr() works
Date:   Mon, 31 Jan 2022 12:43:57 -0800
Message-Id: <20220131204357.1133674-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2675; h=from:subject; bh=WlNK1x9BZiL8PdVBf+UDla5QbcDoyx4RBmBre4o9x84=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh+EoMr8eEAxIe/o1NGdfWCDk8aFcQzwQVoNeu5FZ/ ZAhP5D+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYfhKDAAKCRCJcvTf3G3AJtgoD/ sGCz9a8AssZAQB5fVsmWfX5b+plDMlTy+hmWrQ1KL04znEA2Ju1fh43Iv1MvyfWYxO06Oxl5ZFfMvs F9K+sfSnb5IE91FXjDx+mBjQ57kzHI9anob0KWKPxmIeCXfr1RFTTbLepyF7vQU83jlttFMvPGjiLV 1Okkt9dxBFoFXstRu9x/nx5v/El7bDRdrsk/nka+ZvuAFiqJQXL9RLAkuSgV+2l/P60RLOB3g6SFLs Nbf3EFlIUcN76X+QfhqcYHeohmywr0hCJtX8kvwhEpb0QSUocOPVXjZf6qDCI5HWDr/fNGtfHn1yEd RiQei0uJLVmH1EKHt2ZcahLv4LQyQq/cFG1u6VUnRJXVJRBL89zdqW8iiYirdHTmJ2wg4Ay8SJo69E 7tZpQ9HfQS9QwbIMeQwGYA8sHB90DoJgFehqMxnwoXDFJRCKSmIOzesglOo9B+4yqFJw3UnTeSldre rLSGF217GOQfzzcXXMgGRIeyxYRwwzqTyMGM5+U8SAlcswtDbakvP7aT9bctGV1LfUUUpI6RlicNK0 uOk07acYE93Cu2a5NUMH5GJhA8xb7SxT4Asp7IQZgzlTtBjcv2DYx4rMI/0VpbA4/Xa5b/gwaSWFgD DnHzo+Vxqd8CcB7ztHxX+Za2OqabUhA50217kdRVCT8PRtH0ZO+ZrdKqKHhw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __is_constexpr() macro is dark magic. Shed some light on it with
a comment to explain how and why it works.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Jon, since this is pure comment, do you want to take it through the docs tree?
---
 include/linux/const.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/const.h b/include/linux/const.h
index 435ddd72d2c4..7122d6a1f8ce 100644
--- a/include/linux/const.h
+++ b/include/linux/const.h
@@ -7,6 +7,30 @@
  * This returns a constant expression while determining if an argument is
  * a constant expression, most importantly without evaluating the argument.
  * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
+ *
+ * Details:
+ * - sizeof() is an integer constant expression, and does not evaluate the
+ *   value of its operand; it only examines the type of its operand.
+ * - The results of comparing two integer constant expressions is also
+ *   an integer constant expression.
+ * - The use of literal "8" is to avoid warnings about unaligned pointers;
+ *   these could otherwise just be "1"s.
+ * - (long)(x) is used to avoid warnings about 64-bit types on 32-bit
+ *   architectures.
+ * - The C standard defines an "integer constant expression" as different
+ *   from a "null pointer constant" (an integer constant 0 pointer).
+ * - The conditional operator ("... ? ... : ...") returns the type of the
+ *   operand that isn't a null pointer constant. This behavior is the
+ *   central mechanism of the macro.
+ * - If (x) is an integer constant expression, then the "* 0l" resolves it
+ *   into a null pointer constant, which forces the conditional operator
+ *   to return the type of the last operand: "(int *)".
+ * - If (x) is not an integer constant expression, then the type of the
+ *   conditional operator is from the first operand: "(void *)".
+ * - sizeof(int) == 4 and sizeof(void) == 1.
+ * - The ultimate comparison to "sizeof(int)" chooses between either:
+ *     sizeof(*((int *) (8)) == sizeof(int)   (x was a constant expression)
+ *     sizeof(*((void *)(8)) == sizeof(void)  (x was not a constant expression)
  */
 #define __is_constexpr(x) \
 	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
-- 
2.30.2

