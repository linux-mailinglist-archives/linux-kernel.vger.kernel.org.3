Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99AF4EC356
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 14:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344762AbiC3MU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 08:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347285AbiC3MGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 08:06:08 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3A4DF89
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 05:03:10 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s72so17447996pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 05:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=RTflF79o5OP29Yqh4bp0dgbknlfdt+57gJKaSZ3FARI=;
        b=VL0bzsmtcSUPzVyWP7mi0xQ+4ls81NJ7RtCQgXi2DxlyIwGPzKC06587rD0lq+YntF
         J85c0GMPkJOvT91ylfX/r1/DkdKq7NGD2dP9Zv6Mqa7ptY9zk4PB9nSJUZ0a6ZPFtot8
         Hla7FGOpLSQuDnHq41TpQjuLilt47tTDdeu/zQwgQH+7Sc5jUHVmr5C3D03yfbAFww1p
         PAnMBhUhd5AH5PPQstg/rnla/t9CJm4C5KH+DRU6sfALCPn2UvqctWysc2paQnH1tnqK
         M+9MFUXjLGRsywHbqZYXorXp6EQ2va7Y/8AfCYtTaFxAQa8o4oSlDEKniIc8LNkv9es+
         b4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RTflF79o5OP29Yqh4bp0dgbknlfdt+57gJKaSZ3FARI=;
        b=36ZJnzBFmhzYqnFn4YKo3N/F7MJ5bx40zZGeUI6OMTAWgL5n8BBv07t1qaANPTu1/U
         0TfuzR8104Lyj8lflREqHL4XpeN8dwEvQnP1zE1KHckZNYAUuCYhJoXXSBt9eZ/MigZj
         NnTA9/JTkgnrBx2uIE824ZYzHTra5C3b0mQ8ExT1MU1mmyzT7IeaZVXkm1+0v6gySCpQ
         CwkATScGtETi4K2Tk4hsQo3QVbhxWHUC+DBnp7qO7XnQoFUlscvyTvMKUS9GHFwccGza
         S27Pg35zhIBKGBHB//9UrlxwGWak8jRQgX163T6Pn9A3N34wAoOq/hMyKFHtqGdY+sIj
         nyxg==
X-Gm-Message-State: AOAM531pQ1Btqnt2BntPHzLPHvIsLR49kyt8Na+Ip2b2+Nkvn/fyLkSy
        3/+Jvk3tlcNHNYHm2+pjPsI=
X-Google-Smtp-Source: ABdhPJy/PTS8tLtmbm8he2KZ/1O5Av4iSQIycqWogq9rw09/AWC/lro3H8I7WnDkdQ9eq5Y4Svij+A==
X-Received: by 2002:a63:4e:0:b0:37f:f3f0:2d24 with SMTP id 75-20020a63004e000000b0037ff3f02d24mr5812726pga.526.1648641789354;
        Wed, 30 Mar 2022 05:03:09 -0700 (PDT)
Received: from localhost ([119.3.119.18])
        by smtp.gmail.com with ESMTPSA id d80-20020a621d53000000b004fae1119955sm23364301pfd.213.2022.03.30.05.03.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Mar 2022 05:03:08 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     patrik.r.jakobsson@gmail.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     rob@ti.com, yakui.zhao@intel.com, airlied@redhat.com,
        alan@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH 0/5] fix missing break in list_or_each_entry
Date:   Wed, 30 Mar 2022 20:02:41 +0800
Message-Id: <20220330120246.25580-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of exiting the loop as expected when an entry is found, the
list_for_each_entry() continues until the traversal is complete. It
could lead to invalid reference or set 'is_*' flags mistakely.

To fix this, when an entry is found, add a break to exit the loop.

Xiaomeng Tong (5):
  gma500: fix a missing break in oaktrail_crtc_mode_set
  gma500: fix a missing break in cdv_intel_crtc_mode_set
  gma500: fix a missing break in psb_intel_crtc_mode_set
  gma500: fix a missing break in cdv_intel_dp_set_m_n
  gma500: fix a missing break in psb_driver_load

 drivers/gpu/drm/gma500/cdv_intel_display.c | 2 ++
 drivers/gpu/drm/gma500/cdv_intel_dp.c      | 2 ++
 drivers/gpu/drm/gma500/oaktrail_crtc.c     | 2 ++
 drivers/gpu/drm/gma500/psb_drv.c           | 2 ++
 drivers/gpu/drm/gma500/psb_intel_display.c | 2 ++
 5 files changed, 10 insertions(+)

-- 
2.17.1

