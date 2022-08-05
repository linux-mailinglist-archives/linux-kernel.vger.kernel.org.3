Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7ABC58B2AD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 01:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241475AbiHEXIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 19:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241616AbiHEXIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 19:08:15 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38C97539E
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 16:07:49 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id u8so2768133qvv.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 16:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=5F0eHPPG4uUzCHy43JBmziMscU9ueyHbDMwQuD3xgdk=;
        b=MttiJjLrR5b8sL76Krr4fcDE7ctULZjc895Lbooht+i8fJiiYTTXTn8UzRziWwwKWq
         rX8cbo8fFXTyRQqq/3ebxGmAMzoMKJAxtIzWHP41zmRbLYc5YxRfTRVG3RhfT05OqE8L
         kkVu1add0Z25dJ3zLgcAetkPabQHsr/it2kGXkUvlHXRF2r3aam752t+0hguxwfwCnIt
         aua32KVlxFpz8M73Id1z02WeJgvv30KHu5F5zW5FNZQ/rwqwyWc7fB18sfYL69YsdejZ
         URH/YF6DzIsYLHlrVPm502/cF9RDHLV5iwm7/OmnTIPKlLTPGDLgKlgFc6d3T5URaQYn
         oupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=5F0eHPPG4uUzCHy43JBmziMscU9ueyHbDMwQuD3xgdk=;
        b=lEC/Gtk4l5mlVglF0/CM70edlroNr6N7Y6XrJADWrcvGcSvkCvKO5JzdHXCVki+Rdn
         RjF3/0RlUJeIps2kuPkRsZffps1ToTeGAiZZh2pQw7/y/QdTOm7hD1d0k92zBJQFx+E8
         C847Xp89FGo9Y0ZD5Ge0mmgFuRYAaa55yx6BvwR+Ys+HMs3ukVepsY5iKRg7p1KRSG73
         I2OPAq62mnz+Vq/FAHYhMr25A+t+PFjKQoL6wk29MMHylvq1184WzBbLW3zwcFgghsrL
         IQAYJEhfWu5aiWxDUCtPn4H2XphQOLZh1vPU1jF+B9NeAt79OVWMkgWn30A/aWzp0VQ8
         9P7w==
X-Gm-Message-State: ACgBeo09hha+Ob3jJf3PSnIuStdVTxOIyvOY9GN+caiRmaRkQR2CMcAm
        aqODmmsH9EvaJstejB85AbTlZcQvb6k=
X-Google-Smtp-Source: AA6agR6lmoaKTG7LS8GUVaXTiBLPVc+HsLx/ArhLCURb/fy+rMDj1XGRj6PUwa67yzTQ203naLaTcg==
X-Received: by 2002:a05:6214:27ea:b0:476:779d:f68a with SMTP id jt10-20020a05621427ea00b00476779df68amr7656666qvb.49.1659740868296;
        Fri, 05 Aug 2022 16:07:48 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p4-20020ac87404000000b0031ea2328edcsm3516270qtq.82.2022.08.05.16.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 16:07:47 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH] arch_topology: Silence early cacheinfo errors when non-existent
Date:   Fri,  5 Aug 2022 16:07:36 -0700
Message-Id: <20220805230736.1562801-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Architectures which do not have cacheinfo such as ARM 32-bit would spit
out the following during boot:

 Early cacheinfo failed, ret = -2

Treat -ENOENT specifically to silence this error since it means that the
platform does not support reporting its cache information.

Fixes: 3fcbf1c77d08 ("arch_topology: Fix cache attributes detection in the CPU hotplug path")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/base/arch_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 0424b59b695e..eaa1b8d2d39d 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -735,7 +735,7 @@ void update_siblings_masks(unsigned int cpuid)
 	int cpu, ret;
 
 	ret = detect_cache_attributes(cpuid);
-	if (ret)
+	if (ret && ret != -ENOENT)
 		pr_info("Early cacheinfo failed, ret = %d\n", ret);
 
 	/* update core and thread sibling masks */
-- 
2.25.1

