Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E5750A8A3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391678AbiDUTDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391675AbiDUTDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:03:19 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4317312AE9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:00:28 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id y20so11890417eju.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fjBt4PhnxyvpQZHwHALGbz1X5a0xwh6G7fjizoTyXiA=;
        b=i6U2/yAjMOkdBidWAmcSgVDLyabaiJJu7U+VStkEjtxawmMvvbGvWob5cDMHUo7yFt
         VuPfS8hf9Dcyp2vS7vEOqX8O2ufGAPHpMRoKv3PEHyJZzLZVy+VlKS9uTNLRjbGpkvUe
         fV4PXqEFEMiu0AOTe1MLUCb4GrUVkVwFNUlxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fjBt4PhnxyvpQZHwHALGbz1X5a0xwh6G7fjizoTyXiA=;
        b=0Z3/ni5QIhv9r3zlvoS05nr9rambUjb2FJL+zH+ZfIwYycbBxquYqd+7/sZamFTSHs
         OjO1P8ycnCd1gYz9WPg3/bhOX5YEzkX+KRUqObs726qEG5ve+62weRYbC/alJSs4Zphi
         CBo4VmMUW43xxNSH0IpjcKWDsxVRcM95IpjOnbr7N5BqZ7SwtPhRaMvUpPtseQJdTqhg
         WSBtSjGkI8U8eYsp9aMQUueG/bS64KIW3SNE9BrcXOz0U+I/ys1GkuADeyLRunej/QmT
         p3kveZCcn9SM+OR8b98P/Tvlw3UlUTDYjkIURKYrieBGPVIOxYdjaUyNwozs4/nLzL9W
         t3QA==
X-Gm-Message-State: AOAM5322vvvXoBZ8dTsnl4nf0YVXQThqBq8UGSUSdkyfH+nMRjFvBhwx
        IcXAl8ec4ULEl1vk5FtjJglSMz+jB9K2Eg==
X-Google-Smtp-Source: ABdhPJwk7UF//4rit6xV+W/Nlh2a/A65+mGGNIXZIATOnnKEDUzGWzxNkS/uJ9H2oxPTGMBkIRvXSQ==
X-Received: by 2002:a17:907:8a0c:b0:6f0:180b:df13 with SMTP id sc12-20020a1709078a0c00b006f0180bdf13mr868191ejc.110.1650567626383;
        Thu, 21 Apr 2022 12:00:26 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (host-87-0-15-73.retail.telecomitalia.it. [87.0.15.73])
        by smtp.gmail.com with ESMTPSA id s11-20020a170906284b00b006e108693850sm7975142ejc.28.2022.04.21.12.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 12:00:15 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org
Subject: [RESEND PATCH v4 0/6] Input: edt-ft5x06 - Improve configuration
Date:   Thu, 21 Apr 2022 20:59:57 +0200
Message-Id: <20220421190003.3228699-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series was born from the analysis and mitigation of a crc problem
raised by an M06 type device. The added sysfs attributes were helpful
in debugging the problem. Patches that change the report rate on driver
probing, mitigated crc errors on kernel bootup. The patch to get/set
report rate by sysfs for an M12 device, has been tested.

Changes in v4:
- Add Rob Herring 'Acked-by' tag.

Changes in v3:
- Add hz unit suffix.
- Add '|' to description.
- Check the lower and upper limits of the report-rate-hz value
- Convert the M06 report-rate-hz value

Changes in v2:
- Add Oliver Graute's 'Acked-by' tag to:
  * Input: edt-ft5x06 - show model name by sysfs
  * Input: edt-ft5x06 - show firmware version by sysfs
- Fix yaml file. Tested with `make DT_CHECKER_FLAGS=-m dt_binding_check'.

Dario Binacchi (6):
  dt-bindings: input: touchscreen: edt-ft5x06: add report-rate-hz
  Input: edt-ft5x06 - get/set M12 report rate by sysfs
  Input: edt-ft5x06 - set report rate by dts property
  Input: edt-ft5x06 - show model name by sysfs
  Input: edt-ft5x06 - show firmware version by sysfs
  Input: edt-ft5x06 - show crc and header errors by sysfs

 .../input/touchscreen/edt-ft5x06.yaml         |   8 ++
 drivers/input/touchscreen/edt-ft5x06.c        | 103 ++++++++++++++++--
 2 files changed, 103 insertions(+), 8 deletions(-)

-- 
2.32.0

