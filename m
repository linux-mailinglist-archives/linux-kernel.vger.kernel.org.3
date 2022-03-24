Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975DD4E6388
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350251AbiCXMp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346878AbiCXMpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:45:54 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD222387AE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:44:22 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id n7-20020a17090aab8700b001c6aa871860so5029187pjq.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8wFC9YW3CcXhHcZMHwjsfj1QBnxz6LwcdW4DyRFF18o=;
        b=NriUdSWmBtsn2giAdLdLQosCmOxQLZXzbPd7FQNTkkKWxGAXPW5IbYGnHVT3uv/pKQ
         c9vV5NGvoPftOkpkblOSNEss9ttnP4VtpVnh3PPKYg0AvGHKqlkYfiBrcQf9j1p3NPRI
         ckb6dD6KT34nZIefAwhpuSghjR4woe+De/LkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8wFC9YW3CcXhHcZMHwjsfj1QBnxz6LwcdW4DyRFF18o=;
        b=08MI9TXMfEKDIAhXruR6mTgCGhiJLnufkj/IhV+doBJcgTxfoiXHYbS0CE8PHnojMl
         SvkzYfgq8cvV10yYIjJ6hA3MVN7QHAorkvLPwLY+bQ01+qNWAiFB8Wv/B0J5IBelB9Hu
         AYbnGG1UcVE3FeWyS2rUElqWNPlmUtQMkc29Hb7Fs+4HVCud/CpueuK4QoGUgYxBb6dn
         k06xVYGwbwZQbvswV/8pjnbC5HssSwTxXw5R09SBPGBGGMLSfnKk4M87ahNkRUAXypYn
         hFaV7A5g9lTwTmbd9qhBXDF2KqKefBvMgMNBusUv39bDID5GRKZIYV8LmyaVIdKKSjyx
         0XdA==
X-Gm-Message-State: AOAM532ewV+fQOxXMthw73inuznehrqrOtWqcTLplNtbsy8PcxHRycCS
        4M3Jmok6q6xFpxgazFOA9C41cg==
X-Google-Smtp-Source: ABdhPJxoIxB2KJaE6zI+VE6S+D0JuAd+6GyosC1La9J70sxiaH8rfa0ODvZ0LyxtMx6HRcM/TNgwaw==
X-Received: by 2002:a17:902:c40a:b0:154:2302:9b88 with SMTP id k10-20020a170902c40a00b0015423029b88mr5704334plk.165.1648125862129;
        Thu, 24 Mar 2022 05:44:22 -0700 (PDT)
Received: from shiro.work ([2400:4162:2428:2f01:7285:c2ff:fe8e:66d7])
        by smtp.googlemail.com with ESMTPSA id t10-20020a056a00138a00b004fa9c9fda44sm3786924pfg.89.2022.03.24.05.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 05:44:21 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        robh+dt@kernel.org, andriy.shevchenko@linux.intel.com,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        romain.perier@gmail.com, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 0/4] Add support for MStar MSC313 uarts
Date:   Thu, 24 Mar 2022 21:43:58 +0900
Message-Id: <20220324124402.3631379-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a fairly simple series to add support for the MStar MSC313
uarts found in MStar/SigmaStar ARMv7 based SoCs.

I have been using this for years now but I held off sending it because
I wasn't entirely sure the uart was actually a DW based design.

We got documentation recently and it refers to this being a "DW UART"
so I'm pretty sure it is now.

Daniel Palmer (4):
  dt-bindings: serial: snps-dw-apb-uart: Add MStar MSC313 uarts
  serial: 8250_dw: Add MStar MSC313 quirk
  ARM: dts: mstar: Switch pm_uart to mstar,msc313-uart
  ARM: dts: mstar: Add second UART to base dtsi.

 .../devicetree/bindings/serial/snps-dw-apb-uart.yaml   |  3 +++
 arch/arm/boot/dts/mstar-v7.dtsi                        | 10 +++++++++-
 drivers/tty/serial/8250/8250_dw.c                      |  5 +++++
 3 files changed, 17 insertions(+), 1 deletion(-)

-- 
2.35.1

