Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2750529649
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243400AbiEQA4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241833AbiEQA4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:56:05 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640C11FCFD
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:56:03 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gg20so5946577pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GLuZhVjtGK5TbXwgi8Odrp2p8Tu7QkWjhdCCk7ovaas=;
        b=OsySeMMZGq6yomS1KDnoTl6b0LIngdBZ3Omh+Vc/fSzyz+imuzyNrjQmUZczLIhegX
         +NV8Gfo9Tput/QUY1MVOp/wmL3M55pSmBtD57O8/1JpQp8rGPdCzSmzBC8eK5opvxFJm
         YnVEuPcnGO9XlQLIge0UeJilt0t25njUQsNYGrybJ/XImbGbZ4O1Yq460hiZQpdk1gs7
         Dg1LZ6ZjFxW3MBu/o51RGLacoJcuoZvqs22cA2+nNAoFmpwfLm1tPRiYd/P2qSL4DGm5
         MwiIpVEpFohND8ZtgZzd0aJ9oq+EKG7OfDkUAcNtTOnbR3Rpu01HowmUYrrc7HGmdsWs
         Q57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GLuZhVjtGK5TbXwgi8Odrp2p8Tu7QkWjhdCCk7ovaas=;
        b=es1BHpeLLA3ULBfWoupq00+6ptaJyShtZOhUU6UEQ4MLp05XNhDQiXCBz/nKZ87ndB
         QowNXpQj02rlQOipN6gQth2iKV+JUEIEHlcjiH/ufNpjmjOqpPNvQmcGZiDlj4saI5Nl
         wsvIK7xMBMSk4OxqK0kAjEx6kekrvPMOHEhmqBeuWz3uCQPilpo1wSQCr16e8HYswBsF
         quLzHHuXoNeGeYszcDuqJmAMFcANkQm3jkzveuQNKMZwgvmLM0+a9oWNCUJ5RdUmwsp8
         daQXpHvXnkA5hRhPNvPIcNz6mZhEXqSQpjPV4t33TJ+4em+7G3zc8s+k6cs8tirTtt/x
         AxUw==
X-Gm-Message-State: AOAM532BUq9WP4eX99m4jEKwcqdEmhq4OqJZZisT+AFap5bwg1U6xoUX
        TlD6617u9UpVzcr6RdRlzrIepLuYmcr7MA==
X-Google-Smtp-Source: ABdhPJyRflxVHHKzD7PI9Xa4kr/OcWekhtakidWl3XVIQlsItD1qwG0ktFMPtDJCote4gDFgvalZqQ==
X-Received: by 2002:a17:902:7892:b0:161:61de:eaeb with SMTP id q18-20020a170902789200b0016161deeaebmr10850706pll.132.1652748962201;
        Mon, 16 May 2022 17:56:02 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id t19-20020a62d153000000b0050dc762815dsm7425197pfl.55.2022.05.16.17.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 17:56:01 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: [PATCH v2 11/13] openrisc/delay: Add include to fix symbol not declared warning
Date:   Tue, 17 May 2022 09:55:08 +0900
Message-Id: <20220517005510.3500105-12-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220517005510.3500105-1-shorne@gmail.com>
References: <20220517005510.3500105-1-shorne@gmail.com>
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

