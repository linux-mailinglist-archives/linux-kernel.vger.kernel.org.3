Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1B9585AE8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 17:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbiG3PGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 11:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiG3PGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 11:06:50 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC84413EA3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 08:06:49 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a7so135429ejp.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 08:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VsL98Lrs98Wy38pw5pkmOgCJAyFL+RwwzHJiWxEvQRQ=;
        b=iJAOKYO34qCePC3M1xT48SeEo0Edz2Cz0mC0NEJXVTy1qBZggD1UmHK1z9ZLXd+2Dc
         TxWp9pJAVZHL68yMax9WuXOegSieaKwxo5auKVyZaTIOdyeSAMOAIWP0JxLA+igLA7BF
         sZ9B3WyAOU8bDmGB5gZWdy0DOfmtbr/zaE2waxZzRYK2B+nM7D9/Pvq6JEluFj7S6xMT
         52pzUSaxtMITmfLcwsnnoW7vNWzvOhRbejPcdS/QtCBHTX6xddiZMSYkzl18lX0XZ+V7
         Uj39htufud211Ka+liB7qnL/qfD3nyeRJTi7Kv5rHg+d+K3beU0msYEnQHIj4fast+cO
         qOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VsL98Lrs98Wy38pw5pkmOgCJAyFL+RwwzHJiWxEvQRQ=;
        b=LxjhkdpKd0YvWho9yZXhIF3H/KRkm5lIbmrOE+JljJJED6sqNo712bA+RH4T+iGoFC
         1KJnBxywM4H+mLeg52HaAE/DRrNvn2ATqgTELYriLpx5AoAnlBiJ87wlX+dPnnTC+vrm
         4oeWu3u+oXTIuoGk9n2H3mqyjmcM0sH1K330o598sA76rG+BzzNIaSJhsf3nd5VFSDrX
         e0ucRHGeyjrhnDpwoVleUUKk5VoSb8RAHbFogTPgdNH2kzOr/iCef++dNNEc8CJZdX3L
         eJf0EWHu6dxo/yUXeNJ6zT2huqKXH6cfZYFFAiE9vAyh0QkQk/XiuBFoxdO1r94xvod1
         mu/w==
X-Gm-Message-State: AJIora+hxjPhjRROWIOdu1+z4cFgrdrAgJkhd6OdYu+m1i828aojofBG
        f5D74wrij5aYZGL6CKqXFe5VMgLi1A0=
X-Google-Smtp-Source: AGRyM1unkIJ9uUdveVgDU0EeiIYPA/8KEn6ZCbM6LKRyh6dzQzN8tH4rAY2//VQwdUMPheVaeo9nIw==
X-Received: by 2002:a17:906:8a44:b0:72b:3bba:e867 with SMTP id gx4-20020a1709068a4400b0072b3bbae867mr6659970ejc.752.1659193608211;
        Sat, 30 Jul 2022 08:06:48 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb9e.dynamic.kabel-deutschland.de. [95.90.187.158])
        by smtp.gmail.com with ESMTPSA id sy13-20020a1709076f0d00b00722d5b26ecesm3013989ejc.205.2022.07.30.08.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 08:06:47 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/2] staging: r8188eu: clean up dump_chip_info()
Date:   Sat, 30 Jul 2022 17:06:35 +0200
Message-Id: <20220730150637.3550-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches clean up the function dump_chip_info() as suggested
by Greg Kroah-Hartman and Joe Perches.

Michael Straube (2):
  staging: r8188eu: convert dump_chip_info() to use netdev_dbg()
  staging: r8188eu: refactor dump_chip_info()

 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 37 ++++++++-----------
 1 file changed, 16 insertions(+), 21 deletions(-)

-- 
2.37.1

