Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BB4500882
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240992AbiDNIlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbiDNIld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:41:33 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5D26515D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:39:09 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id r13so8679970ejd.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kB4kilg+/jA91cTYXeFtmrlj5e57Ul2uuK4gQaNzlZw=;
        b=nKjsgM333Aqv36Jl50BZR8f5Q58KG4h1RfldtzhYuK4xT5FDh0eDV4Xo3qM5CSzz7U
         bOtGoNbyHlftPQ0y/Z8tIbJ79jQkXqEyoPvP7YPdeMD7TjxIw8CUHRouEhzyxdBa0hW/
         tLgngXExu8pkPHdL6DS09WjgrrxQ6E5G/yvL2IR3ex0o+ujLDY0ZpAV3xNr9Z6H4fucx
         UvKLUqXj3T5OVUluZxuL9tiiLWJxOWhwc2T/gAl3GEvlINdilBw2abTWvf0sDNfT2z3H
         v1mWsjSEP/nE1uB1fnH3fekvWqieAWA9CE+vytjMvu1/Mb8OZoagtCIf36Qernep1mnU
         32cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kB4kilg+/jA91cTYXeFtmrlj5e57Ul2uuK4gQaNzlZw=;
        b=MMGxzkHCYPNHFWkAGdRXLgo8tqQcMK3RujVwNIwF01QLHdViOkZT+lE6jM4tnFTAur
         +htpVCbyqbPB1+ue4G0QSfj/4OQ3UxCorkf6b2nec7m2aQs/4JU5pSwWbUKa5V36x5az
         NDp1pMW0QyacHuO4es/SbHcKnkPgAkUfsH2f0H/cuIC24bJHUR5oW6lykpNrKnJ7dKU6
         b7SGd1zZZozR0X9k9lIbvTnANkpuVNF0VIJ3YdDXbLl8l9CxeZxtOQnZpZAa0o/TOCM+
         JzeHg3/JdR4LH9HinOT0Soh4W6b1Bzlm489mYG1BJMmbA/uWsGSij7bzgLt7okh+BLaL
         Yq6A==
X-Gm-Message-State: AOAM530IYXk+wOCpZugqpbh+Fu1FotG/w5JeXSlUBSOBSihNq+4rn1BO
        a+VjBWiY4uiHV6liqAUDt60=
X-Google-Smtp-Source: ABdhPJylS83UA9NAUOMN8mCqXYytG7ayAcCQNLZ1+NLN8soWkn4QWK+JG7C5Ja+ktAorYgS8+RE4ng==
X-Received: by 2002:a17:907:7f94:b0:6da:64ec:fabc with SMTP id qk20-20020a1709077f9400b006da64ecfabcmr1395566ejc.717.1649925548124;
        Thu, 14 Apr 2022 01:39:08 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id ah13-20020a1709069acd00b006e8a0b3e071sm418138ejc.110.2022.04.14.01.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:39:07 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/7] staging: r8188eu: fix and clean up some firmware code
Date:   Thu, 14 Apr 2022 10:38:46 +0200
Message-Id: <20220414083853.3422-1-straube.linux@gmail.com>
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

This series fixes wrong size of struct rt_firmware_hdr in the first
patch and does some cleanups in rtl8188e_firmware_download() in the
other patches.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (7):
  staging: r8188eu: fix struct rt_firmware_hdr
  staging: r8188eu: clean up comments in struct rt_firmware_hdr
  staging: r8188eu: rename fields of struct rt_firmware_hdr
  staging: r8188eu: use sizeof instead of hardcoded firmware header size
  staging: r8188eu: remove variables from rtl8188e_firmware_download()
  staging: r8188eu: always log firmware info
  staging: r8188eu: check firmware header existence before access

 drivers/staging/r8188eu/core/rtw_fw.c | 75 ++++++++++-----------------
 1 file changed, 26 insertions(+), 49 deletions(-)

-- 
2.35.1

