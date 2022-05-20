Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF3B52E888
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 11:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346169AbiETJQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 05:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343770AbiETJQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:16:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0A5A34657
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 02:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653038172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=37VtCkmeYBj19kPbM9wIPiRfK6JVm/8EYkASIsdU9tQ=;
        b=aG7t6omxdqv0TVFF1y8uyt67L3R0WhwONls795NrjZG9DYMYES335IHwH7Z+9qNc3j8dcI
        DZmtob7prAAP2vYxJk9TnpFhcau4ifn7ToX5JpXSpE8yNHAcf1AOd/4gZvFhAo/FTz2Knx
        Z/CTe777Omz+yDUuHbJP+psnG1o9OK0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-SiEdDXCcOquq4-FDuiw4bg-1; Fri, 20 May 2022 05:16:10 -0400
X-MC-Unique: SiEdDXCcOquq4-FDuiw4bg-1
Received: by mail-wm1-f70.google.com with SMTP id bg7-20020a05600c3c8700b0039468585269so2903201wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 02:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=37VtCkmeYBj19kPbM9wIPiRfK6JVm/8EYkASIsdU9tQ=;
        b=JC2dhWMnPoiu63y2UGJB+CBWuN4Mg7TtmFw44Dvl1rVUzLeEUcsu5fZOSmcm0Ib76F
         coEVDh5ux39p2u9ekhWOLSVGaWz7TtYS0O5jUR40PAAFww9i73EBAqBbN3ekmswUtfom
         sDD3TbfYMvOB36oXWzXkm7KyACHM/eO0YHMzUZAhFwv48xBVVd7NeNrb3fIky6EX/GNf
         7KyllpTIy5h2C9/8hPGkiip93aA3iQ0qH7eQydLMJru56zMvebJmReIUPpnDMMFNuHQM
         lLTvLKjmfrCpPlncr920VWWKrUi3jygYudH6srglyp/apyMxOhxzhPhwl0RV1B7IwUg2
         8h2w==
X-Gm-Message-State: AOAM530POK5D7+iTpVbc1yVPgy9R0HO29d7J7dYp07DGCZGhEN3vdp3H
        ozDXirDbGnxiQLenAJPNl9xPH8wJ1ex5DmCXokKfiXweD13sph3LVz4yv/O2cW67fMwxZvLBESw
        r/XstvfxHl9pJ965IA/WYvr3VAFyvE+i1O1PQJt7+LCrm+fPR+6A2gowwWnoqpEL692NxEAx5zC
        0=
X-Received: by 2002:a1c:4443:0:b0:397:38a7:30 with SMTP id r64-20020a1c4443000000b0039738a70030mr1918612wma.14.1653038168242;
        Fri, 20 May 2022 02:16:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRnV/FLXilJCVFaq7XzkxHGACQ2befF60ot270hFjpctpC3oeb6FZd2yxb9EjKoqwk5Wqehg==
X-Received: by 2002:a1c:4443:0:b0:397:38a7:30 with SMTP id r64-20020a1c4443000000b0039738a70030mr1918587wma.14.1653038167957;
        Fri, 20 May 2022 02:16:07 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id ay28-20020a05600c1e1c00b003973c4bb19bsm495397wmb.16.2022.05.20.02.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 02:16:07 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        David Lechner <david@lechnology.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/st7735r: Fix module autoloading for Okaya RH128128T
Date:   Fri, 20 May 2022 11:16:02 +0200
Message-Id: <20220520091602.179078-1-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPI core always reports a "MODALIAS=spi:<foo>", even if the device was
registered via OF. This means that the st7735r.ko module won't autoload if
a DT has a node with a compatible "okaya,rh128128t" string.

In that case, kmod expects a "MODALIAS=of:N*T*Cokaya,rh128128t" uevent but
instead will get a "MODALIAS=spi:rh128128t", which is not present in the
list of aliases:

  $ modinfo drivers/gpu/drm/tiny/st7735r.ko | grep alias
  alias:          of:N*T*Cokaya,rh128128tC*
  alias:          of:N*T*Cokaya,rh128128t
  alias:          of:N*T*Cjianda,jd-t18003-t01C*
  alias:          of:N*T*Cjianda,jd-t18003-t01
  alias:          spi:jd-t18003-t01

To workaround this issue, add in the SPI table an entry for that device.

Fixes: d1d511d516f7 ("drm: tiny: st7735r: Add support for Okaya RH128128T")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/tiny/st7735r.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tiny/st7735r.c b/drivers/gpu/drm/tiny/st7735r.c
index 29d618093e94..e0f02d367d88 100644
--- a/drivers/gpu/drm/tiny/st7735r.c
+++ b/drivers/gpu/drm/tiny/st7735r.c
@@ -174,6 +174,7 @@ MODULE_DEVICE_TABLE(of, st7735r_of_match);
 
 static const struct spi_device_id st7735r_id[] = {
 	{ "jd-t18003-t01", (uintptr_t)&jd_t18003_t01_cfg },
+	{ "rh128128t", (uintptr_t)&rh128128t_cfg },
 	{ },
 };
 MODULE_DEVICE_TABLE(spi, st7735r_id);
-- 
2.36.1

