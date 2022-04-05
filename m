Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CDF4F4871
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383485AbiDEVjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358862AbiDELRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:17:39 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8B5890B6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 03:49:26 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bg10so25873759ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 03:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7577hiEEV60XWnU+gm9ig1vjqa65ibu1AZU+K7+N5IQ=;
        b=E+cn+nYJ0eiXQPg7n4oHQaZOzpWn0DzsXu6Eyo8UPMxYDv6mVqQAQ7PPnro/TdPijA
         FB1YZYILpwko9Q603p48/DJrOPcBcCeYTQ1UrV8uvnGf8Qucx/2jh63VT2P/ouJudb3I
         I8mXgcTc9T0+Cm5E8ug6Kwn5INkDW2q1bP93Qvigi9QClBrc7nDrxhKPVKQtZVUZWEiB
         P4yLWkpWOfLcwXk+dj6s8iIJf+D/mY31Y7nQaFBefs/LxtcstHiq13dkfdiaEo8NAIeL
         9P87QqFuF8mH9xpKuQ0yql9arUlaCMOPWvOKgYhpyVaooeRb8dp5W0Sw6RKNYr655mz6
         DfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7577hiEEV60XWnU+gm9ig1vjqa65ibu1AZU+K7+N5IQ=;
        b=komZRqmWZBxlCjfEFf+l/EZGP4p5xYH+qA9E6yqzJ8ouUgY+L2Bt5GPN3Q310/WsXK
         T9bDXbWDV+zMeg84VacGBOv02c2mP/J9+eu1fuO9v+7ixQXv+TTqGq6Kk1BXNKxPQFYg
         rXCT5ZQCmswSiFAvTUk0kneqreV6GANv8+xwRbvciVhVLDoU/d81UId6PwxTeZO82VkE
         PqLPQ+qZQLH6C/iQ11hgVjnzkCtxCLdIRUcEVzZJpDLBk14MyvBdy5EgV6OjUdxNq0BU
         Y+GVAf0cknPXilLB4/IaBTh4j8noT03wRNK8idA4BQwz03hnvWimq8av3pw8habcTFB2
         YTHQ==
X-Gm-Message-State: AOAM531fkC4XgJ5x/dmgbeF+Mb5BldxT1oNQ/HJwE5h7shMiYzuFhTSW
        LPVjPIh+t1c4CGfPTECv/c+i9QbVwFY=
X-Google-Smtp-Source: ABdhPJzlWvczrjaKZjKGrm8PwiUl7ri7bCRqBl55s3ADRN2o7JLvUjYq6wkv+QrsdJTIEZtmGbh2Qw==
X-Received: by 2002:a17:906:9b8f:b0:6db:ab62:4713 with SMTP id dd15-20020a1709069b8f00b006dbab624713mr2905921ejc.738.1649155765362;
        Tue, 05 Apr 2022 03:49:25 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id j12-20020a50e0cc000000b0041cd813ac01sm2436702edl.28.2022.04.05.03.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 03:49:24 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 0/4] staging: r8188eu: remove GetHalDefVar8188EUsb()
Date:   Tue,  5 Apr 2022 12:49:06 +0200
Message-Id: <20220405104910.9769-1-straube.linux@gmail.com>
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

This series removes the function GetHalDefVar8188EUsb(). This is part
of the ongoing effort to get rid of the unwanted hal layer.

Tested on x86_64 with Inter-Tech DMG-02.

v2:
- remove dead code first
- use better function names
- make one function static

Michael Straube (4):
  staging: r8188eu: cur_ant is set but never used
  staging: r8188eu: remove HAL_DEF_IS_SUPPORT_ANT_DIV
  staging: r8188eu: remove HAL_DEF_CURRENT_ANTENNA
  staging: r8188eu: remove GetHalDefVar8188EUsb()

 drivers/staging/r8188eu/core/rtw_cmd.c       | 11 ++++++++---
 drivers/staging/r8188eu/core/rtw_mlme.c      | 19 ++++++++++---------
 drivers/staging/r8188eu/core/rtw_mlme_ext.c  |  2 +-
 drivers/staging/r8188eu/hal/usb_halinit.c    | 20 --------------------
 drivers/staging/r8188eu/include/hal_intf.h   |  3 ---
 drivers/staging/r8188eu/include/rtw_mlme.h   |  2 ++
 drivers/staging/r8188eu/os_dep/ioctl_linux.c |  8 +-------
 7 files changed, 22 insertions(+), 43 deletions(-)

-- 
2.35.1

