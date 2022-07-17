Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBFB577890
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 00:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiGQWUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 18:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGQWUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 18:20:08 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6720112748
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 15:20:06 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y4so13089252edc.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 15:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=Ni55GkXtmz8IMGDR+CYFgP4mhPfwYhJDFZvT9kJS8E8=;
        b=WknUigVXY6JBY8Bww8UFrLPLQcoccIcD9UolgQxtD0vetPaYGWVtwCbbHofwzfiN7T
         /xg+qE9uSysumbJRflR6/9IbveUeEZo2RSFPsXHG9rb+I2KuQ047poOoKJeRxwjYMNXz
         +f9a9hid6vI8nw8P667mhd0WxlvyltgMyg3aCYZf91SugmY7kHHkCSQh0OwPdZjHfMKF
         erYOIA8X1pCvqfWj96dgd8U7z/Ih8KpvrrUkgsqk6J7RQdL6hjgVssG4LfAgLsX+pXus
         IUYFGAgGM3kxdHvfx3SIePVkk3qyuHoXH06uvlim5seVDwDCZaHDWMVUOnaN+1O8kGcZ
         /xMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=Ni55GkXtmz8IMGDR+CYFgP4mhPfwYhJDFZvT9kJS8E8=;
        b=kiCzg81DrG6v9SsevkHpClZ14SRJJ5IxVNnuX2L3Lg7gvY/CUFncdAgmEMHdXLWXrH
         FMlkCR9I85Cy9d+KMwiwMXPxFkfH4uJ80RgIHNY0hvfUsh+FCf23jOr1QSo7g4ox+9gs
         ogz29UUlKbgEK0e+VVBobkXKhZroPWyIfgcxEUDSAFFsK1mH4dqHjTChZ0qGvXuOkMBd
         CuLb5e406Ryx3jmYHkphVmTspXF97SSWm7w2iGatV23GTRJKyHYds3MoD8O0gmgoZ+UE
         6daVjR98C3qv+ZpN9APUUChlBTj7tRPOldj8gV33z3Z9Ah87v/ZXFFyidLgg8CZk8paL
         rXzw==
X-Gm-Message-State: AJIora8VhXp/JKHMvRNiXN55x6mCsPVj9osBS0317gsf/YhJNCld2N04
        q8afBSlq5X+m7MyqGkRstO0=
X-Google-Smtp-Source: AGRyM1s3ojKoZr+Z99ifHNLSI9ov8Mbs9MNOpe0WR1ax/vvK4eQYy+qMKHWHDXIDxvWpS5/gfkk2Mg==
X-Received: by 2002:a05:6402:1003:b0:43a:75d8:a0e with SMTP id c3-20020a056402100300b0043a75d80a0emr34028761edu.303.1658096404863;
        Sun, 17 Jul 2022 15:20:04 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id n23-20020aa7c697000000b0043a71c376a2sm7445710edq.33.2022.07.17.15.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 15:20:04 -0700 (PDT)
Date:   Mon, 18 Jul 2022 00:20:02 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] staging: vt6655: Convert four macros to one function
Message-ID: <cover.1658094708.git.philipp.g.hortmann@gmail.com>
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

Convert four multiline macros to one function with parameter.
checkpatch.pl does not accept multiline macros. 

Tested with vt6655 on mini PCI Module
Transferred this patch over wlan connection of vt6655

Philipp Hortmann (7):
  staging: vt6655: Rename dwData to reg_value in four macros
  staging: vt6655: Rename MACvReceive0
  staging: vt6655: Convert macro vt6655_mac_dma_ctl to function
  staging: vt6655: Add parameter to function vt6655_mac_dma_ctl
  staging: vt6655: Replace MACvReceive1 with function vt6655_mac_dma_ctl
  staging: vt6655: Replace MACvTransmit0 with function
    vt6655_mac_dma_ctl
  staging: vt6655: Replace MACvTransmitAC0 with function
    vt6655_mac_dma_ctl

 drivers/staging/vt6655/device_main.c | 25 ++++++++++++-----
 drivers/staging/vt6655/mac.h         | 40 ----------------------------
 2 files changed, 19 insertions(+), 46 deletions(-)

-- 
2.37.1

