Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E814EB4A9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 22:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiC2UXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 16:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiC2UXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:23:34 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A5D12221F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:21:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id p15so37397417ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aGUeIhIlqrmJCyD9+oOrQ5s+iflJJ+7myFcwnSduBIw=;
        b=WyRgy3/lZ7Tbr5Of7/54vktujTA+sfTmiUJeTZJW4Uyts1els4oPKF959+mUVN7kQF
         /lEOzK/TsuSN7zc50KyiogIqbH5ACGh6cpYwJLR11F2J2c0qo2XHn3e0VQohVbhPjcBL
         wFa5LaIOP7wZt82CF9GbcT06Boch12lgoHrebNdzcvszdcYbPbEQD3JPTolo160wa9iW
         s9Ju+bEA4UjEAW75PRyFuqroodrZ/XBuihyYXiZeLcr+n9ZZ4MugN0xQdpZ1yjZt6C3K
         iw6C0jzhxbvOp9HXz85Ylf7qxCLC+IzkmUQSIKgZHSpiRPRrpFC31yFtaNYronzjGvl5
         nXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aGUeIhIlqrmJCyD9+oOrQ5s+iflJJ+7myFcwnSduBIw=;
        b=UBSWjuqymSQP+UljOV7jl3rgmzisTxZH0kgXFZ90vQ8jpHzBUVZyJYGuWRKSFXJBID
         5YKQYHAEFo6WpFUu4ytmRgLs2VCveOtUviiXR1XO/r/3RORm/eqQT4pq7k+F0VPoyNPM
         vcuk0eP41q5hzV5T1WyWDS6YzfR1CYGrUh9AtIVtf6JnT7woVTD+ix2J3+5AM2ztv1Ko
         DX7NBWysHqz2HldkjRJaEVnqmS8bvG1gJ3t/7Ms2Gh2k0f1fyOFZyvtXO+GIxRTYSb1Z
         RXYQ+8XVLxxfkv6b8VnhWNKdMWpK4owpRhqtb8dC3gcIrNTIdbKutxO0JZiAKoZIeqyO
         ANlg==
X-Gm-Message-State: AOAM530dLgQCA1ey+xvhNPFUx6/G8jgFk4V2XSEohj+VbwiPEbUpxssd
        hItYc2csJSa6IM6pkOtZ8EQ=
X-Google-Smtp-Source: ABdhPJz8hHXvUVF6ar0Kwk8uUKvrtkO9Fjp9PKjI1G7G9bP1nLt1iFX5qjdllXRPV71/khuszy3eFQ==
X-Received: by 2002:a17:907:6ea4:b0:6e1:260e:a232 with SMTP id sh36-20020a1709076ea400b006e1260ea232mr10819255ejc.15.1648585308803;
        Tue, 29 Mar 2022 13:21:48 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id ss12-20020a170907038c00b006e0ec9e806dsm3938111ejb.136.2022.03.29.13.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 13:21:48 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 0/8] staging: r8188eu: SetHwReg8188EU() cleanups
Date:   Tue, 29 Mar 2022 22:21:33 +0200
Message-Id: <20220329202141.7028-1-straube.linux@gmail.com>
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

This series removes some cases from the function SetHwReg8188EU()
and moves the functionality to the callers. This is part of the
ongoing effort to get rid of the unwanted hal layer.

Tested on x86_64 with Inter-Tech DMG-02.

v2:
Moved some code into functions.
The series is based on todays staging-testing.

Michael Straube (8):
  staging: r8188eu: remove HW_VAR_RESP_SIFS from SetHwReg8188EU()
  staging: r8188eu: remove HW_VAR_MLME_DISCONNECT from SetHwReg8188EU()
  staging: r8188eu: rename some macros to upper case
  staging: r8188eu: remove HW_VAR_ACM_CTRL from SetHwReg8188EU()
  staging: r8188eu: remove HW_VAR_RXDMA_AGG_PG_TH from SetHwReg8188EU()
  staging: r8188eu: simplify if-else statement
  staging: r8188eu: remove HW_VAR_TX_RPT_MAX_MACID from SetHwReg8188EU()
  staging: r8188eu: remove HW_VAR_BCN_VALID from SetHwReg8188EU()

 drivers/staging/r8188eu/core/rtw_mlme.c       | 36 ++++++-----
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 31 +++++++--
 drivers/staging/r8188eu/core/rtw_wlan_util.c  | 38 +++++++++--
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  5 +-
 drivers/staging/r8188eu/hal/usb_halinit.c     | 63 -------------------
 drivers/staging/r8188eu/include/hal_intf.h    |  5 --
 .../staging/r8188eu/include/rtl8188e_spec.h   | 10 +--
 drivers/staging/r8188eu/include/rtw_mlme.h    |  1 +
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  1 +
 9 files changed, 87 insertions(+), 103 deletions(-)

-- 
2.35.1

