Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A075B17CC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiIHIzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiIHIzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:55:13 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DF1C5789
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:55:11 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id z9-20020a17090a468900b001ffff693b27so1694728pjf.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 01:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ZK3gsfh7RWbM9CrtWvTUZX33Bm/T3p94/yUzT2/I0OU=;
        b=YmogQJprMr/RjjMlImkpkLfcp+AUyr1pSrltT5i1jjkh/48lBCoo7DQ6EBMcx4CIA1
         Ew7JXnoTYEp3MpdEHmINpkmPkqdlNP5IZOJ5BqmYb7QMOMKcsx9n4V61kxlYvwODDHJ/
         KZa74fEuebxJNQwcZGJ8jHUKTvCGq/+UOXnNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZK3gsfh7RWbM9CrtWvTUZX33Bm/T3p94/yUzT2/I0OU=;
        b=kHqpzX0iMnuPyIdlz3X/Dlq+dj/h2ngn5B6pa0D8hMgIJPfiPmZ1rZsIc5uLOMCdxJ
         vpid2yCMzs/+NbQ+KdMVxl5N70qSZKNS9q5AlEJaNIWRMRMzgN7WLXLHHjVtvaWcj25n
         +IRxyi0TQsa/eM1c10NpyZ8FEnjEcU41CGODY6ClAWB+1eMAAtdOH6lIcuaJ2X4VNk/U
         WaNjXfJfqOZG4aVK5EDByYbAktLsCGPHJrMAH3cAecW+kGtywWuq/rgn0SDUn7gTdXHZ
         ZGDehnOXvvr1ho+wK2s80x4agQDBD+8uy0picufrdiW4qIqrQ/3jKE1RIZGbKt8j4Cyv
         f+EQ==
X-Gm-Message-State: ACgBeo2r/2b+nNoYw2uApsgXnqPbg5gZ68nQ3hqAks/S3Bw/j4bTJ4Rp
        CnY52V1omsRfUIb5RKzvI9xW5w==
X-Google-Smtp-Source: AA6agR7+/jywm3x00fh+VStEJoKR8VdWUmDZ3AeFxeZiVW7XtGSjj4Hjpi+FdrUummQmeMktGomVTg==
X-Received: by 2002:a17:902:b715:b0:174:dba3:8bca with SMTP id d21-20020a170902b71500b00174dba38bcamr7806570pls.51.1662627310835;
        Thu, 08 Sep 2022 01:55:10 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:c6ba:fe7c:d2b:242e])
        by smtp.gmail.com with ESMTPSA id mj19-20020a17090b369300b001f334aa9170sm1188629pjb.48.2022.09.08.01.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 01:55:10 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/panel-edp: Add Innolux N120ACA-EA1 panel entry
Date:   Thu,  8 Sep 2022 16:54:54 +0800
Message-Id: <20220908085454.1024167-2-wenst@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220908085454.1024167-1-wenst@chromium.org>
References: <20220908085454.1024167-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This panel has the same delay timing as N116BCA-EA1 from the same
company, which is also the same as delay_200_500_e80_d50.

Add an entry for it.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 65e3a5361c80..15e18a64b03d 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1890,6 +1890,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a5d, &delay_200_500_e50, "NV116WHM-N45"),
 
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x114c, &innolux_n116bca_ea1.delay, "N116BCA-EA1"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1247, &delay_200_500_e80_d50, "N120ACA-EA1"),
 
 	EDP_PANEL_ENTRY('I', 'V', 'O', 0x057d, &delay_200_500_e200, "R140NWF5 RH"),
 	EDP_PANEL_ENTRY('I', 'V', 'O', 0x854b, &delay_200_500_p2e100, "M133NW4J-R3"),
-- 
2.37.2.789.g6183377224-goog

