Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45D0516992
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 05:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357115AbiEBDXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 23:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352309AbiEBDXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 23:23:41 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8A632B;
        Sun,  1 May 2022 20:20:13 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so15064891pjb.5;
        Sun, 01 May 2022 20:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IePjmsv/wJb+ld44IWbALrDKn84ocVyOv7AyLW74QVM=;
        b=MslsXcZBG2Ebnlr9tTvufxRaYlBTsHexqrXWNDSpk3cQquHbeSpd6jMP+ZKXNWJZtD
         Gx2GrUAph/nqjClE8WNNBueryr+yg3+Q9NdZusbcvZSKmyinEMLnvCwVNqG3u4hxifRi
         7aA/oxJJf9e9MTtdwqrB/ZD+t4OjLxwlIOb+wapIlDfnoWlVLFfEgluFDr4vvh1y5zth
         xactzwlG1YxnnwnihWIsWZJmKdD/FbaEXsT+N6veOcVMfB/WElUyKDeQR2BnrpUCM1Yf
         glUQoT66t1jG8D3S9AboY8f1djrcUH8Ese8wL2RgzcA1y7o/geuQ7dutNH7HR+dlhwzJ
         TKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IePjmsv/wJb+ld44IWbALrDKn84ocVyOv7AyLW74QVM=;
        b=XOWRCAM6xNkXq1a1l+7YkStbdIMP9YiNL50e9jQ7dhIWMxcBYBUOmZDjdmVQjz8Lt7
         ME3gV1+5SMaGf6UORVuZDaenX3f/U9hG1Ablff8NwQ1SdlBuz2jOBFv8Bgh2xzibquJK
         istLP38rwNSjnVlscEhlOPB5XS9fph/qVGWP1zyVbar2O5b1N4KDR7AMvYiwBlIrynxJ
         xGQqHGY75Op5tLAgxcgZtj95B/ec7Y1ReAPkGR4txjux3IY9KTn8FpiXda67ts80Ye0Y
         YuUGWR4grRe2gByYIoD18pJ0PBxYllIfFgdnOJIuOMq0oqEyAYM1gJA3DIy1lciEDxMn
         DzBA==
X-Gm-Message-State: AOAM530tmupPDjiZKuWx8zMOxUI/ErUX9JNtzvbTT9vmaQRV+7AjMRLu
        vqe+p4ZV65+eeMbQ0vt9Q1Y=
X-Google-Smtp-Source: ABdhPJxEVZNbg++xtGxYC7vFyL8C5z1r9M//0XFPWYGl7jb9BmPnwTVysa5bRV8u5tMhTopwQPwSXw==
X-Received: by 2002:a17:90a:a593:b0:1c9:b837:e77d with SMTP id b19-20020a17090aa59300b001c9b837e77dmr10778341pjq.205.1651461612983;
        Sun, 01 May 2022 20:20:12 -0700 (PDT)
Received: from localhost.localdomain ([103.197.71.140])
        by smtp.gmail.com with ESMTPSA id i1-20020a17090332c100b0015e8d4eb1f4sm3507824plr.62.2022.05.01.20.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 20:20:12 -0700 (PDT)
From:   Stephen Zhang <starzhangzsd@gmail.com>
To:     macro@orcam.me.uk, tsbogend@alpha.franken.de,
        liam.howlett@oracle.com, geert@linux-m68k.org,
        ebiederm@xmission.com, dbueso@suse.de, alobakin@pm.me,
        f.fainelli@gmail.com, paul@crapouillou.net, linux@roeck-us.net,
        anemo@mba.ocn.ne.jp
Cc:     zhangshida@kylinos.cn, starzhangzsd@gmail.com,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v4] MIPS: adding a safety check for cpu_has_fpu
Date:   Mon,  2 May 2022 11:20:02 +0800
Message-Id: <20220502032002.840029-1-starzhangzsd@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Shida Zhang <zhangshida@kylinos.cn>

There is a chance 'cpu_has_fpu' would still be overridden when the
CONFIG_MIPS_FP_SUPPORT configuration option has been disabled. So
add a safety check for 'cpu_has_fpu'.

Suggested-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 Changelog in v1 -> v2:
 - Choose to redefine cpu_has_fpu to solve the problem silently.

 Changelog in v2 -> v3:
 - Choose to point out the error instead.

 Changelog in v3 -> v4:
 - Make the check work for 'nofpu' option.

 arch/mips/include/asm/cpu-features.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index de8cb2ccb781..c0983130a44c 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -133,6 +133,9 @@
 #  define raw_cpu_has_fpu	0
 # endif
 #else
+# if cpu_has_fpu
+#  error "Forcing `cpu_has_fpu' to non-zero is not supported"
+# endif
 # define raw_cpu_has_fpu	cpu_has_fpu
 #endif
 #ifndef cpu_has_32fpr
-- 
2.30.2

