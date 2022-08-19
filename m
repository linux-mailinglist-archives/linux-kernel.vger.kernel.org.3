Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3DA599C6C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349171AbiHSMzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349246AbiHSMyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:54:53 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E48675FEB
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:54:40 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a7so8673684ejp.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=KfYI7x2n+dPKcoeo3/p/jfkeVeouaOocnFlGHnujIGM=;
        b=nT+J9Cm3+lhdZyTLLhnF7i0ChpfUMDU0Vj00UzYd/cu7MAysd6CbxuwWV/jvxXWFI7
         HDnwi08l5SeKOx+XfAHNnm4R3IcsXIKOSgEYQ2xMNxve2ss6RoxwjrqQhRmthEmhS5VN
         i6tV2sVxzWiXbDTOcJjoF2vqWHvwEFW+pkt3RLk3courf6FHbx6oEI9y3deb7sNRZ+c4
         heN8ck+artU7oEGC/2Eduxf0pen/2nz+qno6vUBYM0CL8u+o2sC/JZSTL74KQ26WVeMP
         W16baG7roQJZ6lkOQ1AciQwtMKR1vgPkcXFiwPwZ77tiPt81p8P+KqQKw3tpl5gpcSOa
         afzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=KfYI7x2n+dPKcoeo3/p/jfkeVeouaOocnFlGHnujIGM=;
        b=Zf1liLZZoOcKEVAHOSmxgPJ8f7woIKsaoIx1O4RbESOZsU3ZDhJrwkwhDb467e361h
         KOG7ZsWtCYGUWH6mRiMTYOXABSExSOcWYVFTLpfX9M4CFztZdYY29TPSiF11SEanYvOc
         GY6ib9gCl0HTGANrFV5t6ZHpms6+olfN5A8OjimMITVNFW+5HaeJZ+W1Y7cy9ZiCS7DN
         bFH6+kFKEqzEMg8sSw6roz1YX41pkquROy0jNOX23/fZpYNBVXqX6wlunLDGNgExNkwa
         ENKOMEu4arE72AXpZDAT/t0FOncDTULNM80eAx/S/rv1bwne2t7dF8YqR6NxK3mgBITl
         rYiw==
X-Gm-Message-State: ACgBeo1z9cYe5CNbiT/a+NbxWzOeIFK8QfETEssF6CzFS6PuISMlhQN2
        UoQ3KW8Me0sv9g9AYzu8v3I=
X-Google-Smtp-Source: AA6agR5C2Q0KBcn5O4IPpfiZF6PU4jcqfp3pKwnZJV2CMTwJf9pk+4iflwiOsNPZCXrgNpSlUV8qWg==
X-Received: by 2002:a17:907:6092:b0:731:59f0:49ac with SMTP id ht18-20020a170907609200b0073159f049acmr4763632ejc.383.1660913679217;
        Fri, 19 Aug 2022 05:54:39 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id b12-20020a056402138c00b0043d6ece495asm3000955edv.55.2022.08.19.05.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 05:54:38 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 00/11] staging: r8188eu: start migrating mlme_linux.c
Date:   Fri, 19 Aug 2022 14:54:17 +0200
Message-Id: <20220819125428.8412-1-straube.linux@gmail.com>
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

This series starts to migrate the functions, or their functionalitiy,
from os_dep/mlme_linux.c to the core/* part of the driver. The goal is
to remove os_dep/mlme_linux.c at some point.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (11):
  staging: r8188eu: make init_mlme_ext_timer() static
  staging: r8188eu: make init_addba_retry_timer() static
  staging: r8188eu: make rtw_indicate_sta_disassoc_event() static
  staging: r8188eu: move rtw_indicate_sta_assoc_event() to rtw_ap.c
  staging: r8188eu: make rtw_report_sec_ie() static
  staging: r8188eu: remove unneeded initializations
  staging: r8188eu: make rtw_reset_securitypriv() static
  staging: r8188eu: merge rtw_{os,}_indicate_disconnect()
  staging: r8188eu: merge rtw_{os,}_indicate_connect()
  staging: r8188eu: merge rtw_{os,}_indicate_scan_done()
  staging: r8188eu: remove unused function parameter

 drivers/staging/r8188eu/core/rtw_ap.c         |  42 +++++
 drivers/staging/r8188eu/core/rtw_mlme.c       |  86 ++++++++-
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  22 +++
 drivers/staging/r8188eu/core/rtw_sta_mgt.c    |  12 ++
 drivers/staging/r8188eu/include/mlme_osdep.h  |   5 -
 drivers/staging/r8188eu/include/rtw_ap.h      |   2 -
 drivers/staging/r8188eu/include/rtw_mlme.h    |   2 +-
 .../staging/r8188eu/include/rtw_mlme_ext.h    |   2 -
 drivers/staging/r8188eu/os_dep/mlme_linux.c   | 166 ------------------
 drivers/staging/r8188eu/os_dep/usb_intf.c     |   2 +-
 10 files changed, 159 insertions(+), 182 deletions(-)

-- 
2.37.1

