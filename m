Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF0153B3CA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiFBGn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiFBGn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:43:56 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44E523097D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:43:54 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id s12so3798821plp.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 23:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K0u2KzWIytiSdD6ML4+0XkSmtReBuX0G+WX+GXHkpOc=;
        b=HgUIr+HVYFkuGn0ibT/PnpwWdlgFPSeqEdnoqRU+1dnXkR8f1/qjNE6K3j1hSzk8sb
         sisQ6hJN5ETEk4rqOgLRsRpYuqjbBYlcz7XVrwQqVr2Y6RyIEYbMohKaNqK55UWyLioZ
         ptn53MFc8x0t3aGh8pBZBK5WrRJww7alakE+3ut5tia9tozxRtw82IHC18A8eirrfPuf
         m9dNQ/XMdH67Mvpv9djgbC8yN+x1Y3dy87E+ooZYkldely+huMpQqJk7mZMw+OZH0ZkD
         vLwiSJ4+kBh/3LFS1JxEec3C77xnOqYOAHc53+tPzk1QKdSbDGt0bOIOLnYjKHH8/N/r
         N7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K0u2KzWIytiSdD6ML4+0XkSmtReBuX0G+WX+GXHkpOc=;
        b=4nMMImQX6Y5iFgi8nx94zd2Zugoc0HYubXTJvfQ+M/AwrqTZeseywo30JSI8dBbhvv
         +ZSUTWhRh3zJj60lDE/0zh7x66pGVXzF7uMwpvmNiqYt69NC4jd6AG9EhQbiDC15zKAH
         dA+8CFOakAuRZ1+X22aSqO9zwsrb7jG+dpgI+/3Me9QYBoRhsTc6Cua4smSnJAiQVXqC
         fqBeiKutwdJRz+hee/59MEP4CKQXMk4+NIO8YcezXouCJGlZyNArYdjXk7qF5bihtfep
         gjHoXpykIC5sOW+xm1NEQli7TSiL/Oo+55GzU4tZGVoe8kOn1IDpCMyIKRbfKx3qddb5
         jKVA==
X-Gm-Message-State: AOAM531/xfpbhoSf4OH+4innHIPKm4Xn/q7Z6TcQncPIapuoqItg+/EL
        Ebnh5F9pJcC2CdUcMve08kMHDObyT1A=
X-Google-Smtp-Source: ABdhPJye4BWKiVLC5/3qtKdHyka1IflFCPHnCyFYi+fqZ0FxaVzdYp7koGLHYATlbmN0NeMkSMiT2w==
X-Received: by 2002:a17:902:f60e:b0:158:5c4d:d9b0 with SMTP id n14-20020a170902f60e00b001585c4dd9b0mr3372413plg.63.1654152233693;
        Wed, 01 Jun 2022 23:43:53 -0700 (PDT)
Received: from Vostro-5471.. ([2001:288:7001:2708:cee8:633a:13db:6557])
        by smtp.gmail.com with ESMTPSA id 184-20020a6302c1000000b003fcf1279c84sm268063pgc.33.2022.06.01.23.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 23:43:53 -0700 (PDT)
From:   Jui-Tse Huang <juitse.huang@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jui-Tse Huang <juitse.huang@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Bruno Randolf <br1@einfach.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>
Subject: [PATCH v3] average: Clarify the restrictions
Date:   Thu,  2 Jun 2022 14:43:07 +0800
Message-Id: <20220602064307.18049-1-juitse.huang@gmail.com>
X-Mailer: git-send-email 2.34.1
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

There is several restrictions in the EWMA helper macro that the
developers should take care of, but the comment does not mentioned yet,
thus, this patch clarify the restrictions.

Signed-off-by: Jui-Tse Huang <juitse.huang@gmail.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---

Notes:
    v3: fix typo (Randy Dunlap)
    v2: fix spelling and wording (Bruno Randolf)

 include/linux/average.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/average.h b/include/linux/average.h
index a1a8f09631ce..9c3c8b5b518e 100644
--- a/include/linux/average.h
+++ b/include/linux/average.h
@@ -11,7 +11,10 @@
  *
  * This implements a fixed-precision EWMA algorithm, with both the
  * precision and fall-off coefficient determined at compile-time
- * and built into the generated helper funtions.
+ * and built into the generated helper functions.
+ *
+ * This implementation supports up to 30 bits of precision, and only
+ * the API for fetching non-fractional part is provided for now.
  *
  * The first argument to the macro is the name that will be used
  * for the struct and helper functions.
-- 
2.34.1

