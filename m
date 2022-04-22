Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2816250C1CF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiDVWGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiDVWGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:06:23 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B94178F7D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:50:21 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n18so13380953plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ad/QwBoaLcblV6YkIeWuUrZIToNy2PlGXIo1QCJ7d/Y=;
        b=Ko/peBWKlgHk4Vd467FlMQoUcvpxF1aWq82G2L/42YwmW4UuMoiR4iUMku/8Yaax+i
         nxBIngcvmr4Ce2URDbV9DC58RMvMJe+Tfqkz4yuHYCvprr6cARxxUSN0w0kRSDMaPA5P
         bWEK1pFRBbswAtjyRQlC0qFZ8tZ5IIOUy6/EpfFLPS+3gtyaZBLwFog/CRYEvnm9P21P
         ZeD/sUh2WVk0JvpvG1QQGEDQy0ZNb7OlpFGvJz8r4wUCJ82wanDwg8r3QzuUV3GcxbKr
         o0rdK0taDvVPLS7mU9DMB47VQuBzwH0pFkOoQBEUrzJ6vpviggRL/Faldi6HSzowY99a
         IP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ad/QwBoaLcblV6YkIeWuUrZIToNy2PlGXIo1QCJ7d/Y=;
        b=zDPt1ImZ2qQREm4tVBA5Fstxe5Ri2wHpAsbuKnxpUPMTiVyoSSPe9sY0775y1Ha9EZ
         V1Pf5P1M9loK5EwI/Sb7DuKN1TS5RtXqG0OxRASPM0Grjr3EFiWnOvVbo7/QPDjQ7HM5
         OuWOHuqftcY8X/Icg3DGBjZA6txUDtPpUeqc14xtgm4emQ20tgifz+1i3BX8taMKGJJI
         amCfs3WQN4DUoIUKu7vad8RZZDZ0Z2iUAt9EjbSl8jh7e3rIj90QffxwM+hYK69TfTO2
         GHagIzLv42b8iMf0P5aOMpAc4BtepcsAL5BMjW4YqlvMDRTut2Us2cZfBpTz/TZN/khK
         0j4w==
X-Gm-Message-State: AOAM530uFX/DJb+Tie/p1kHG93tVt2EdP+KwgsHhdh00TmUSxtEdT1LN
        7m3nGXToR7/yTa90wLqGPNbXTYTZGQyOxg==
X-Google-Smtp-Source: ABdhPJzM1tudRoIceKhOplJeE8VebcQReB+kqAwFMEijuKAIGHtFEYV6wYwz+TjzDIvKR44Q95rHDw==
X-Received: by 2002:a17:902:e00c:b0:15a:3b4a:3e42 with SMTP id o12-20020a170902e00c00b0015a3b4a3e42mr6070926plo.10.1650655953960;
        Fri, 22 Apr 2022 12:32:33 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:15:bfe0:e8c0:bea6:ee63])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b004e15d39f15fsm3518932pfh.83.2022.04.22.12.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 12:32:33 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH v3 0/7] staging: r8188eu: drop some unnecessary wrappers
Date:   Sat, 23 Apr 2022 01:02:16 +0530
Message-Id: <20220422193223.11948-1-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NO_RDNS_DOTCOM_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop some unnecessary wrappers and update all the references
accordingly.
Tested on Comfast CF-WU810N RTL8188EUS wireless adapter.

v2 -> v3:
Fixed subject line

v1 -> v2:
Drop the wrapper functions with underscores prefixed.

Vihas Makwana (7):
  staging: r8188eu: drop unnecessary wrapper _rtw_free_cmd_priv
  staging: r8188eu: drop unnecessary wrapper _rtw_init_cmd_priv
  staging: r8188eu: drop unnecessary wrapper _rtw_init_evt_priv
  staging: r8188eu: drop unnecessary wrapper _rtw_init_mlme_priv
  staging: r8188eu: drop unnecessary wrapper _rtw_free_mlme_priv
  staging: r8188eu: drop unnecessary wrapper _rtw_alloc_network
  staging: r8188eu: drop unnecessary wrapper _rtw_dequeue_cmd

 drivers/staging/r8188eu/core/rtw_cmd.c     | 145 +++++++----------
 drivers/staging/r8188eu/core/rtw_mlme.c    | 177 +++++++++------------
 drivers/staging/r8188eu/include/rtw_mlme.h |   4 +-
 3 files changed, 134 insertions(+), 192 deletions(-)

-- 
2.30.2

