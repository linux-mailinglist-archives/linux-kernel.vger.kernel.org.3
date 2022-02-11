Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFA94B21AB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348447AbiBKJXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:23:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242601AbiBKJXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:23:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15C22EBE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644571383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qo5tt7qfqFuuHdwxRe62Yd9mxK2KKNk3oIAuQuMoJM4=;
        b=C34PYzMbNnAlfRQ/lVP4jXhOVSdCEBID+yOybRmtRfbkU5iqgm6USifdFHf6yE2+iTeamk
        nd0zNFNlbXkGKqt3oyg1x6hBoSYNmPERuItnB2tqGTdKMtGOAkhu0NQy+NBIZww6yQJn5f
        Agf7Uw6khAdiuu/DF1jtDuz+d/vQkHg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-CNqavvkvMLKVlDk0G_6Zwg-1; Fri, 11 Feb 2022 04:23:02 -0500
X-MC-Unique: CNqavvkvMLKVlDk0G_6Zwg-1
Received: by mail-wr1-f69.google.com with SMTP id c9-20020adfa709000000b001dde29c3202so3630856wrd.22
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:23:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qo5tt7qfqFuuHdwxRe62Yd9mxK2KKNk3oIAuQuMoJM4=;
        b=KNFcAonwrFgWcyG28zSuPMnv4ff9ijcejvobxOON+euY9mKQnuzRM7zKgr3hC14tSB
         dcJgXgfJkQC1cOBYNiKHdI8QvW3pKLDbnCOp2f06sF+Owzh7L8MsoTHaBvrNVRaqR+zz
         k/xiM1hoBd8zYNiUzP5hLxZOtrirPAOYNj0SB4e3+rqgagkt3uEZh5dTJvrxs5nvL4Mt
         +LZlK0T2pLQnge1gY5UxN//cnAexXLnZ+Wp5dRDM9KNtpytrBmRHsGCKRN/JoEHnE6T3
         6X0gM4PJwXawdz/9Z4zfdkABnzguEl1jATAxf/keGMUUZWd9qilHgfJGnGRbtQBgwP7v
         EtZg==
X-Gm-Message-State: AOAM532U9ftXkw8gBch1qOTcvWjoMTcyrlPtBD5aYcfHxcmAk+INBKkz
        fduxS0//r2r+TlxRn5kVKsa/8DojreyG/eTDLrG7ZKS29pr/ziXBDaWCdNeQdY3Zndltu5b6+Dv
        2L4KHVSz6mJVjCU3Su1BHuJX54rWCoHosXb2AbVj/nQMOBkrgjLSkBlfNXg2tYELMZyS60H8xYa
        w=
X-Received: by 2002:a5d:4910:: with SMTP id x16mr617234wrq.360.1644571381021;
        Fri, 11 Feb 2022 01:23:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQmkhSio3XmknDv+U+BFj72PJlq29Q9DPCbv2FXY27W3811LtmWuIDulWlfqEUKhTodynTLQ==
X-Received: by 2002:a5d:4910:: with SMTP id x16mr617195wrq.360.1644571380540;
        Fri, 11 Feb 2022 01:23:00 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q76sm3795124wme.1.2022.02.11.01.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 01:23:00 -0800 (PST)
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
Subject: [PATCH v4 6/6] dt-bindings: display: ssd1307fb: Add myself as binding co-maintainer
Date:   Fri, 11 Feb 2022 10:22:53 +0100
Message-Id: <20220211092253.2988843-1-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220211091927.2988283-1-javierm@redhat.com>
References: <20220211091927.2988283-1-javierm@redhat.com>
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
---

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

