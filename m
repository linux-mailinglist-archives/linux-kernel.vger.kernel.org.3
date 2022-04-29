Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271FA514104
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 05:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbiD2D3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 23:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235621AbiD2D3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 23:29:50 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCEE2B1BB;
        Thu, 28 Apr 2022 20:26:32 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id j8so6013568pll.11;
        Thu, 28 Apr 2022 20:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V0DksDX7L8d9ICYzpzWT3BjK+82KTj0h2xAmsixo6B4=;
        b=hs6rJ0prHWduho+W6SDhLDRzzl2by6AnSQ9UKFQkQAT7IY0ykKyYUs+mIyVMnb8Ehf
         LvCbL55Ylx6uwJVnFE9Tg5tKHzdLVpNn0bISNyukRfH/XD+5Tu40BRRwt2bXGsQ0x/yN
         I3hiHlVjqXfWh32dj7cQhNXciuOVgD3J3ZDqgQNDXh0EwGtR7iCzd+Agdn6sT3gWEnr+
         IwZTACpIsRmmvhKJNH6O1RBaF+KzIPx7Ld7XvFFp6vPy6ebudDjEyV00spJCeq3g7/kH
         FuIXuky/v45NZOgKdaTYO64ZYcDcVyTyzSgvpdivbLmwGzCBJ/tzxPdMNBvLU6N4MRj+
         Cf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V0DksDX7L8d9ICYzpzWT3BjK+82KTj0h2xAmsixo6B4=;
        b=Tmjj/ITogMMurCdAdKGZINtZMShx76Jl+DGpXkniNlg2REzDpi3hpQBeKGqunbOvkM
         DxxWEjJw4xXC4nYKH2/0nAUZ5yV221ov4Cq7Vd0G1BOPzy9RHI1kQ3pgubZaNnQl95ag
         XMptq9HOn+urDtqYg/xmu8moUD2Drmn/lE7FXX+C/mPn8ppWTFUuxr+YqR3NdDtTeCNo
         tKbeV1yniO7QxjcYIBTWx4AwnvKPuO06i8uOO6cHEDjsdXmcQsUqi1OeLZMlvgf5RpLt
         9x4xMl7FxfAgyf+9pi0TzLQQyzEZ88zjqItdSAmNUe01fnepVxXAJUaHSsvtP7tH0Qt5
         gfSA==
X-Gm-Message-State: AOAM533MNrmFBO4TKW5iRkg7iNMzbYx6OvZBVX9p/MTk+1dM9BQ+1C31
        lRl6DF4yTNumnhWsfpP99bQ=
X-Google-Smtp-Source: ABdhPJwm940q3HfQuVXxneIRqd106dvVhfUMZfSb9vuTfNMUl/pjgn0BgFdQgO3dPZkoTqzc3Oo2lw==
X-Received: by 2002:a17:90a:a509:b0:1ca:c48e:a795 with SMTP id a9-20020a17090aa50900b001cac48ea795mr1597345pjq.165.1651202791934;
        Thu, 28 Apr 2022 20:26:31 -0700 (PDT)
Received: from localhost.localdomain ([103.197.71.140])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090a3fc700b001d0ec9c93fesm8212104pjm.12.2022.04.28.20.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 20:26:31 -0700 (PDT)
From:   Stephen Zhang <starzhangzsd@gmail.com>
To:     tsbogend@alpha.franken.de, liam.howlett@oracle.com,
        ebiederm@xmission.com, dbueso@suse.de, alobakin@pm.me,
        f.fainelli@gmail.com, paul@crapouillou.net, linux@roeck-us.net,
        anemo@mba.ocn.ne.jp
Cc:     zhangshida@kylinos.cn, starzhangzsd@gmail.com,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        "Maciej W . Rozycki" <macro@orcam.me.uk>
Subject: [PATCH v2] MIPS: undefine and redefine cpu_has_fpu when it is overrided
Date:   Fri, 29 Apr 2022 11:26:21 +0800
Message-Id: <20220429032621.674865-1-starzhangzsd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shida Zhang <zhangshida@kylinos.cn>

Undefine and redefine cpu_has_fpu to 0 when it is overridden with
the "nofpu" option.

Suggested-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 Changelog in v1 -> v2:
 - Choose to redefine cpu_has_fpu to solve the problem.

 arch/mips/include/asm/cpu-features.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index de8cb2ccb781..38eb469008b6 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -134,6 +134,10 @@
 # endif
 #else
 # define raw_cpu_has_fpu	cpu_has_fpu
+# ifndef CONFIG_MIPS_FP_SUPPORT
+#  undef cpu_has_fpu
+#  define cpu_has_fpu		0
+# endif
 #endif
 #ifndef cpu_has_32fpr
 #define cpu_has_32fpr		__isa_ge_or_opt(1, MIPS_CPU_32FPR)
-- 
2.30.2

