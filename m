Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FC24DC762
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 14:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbiCQNRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 09:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiCQNRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:17:32 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B72819E0BE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 06:16:15 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a1so5947633wrh.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 06:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mGNq1VtdAJO1ZeMl0bHx5YJtvGssvSJA1T33fHPp93c=;
        b=AnTZyk5MoAuKy7AgmJRTnAtf/NK/7MDFFNmUOjzE9Xad+y+krrvtyff0a2gHsFnHI6
         gMd9h43ROvJHQz6JtgrI9K54ov6N0nGepsdEYppt6gNmucHT4mh7wXWlqhrEubQG8VEK
         D/BGrat3SSNnlvZ1Cm+nQ79b3AJ+6RkkzQpTGi4vs5B2wbAWzBkDVD49OXmZ06XepDR/
         3K77NgmEY2NXNPNiLEzmLbHDgbURbCtHBV+RLAcgRZyh87bJEzohGU0j2nv8HwXPiTp0
         8smPSc2LRyfJazaWh6ZgyiWWsGFopf1VF5jHSpGiOTg+MzkhwIXCZ/h4SMTfIvTe4JyZ
         B0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mGNq1VtdAJO1ZeMl0bHx5YJtvGssvSJA1T33fHPp93c=;
        b=WziiQ0Yr2tGXfgoZMso+Y1T8O1CuBJrrrw18YF77EepvTtVRcZwGmh+jMZA1zToBV8
         e7z9l+EJFxFlBJ/nkF7SBoxtO9w2em9ZB/8bZMlMimKDogixwXqP8BKlgQ01zbHTArNR
         KUECddGdTrvtJUSo0Pxa9Uz0VtB2PSCd/rfIN3DEK6JQq+9cC04raYQGvy4amcYg128I
         3kC9b8sxlldBRANgbBCpbHKHWVmuGtLEZsFf57YyjQJp3YZW7SfrIgMedaRZj7zX7jpu
         3skP32pT0PciQF5dm2nq6dVwji/rcCpevIHE4sxdjnNCmyiLpnikUZ5pPU4ojXRsdv2/
         ul+Q==
X-Gm-Message-State: AOAM531VX4MeUg9iWhWwqYNCd8nPJhtCNJZ1+ByYquy5vxHo/HGAokRU
        7CZQhBQBYzCwM2WrQFZnfBv5/g==
X-Google-Smtp-Source: ABdhPJynt03P4guHUS6/f1MTsqVNLGdBo3gyMn10Yy106t9AfOzszR2jg6ZUfbFh/1EyicNos0Pbaw==
X-Received: by 2002:a05:6000:2a6:b0:203:ebe1:2900 with SMTP id l6-20020a05600002a600b00203ebe12900mr2169745wry.423.1647522973870;
        Thu, 17 Mar 2022 06:16:13 -0700 (PDT)
Received: from joneslee-l.cable.virginm.net (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id c1-20020a056000184100b00203d72d0f4dsm4715113wri.59.2022.03.17.06.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 06:16:13 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdkfd: Protect the Client whilst it is being operated on
Date:   Thu, 17 Mar 2022 13:16:10 +0000
Message-Id: <20220317131610.554347-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Presently the Client can be freed whilst still in use.

Use the already provided lock to prevent this.

Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index e4beebb1c80a2..3b9ac1e87231f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -145,8 +145,11 @@ static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
 	spin_unlock(&dev->smi_lock);
 
 	synchronize_rcu();
+
+	spin_lock(&client->lock);
 	kfifo_free(&client->fifo);
 	kfree(client);
+	spin_unlock(&client->lock);
 
 	return 0;
 }
@@ -247,11 +250,13 @@ int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
 		return ret;
 	}
 
+	spin_lock(&client->lock);
 	ret = anon_inode_getfd(kfd_smi_name, &kfd_smi_ev_fops, (void *)client,
 			       O_RDWR);
 	if (ret < 0) {
 		kfifo_free(&client->fifo);
 		kfree(client);
+		spin_unlock(&client->lock);
 		return ret;
 	}
 	*fd = ret;
@@ -264,6 +269,7 @@ int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
 	spin_lock(&dev->smi_lock);
 	list_add_rcu(&client->list, &dev->smi_clients);
 	spin_unlock(&dev->smi_lock);
+	spin_unlock(&client->lock);
 
 	return 0;
 }
-- 
2.35.1.894.gb6a874cedc-goog

