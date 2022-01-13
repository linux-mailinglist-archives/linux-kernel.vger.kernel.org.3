Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0039E48D051
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 03:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiAMB7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 20:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiAMB7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 20:59:12 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB06DC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 17:59:11 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id t18so7302747plg.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 17:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2cfldz1eeMJcpNwnXB66nvpkQHd9gmRZUm2/X7KhHco=;
        b=Mcv5lolFdSbDXkT5MmOyiFVbSDEhQP6xFuTYgJIgjLIEP9dHEXmbNOvVyWwKNzTAYU
         +uDPFnAfMp2Dgbzev83JzwnbBhVGG3Uf1My4/U/mDEnnc0gkyb5TmtQMyUXR7kujOnEg
         wvssxHq/rXYplwqVtv6Of+djQJN/HpFhmz4gRHyRK1nHuEmxsgjiZ41g8Q81oaRh4Qmk
         3KEGA0pIEvGN34ODVnqwMUcYjQK1ljscU20CHhe9wuS7aetl/yNPIlATq5wsZO3Ddxm5
         PwauI67kFWdiFnzY4YVjlcZPVkEC0ixHTNIgez8JA9jpt6JV6XeoBQyPPEVq5EOab5sO
         Hr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2cfldz1eeMJcpNwnXB66nvpkQHd9gmRZUm2/X7KhHco=;
        b=u1DGGRWmhPqD8pz3ubZEqjCB7iD+53+8X7q3qWV+ytpVbpNkcibxPdVYShSF69JxLM
         TR+XZhySljuYIsBd05Sn/+MDp/6xWZz6GQ6nLEk00Dtle0e6vc/ruF2fu2qDtqmd/Gv7
         VbEkub5NFtDjibjyvCi4NPobkp/byRqYHw6n8t1N2IWiRbUxPcCG0aUKi7e1oNKvb/Hr
         90G7aO5EtbrDCp9YN8GOXMzojVJa/YU6sVUqmNIi6IRitez7StT+m3CXkW5iNySyJhFt
         0QzOLXklYtMU64lqUOtJDM8IXwmMY0b2LhKFr6OHznTPWyjXd0Nu4dgihsqUt6rCh0EA
         Iuuw==
X-Gm-Message-State: AOAM530RQjSrLZkFY9CLrVieHGtBwZXh/aiqAGiS9KJ4Eqxf++YWPqhY
        LOkETbEngoCrfHa3ivQcwKIWhH4yEtWumJcw
X-Google-Smtp-Source: ABdhPJw0+d7mdGrxuYxATKHc66u8ysbhM4k83yTUQVUKqthfB24t3zzJ+IP08lUeBIrx/D5cWtktJQ==
X-Received: by 2002:a65:6a0f:: with SMTP id m15mr2094339pgu.391.1642039151314;
        Wed, 12 Jan 2022 17:59:11 -0800 (PST)
Received: from slim.das-security.cn ([103.84.139.54])
        by smtp.gmail.com with ESMTPSA id b9sm753326pgb.17.2022.01.12.17.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 17:59:11 -0800 (PST)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     geert@linux-m68k.org
Cc:     schwab@linux-m68k.org, gerg@linux-m68k.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v2 RESEND] m68k/kernel: array out of bound access in process_uboot_commandline
Date:   Thu, 13 Jan 2022 09:58:54 +0800
Message-Id: <20220113015854.9326-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the size of commandp >= size, array out of bound write occurs because
len == 0.

Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 arch/m68k/kernel/uboot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/kernel/uboot.c b/arch/m68k/kernel/uboot.c
index 928dbd33fc4a..63eaf3c3ddcd 100644
--- a/arch/m68k/kernel/uboot.c
+++ b/arch/m68k/kernel/uboot.c
@@ -101,5 +101,6 @@ __init void process_uboot_commandline(char *commandp, int size)
 	}
 
 	parse_uboot_commandline(commandp, len);
-	commandp[len - 1] = 0;
+	if (len > 0)
+		commandp[len - 1] = 0;
 }
-- 
2.25.1

