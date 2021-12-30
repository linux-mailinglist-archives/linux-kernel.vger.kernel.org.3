Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8C8481D05
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 15:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240014AbhL3O04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 09:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239988AbhL3O0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 09:26:54 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0D2C061574;
        Thu, 30 Dec 2021 06:26:54 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id h7so10222170lfu.4;
        Thu, 30 Dec 2021 06:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+tf4nBFZgti+nl0o1bJRk3qvXgnYx/HTJhgteUE1QXw=;
        b=gH9FQ3nysBpaf6G5Z0BPfhrqQtpn+qTmTd9UB7DUm+POlRm9S/SWcJhtT6sWg8x5VG
         5wF/wNm7rAkcswm9tYQ+CR7jZhIoTCyvDYLB7k3A7y1VmhocDh4hpQHOMgOns1Zs2jEp
         a8xCGzZH9LvUYy31L0ngkPTIni39sm99s1tDL2lPqEJYEMz/R72swz7s82+NAfYC3Y2n
         ZwN8MwlCkUqzY6M3n5PPQRrVfnVFwAL180ELTGvhAOdIpyXLvNDrhQN8zc6co8nNtpIC
         3HzPMQFQk6TgJ+rS48DAfXKP2meFfw6HhUdjPeaS2dPj9EChx7KhfBUwex5IrnrVLfyx
         UFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+tf4nBFZgti+nl0o1bJRk3qvXgnYx/HTJhgteUE1QXw=;
        b=yYBJ9nwuCtOI3D27mvCuXbVH49RTT21amLxGzKi0JprPsoZ+aSB8pDbGr4ZOhC7Zad
         xHxjOLNyl8YrnoEqfZ7j/4he1kc51mxIKvrzog8kUumNj8x4LqYH4hmZ2LLpulwMynoq
         6omXtDqUETRjD42Dj7QAx+vh9Mh9VAsq2ltoub3I66Xw9KQwOcAdbla8RQJdUwsNzS0m
         /PhJCXbafDQ2TE3O9ofsLCqb38glL7q0HK2URq4AGyfzllc27y2xIlURwDlDzIXwN+aK
         aZhEr3wsOdPs+mrP7EqklQDSZ5VyEnj1ceyJqwqwQqPTN85t4gprXSEIbiwkuMJVTnw1
         8RMQ==
X-Gm-Message-State: AOAM530XCBXzGtFvHrrVcuocxLm/VA58+7q4bPRcqU5e6qyigYrpuMrT
        Y1p52dqHvnS2VNRDe/+KagQ=
X-Google-Smtp-Source: ABdhPJxxcwPDUWvaddgiXQGl/eGIsXz0jw20BcLQgPCKVg4rWRtMVdGV8LZ3Vvbkd2/qzkOSH5LouA==
X-Received: by 2002:ac2:52a3:: with SMTP id r3mr28192890lfm.580.1640874412548;
        Thu, 30 Dec 2021 06:26:52 -0800 (PST)
Received: from localhost.localdomain ([94.103.235.97])
        by smtp.gmail.com with ESMTPSA id v27sm2510259lfo.97.2021.12.30.06.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 06:26:52 -0800 (PST)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     kraxel@redhat.com, sumit.semwal@linaro.org,
        christian.koenig@amd.com, daniel.vetter@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+2c56b725ec547fa9cb29@syzkaller.appspotmail.com
Subject: [PATCH] udmabuf: validate ubuf->pagecount
Date:   Thu, 30 Dec 2021 17:26:49 +0300
Message-Id: <20211230142649.23022-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot has reported GPF in sg_alloc_append_table_from_pages(). The
problem was in ubuf->pages == ZERO_PTR.

ubuf->pagecount is calculated from arguments passed from user-space. If
user creates udmabuf with list.size == 0 then ubuf->pagecount will be
also equal to zero; it causes kmalloc_array() to return ZERO_PTR.

Fix it by validating ubuf->pagecount before passing it to
kmalloc_array().

Fixes: fbb0de795078 ("Add udmabuf misc device")
Reported-and-tested-by: syzbot+2c56b725ec547fa9cb29@syzkaller.appspotmail.com
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---

Happy New Year and Merry Christmas! :)


With regards,
Pavel Skripkin

---
 drivers/dma-buf/udmabuf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index c57a609db75b..e7330684d3b8 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -190,6 +190,10 @@ static long udmabuf_create(struct miscdevice *device,
 		if (ubuf->pagecount > pglimit)
 			goto err;
 	}
+
+	if (!ubuf->pagecount)
+		goto err;
+
 	ubuf->pages = kmalloc_array(ubuf->pagecount, sizeof(*ubuf->pages),
 				    GFP_KERNEL);
 	if (!ubuf->pages) {
-- 
2.34.1

