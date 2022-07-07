Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCCE56A8CB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbiGGQ7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbiGGQ7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:59:30 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19A223BD3;
        Thu,  7 Jul 2022 09:59:29 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id bf13so6542063pgb.11;
        Thu, 07 Jul 2022 09:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aCuy9HCuGOb/4o/JB1pE/O8o1Pj0qs6rlMMSXSwX4gQ=;
        b=oeWLvkGc74pEhVPGeRO4qxrGcwiWQtMrCyKy3h/uVtGGaP6vElja2Vr6sT+lqYUsbY
         SUH91UjIgU5ryiVWbKb7/RxdiQ1YqHf0ePPPvQ/auhjzA7Ec6YizG00e5KE1iDHro2VF
         yQuHUtPvcdXHlI/0yly1ZnSpyASWFPD5WgQyGXCB6fOYhUONQoPbJL0l4wJXeslK8Okn
         uTW4rcaFLIAZ9j8qHbiozGjtK/rfOiw/1VVzaeF9xHCZZ2wdZd78Z3vo+Rem4kc4wqUY
         oJRJ/OviUEf0fUevLlqCQmW0QDlSDaKyQlk4TUya+vv/EU6wI5JAk/K4bIanxSwCOmsn
         RwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aCuy9HCuGOb/4o/JB1pE/O8o1Pj0qs6rlMMSXSwX4gQ=;
        b=fFdBnT4k/PdlGzUcYMI14Y4BmpgwWNb5ZwtdVqnJIgENShZQfTIjd9v+ysNCeth/R6
         wxMmBUX5EPDX2zAVCh9tBLUjeJpWTOVEOPpUBZdyj1psNv0daDIa95e3dNhULYFNKRCz
         NB8In03yDOtgLZnVxKECMXwkhZnvzidGc+uYK7nqrSTysODs7SEUF8AWJ36hEmSQ79zS
         LZmPrArRknLKwnikxbsdTG0pg+mEr16gZeKGrWCf4hy7BjSZvmidlxjUyfsM+qLKsEOJ
         as8LSFzifeXsQrnwuguuBAMfmZR4fkesz1qY1Ca5t8TWAfeJcux5ZRkj/WzV2iw9Lokw
         nt8A==
X-Gm-Message-State: AJIora/t2VZFFDWjLkh62sFaO3uDWkixDPooformNJFE2JXcMUAV4ptb
        WdafpHNyTw97rcvV60RuBq8=
X-Google-Smtp-Source: AGRyM1tqHHvSjFqOODZz+u4tzjFjlRbky2Awv11XBgWQmDqOEr7/h909XjWVppBPflLvsJREx2bY5g==
X-Received: by 2002:a65:6e96:0:b0:415:5973:b4f4 with SMTP id bm22-20020a656e96000000b004155973b4f4mr1109950pgb.568.1657213169193;
        Thu, 07 Jul 2022 09:59:29 -0700 (PDT)
Received: from jaschultz-Thelio-Major.corp.microsoft.com ([2001:4898:80e8:37:6a04:c27c:dcee:eb11])
        by smtp.gmail.com with ESMTPSA id v14-20020aa7808e000000b00518e1251197sm28184185pff.148.2022.07.07.09.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 09:59:28 -0700 (PDT)
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
Subject: [PATCH v5 6/6] Enable building drivers/hid/spi-hid as a module
Date:   Thu,  7 Jul 2022 09:59:02 -0700
Message-Id: <20220707165902.3184-7-jaschultzMS@gmail.com>
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

Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7d1105343bc2..731fc6e67f31 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -848,6 +848,7 @@ CONFIG_SND_AUDIO_GRAPH_CARD2=m
 CONFIG_HID_MULTITOUCH=m
 CONFIG_I2C_HID_ACPI=m
 CONFIG_I2C_HID_OF=m
+CONFIG_SPI_HID=m
 CONFIG_USB=y
 CONFIG_USB_OTG=y
 CONFIG_USB_XHCI_HCD=y
-- 
2.25.1

