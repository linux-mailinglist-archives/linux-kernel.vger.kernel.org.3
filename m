Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264F758EEA4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbiHJOmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbiHJOmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:42:04 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82215007D;
        Wed, 10 Aug 2022 07:41:43 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y13so28041878ejp.13;
        Wed, 10 Aug 2022 07:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=fTJ2OK/JmvWIS6+MCN0Vybn0C6WdQyyK6xBw94ER00Q=;
        b=P7U4vyZdOO9BJ7p33fKmRYXZGxvyUSoyamrQok4DgzSdTxYMmdMwkzggARBfTPdoPl
         5msP9psUlBmyF1Pu7qT6IHgCF6s8ReBtG3UxOv50rRRFc9C/FHWhVHRWl638UfbGjWiB
         61Vy243op7nnVK/Zh+CIqevSv9mKYeJfR8EtoYegteMB9a5OujeXqAa4Ksh+ONW1/SVn
         v1XRKCMTvKS2x4YQlFcaQMaRizOrmNQLoOVftXXuticHwQMaAtCNZfUsmGOgZImnlfCB
         DJ/9DADP6y2ArbGC7EP5cI8VJgKksiC9WdE9uW0BxSsx2TYA8WevsNQEW6gn/xJrIcix
         9zSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=fTJ2OK/JmvWIS6+MCN0Vybn0C6WdQyyK6xBw94ER00Q=;
        b=xkUBHCMUytwzmKiRumwjZSKe5qH309LC4FDGgofIN/Hbcd/bYfnjpPJekG75s56WM/
         hpMDbmzQ3C5F1cu2wm0o5TUBg/1a7yTiYMYGbqWLP1EWZxVyg+5+LkqLJJyIBUm/gYts
         rew4f5EJd1pz2Ov8d92zifDJMH41Pl5/c4++vkvApRYz53Ub6JsRnIzR4TYxLObpQMPS
         NLnZyLj21OopP5FP4YDFPswYWGdTTPFJEfCFF+uFXtieh+OOsOFclGk1ucnKw9EnYB0a
         +EfZqXh38n9P4WEETc31uVIlK0y7pQGyFlG4XD6I7gdiRxUYxef7mLdE9OFYV5pyZpTr
         pdmA==
X-Gm-Message-State: ACgBeo3WFSnC1lg9l0W7evxKYyMGTTz9fnaGDYKuxFluvwEgRh7eVOER
        Zq6kHD7IRxdypmYWvK0PJE4=
X-Google-Smtp-Source: AA6agR5RQoYGsFn4BW5A3CIqN+VDgk//460F/XCjMZfMfoMO0Bh+Rn/8QgRJGGcGO04V8y9vjqsz+A==
X-Received: by 2002:a17:906:7e43:b0:72b:52de:b039 with SMTP id z3-20020a1709067e4300b0072b52deb039mr20979138ejr.198.1660142502388;
        Wed, 10 Aug 2022 07:41:42 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id d25-20020aa7d699000000b0043cedad30a5sm7778049edr.21.2022.08.10.07.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 07:41:42 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 3/3] platform/surface: aggregator_registry: Add HID devices for sensors and UCSI client to SP8
Date:   Wed, 10 Aug 2022 16:41:17 +0200
Message-Id: <20220810144117.493710-4-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220810144117.493710-1-luzmaximilian@gmail.com>
References: <20220810144117.493710-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add software nodes for the HID sensor collection and the UCM UCSI HID
client to the Surface Pro 8. In contrast to the type-cover devices,
these devices are directly attached to the SAM controller, without any
hub.

This enables support for HID-based sensors, including the ones used for
automatic screen rotation, on the Surface Pro 8.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/surface_aggregator_registry.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 805c7bd4b15e..cf6e213db223 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -279,6 +279,8 @@ static const struct software_node *ssam_node_group_sp8[] = {
 	&ssam_node_hid_kip_penstash,
 	&ssam_node_hid_kip_touchpad,
 	&ssam_node_hid_kip_fwupd,
+	&ssam_node_hid_sam_sensors,
+	&ssam_node_hid_sam_ucm_ucsi,
 	NULL,
 };
 
-- 
2.37.1

