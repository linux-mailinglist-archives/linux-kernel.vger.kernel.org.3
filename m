Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3F049BFB2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 00:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbiAYXqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 18:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiAYXqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 18:46:10 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782FDC06161C;
        Tue, 25 Jan 2022 15:46:09 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id z20so8307621ljo.6;
        Tue, 25 Jan 2022 15:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zaINez3rSSjlWvImf4qb8L/2ha5D25vy6vOExgL5WaQ=;
        b=iV2aH8lTgzOeF0OfA9lwfhljizJow9SpdPc45/DZRASudSweStW612jn+PZ/SLp1iM
         PkFIPw+KeTj3jctJArVvg40BhNj9efuvDxUAj99GkzbheimDRi3Db7xMMbeVQl3JE0d/
         +YYv2PdLlgBLI2N4zigOsoa3y6nR+qFWEhOQVB7hZTFr0HFWlmdpWW8KTvbbb+9zkC9j
         BIVnY5qViAXQvKir3vwPjuIqBYI0X2Zt8WqAakV09DDTG+q1g/aq1CHiJg9WbIdm9kVm
         J+ReF+9GDJuIs4W5VxGBPnlMNod9ddq+uDmP1cGgn3K9lU4DdvGGfveo5IcDYqsVBv0L
         sRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zaINez3rSSjlWvImf4qb8L/2ha5D25vy6vOExgL5WaQ=;
        b=AsgWOrru6ZYd26D4Ym+9uxsi5fe0d7U/fqqKGCJNd+tJwxWRQg2eFPQrWoMnFofJDT
         nDsTu/OLGqhb9oVZJEd4Xn7P4Q7S0TYxmyZm1FuQ3RgsqsrFbAiP6ukhDG1+dPRw9Pvk
         mbazXz7Ap+pQpCMrgkZS1eiZPh/Gj9+pn+ovECCl4ZSpZU2hDAap7XOFrPlGrXfw72A5
         ca2HtyggrSP30qZ6HtQ9DZGJWtWcpqKJ4efp7qNF2FLm/TH3p+jVtoenE+VI1VqKvREL
         q8JstKHKuCNTc/siGHmhcSuFHOL4owjOf874PG/PBGDNpFOgGDQp70WJkZdEHi2+XOnP
         8rWw==
X-Gm-Message-State: AOAM532hSV0ho1hKMgtkvbUAIyENKSlJSmhpLfG49N5fkQF5tvuS75m8
        /0D5kEojldORt9obbYrWpFU=
X-Google-Smtp-Source: ABdhPJzguO9tzrOFKU/gflOLSpo2MsfX3F0pmTBxx/6XNlHW1oZOrdA/q/xNp6vlajb3Tox4CbN8rg==
X-Received: by 2002:a2e:96cf:: with SMTP id d15mr2043717ljj.342.1643154367641;
        Tue, 25 Jan 2022 15:46:07 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id k3sm900383lfo.127.2022.01.25.15.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 15:46:07 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] media: go7007: Constify static struct snd_device_ops
Date:   Wed, 26 Jan 2022 00:46:02 +0100
Message-Id: <20220125234602.10481-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of go7007_snd_device_ops is to pass its address to
snd_device_new() which takes a pointer to const struct snd_device_ops.
Make it const to allow the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/media/usb/go7007/snd-go7007.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/go7007/snd-go7007.c b/drivers/media/usb/go7007/snd-go7007.c
index 2ce85ab38db5..9a6bd87fce03 100644
--- a/drivers/media/usb/go7007/snd-go7007.c
+++ b/drivers/media/usb/go7007/snd-go7007.c
@@ -191,7 +191,7 @@ static int go7007_snd_free(struct snd_device *device)
 	return 0;
 }
 
-static struct snd_device_ops go7007_snd_device_ops = {
+static const struct snd_device_ops go7007_snd_device_ops = {
 	.dev_free	= go7007_snd_free,
 };
 
-- 
2.35.0

