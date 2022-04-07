Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61C94F7FA2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245563AbiDGM7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236115AbiDGM7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:59:48 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AC148E73
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:57:49 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x20so6274021edi.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 05:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hcoCrifVh3jGcgC0QHKBTVRExy/JJ4Or1ScZya4YOn8=;
        b=kWtO1BI99Fv7NjLqkGRW5l4rJTmet9h0vqKsFtk1q/jY10kDxbMHO0oa+mY6oBknIg
         P+yUhK5IiUrxPTHu2cTmEUNZK5h1vKusvNDoylIl8AJ8MpjklAOGwW0YKb2oKeCdNZ7U
         6kzmgkWn3HIs9X1VLheGJ+Hu2flmD1vWuDYVCb1pZOdWI42/Df4TRaLapYGWJ/jMtChv
         bxu/mVAg9rOMsDzmPN5dh3cN1SatPZxO1FtfFJTGRo2bjgkF3vz3i/GM7rzJF6DBSXl5
         fY73Y5YigZrC/Nile9exusXUgpEHyOei7cbsLOHmd1Iyv5Mr8clNtvq8LL/8+0JXWHTX
         k2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hcoCrifVh3jGcgC0QHKBTVRExy/JJ4Or1ScZya4YOn8=;
        b=EZnoZJIf43UK0P4dFJQ0ZqnreboYpzep3N7fYEHQre2xWzKy9deC74gk+WVy+Zycsy
         h5EF4p1vz3MS3iCxpEbivXYNOiFjv2xptg5ZZRJgEqPoeG/ZAGk2Lp22fGbipvaMpDx7
         Y4ppSOJ4iIFSJ5X+LEczgIVweaZFfYmCMWjjMOjBds+BaFEtg09aHIx3mepnX4EXOY0g
         QHeXUWfhmml24nNpIr4ZaGLzZlGfrJ2KNG9IFS63OVnukD6gIOKIxe4lJObM/5Q4Bk7H
         AKhPHoDDXV+Mp8fve4TkYlQhp1g5fsLkplKpJBUI494tpfPGWDWPIJF4+s3HyIF6REXO
         eYuw==
X-Gm-Message-State: AOAM532YmwfjE7qn2pmNq0aHeUvFklaf20ONLUA/UhX+K8c8uNgOKfCa
        L8cvKL/KnhatqkImYONTuNI=
X-Google-Smtp-Source: ABdhPJwrM3Jn6ZZx/kiPxaG6xqSXaPGp88T+W/Y+xl2nga11i+VTsOxQJF1VX9yj1LafADPzb+Zxaw==
X-Received: by 2002:a05:6402:1a33:b0:41c:bfc1:957c with SMTP id be19-20020a0564021a3300b0041cbfc1957cmr14007296edb.354.1649336267756;
        Thu, 07 Apr 2022 05:57:47 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm7676764ejk.119.2022.04.07.05.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 05:57:47 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 0/5] staging: r8188eu: use round_up()
Date:   Thu,  7 Apr 2022 14:57:37 +0200
Message-Id: <20220407125742.7814-1-straube.linux@gmail.com>
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

This series converts the driver to use the in-kernel round_up()
and PTR_ALIGN() instead of custom _RND* implementations.

Tested on x86_64 with Inter-Tech DMG-02.

v3:
just remove _RND8 in one case

v2:
use PTR_ALIGN in patch 1/5

Michael Straube (5):
  staging: r8188eu: use PTR_ALIGN() instead of RND4()
  staging: r8188eu: use round_up() instead of _RND4()
  staging: r8188eu: use round_up() instead of _RND8()
  staging: r8188eu: use round_up() instead of _RND128()
  staging: r8188eu: remove unused _RND* from osdep_service.h

 drivers/staging/r8188eu/core/rtw_cmd.c        |  2 +-
 drivers/staging/r8188eu/core/rtw_security.c   |  6 +--
 drivers/staging/r8188eu/core/rtw_xmit.c       |  7 +--
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  |  8 ++--
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |  2 +-
 .../staging/r8188eu/include/osdep_service.h   | 43 -------------------
 6 files changed, 11 insertions(+), 57 deletions(-)

-- 
2.35.1

