Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E284B51E2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354400AbiBNNjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:39:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245609AbiBNNjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:39:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7856650474
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644845981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Etof0neSgRXt027GXsgMkq+0wQ1AzPcD2BHFX9AFsyc=;
        b=bd1v2bS/soZIYMR2fHFdXMHG4K22IGIoMeOCdOOBLqcxQnwz1l5pCZ3TblCtuQr+ncQBdG
        VZ4VrhnbGExpQk08AcSnw0RtKndrlSL/Yhe03XawdnLNhBM91QB0hL8l7w6voztglSxgcX
        MBmwUXNgQ5qXA4BkCG0NH067ZxcMc1o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-iVZbllHGOKSxWXDSv0MfPg-1; Mon, 14 Feb 2022 08:39:40 -0500
X-MC-Unique: iVZbllHGOKSxWXDSv0MfPg-1
Received: by mail-wr1-f69.google.com with SMTP id m8-20020adfa3c8000000b001e3381fdf45so6897355wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:39:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Etof0neSgRXt027GXsgMkq+0wQ1AzPcD2BHFX9AFsyc=;
        b=JhTrBuqLV5hG9TwJErTBJ3peZQB8yv8KA5H2QL6E6cXqvyQLew85GuQrPh9mV0i132
         QYIqvS4rkb92PUExHBymAXae4Mq+o2FhFdJidlgAFEN5JGM6n6Jdc8YkjmvhLhcTshpv
         k+Fym51z+y/Bcx/rnfc7RXrw4OvTG8XTyuw0hKjOLI8BQGynd26hM/sskoIiC9dufkg+
         Vta0CB7R8Phg5Y+rKSWlEXg1ZkKFfw6U4LoBRDhasQdCfci4xh57m7EHc5DIVa/Jskqy
         0Pb1ag4wtnhGhgvcKWSuHUf5ojWCdz8bqwNOAhLUXCxtKqg288xT7g63MWs7iXShAcUt
         EqRg==
X-Gm-Message-State: AOAM53079LzoG4H4n1WRjQ+imjyrCyrjHrv1jA0liBWnqV0EV9yykJeM
        a9XA97tUBTxa6OEbKZjPRfDkzfdvBTokStuwfaN6kwEhpwZnMv+vzQY1LPgy82baSRS/mJ/0+yk
        kvJB6+6dyIn0OuioJeTYCP/gocErFMFi0ZrBQhY80U3nSw10fneyzIIUn3wvN9v7KfGNghiGjOZ
        8=
X-Received: by 2002:a5d:4411:: with SMTP id z17mr10986774wrq.384.1644845979336;
        Mon, 14 Feb 2022 05:39:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx3m0kF1+a4nMfmlEayb8F11MLh6Npr5zmIcoMfkIl8FoBO9TtWTVfjOMLjIXuY3s4cdKK7qA==
X-Received: by 2002:a5d:4411:: with SMTP id z17mr10986751wrq.384.1644845979070;
        Mon, 14 Feb 2022 05:39:39 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l15sm11826697wmi.29.2022.02.14.05.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 05:39:38 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH v6 6/6] dt-bindings: display: ssd1307fb: Add myself as binding co-maintainer
Date:   Mon, 14 Feb 2022 14:39:35 +0100
Message-Id: <20220214133935.3278933-1-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214133710.3278506-1-javierm@redhat.com>
References: <20220214133710.3278506-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ssd130x DRM driver also makes use of this Device Tree binding to allow
existing users of the fbdev driver to migrate without the need to change
their Device Trees.

Add myself as another maintainer of the binding, to make sure that I will
be on Cc when patches are proposed for it.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

(no changes since v5)

Changes in v5:
- Add Andy Shevchenko's Reviewed-by tag to patch #6.

Changes in v4:
- Add Rob Herring Acked-by tag to patch adding as DT binding co-maintainer.

Changes in v2:
- Add myself as co-maintainer of the ssd1370fb DT binding (Sam Ravnborg).

 Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
index 2ed2a7d0ca2f..9baafd0c42dd 100644
--- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
+++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
@@ -8,6 +8,7 @@ title: Solomon SSD1307 OLED Controller Framebuffer
 
 maintainers:
   - Maxime Ripard <mripard@kernel.org>
+  - Javier Martinez Canillas <javierm@redhat.com>
 
 properties:
   compatible:
-- 
2.34.1

