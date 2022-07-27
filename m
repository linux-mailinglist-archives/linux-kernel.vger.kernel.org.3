Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95819582853
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 16:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbiG0OPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 10:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbiG0OOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:14:53 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FD11CFFA
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:14:50 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i8so1500187wro.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=g0bsdzXmBDeQwJaCnAl3Ic4Pv1Ya9VI+0Ez/Tkq/nR0=;
        b=g4+0Csv61l+wftLNKrX2Q8V9MFuUCSuZuRHIgUKSg3TmZnXbcc4ig2HCSA4h+tNYfs
         do+vABP0GweZupiDr4fx3Dw1JVLzwClPdgasziO8Rc6Ynd6WBPIFZFYyHr0zyqDMSS50
         PCo5h19eImSURrigfAGakXAEjI6oyK6tT+/t3v0uOu22UBxg2ZFEOcEtYPSMXhbkbT/G
         EB6mAtC1ujP2z5aD5E/V5OTcO9snQ524aFkMbGTAzahJSvFjnsUUvWXLQux+lb9+eQuz
         cAxUGkAtBAzg7BkI7BTnA9yocLCdMvotBUia3iMhOqA2/2NC375hwmS1qiS7DXDf0YIa
         fzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=g0bsdzXmBDeQwJaCnAl3Ic4Pv1Ya9VI+0Ez/Tkq/nR0=;
        b=BIXy/T2Ni+UxzFpgTwj9Gqsv+jvnRosIocwA7V0U2986IwdLmQJiiKxbaheutOtrtX
         cSrpdtepf/BAo2mSjA5H7o41XgHvjnc3J6n2oibl0ERjWQgx3samyTJvM18GXpsWK1qZ
         qlyygjZHLU2OqzWClq6Lkp7C3rtPNsDeJT8Thb4QzppPCOCVJgWwz6qFVCMunR+mzTtl
         lOvPR5Kgt1OQkdGb2bUQgYvsF7YxHbyJWKTQkJVg359ZZPZR/zj9T8T0dUOEugIuaCUx
         x1vRHqWBXaFC6qhlBXzCZOJXi8xd6LrofrWxXHH3zYAlaXzGnBxFp0Ey2HY9yumAOH6g
         A7Jg==
X-Gm-Message-State: AJIora8O17AfR+08TDp0XZufFx9ZYjoNGV2STb5p7vJkuLEOP7QXAfty
        jqQkN2tuTXdAhnpyVWdKzL+paPyhJ4I0Hw==
X-Google-Smtp-Source: AGRyM1t40t5G293ZwrXYCAPiC3YcZFwzsnsSTe/eJK1R3ut6BMxo0gpIUrEAdcTvXc7xzaF6ijhoMg==
X-Received: by 2002:adf:ded0:0:b0:21e:5555:6f16 with SMTP id i16-20020adfded0000000b0021e55556f16mr15458473wrn.30.1658931288434;
        Wed, 27 Jul 2022 07:14:48 -0700 (PDT)
Received: from localhost.localdomain (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.googlemail.com with ESMTPSA id o20-20020a05600c339400b0039c54bb28f2sm2489524wmp.36.2022.07.27.07.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 07:14:47 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     jan.kiszka@siemens.com
Cc:     linux-kernel@vger.kernel.org, narmstrong@baylibre.com,
        kbingham@kernel.org, Amjad Ouled-Ameur <aouledameur@baylibre.com>
Subject: [PATCH 0/3] scripts/gdb: timerlist: fix rb_node access and python errors
Date:   Wed, 27 Jul 2022 16:14:40 +0200
Message-Id: <20220727141443.133094-1-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes use of lx-timerlist with kgdb.

It has been tested on Amlogic libretech-cc s905X and works fine [0]

[0]: https://pastebin.com/RAhQYh6L

Amjad Ouled-Ameur (3):
  scripts/gdb: timerlist: use range instead of xrange
  scripts/gdb: timerlist: fix rb_node access
  scripts/gdb: timerlist: convert int chunks to str

 scripts/gdb/linux/timerlist.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
2.37.1

