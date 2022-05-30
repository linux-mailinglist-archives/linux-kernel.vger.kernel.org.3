Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3961537662
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 10:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbiE3IJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbiE3II7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:08:59 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEB2644F7
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:08:54 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q12-20020a17090a304c00b001e2d4fb0eb4so3215147pjl.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ktUZ7Jayji8WcqStkjl0qUGO7i4FHkmNzMUAUMXluTg=;
        b=KuTdqisqGYSWAu9SpxFOYy6qtFuiRMNGCggpOV+CbFXI4ZSeUon0O8i81XddsFFMJU
         F/nhFSVsFdL6K6S5zZDT2gWQiyi2uQfS4h7PGa2eyEbK46NkZ2eRVKw5vGz+TOIi7Fde
         I7N3j6JrIzC03AKojxk+3NXLtx0hMP4kIsAJwvSsF69vwDC1gx7jZEkTDoFqR6AsWJID
         wyXYMeqB/ZlYcce12VPnEu/TV61dqeQj+bEwmGEiREeznbKsp7JEx5otKBToddC/Jdz1
         keQ0DMZzMJDvefRKjIhL+UwV07DWFn/06fmGfLTactx2RV2muBxrIsfTqQi5WsiH0i7n
         2O/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ktUZ7Jayji8WcqStkjl0qUGO7i4FHkmNzMUAUMXluTg=;
        b=K3dLqK+6SBciJ/juxsFOOZwnwN1z9bbMO7g74eLmqileOWHanhoYwivREjUsnf5nco
         cv8rxvGE+8clecLR7FtrwbuP2PUo1WFa/+iFofEovOjsghTVMCHGS8GSsWmliFSxMgmV
         psw/v0TiZo7YVC5F4Zu6RS7DFk3hUHTnVimeLWJYU6QO35G9hJaMOJHhEIlLPNQCcqKP
         leMHXSqe7+I9rw/sYHhMrTFIX1x2H74t55HubF38cFzzhwFnlYfPHcRvpOcpa1SU1bkJ
         CMRoPmZuSy2PhrgxJm61WccdK7I6jOy+hbLvLgh+krImRdGjqQfBiiAfvTE3qsnohnpb
         BP1Q==
X-Gm-Message-State: AOAM531Uln4TaVn1S7U/n/AhkYcjs84cO6CXywB2C+QQKS9PMiuq9E3v
        uxUG3COkEkh3uIk8gDnEsEeAt1FF/K71
X-Google-Smtp-Source: ABdhPJzpye3BIRyeRcfZKMgh/enut/RYAKyDccJEWHc1q3Au19MJ6OtkkdKME793c6nbw7YIkrGV7g==
X-Received: by 2002:a17:902:f543:b0:161:9f00:7b2c with SMTP id h3-20020a170902f54300b001619f007b2cmr55193063plf.1.1653898133768;
        Mon, 30 May 2022 01:08:53 -0700 (PDT)
Received: from localhost.localdomain ([220.158.159.114])
        by smtp.gmail.com with ESMTPSA id io17-20020a17090312d100b0015e8d4eb285sm8450345plb.207.2022.05.30.01.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 01:08:53 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     tglx@linutronix.de, maz@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/3] Check for IRQ trigger type mismatch in __setup_irq()
Date:   Mon, 30 May 2022 13:38:39 +0530
Message-Id: <20220530080842.37024-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Hi,

This series adds a check for detecting the IRQ trigger type mismatch between the
platform (DT) and a device driver. Currently, if there is a mismatch, there
is no error thrown but the driver requested trigger gets set silently. Then
during the second time probe of a driver (due to probe defer or rmmod/insmod),
platform_get_irq() throws a warning similar to below and fails.

irq: type mismatch, failed to map hwirq-9 for interrupt-controller@b220000!

But ideally, during the first time itself, request_irq() should've failed as
the flag mismatch is a hard error. So let's add a check in __setup_irq(), such
that the request_irq() would fail if a mismatch has been detected.

NOTE: This might break platforms those has the flag set incorrectly in DT. One
of such case is SDX55, where the UART node has the trigger set incorrectly.
I fixed it in a couple of places I happen to know. But there could be many...

Thanks,
Mani

Manivannan Sadhasivam (3):
  ARM: dts: qcom: sdx55: Fix the IRQ trigger type for UART
  arm64: dts: qcom: sm8450: Fix the IRQ trigger type for remoteproc
    nodes
  genirq: Check for trigger type mismatch in __setup_irq()

 arch/arm/boot/dts/qcom-sdx55.dtsi    |  2 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi |  8 ++++----
 kernel/irq/manage.c                  | 14 ++++++++++++--
 3 files changed, 17 insertions(+), 7 deletions(-)

-- 
2.25.1

