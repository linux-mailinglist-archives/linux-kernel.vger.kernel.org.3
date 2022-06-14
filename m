Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35D654BC8D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbiFNVJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241295AbiFNVJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:09:11 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6E24B1D9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:09:09 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j5-20020a05600c1c0500b0039c5dbbfa48so71025wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dnaIqBDbCyzz5sazrfv/hnRno7qZfKznnneM3yQMjCM=;
        b=MwWXD1NNdJsijjlQJJW+hNC4fPHeDS8AEPvHcuz/8lHZsA9tkqL4Pr6WtJGAPMUaZC
         KFMTrUCG7jpUAOdVA8ONDaHYlx7fC+pQqrycdkojypvNFyInjRvrZZi+tG2UkCaIvxU3
         159lKe7u++XEplrQY2rbKa9FRbwnbK8U7btZqPJKU8vJ68LXdiL+xpoVkMBf20nDaJZm
         UHJonySUtkt5LxWzc+pIvKHrqQEk+BYXmbke0Tp0AW3n3euPFa3WaF/WRf9QmgEBzS62
         Xq39bEq9yovUJ5IiS0eOUR7D8Z0qEq7CssoGnAHVGsFTWsn/Rp6g9Sh6piHg/nEKVehX
         PeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dnaIqBDbCyzz5sazrfv/hnRno7qZfKznnneM3yQMjCM=;
        b=CC2ewCmIt6lQeR4TngoDJwYYCriHwLYx9IEDHFAtPohU7IkcrAzv5T8CDZ7dhr/Zer
         ljDhgdGGagLy+M1DpbdpRqJA37vggYWoymFjIOD9BjA/DuhICMqsO61LJJo73ib7GjSY
         s4ZG4D98YpTYuY4VO42Q32kvKz+Yx3FgxUAFTFEoh2KuoZPtgQXHdNlWxogggL+e1j5T
         XLAt42psy10Qwnd9ka9PJLeapLwLzxzK8BcD0HgijajNi9ypcnE3xH0FXKvs1sMp9n60
         mWquuekQgkZEA/KoglLDJ92lLbZFUk1ReLYxLHNzZu7LejNQg9ci3mXJu6sH48FfMmo1
         DefQ==
X-Gm-Message-State: AOAM53084adDMN624qQLA4dwvPpIf0W+Dsm+HAruItJNQ0sw0pPZ9q5l
        iMBq9SJEM0oKWHXv4diwt9E=
X-Google-Smtp-Source: ABdhPJxDEqxbYgDFnbrpmUxjhMd1J8pScMFMyx/vcs+fF91/xTqFxD+utNYUUXhFZ56En6vyc+3cog==
X-Received: by 2002:a7b:cc13:0:b0:38e:67e3:db47 with SMTP id f19-20020a7bcc13000000b0038e67e3db47mr6112096wmh.133.1655240947652;
        Tue, 14 Jun 2022 14:09:07 -0700 (PDT)
Received: from laptop.. (82-64-133-20.subs.proxad.net. [82.64.133.20])
        by smtp.gmail.com with ESMTPSA id bt15-20020a056000080f00b002183cedbf34sm3546649wrb.73.2022.06.14.14.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:09:06 -0700 (PDT)
From:   Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
Cc:     Erwan Velu <e.velu@criteo.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] nvme: Ensure char members of struct nvme_id_ctrl are null-terminated
Date:   Tue, 14 Jun 2022 23:09:01 +0200
Message-Id: <20220614210902.744318-1-e.velu@criteo.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When issueing an identify command, the resulting data structure stored
as a nvme_id_ctrl struct, contains a couple of char members.

These char members features:
- the serial number (sn)
- the model number (mn)
- the firmware revision (fr)

As per the current code, nothing enforce these members to be
null-terminated which causes issues when manipulating them with regular
string manupulation functions.

This commit ensure the three of them are always null-terminated.

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 drivers/nvme/host/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 24165daee3c8..0f7e625e8bd0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1274,6 +1274,13 @@ static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 			sizeof(struct nvme_id_ctrl));
 	if (error)
 		kfree(*id);
+	else {
+		/* Ensure that model, serial and firmware fields are always null-terminated */
+		(*id)->mn[sizeof((*id)->mn)-1] = 0;
+		(*id)->sn[sizeof((*id)->sn)-1] = 0;
+		(*id)->fr[sizeof((*id)->fr)-1] = 0;
+	}
+
 	return error;
 }
 
-- 
2.35.3

