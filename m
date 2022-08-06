Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F7158B402
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 08:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237027AbiHFGJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 02:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiHFGJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 02:09:48 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED3420199
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 23:09:47 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gk3so8264426ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 23:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dOwmTAb/YyYu9dvtbrEUu3VG7RE6NxbTxlYgj7dPfSU=;
        b=a5mNY3fulOEL0OlxHdFGSGJzJB9w3t0CQ3SEkGhuG9XwhqNHZ3uZuP2HDeeyw2QGI3
         2tDVTsCYKNcSEbaOsihngfUl+bI3rVaXn9TyK2vEao9xf2PwyexjXRACtG6bJqMCpMT4
         DZPx7nVRls6tHbJafngLlGRakMsMF+czRLz70TCcc2KF4O4XHks45p+ENqAVPqeFzOi7
         P2i+Jm8HZzioCH1LOfxyLtIkOxAo+8R6MqivY9OVQqKWfpfw53dTX+WIzFu/1ICydsHt
         TChPjQMS6yWK1YSTH3YG/MykBU75WOj8C1EufNoKLgaMeUX2CMTmOPFuIxg7/CUQVFw2
         Txyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dOwmTAb/YyYu9dvtbrEUu3VG7RE6NxbTxlYgj7dPfSU=;
        b=d9NYjI0vDUUcZOTrdyeRnWDM83VYOr9s4JHdjNa7XXfvAPWcvFKzY6umegKPuBmyo3
         sYtBvd3SalHnbFLORjg2DJpsufiB5b/daU0n2/O0krEcp7jc/v4uyGpr1Ofvho0rOe9C
         XJ6Gjjtae2BbbR46+eRiAaW8B1H/ikt70UsmDN1UznFqleW9VFH7hqID+t0wTVqxbmpk
         2PrRUMLZE2kd7aZE3UR01f380vWUbECSL+dznpWTri6quwhlkzcsngIf0iqpz4HXXLy4
         Fp+8HiuZV+DVE9+J6M1GOmi60JNAzyua/UL1c4VPrnqJwQWmTGAzrESoCRd3Jt3PK+ie
         bAdQ==
X-Gm-Message-State: ACgBeo2oV9GUAyhRYDUiwbzc3CqhMTaNmpHlg6G/IFzwFtR1iQ5dJ8Nc
        4p862CombopbnQMRiQZWiwM=
X-Google-Smtp-Source: AA6agR613ThnWZjyEgQeGd3tVPxybmcPnYwV5sowDy4K1bxoG5SmKFYLHCdOroFIHPOqScnNzt2/8w==
X-Received: by 2002:a17:907:6d98:b0:731:2bb3:8e17 with SMTP id sb24-20020a1709076d9800b007312bb38e17mr697716ejc.203.1659766185809;
        Fri, 05 Aug 2022 23:09:45 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abba5.dynamic.kabel-deutschland.de. [95.90.187.165])
        by smtp.gmail.com with ESMTPSA id p10-20020a05640243ca00b0043a7293a03dsm1002357edc.7.2022.08.05.23.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 23:09:45 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/3] staging: r8188eu: clean up phy_CalculateBitShift()
Date:   Sat,  6 Aug 2022 08:09:26 +0200
Message-Id: <20220806060929.11022-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.1
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

This series simplifies the function phy_CalculateBitShift() and
cleans up coding style issues in that function.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (3):
  staging: r8188eu: use ffs() in phy_CalculateBitShift()
  staging: r8188eu: avoid camel case in phy_CalculateBitShift()
  staging: r8188eu: clean up comment for phy_calculate_bit_shift()

 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 30 +++++--------------
 1 file changed, 8 insertions(+), 22 deletions(-)

-- 
2.37.1

