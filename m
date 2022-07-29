Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6596B584D3D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbiG2IOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbiG2IOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:14:09 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9115F820C7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:14:06 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id rq15so1226047ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=oM46eXptfbatvoXc4tueJ2S0lHEzCvpbn6+eK+o9Gjw=;
        b=Cu08n+NMzjQKaMTXkYNop6J+Rs/nc+Zfc/M56sm33BmW2eZXO7rx7c4d9ECpwwNz3r
         oEfAqTopNg8oy7TUaGaMpgZO74hlFdG3Bg3fxim2Vz1HwESq9vJhrSJS/piVKkgBzxrG
         EfIZ5FySpeExK0u0ptq6pGahcH8h0KFFUCxpSCvUqX7dmr1CLGBFS6DxWgcoRBgm7NZM
         UmdhnsxcYvVU/6VqKMRPXodXzjTSyXKP/4DcikNLjW70ahYpfai3rv58SQZ/9CVpkQzx
         wMbN06y/p0TguRCeA1z5LQQTCZmZbf7oqmgnhLRoMytLKAOJDS9q1zJvLuPpfYZQqDpe
         vv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=oM46eXptfbatvoXc4tueJ2S0lHEzCvpbn6+eK+o9Gjw=;
        b=jpuiuiXlVGHkPFKFnaXOw0G4ZmIJoWkhXE3NLFFYRnbvImmauMV3hM7nrg6z5C/ehQ
         79oQDPhfkyIf9wSFjBqXe7lOoujuPCHBW1EKvMVrjTroI8a5GzpgQV89iE/P9R80uANK
         SRC5R3n9RZGXrdOpxg0wZ3ZuZZ7b5FLWA5w3tVLX0LhlcZ75dc4HmtCdaPHfwqnrFDan
         qYByK7jb7hySMZBlOa87vj4bnWIGmB0d6nH+ueykQrGm0jCCoQ/6hZ7aUn4ZSk7hKHIn
         SAmIDrE8RFWxWj2f+Dddl82k8hT7UH87xb/LUUoth5mXNgpaVIa4EDundiKs/yhnDjXo
         5XpA==
X-Gm-Message-State: AJIora8iZnW6eoPCHxrk5Khs59YlSDgtSBtAU0hFfFrWen/neFGwPnZo
        iOr7d3BrtumsBJqWEhhRIlSWPk7g6HM=
X-Google-Smtp-Source: AGRyM1sKlFf5DKlbm0zqhYVX1EaD2q4iDOyWD1ZRODA6ja2C5v4L9es0+Rx9uk47bjrbWAQlRBY9dg==
X-Received: by 2002:a17:907:2bd9:b0:72b:1752:aa52 with SMTP id gv25-20020a1709072bd900b0072b1752aa52mr2069615ejc.646.1659082444775;
        Fri, 29 Jul 2022 01:14:04 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id 5-20020a170906308500b0072b565507c5sm1364222ejv.203.2022.07.29.01.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 01:14:04 -0700 (PDT)
Date:   Fri, 29 Jul 2022 10:14:02 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] staging: vt6655: Convert four macros to one function
Message-ID: <cover.1659080988.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert four multiline macros to one function with parameter. Multiline
macros are not liked by kernel community.

Tested with vt6655 on mini PCI Module
Transferred this patch over wlan connection of vt6655

V1 -> V2: Combined patch "Rename dwData to reg_value in four ..." with
          patch "Convert macro MACvReceive0 to function"
          Combined patch "Add parameter to function vt6655_m ..." with
          patch "Rename function MACvReceive0 and add parameter"
          Changed order of renaming function and conversion to function
          Improved to early line breaks in patch descriptions
          Removed function declaration of vt6655_mac_dma_ctl
          Changed variable declaration in vt6655_mac_dma_ctl
          Improved patch descriptions

Philipp Hortmann (5):
  staging: vt6655: Convert macro MACvReceive0 to function
  staging: vt6655: Rename function MACvReceive0 and add parameter
  staging: vt6655: Replace MACvReceive1 with function vt6655_mac_dma_ctl
  staging: vt6655: Replace MACvTransmit0 with function
    vt6655_mac_dma_ctl
  staging: vt6655: Replace MACvTransmitAC0 with function
    vt6655_mac_dma_ctl

 drivers/staging/vt6655/device_main.c | 23 +++++++++++-----
 drivers/staging/vt6655/mac.h         | 40 ----------------------------
 2 files changed, 17 insertions(+), 46 deletions(-)

-- 
2.37.1

