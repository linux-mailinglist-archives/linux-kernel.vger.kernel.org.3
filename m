Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E7E4B280E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbiBKOge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:36:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345512AbiBKOg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:36:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA4DFB75
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 06:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644590185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mUtEuWaqCGQh3IRK8HcXsRqsLNSC6YZZzta5hJkK91U=;
        b=ee/5eo8GC14Vzi7Vpdic2bScbij0vpmEKycqGZI4lUkMemiG2XTZETzDX9s+4N5cjIMznq
        ISAPA4m62kdB97x0zK8ZyZlj3Rczh48v+JJbZ+/HkAmxj7LPmwRdf6NovR3GezxGhErP5G
        ouFqAhuBiujztHwdVaHuNHqVCoTXfAc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-NS5lPdQdOO6zAFRv_Xig7Q-1; Fri, 11 Feb 2022 09:36:24 -0500
X-MC-Unique: NS5lPdQdOO6zAFRv_Xig7Q-1
Received: by mail-wr1-f71.google.com with SMTP id v17-20020adf8b51000000b001e336bf3be7so3956023wra.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 06:36:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mUtEuWaqCGQh3IRK8HcXsRqsLNSC6YZZzta5hJkK91U=;
        b=EXcEC59rSnjwsIO85gYdW+2DZUsYRpIouYGc+O7JSBJFk0OvRXvOXmS+bs9NUxToHm
         vl8+9D3/OSHVFR1GPj2q6bD+aCG7VF3wPUuWV/idEAdWqLn8MDUAhcUuIiprv+0Hk9rx
         xKMHUctaa7bbpQIhjt6hOvwNW6rsjkSSC8K7izj1203ql6xteYT8gj2PVc+z/r3Q9Wd3
         FuzXtVXlgdpQ0EVCUHBnJHwcN1knWz+jLM4u18LVTeZHF3ihA3jtMgzm1LssBWNdzfsq
         ruusPeaMu3lmeJcxg4Zd9N5NqRYxL1jxOXIKVld3/9Yx5sEkV6lEhQOQsomWmfgDqCOH
         PcsA==
X-Gm-Message-State: AOAM531SDIgbVfC9IJ1hEuwiu0yrxWRw/gtH6T/D3VcyoCqhpm7XZqQj
        IUsXresbohJUioU1NiwlWHoTvFcDSLPyuiLzWNn781SGJ60XxJnZBIBkOkt7izd01sjP9SlLUT9
        kSiF4byItLsuO2TpH/OeOoTtHwoQc9OdL5XD7wphinR8CwDSXp8gDYmedOJ8u5+F+Zz2ok99d+Y
        c=
X-Received: by 2002:a1c:a550:: with SMTP id o77mr494944wme.121.1644590183504;
        Fri, 11 Feb 2022 06:36:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxkpykMeULk3o3z734U+NNGKDB0UPb/QdCSIArUOUfzqYPoPK1eHc9CCs2as5dGckIMzeUTXg==
X-Received: by 2002:a1c:a550:: with SMTP id o77mr494922wme.121.1644590183267;
        Fri, 11 Feb 2022 06:36:23 -0800 (PST)
Received: from minerva.redhat.com ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d13sm159759wri.38.2022.02.11.06.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 06:36:22 -0800 (PST)
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
Subject: [PATCH v5 6/6] dt-bindings: display: ssd1307fb: Add myself as binding co-maintainer
Date:   Fri, 11 Feb 2022 15:36:20 +0100
Message-Id: <20220211143620.3113464-1-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220211143358.3112958-1-javierm@redhat.com>
References: <20220211143358.3112958-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

