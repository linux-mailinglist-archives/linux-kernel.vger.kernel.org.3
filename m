Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB6F47500A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239028AbhLOBBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:01:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32172 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238786AbhLOBBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R4sk0aOGoZo6DhLKUJGsiUdEPfqgud6UXrgjI7DBDO0=;
        b=eVhyfSh43m9R+9JbWEZdzba8zpIegMaMPGwzssQ3ikDWhNodDtqSqdKWryDl/8uw00+vdh
        F1mHo6ql8yIu8NYFunpsquUgOdMeMagM1rGNajhcknsZuQLI8qt81AVgKBM/JjDt5K4VDB
        4Ff/KXyScrvcKnYMTaRn3B9UozvalhA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-UHvyWX9PMdmDSmhodvwSYQ-1; Tue, 14 Dec 2021 20:01:04 -0500
X-MC-Unique: UHvyWX9PMdmDSmhodvwSYQ-1
Received: by mail-wr1-f69.google.com with SMTP id m12-20020adff38c000000b001a0cb286eacso1153928wro.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R4sk0aOGoZo6DhLKUJGsiUdEPfqgud6UXrgjI7DBDO0=;
        b=xQUSTcUycs8W3BbjgdWJ6rb7g4tFjNPtA52Llc6gHt3M/pyInxWx/S5Wkqaz2K8n3M
         xVsCcoBwICX/dCeQSGL21us7Df7Y4gXKlgV8mrDJjPbDI/k69Pfa2m+kI127enCxeyWm
         1cwItix8epRFvTLZaUfPC7EKrwJtUPu8loQi+fdH+HMboHUlOr6rObdBDxs//izWrgDk
         rJGnH2akLKeK+hAE6VjuSpkMkovNRE3ZEwSmi+AJWRrt44lXUOh0/wYErmoprxZipHX3
         u4rLN5FfGDt3dauBG7A964UOMIvQ7dvl8usWLJqYWO6Rpw1Q61RONSNbXd0YN6XtT58L
         WzHg==
X-Gm-Message-State: AOAM530S5qX0dUfe72NYRKlMlRrj5m6IOdyGxYfBKFfobTvOWmruYwbt
        dFSErT6hcR3XwernRCryf10T8hfbV1v15jjeF2fikzsURpq8YsJKdkQb5lkGuftE3btgrfQhRip
        ZrR5C/uoeZc76bcegSNScylDCMS3HBQ+WwJxm8JiyeeeQOeVU66dJSwkBFic70qA0S0WC4RPRHn
        o=
X-Received: by 2002:adf:d18f:: with SMTP id v15mr2109914wrc.447.1639530062931;
        Tue, 14 Dec 2021 17:01:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzILyKS6xkmD+jqzqVV4KBj0XycKfBbUVs/Yu6SqmEzKz2P1vRUfBpoPKqcsiT6hf6Y5qmI9Q==
X-Received: by 2002:adf:d18f:: with SMTP id v15mr2109899wrc.447.1639530062649;
        Tue, 14 Dec 2021 17:01:02 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:02 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 15/60] drm/i810: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:23 +0100
Message-Id: <20211215010008.2545520-16-javierm@redhat.com>
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

 drivers/gpu/drm/i810/i810_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i810/i810_drv.c b/drivers/gpu/drm/i810/i810_drv.c
index 0e53a066d4db..7ce268b54a18 100644
--- a/drivers/gpu/drm/i810/i810_drv.c
+++ b/drivers/gpu/drm/i810/i810_drv.c
@@ -80,6 +80,9 @@ static struct pci_driver i810_pci_driver = {
 
 static int __init i810_init(void)
 {
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	if (num_possible_cpus() > 1) {
 		pr_err("drm/i810 does not support SMP\n");
 		return -EINVAL;
-- 
2.33.1

