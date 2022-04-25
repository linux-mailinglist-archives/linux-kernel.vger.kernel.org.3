Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4059250E0F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240299AbiDYNEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238933AbiDYNEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:04:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DD1113D76
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650891661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rTys+erDRBI/RIRvGMImXOuLh5EmnDonu4B+GkyDP0E=;
        b=YWAM/0ZUiWI9+HGRciENZSQZkzTZDvAdONSIhM/5y1V0F2X8hJ+ju1d4zyX/rtHqHuELbI
        P9ETIXjgK0wKv5Gp/OyJNXQBFekARSQV81VBuaveY6ckJxZUvhePkb4g6j93rSfZtUljgp
        PhvuNBJjbvSAYnxU9rxweFwQahQne/w=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-wLuEkrrvNi6AlnST3ycIdA-1; Mon, 25 Apr 2022 09:01:00 -0400
X-MC-Unique: wLuEkrrvNi6AlnST3ycIdA-1
Received: by mail-qt1-f199.google.com with SMTP id a25-20020ac844b9000000b002f1f8988487so7827994qto.17
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rTys+erDRBI/RIRvGMImXOuLh5EmnDonu4B+GkyDP0E=;
        b=nsJW1EtsKc6CJyTZ9XbqxljZNnU1gDTV1GyUNbl4BGT4VnWavVwFQgSxhYlLheGWBD
         82pdmXqsjRARDHva991x22f9vxPJLAZofWFN4V/Eyl8SefhvPxhjp5VP3Zebmy9i9qOp
         09LfMrEr2DqKTC60vwsirH5/jPpSVyuXnEB0US60ntdlXjn7YkhhMAcgLyY5w3sDCW+Z
         XdyulX3/BkkoSMLY2CXAWbiNyET1p+JahjtyoYsvMra68ooI9M5IV3s6pLcA5dUo/i6V
         1dIKFe7KsXjIahsoPMOnDDaONAA9jpgEIJM2jdeVLk5FgNYc+Cj0H7cS4LoBArK7/64W
         +8iQ==
X-Gm-Message-State: AOAM533nNOkr6B5yd1hj45ls7CNrXTu5qwfH9HVmi3q+p33oQq7yBUZ5
        Gaw1GDWupO+X8ImRaReT5ikhtZuE3DeL4/UD3C9G1wozVs8xZGfbIOvO382ErUJ64YkE5nMvufx
        +YcxfW88m3dVd+Q1EAhiD7N20
X-Received: by 2002:ac8:5fc1:0:b0:2f3:6731:241c with SMTP id k1-20020ac85fc1000000b002f36731241cmr3572730qta.675.1650891658440;
        Mon, 25 Apr 2022 06:00:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrNZbxLMQwnrHy53N0H2O7nNxhHG7BzBXBhpXYmwsVimEqJHWZzXb7khbqE1uBB1FI/T3+Pg==
X-Received: by 2002:ac8:5fc1:0:b0:2f3:6731:241c with SMTP id k1-20020ac85fc1000000b002f36731241cmr3572656qta.675.1650891657748;
        Mon, 25 Apr 2022 06:00:57 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x129-20020a376387000000b0069f2aaaf734sm3830995qkb.20.2022.04.25.06.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 06:00:57 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/nouveau/disp/gv100: make gv100_disp_wimm static
Date:   Mon, 25 Apr 2022 09:00:50 -0400
Message-Id: <20220425130050.1643103-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports this issue
wimmgv100.c:39:1: warning: symbol 'gv100_disp_wimm' was not declared. Should it be static?

This variable is only used in wimmgv100.c.  Single file variables should be static.
So use static as its storage-class specifier.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/wimmgv100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/wimmgv100.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/wimmgv100.c
index 89d783368b4f..bb4db6351ddf 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/wimmgv100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/wimmgv100.c
@@ -35,7 +35,7 @@ gv100_disp_wimm_intr(struct nv50_disp_chan *chan, bool en)
 	nvkm_mask(device, 0x611da8, mask, data);
 }
 
-const struct nv50_disp_chan_func
+static const struct nv50_disp_chan_func
 gv100_disp_wimm = {
 	.init = gv100_disp_dmac_init,
 	.fini = gv100_disp_dmac_fini,
-- 
2.27.0

