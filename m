Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A7147503A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhLOBDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:03:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24768 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239112AbhLOBBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2uVXvqerQ3mIROsnwK4gbzNANyt6XjHgGbuV6EWNXUo=;
        b=C6eljFCKCyd+JsjY5XgPq/Eo/uE/qevKfI8GeiM8jIT/d3TuRVXA//45+K7aW32UcC101a
        4s5ychj4Vhu2hl4hGj7T18UIZy7qHtMLWn8Tp/2zYm+NH4UILodldU7NMIkqoHgeylECcJ
        ZMdDG4qJ/P71QBTwVOXA8iLEyYRcbfU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-68-uZr-yfAVNvCs3qW_C04j2w-1; Tue, 14 Dec 2021 20:01:37 -0500
X-MC-Unique: uZr-yfAVNvCs3qW_C04j2w-1
Received: by mail-wr1-f69.google.com with SMTP id k15-20020adfe8cf000000b00198d48342f9so5384187wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2uVXvqerQ3mIROsnwK4gbzNANyt6XjHgGbuV6EWNXUo=;
        b=cr35rmg18agLVx90+TXD3RFZQ8jSyyISTUEJK5gQeHGGK13580AE5BerkyRFrJn+Gj
         azFSjTcFhC3CVtKwTMvDX6hTojvbywRorfsHD0/T+szl0OCp4TyfP2dF+56K3xQyLaCo
         TSFjBGApQaaIl+Xv2cEtuNH1IzsBGUlaK7xk2YXCOxuyOENsdZISYWl7nELBXrFGvhZ1
         pUB05OTvU27ZSMQWme3jlnj4vyydmF+fSvpS751PSLcHFkBs0c7DehgXdPk2Bz87KDJ1
         bFo8pz41HWbasHzE4/Pm872G0iVRZFP4pZEbmjCAoiZPjM8/1DGeZQapQR4kUwMo2VT2
         LFpQ==
X-Gm-Message-State: AOAM531Qpbr3Xhx578p/IevwmNJVWRQaRQciEUl034+3rYaXvrDSCBg/
        lzUT/7MWxpHX/peWHZcGbQcnh2Oj61uuUCZVzFQGjhq8XrPfkTCK2GQRNA/ZutitxABbCqiObBD
        xYiPCeQy+CoAETHD7FoEQazudyykjGFoX4XapaeP1NoAs9kp/kcIYvB+a6Gw6x8QRBXwl09mtPG
        I=
X-Received: by 2002:a05:600c:1e26:: with SMTP id ay38mr2330200wmb.14.1639530096035;
        Tue, 14 Dec 2021 17:01:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxeOncOXUCZ6JUkydTsueQefbGvxmSVfS7725K9mjCeMZVVnN66la0zjp9Cmek/Nd65/4Y6iA==
X-Received: by 2002:a05:600c:1e26:: with SMTP id ay38mr2330182wmb.14.1639530095786;
        Tue, 14 Dec 2021 17:01:35 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:35 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH 53/60] drm/repaper: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 02:00:01 +0100
Message-Id: <20211215010008.2545520-54-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211215010008.2545520-1-javierm@redhat.com>
References: <20211215010008.2545520-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

 drivers/gpu/drm/tiny/repaper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
index 97a775c48cea..ea97b8c06157 100644
--- a/drivers/gpu/drm/tiny/repaper.c
+++ b/drivers/gpu/drm/tiny/repaper.c
@@ -968,6 +968,9 @@ static int repaper_probe(struct spi_device *spi)
 	const void *match;
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	match = device_get_match_data(dev);
 	if (match) {
 		model = (enum repaper_model)match;
-- 
2.33.1

