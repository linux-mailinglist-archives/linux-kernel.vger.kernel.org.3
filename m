Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C5A4D7069
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 19:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiCLSnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 13:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiCLSnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 13:43:13 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944B86A019;
        Sat, 12 Mar 2022 10:42:07 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id s25so20445313lfs.10;
        Sat, 12 Mar 2022 10:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b55LCMkhp264TmQP51h/ZIvxnLYYXWKUvwb4L66CZlA=;
        b=Y8tNNNxJ9veM1vUsWyMvuqwsP756l+1Va1viWJeEl4MNn7vWx9Jy+5fPSBqym1J/6r
         /Sic1ChYNa59HhWWX61eA3j94pAvEFsxsi56+25o4JCBQqK1AhogY6eKlAQnSkxnxu2K
         OhrCMB9Vu5zSkyaLwi22Ob2OavkGF6aWQHSNyf4IT+INoLG6eXEaFDmkhx5cbC+b0x4u
         geIicvNDaHGcpBcrHiGlZn7jx2eqDKFwJGSPrPCIWi2lLxpLaOnCj6X5C6DlkHStYY7t
         DdX23zEvXhcwU7tEMxU/9pi0oLRi7i0WAcSKec87mMv4fcx7OIpd3Vs0r4V9vUZ5I9FS
         hOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b55LCMkhp264TmQP51h/ZIvxnLYYXWKUvwb4L66CZlA=;
        b=j8aCh1wwrsFfI/qt9XuU96jdR8rBr91P4DeYRJ/yJSxY+Ap34m1iglJqMBcUfmvmUo
         EJ+Tq1j7mSQuv/bgYNNAdRpV9tYb/V5l6lZH+OD4GZ4lDJOv/88NuIZE6oJzwLujG4+Q
         9sR1m+7SbKkZWPz3yGi6iTf2eZpQJULzv3R9yo1uM4jleJ7Lp2HiWwIffIXqF0+Z3njv
         Y5S21Zcb1HIIytIZbuaRreUg9+ebGjGqjmxtPFv0z3+1V0YWYTUc1xrveFrZjaJ4PMc/
         G76C+tvoYHKFK5wkPAY64WtJnrwzPWZ43BmQEuTLS+bz7m1IJ9FNJ2EeUXFfeyzIzIRo
         Yz7g==
X-Gm-Message-State: AOAM533T947WWy2Nz6+104V+IKB5JOt9/xflG887gP13SQEwyKduOJkz
        aHH7FQpOFIyYanZxPSNuYSrmquzVfmjMfBKl
X-Google-Smtp-Source: ABdhPJyvzDBUgCjC5xEwO8lH0I8NchXV44z/pltS4lJSaO91RQigadrLJyR8unoNXTWLczrvjqXlVQ==
X-Received: by 2002:ac2:4e64:0:b0:448:5df6:5938 with SMTP id y4-20020ac24e64000000b004485df65938mr8893111lfs.402.1647110525723;
        Sat, 12 Mar 2022 10:42:05 -0800 (PST)
Received: from localhost.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id b1-20020ac247e1000000b0044842b76861sm2311236lfp.140.2022.03.12.10.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 10:42:05 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos-upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v1 0/2] Add support for SM5703 MUIC unit
Date:   Sat, 12 Mar 2022 20:41:52 +0200
Message-Id: <20220312184156.24912-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
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

This series adds support for MUIC unit of Silicon Mitus SM5703 MFD.
The MUIC unit re-uses the register map of SM5502's MUIC unit.

Markuss Broks (2):
  dt-bindings: extcon: bindings for SM5703
  extcon: sm5502: Add support for SM5703

 .../devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml | 5 +++--
 drivers/extcon/Kconfig                                       | 2 +-
 drivers/extcon/extcon-sm5502.c                               | 2 ++
 3 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.35.1

