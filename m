Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB17F500B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242394AbiDNKqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiDNKqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:46:12 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1006EC77
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:43:48 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id lc2so9172167ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KBg1gZpB+ya7NnVLqElXRH341atMJVXzfkwIYoZMBOc=;
        b=YXC9aU3c2gfEzEIe/nd8bLTlcAYArbguOw94TXK58jpSy7gS4KRyL+WOnPddnSe8wx
         cF1Jl/i/EN6R3V/5FaLaxgLyWDQxu+YpXGifKo/Okn9KmzHhN8BNWDEcTj7FRAkV4rFY
         KINM2I81dadhM0dMqj7aegFzFbF/ZCuMv99+LJplSCanGcjmUqPZlJ0s4S7mikqePrWx
         a/iw2upV1rXr46z/kzY8NeIZ46LBPFUWhztu5RbIhPGQBID65yB/CpQJf6VNbHX2M2yJ
         CPSK1SGowE+6z/gdTdkoFHc4A6+nzW4oqm2TRSd2iHlnV+J+KFmjGAau+pxasnstMnyR
         pWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KBg1gZpB+ya7NnVLqElXRH341atMJVXzfkwIYoZMBOc=;
        b=yTNHmhU6KqgIeCm9RH/+6GoAsG9hfm9mLD2lyKhBx2zYEoeeeTRrHVxqCbGjghsY0p
         3Dhhu6EkCe0JvfkTOwkxPaDUrlnPg6pMjZJ+Y3FrRBhU6Q14NiXr9EWEX+oJX0y4uwbd
         eF6aWDXbPhkgQTBtD+aSFInL3y/dyQxhb9oMS7jK/n7Upwk3zhUuFPfLK67LnHKT3BGQ
         ULGY06dNhLgAI3jzC4rVzOLee2i3UnlCkMI86f30VkLYH3iupWW/jOARHFYWLU+2uuCq
         CTIjK4oEAOIftIkc0OgcSd84Qwp6jkIZqFmQlqmSPJR7Czh+t2vCo4SRvcAbyQowaTgl
         CxOg==
X-Gm-Message-State: AOAM533txZkiJTUBFMLOrbnhcVSXh+4/kKbFeOxkJ/hPFl/+n0HXgDU0
        IL6bgRx6gOgS/CPldNIrPIE=
X-Google-Smtp-Source: ABdhPJyIXbfMH1V00imxIlxsSBss6Q0tWUTrWkdG7SbeH0jr3NUeyB+x9KzEfjySaVgo76WJsqiknQ==
X-Received: by 2002:a17:906:58d6:b0:6da:bc08:af7 with SMTP id e22-20020a17090658d600b006dabc080af7mr1746311ejs.537.1649933026702;
        Thu, 14 Apr 2022 03:43:46 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id h9-20020aa7c949000000b0041b4d8ae50csm821318edt.34.2022.04.14.03.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 03:43:46 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 0/8] staging: r8188eu: fix and clean up some firmware code
Date:   Thu, 14 Apr 2022 12:43:15 +0200
Message-Id: <20220414104323.6152-1-straube.linux@gmail.com>
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

v2:
Added a patch to check size of struct rt_firmware_hdr at compile time.

Michael Straube (8):
  staging: r8188eu: fix struct rt_firmware_hdr
  staging: r8188eu: clean up comments in struct rt_firmware_hdr
  staging: r8188eu: rename fields of struct rt_firmware_hdr
  staging: r8188eu: use sizeof instead of hardcoded firmware header size
  staging: r8188eu: remove variables from rtl8188e_firmware_download()
  staging: r8188eu: always log firmware info
  staging: r8188eu: check firmware header existence before access
  staging: r8188eu: check rt_firmware_hdr size at compile time

 drivers/staging/r8188eu/core/rtw_fw.c | 77 ++++++++++-----------------
 1 file changed, 28 insertions(+), 49 deletions(-)

-- 
2.35.1

