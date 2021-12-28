Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E67E4805A2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 03:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbhL1CGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 21:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbhL1CGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 21:06:37 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D67CC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 18:06:37 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id v25so14774821pge.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 18:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2cfldz1eeMJcpNwnXB66nvpkQHd9gmRZUm2/X7KhHco=;
        b=dOaXEjCW0EeZ7C5Lyqj17kzdTW7NWh+ij9PDKvN1cnYf9MeTMaPmKbAdDl4X0ZEMTg
         18qJtCe6DxVr3mXjoUjQ7WTG7Rplns/9i8A0YQYFICo0RNOiuYElL/LTU0luyquhorvc
         71uODdA2sXNQ1qz6shNdbZ+waM2wBOKTPjlN3tQMjWxOcAaMOtxa9LBLOcfToQ6HQU0N
         xX3doxS5pUsPyKI4wiqvz5639ODcZBSp2lNXNbcxw4yXuCRBGOJqII5GeNQN95wj1QhI
         fNyMxVo7pQnGnBn+iUrYsHjv1gRL/Ys1vs9H2+2rTgCdAXbWufnTXwh/GxLrdfKuqOA9
         PF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2cfldz1eeMJcpNwnXB66nvpkQHd9gmRZUm2/X7KhHco=;
        b=cliXN8rNprUFLYwht9GRfOw4GANjqvj7P60oqtXvx6IgX66rBqDDMlHNa6owpQHCpS
         nA5Y8q/bWT82dfBPgKdIly4SO7FDITpd6wLNC/p1ycOqLhwJNTSWMGyV+3oMyiSH+qzN
         Jhanp9R+aDWF+lg99uxqxwlQNuz8+CVlDEsmE6EhPw1az2TzvzeiLfXqbY/vEcJ+noLC
         r/qRKOHPsXcNQNNdWFcKrxbHJqqrzjzQv9PwhMpF2pe03hhJLXEMa98MFiPny+qBYB5C
         7fgLxN0bAMB9aqk7UQxBd6bPlkLI1fBK7Bp+vlZ+7Tlaj1WNbDCxGmT8HdalOaEr8apu
         5/ug==
X-Gm-Message-State: AOAM533jRxrwWKdXXCOk+b64DeluInQQy6Wml9qIWcwsD6Jnno6IBFWA
        yrYa3ryKOtvuwrAouFk0xH3r0jUrZKmzvmZvhx4=
X-Google-Smtp-Source: ABdhPJxJ/YcAEOPn6j5BjESYmFhn3S7yXlxT9QuPj9OSjW3wQcYIAUZRScV2vvx0NskAFdNMneNsMw==
X-Received: by 2002:a05:6a00:1582:b0:4ba:e636:391 with SMTP id u2-20020a056a00158200b004bae6360391mr20431121pfk.55.1640657196953;
        Mon, 27 Dec 2021 18:06:36 -0800 (PST)
Received: from slim.das-security.cn ([103.84.139.52])
        by smtp.gmail.com with ESMTPSA id w7sm19522978pfu.180.2021.12.27.18.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 18:06:36 -0800 (PST)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     geert@linux-m68k.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v2] m68k/kernel: array out of bound access in process_uboot_commandline
Date:   Tue, 28 Dec 2021 10:06:11 +0800
Message-Id: <20211228020611.6582-1-hbh25y@gmail.com>
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

