Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50E547500D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239136AbhLOBBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:01:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25077 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238747AbhLOBBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FFUY3y4Fc7Li7zPn7hZWKeCZOkC5w2h++A9aiZzcqyY=;
        b=QzKrPvrT5rvGA05xY8PCl0nGV5RIvxyToRUD6A4cRYTxo5wyUOw334RgXUuDQDCmQgbxil
        ELIQQLiR3ycWL3knRcy5OXbChLjS+Qw8YGcPnuB1mOy9pgs9U5DudcuomYzE+zZ/tFZvRR
        9oW/VKX6bS9Yzb9vatAdxooIY4kninw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-509-OAU9wZHYPiqs_RlCkg94-A-1; Tue, 14 Dec 2021 20:01:07 -0500
X-MC-Unique: OAU9wZHYPiqs_RlCkg94-A-1
Received: by mail-wr1-f72.google.com with SMTP id x20-20020adfbb54000000b001a0d044e20fso1098992wrg.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FFUY3y4Fc7Li7zPn7hZWKeCZOkC5w2h++A9aiZzcqyY=;
        b=bqUBzZ9xpxqUm/1j7wWvVnHppuf4qxjf8NG1gJ88Z1AGr/1GEobOFfmtjWCNNVitrH
         SWVbqe50qMmkAqsEMXy1teAi+7HYf/28SUaaOrG47wFRwB1sYL3nDvC61fwMDhAyfml1
         Rk7dJk7PIuqSqlBOhTj/PSH2Mlz5tES6WavYLZD4K358ay+xr16vEf94tXScLmbOx144
         GeJ1iyc271/h6himdZyud/8N0YQMPAy9pqRXxmH7FJdDcMAZQ7PH+nipGhTbtQ7IEDj6
         Mg4hPDeZryPr5JdSIQdVg25Cm7X9uB1AsCSJP5ewUPC1IX/lhNbh+PfbhIQedtkBkV/Q
         eJmQ==
X-Gm-Message-State: AOAM533ujCxpKgWe0wy8NO4/DFMnllWiopotHzM1UEbKO2Iv2LfNRXbR
        5zU/vgzOVu5DT4lcey1Or9w5fOhQHZoEcDvlavlyXGVltJ44XFW54kUqQkh/gFSnIYyjK6eGpRJ
        U0/SYeWhp61A2puiKC+DIbTj7o/PMh6Yt7HK0OhiotYvfF3HOEzF56R+lfbwzhdaSgywJ7JTDVl
        Y=
X-Received: by 2002:a7b:c097:: with SMTP id r23mr2275701wmh.193.1639530066420;
        Tue, 14 Dec 2021 17:01:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyBRHnacxFWs8Vwf5YdSr72P6F02qEBLsigQyW6PkgT7R1zH4EboAaqYGonUTE0XPmXOsyY/A==
X-Received: by 2002:a7b:c097:: with SMTP id r23mr2275687wmh.193.1639530066221;
        Tue, 14 Dec 2021 17:01:06 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:06 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Edmund Dea <edmund.j.dea@intel.com>
Subject: [PATCH 19/60] drm/kmb: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:27 +0100
Message-Id: <20211215010008.2545520-20-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211215010008.2545520-1-javierm@redhat.com>
References: <20211215010008.2545520-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to disable Documentation/admin-guide/kernel-parameters.txt, this
parameter can be used to disable kernel modesetting.

DRM drivers will not perform display-mode changes or accelerated rendering
and only the systewm system framebuffer will be available if it was set-up.

But only a few DRM drivers currently check for nomodeset, make this driver
to also support the command line parameter.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/kmb/kmb_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
index ed2424350773..56a59ee71755 100644
--- a/drivers/gpu/drm/kmb/kmb_drv.c
+++ b/drivers/gpu/drm/kmb/kmb_drv.c
@@ -484,6 +484,9 @@ static int kmb_probe(struct platform_device *pdev)
 	struct device_node *dsi_node;
 	struct platform_device *dsi_pdev;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	/* The bridge (ADV 7535) will return -EPROBE_DEFER until it
 	 * has a mipi_dsi_host to register its device to. So, we
 	 * first register the DSI host during probe time, and then return
-- 
2.33.1

