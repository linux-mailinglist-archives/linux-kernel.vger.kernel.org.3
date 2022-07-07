Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655A456A8CA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbiGGQ7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236330AbiGGQ72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:59:28 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7F11F629;
        Thu,  7 Jul 2022 09:59:27 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 23so19582156pgc.8;
        Thu, 07 Jul 2022 09:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mouOf2yAGvzJretTdCLBZi7N9va1QAabtNdEx7dOaxA=;
        b=Iy06ZYNTT2bDPb3p26fQ1eLYPMR1Pfuej5t6SevUQcccl5Lf2yH7jGv/eRdB0SrGoZ
         n3HgRlZd4H8DvQKLEmTIR9zQQoL7zeUbHkifv0bN/i3f3n413ely87lB3uImJ6M5Y/9V
         3zVoc8ssOi7Pp8RDPDCBNHngpchR+S7+RXsm9k0LDq2q5IxZPKh99yWve6IJyQIOwwIt
         bTh2urfAxauiKwEN7SfwNumJgEPIJd43h40ptT+Zay81OCik+yZBubzm7HixxJWX8pyN
         S3nSEhHkhI/BQbqfbW/xItKbsOVj5//o4/KNV9ySCNnxnvz8CKcuMWMqtCaaxfFNx/cg
         Uymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mouOf2yAGvzJretTdCLBZi7N9va1QAabtNdEx7dOaxA=;
        b=WyIzBdE9otzFDeJ8ELZxs9BQd31P2B8XFKDrC+vgJ/yTKp9WmxdU3YbV9OnjvrcRrj
         +AyHGFTxB9Cx1cBJVGXqLzZ6FnyeyNOr8PGGyRv4jJYRUijQSYHYZSMsyHSu1KN/lEsw
         uk/nCM/nz4wqRWFnRPsxbeW8jPk+LhVLScNvE+s5RGGXNjiHR4604draA1oT7vOsv06O
         0vKy8z8Edxl91dyhnFJEzWMjCEUl1HHoelciZ0J0At1BH7FoJjHi4bXOsAQJ6CfrXpK4
         gPVSTwRR5nsCeClU7+siF8zrDAgeAgETfu/B+ujmhPIyVTiSqi9QcVimZtu+hL8KQXJp
         GPzA==
X-Gm-Message-State: AJIora/qo0l0Jc89Ej/lioXSekbOD/Gd9EJ/XAiEXAh1zPirY+0FJRON
        pG4HGB9L5H9Q58TuSzRZ690=
X-Google-Smtp-Source: AGRyM1sqcCTln+QfjvynadCg0/JVQxDlFzJBICdvbGJkQLTJgO7dthIug1H0T4b1oVJhKKoKKDJXsg==
X-Received: by 2002:a17:90a:bd92:b0:1ef:82d8:f2b9 with SMTP id z18-20020a17090abd9200b001ef82d8f2b9mr6051221pjr.83.1657213167120;
        Thu, 07 Jul 2022 09:59:27 -0700 (PDT)
Received: from jaschultz-Thelio-Major.corp.microsoft.com ([2001:4898:80e8:37:6a04:c27c:dcee:eb11])
        by smtp.gmail.com with ESMTPSA id v14-20020aa7808e000000b00518e1251197sm28184185pff.148.2022.07.07.09.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 09:59:26 -0700 (PDT)
From:   Jarrett Schultz <jaschultzms@gmail.com>
X-Google-Original-From: Jarrett Schultz <jaschultzMS@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Dmitry Antipov <dmanti@microsoft.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jarrett Schultz <jaschultz@microsoft.com>
Subject: [PATCH v5 4/6] Documentation: Correction in HID output_report callback description.
Date:   Thu,  7 Jul 2022 09:59:00 -0700
Message-Id: <20220707165902.3184-5-jaschultzMS@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707165902.3184-1-jaschultzMS@gmail.com>
References: <20220707165902.3184-1-jaschultzMS@gmail.com>
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

From: Jarrett Schultz <jaschultz@microsoft.com>

Originally output_report callback was described as must-be asynchronous,
but that is not the case in some implementations, namely i2c-hid.
Correct the documentation to say that it may be asynchronous.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
---
 Documentation/hid/hid-transport.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/hid/hid-transport.rst b/Documentation/hid/hid-transport.rst
index 6f1692da296c..2008cf432af1 100644
--- a/Documentation/hid/hid-transport.rst
+++ b/Documentation/hid/hid-transport.rst
@@ -327,8 +327,8 @@ The available HID callbacks are:
 
    Send raw output report via intr channel. Used by some HID device drivers
    which require high throughput for outgoing requests on the intr channel. This
-   must not cause SET_REPORT calls! This must be implemented as asynchronous
-   output report on the intr channel!
+   must not cause SET_REPORT calls! This call might be asynchronous, so the
+   caller should not expect an immediate response!
 
    ::
 
-- 
2.25.1

