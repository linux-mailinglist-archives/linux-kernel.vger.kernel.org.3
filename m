Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F34505BDD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiDRPvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345668AbiDRPuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:50:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75D9E1A839
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650295698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ih9PEnp4Wjk+k/+TucNV83KQkvF18ND4JmzRmAmOEMs=;
        b=Dsqc9KM0JPnlcTJ6XLBc0DmVAUAKLo9Sedkpv4uLAf3d/MrGa5yiIBvcv6gKtnOBI2z5QD
        KVRE4nP0xqoCKK03QPJJOGcF7k90xSh0LThXLE/aMzQ3vYaFBSyH3kXddm9tlosJ0SaHT1
        mXvQdZYYAOEe0zhngx+OQZMSDhAgyvI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-SSypCA95MkySLcjHCS8IYg-1; Mon, 18 Apr 2022 11:28:17 -0400
X-MC-Unique: SSypCA95MkySLcjHCS8IYg-1
Received: by mail-qt1-f199.google.com with SMTP id bb32-20020a05622a1b2000b002f1f41e6caeso2876618qtb.19
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ih9PEnp4Wjk+k/+TucNV83KQkvF18ND4JmzRmAmOEMs=;
        b=aQKXlLI5K8THFjQsJUb6VQPWfEyzfQKOfG7mOXUErK6UXYYuBnb73c4Sm6AwHxgSc/
         NqbPepO+VHIy1fgj6B7EGUzRd2JRK3frXrsp4P4oooo3oBYmbR/Oh2rKBSFpTV7tqIbz
         CxIz21yJ4X/c3p3cRW5Fe2RqENPGSxrQN4HIK3SERSeG4R4HHRoRDJLqtmXgciWr6ZjN
         WDgQrQn3/ywf/LIuDguZ5Qh/SrRGlXnKvRHXfiae2yzt1y0IoRm/IOQYYYxnxTLR7Fjl
         rij+pd65JJCusNibRvxUltxnFMxlCrO+jCjFNukOVDs8BR9SD6fycIMRHPjd9cB9a13h
         nsJg==
X-Gm-Message-State: AOAM532oTpwAe0IF4MftcOvfhHXpcT0lSN9aJ0oDjWyUalF8aPvM/ScO
        3p5OWPb19cbjn/d2A+JHCCu94FZi75ZSDic33S6uDZrLNRG/eXfABGm0ZImkpsMvuOg7VsuE6ub
        j+CFaLGl6boff8s4Uo3E4zaEw
X-Received: by 2002:a37:447:0:b0:69e:a2be:f270 with SMTP id 68-20020a370447000000b0069ea2bef270mr2733226qke.130.1650295696833;
        Mon, 18 Apr 2022 08:28:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxd+rW0DF6snrQAx/DVgdX3YAtlSUyaxLZbHZLhwb0nZYBV6ivGoW0JK0uNu8zwYr3h06hFlQ==
X-Received: by 2002:a37:447:0:b0:69e:a2be:f270 with SMTP id 68-20020a370447000000b0069ea2bef270mr2733212qke.130.1650295696615;
        Mon, 18 Apr 2022 08:28:16 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y66-20020a37af45000000b0067dc0fc539fsm6830397qke.86.2022.04.18.08.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 08:28:16 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/nouveau/gr/gf100-: change gf108_gr_fwif from global to static
Date:   Mon, 18 Apr 2022 11:28:10 -0400
Message-Id: <20220418152810.3280502-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports this issue
gf108.c:147:1: warning: symbol 'gf108_gr_fwif'
  was not declared. Should it be static?

gf108_gr_fwif is only used in gf108.c.  Single
file variables should not be global so change
gf108_gr_fwif's storage-class specifier to static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf108.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf108.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf108.c
index 030640bb3dca..ab3760e804b8 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf108.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf108.c
@@ -143,7 +143,7 @@ gf108_gr = {
 	}
 };
 
-const struct gf100_gr_fwif
+static const struct gf100_gr_fwif
 gf108_gr_fwif[] = {
 	{ -1, gf100_gr_load, &gf108_gr },
 	{ -1, gf100_gr_nofw, &gf108_gr },
-- 
2.27.0

