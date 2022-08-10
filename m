Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAD358EFE0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbiHJP6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiHJP6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:58:07 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D9850716
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:58:06 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-116c7286aaaso2388076fac.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=xHVC9iyQyL4whVdcmIl9pJfPs5B/aUB5Bv6S0jmKGrU=;
        b=n6+FgFFbkhJN7ErYxopAX9As/tJ0Yy+Meho0q4DZDR+s1qmLiHNrv84NUnA3/DO5Au
         Luj8wpp73yn1eoW7QL/bgA/jgTPgw8rtqgqbnd6796AxAQIAIkyXIFCyRFhPM11BRpCS
         BA+ifxHH452PvVGMI6tOoUjR8y99hcemqGMkS6ofA1N6GKq+JZOiTryV2dlWhc3TWKn4
         yPvQ1gwLCPJJVsVDkWkkwA5TatsqxB96L0jZGRDX80CJG2CCZCs0w/1pOrANYi6gQ6QM
         f4GEXKs6Gc8HQHwsRHyaPcT6+vlroWH0mtzXGAWZtzQsT5NpggEPQWta8QA1XqyjVaud
         NcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=xHVC9iyQyL4whVdcmIl9pJfPs5B/aUB5Bv6S0jmKGrU=;
        b=dFiiS2LP41fbkOEcotXPjjOZHLSVCPtu2qQTFD/z+l0i+/TJ4837/flgzfGTP+mnBk
         zQQsG+2oi+xCZIERWtDKH0CQRN+UBwm8xLqCMr20whIqrjDq6HTxqdn44VN2Gut7cLnp
         fObpbFgTa/u1Htk8gA5mDKv2ZapCTjV0Qf5YSBUYjQG5uPVZXwKno1sypJnD4BiEtH1H
         BHYJNwm/DPM1EYbHgjZujVbd/aNL7poiu0kQPsI6c4himLnTKAdvdIWujIXbezt7Agk+
         VWhZPYlNmP95Q74+VBG742mqJ4tntyhMj75eSSS6LMYHkm39g70XjpVltZsnYJqEEwWW
         PlXg==
X-Gm-Message-State: ACgBeo0JtXOThZYAmb383sArpj5OPibGxSrwgfTNCyKoCSWE/c7OxDKm
        U6a1cbxTHh5MmTFAHT7/tiCluA==
X-Google-Smtp-Source: AA6agR566qNtPc42RYl5Iaz8vv0RSEgk2zSHx//59FNQwuP7J0GoXjN8Vs6bXJmGW6gzkbMIN1vGdg==
X-Received: by 2002:a05:6870:3485:b0:101:b3b1:ff4d with SMTP id n5-20020a056870348500b00101b3b1ff4dmr1786497oah.95.1660147086087;
        Wed, 10 Aug 2022 08:58:06 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id cm7-20020a056830650700b00636a2a150f7sm728227otb.15.2022.08.10.08.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:58:05 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [GIT PULL] rpmsg fixes for v5.20
Date:   Wed, 10 Aug 2022 10:58:04 -0500
Message-Id: <20220810155804.2837934-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.37.1
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

Sorry for the late request, I'm told that with these two fixes the validation
of the DT schemas will be free of warnings in -rc1, so I hope you'll be able to
pick them up.

Thanks,
Bjorn

The following changes since commit 7113ac825371c17c15e2d0be79d850e5e16d3328:

  rpmsg: convert sysfs snprintf to sysfs_emit (2022-07-16 23:08:47 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v5.20-1

for you to fetch changes up to 56e07c0c9e4a4b59a47a848b021a42cf203c982c:

  dt-bindings: soc: qcom: smd-rpm: extend example (2022-08-09 16:37:27 -0500)

----------------------------------------------------------------
rpmsg fixes for v5.20

This fixes schema validation warnings in the Devicetree bindings for SMD
and SMD RPM.

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      dt-bindings: soc: qcom: smd: reference SMD edge schema
      dt-bindings: soc: qcom: smd-rpm: extend example

 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 33 ++++++++++++++++++----
 .../devicetree/bindings/soc/qcom/qcom,smd.yaml     |  2 +-
 2 files changed, 28 insertions(+), 7 deletions(-)
