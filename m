Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C47E56137A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbiF3Hpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbiF3Hpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:45:30 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E2C3A71C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:45:29 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id fi2so37251261ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1bQ5xBUeicswiCyCgoWOXSzl8HXEc/zsS/C+nRnRHLw=;
        b=MqUApkH3IhdDDAQERHu8jscTu/xWLn5Y6gjqmoblfKwDcuQh0Lipffts8j53u3Fv5o
         u1RyUJkoGiP/8EDBK1hsHMOJBPVm9ACoUFvIHdK7v5uigsMbGHYH5Z7OFps0GQlwlk5b
         SqS3lJduk87pseVscd1HrlxZduxRrlfoINkNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1bQ5xBUeicswiCyCgoWOXSzl8HXEc/zsS/C+nRnRHLw=;
        b=4YtpjN69tJaMGaSfs9wj5XupmNErvxqCp5tXbYUvrAXdge/+1Y57bgzU620z7It3Q7
         oYnxr5i3Hnrp9pdh68Mc74Vh8jwDxDAUK4/FsLynuC9dSvj+eK8jI6snlP1ZhG3LYfR0
         d9OHqPCxJ645CjMC4i/igLmSVvKcVN2pnSwpsH01fiWZkDjP1hCxps15nutyySRX9Lur
         O4CJdp4ECA03LIhe1Vj0rJOmtRdff0HALiP7xstCT0g1qqTQ8PAPXBbjMiDrLlinmIC8
         iNCX/jNdAkNZJiKU5lpQFgnLNh/OXuhVUTLyyp9VS5pOKijF9Qerba8ksKcVd9s/7Lwo
         WDbg==
X-Gm-Message-State: AJIora8v9DWRdnRQFlHqwkisscKP0qD2Om0F7hXqV8JA4DN8jzM2vEsS
        zrAsjjD7Z91j7O/TOPiYkcTavQ==
X-Google-Smtp-Source: AGRyM1uCrkNlFcdv5mI1wZbzA78y48xRik4PhDZD5io5u7jyAp3cvz7Y/r51YYwfJ+xH6Rd1t9QMqQ==
X-Received: by 2002:a17:906:dc93:b0:726:a75b:f60f with SMTP id cs19-20020a170906dc9300b00726a75bf60fmr7346462ejc.564.1656575128346;
        Thu, 30 Jun 2022 00:45:28 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-58-216.cust.vodafonedsl.it. [188.217.58.216])
        by smtp.gmail.com with ESMTPSA id b13-20020aa7c90d000000b0043564320274sm12594731edt.19.2022.06.30.00.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 00:45:28 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     tommaso.merciai@amarulasolutions.com
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] media: ov5693: cleanup code and add dts support
Date:   Thu, 30 Jun 2022 09:45:19 +0200
Message-Id: <20220630074525.481790-1-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
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

Hi All,
This series cleanup code on ov5693 driver and bring up dts support, also add
documentation for ov5693 camera sensor

Inspired by recently Quentin series:

 - https://patchwork.kernel.org/project/linux-media/list/?series=64807

Tommaso Merciai (6):
  media: ov5693: count num_supplies using array_size
  media: ov5693: add dvdd into ov5693_supply_names array
  media: ov5693: rename clk into xvclk
  media: ov5693: move hw cfg functions into ov5693_hwcfg
  media: dt-bindings: ov5693: document YAML binding
  media: ov5693: add ov5693_of_match, dts support

 .../bindings/media/i2c/ovti,ov5693.yaml       | 106 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 drivers/media/i2c/ov5693.c                    |  86 ++++++++------
 3 files changed, 159 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml

-- 
2.25.1

