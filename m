Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C524BA68D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243481AbiBQQ4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:56:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243467AbiBQQ4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:56:21 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CE12B356C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:56:05 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id k25so8742254ejp.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X8eXZNrFFHAWkiQ5+tXhP7f4uollds+AL1jwIVekCuU=;
        b=bI+UATg0tE4/Gkr3cqjYageoYSoGeKk5faPV5PUER65RTUL1poIOHCtyeOE3ao6aRy
         himMFeDmCgHg6n90KTDJTQKE2WKWPAM0ykFen/46sqa/fGLaP2rOVmnejHRZj4LzQBq2
         CoRvThua47IS3+b40vhVMC3KNcd7RaHO8BQoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X8eXZNrFFHAWkiQ5+tXhP7f4uollds+AL1jwIVekCuU=;
        b=Jr95npipBzL2NBX+ofqUYqHysT5PnWjQaGd9alIX7fPhAZdhCuOpm+Cm9V1tfNkkfn
         YggoWiGh15o9kLdo2T2CaC88xmFsX5c7ry2wpfc1dV8km1pbSnM+YSVFViw0hN55IrJ9
         D0zb8lV39BYWBKD63QlLBSdAa8eM6XSdOywq1nhlm6iIHTe6HhvJymt/jRgHrp32UNML
         l3Bjv73eoXQ3cYFXnFxtFv2hT1MkAGOs4rfy5f6/YyqCL3f29mudSaKiOydNXlf3F+dU
         DS3kG3jNnMk6Oi2vcFSxEVVQ4dy6yvTTl6nXWQwjKGRRPpDM+yoRrkxkUMNYrSfqqfZB
         Ecjw==
X-Gm-Message-State: AOAM530Z3cl05NAIOjxfLhZ8HIi7IFlAiRnBNAJu0p17iwB5i5OfaupM
        Pu8jiMIIz0iZkHYCbshxhnSMn/rRpwYC9w==
X-Google-Smtp-Source: ABdhPJwxrNlK3b7zF7xBUXs57Q5KKEMkjcHArJccdDpvsgJFcScD61UYUp7z2vxiF2gjklAgKS+4tQ==
X-Received: by 2002:a17:907:174b:b0:6ce:70ef:85a4 with SMTP id lf11-20020a170907174b00b006ce70ef85a4mr3044023ejc.486.1645116963645;
        Thu, 17 Feb 2022 08:56:03 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (host-87-0-15-73.retail.telecomitalia.it. [87.0.15.73])
        by smtp.gmail.com with ESMTPSA id v4sm965323ejb.72.2022.02.17.08.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 08:56:03 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH v2 0/6] Input: edt-ft5x06 - Improve configuration
Date:   Thu, 17 Feb 2022 17:55:52 +0100
Message-Id: <20220217165559.313366-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Changes in v2:
- Add Oliver Graute's 'Acked-by' tag to:
  * Input: edt-ft5x06 - show model name by sysfs
  * Input: edt-ft5x06 - show firmware version by sysfs
- Fix yaml file. Tested with `make DT_CHECKER_FLAGS=-m dt_binding_check'.

Dario Binacchi (6):
  dt-bindings: input: touchscreen: edt-ft5x06: add report-rate
  Input: edt-ft5x06 - get/set M12 report rate by sysfs
  Input: edt-ft5x06 - set report rate by dts property
  Input: edt-ft5x06 - show model name by sysfs
  Input: edt-ft5x06 - show firmware version by sysfs
  Input: edt-ft5x06 - show crc and header errors by sysfs

 .../input/touchscreen/edt-ft5x06.yaml         |  8 ++
 drivers/input/touchscreen/edt-ft5x06.c        | 81 +++++++++++++++++--
 2 files changed, 81 insertions(+), 8 deletions(-)

-- 
2.32.0

