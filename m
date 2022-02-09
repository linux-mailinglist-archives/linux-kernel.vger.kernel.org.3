Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A104AEE61
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiBIJoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:44:15 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiBIJoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:44:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24F9DE06A602
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 01:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644399609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HkjkJCV3RnHyv5DSE+jtNb73ClQ4fv7HXl/dV01kYKA=;
        b=bC/4gKYS6sT2hAWsps87ucYKPUMCaEA72CXkrCkX2Qj2hBk8sV/FCDNUlt1TcipAZwaPcX
        jGHEWGTTmflXCnZjb8YTMSCFRm8u7zHCuQocXiblRdNOOSOdOokHjPYtl0yR52qrUxDNFs
        yxrvUdt+X59TykT4isw5+4zklhmIJ4I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-kOzwFI8MOgOsnHzbSMiIzA-1; Wed, 09 Feb 2022 04:13:57 -0500
X-MC-Unique: kOzwFI8MOgOsnHzbSMiIzA-1
Received: by mail-wr1-f70.google.com with SMTP id c9-20020adfa709000000b001dde29c3202so833707wrd.22
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 01:13:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HkjkJCV3RnHyv5DSE+jtNb73ClQ4fv7HXl/dV01kYKA=;
        b=x2DGWRCAjoHIIL4yqazupyep0VVbFI+cAfGjHkT+JE9fJGT69EZZbFO4xD8T9382Wo
         d7j2jL39X5nqUhhyjvQhURpsqP088gWIDcOHejtYg4EAnbgvHVGENrOwW3D0V9ZQHyV4
         ulFW58wwVIZl8AeQRSe4SZfccL6tpsiyjew0CcBHhTREx26KZvFOsD6KY7VktWtn0R4B
         UrQchgExomcZ18U8HPgt4ujrmkN2Ni/a4dm25U8BPcDTNqI4QMcVqztsjeeuPT8BIn4z
         5JUJdhw8YDTouHqRRVSx2bFbyxRGVQgmTbFHSkBgAodsK0Y7jIkaQKhwVoUopEdJSoSz
         RgDg==
X-Gm-Message-State: AOAM530HKj5VkEyOWXrQ1dWn55ypr0wlDTO3aIxspAdxEhBo7cXTxXgf
        bbt2C33w4HMDLAOivRHmi/soJAv0HvNICUjPEYY7C3uLqU482jnJtktgjObjDCOj7UMfehtRH7m
        WytjV6q4x+8aSAYRydXqol4Lf8tX7mDxzn351JvhMP/tjqHuveekAyeFbwMR5aOaGI8ozReZ2Pd
        Q=
X-Received: by 2002:a5d:53c9:: with SMTP id a9mr1221614wrw.672.1644398035804;
        Wed, 09 Feb 2022 01:13:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwN9IG1QALjH1ZUKqnf6ckKETjeoTD+yjoTXUPxM8Hq+sCkIBChwrk3c3nzhT8/h+bVv4FVsQ==
X-Received: by 2002:a5d:53c9:: with SMTP id a9mr1221588wrw.672.1644398035459;
        Wed, 09 Feb 2022 01:13:55 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w6sm13557623wrp.51.2022.02.09.01.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 01:13:55 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v3 7/7] dt-bindings: display: ssd1307fb: Add myself as binding co-maintainer
Date:   Wed,  9 Feb 2022 10:13:44 +0100
Message-Id: <20220209091344.2513662-1-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209090314.2511959-1-javierm@redhat.com>
References: <20220209090314.2511959-1-javierm@redhat.com>
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
---

(no changes since v2)

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

