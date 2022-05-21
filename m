Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6016152FCAF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 15:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354851AbiEUNPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 09:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354909AbiEUNO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 09:14:28 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8F8EBA8A
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:14:16 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id v10so9894433pgl.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GLuZhVjtGK5TbXwgi8Odrp2p8Tu7QkWjhdCCk7ovaas=;
        b=nmgM+6vuXjpX8KiwaDgzVgiYN2BD9hnKoi1p6MXLnRPMVGudkXgQk5rpmk2WEZeSfD
         TUU4GF4qa3c0hBliZhaoUoLCI3n5c/bqAS0RPC4swau3lhMzh+cE1IvOrbl6zy5r6MLX
         W2n+UbMqKQIZpgneQz4e6zjiLZu7FTYwfuekLnyGUc+SLYShDDHe04VjYSuiwqxuv8U5
         0PdvQsz/j42plRlSL7E6VxsATCEdO3cC0OcQ3eDyYhFlFA+QZROMVz0MIImXVQiwfamN
         OkACTC2CzmtHqvTadDkcfUy1nYLliiFahuyjCbV0lpLPOlZNHjrT3cTM7AsF3uCCGDGP
         /CxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GLuZhVjtGK5TbXwgi8Odrp2p8Tu7QkWjhdCCk7ovaas=;
        b=j6fx2aJ//sMlK+nfsPr9KsNnPYbOfpqGwwSQsIcdEtCg8vWBdJGUJC589FULAXB2Ic
         QmQ6ZgvurXL+8Wj/6XsJ/51BF7xOQb7e8FstdSuY3WSglfPGGDfKj8wMeYzJ5R7ZbcQf
         Qt4ef2LUs5cCLtPoZ3nxjodPJxs+eaJnAHnW2h3e03cFBpUPBRdpjdYIEJPGQZ+lXhDp
         lg5qYG8uUJzMopiTsdD0kgop6uBkz4C8rwQFszS/K05X2K3SVSWLfXyhU4GN+3Z4rCs5
         ohLBMj62GYTf+Y5dElYAB8NhZuph8yCBWVxPb/NACNnMc6gpS2uWwza+j0n0EWMRVNfx
         B+Gg==
X-Gm-Message-State: AOAM530JsASv0xCw9rFl8T7NNJ5cSz/INqQVnWonnxXKH21QnvEPafFA
        ZEIPUIE8MlkkH4CPQHtDK2yju/pWl3E=
X-Google-Smtp-Source: ABdhPJzSXnY7snJEhqn+uj+twSGinI9pDclYPisFikM4HmtEYq3hRdpqXVRiekvfzyKo1ySKSWhiog==
X-Received: by 2002:a05:6a00:21c6:b0:4fa:914c:2c2b with SMTP id t6-20020a056a0021c600b004fa914c2c2bmr14746058pfj.56.1653138854479;
        Sat, 21 May 2022 06:14:14 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id a31-20020a056a001d1f00b00517c84fd24asm3577253pfx.172.2022.05.21.06.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 06:14:13 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: [PATCH v3 11/13] openrisc/delay: Add include to fix symbol not declared warning
Date:   Sat, 21 May 2022 22:13:21 +0900
Message-Id: <20220521131323.631209-12-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220521131323.631209-1-shorne@gmail.com>
References: <20220521131323.631209-1-shorne@gmail.com>
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

Add asm/timex.h include for read_current_timer prototype.

Sparse reporting the following warning:

    arch/openrisc/lib/delay.c:23:5: warning: symbol 'read_current_timer' was not declared. Should it be static?

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/lib/delay.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/openrisc/lib/delay.c b/arch/openrisc/lib/delay.c
index 036ae57180ef..5e89e4131304 100644
--- a/arch/openrisc/lib/delay.c
+++ b/arch/openrisc/lib/delay.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/init.h>
+#include <linux/timex.h>
 #include <asm/param.h>
 #include <asm/delay.h>
 #include <asm/timex.h>
-- 
2.31.1

