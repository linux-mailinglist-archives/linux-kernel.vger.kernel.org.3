Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97788505EBB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 21:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347782AbiDRTvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 15:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347775AbiDRTvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 15:51:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE90D2980B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 12:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650311317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xoFC0RlqU29MoZ59ErURITWrPmQFVCqFinpLIIkANfM=;
        b=ZPvRrnku4f0U2CY0q5pWSUFRJhqj7t4yTAlgFrjrjlL1O+H84gOU7vWpo2i97aQ6o+9W89
        8s5rIeRPS25/W93B0FmfCP/PBg4uETwczDf85D/v5s8zJN2OEM8QvVGqGQW6Uqz4JyyAdY
        veNgEdhXtoHiysmOC0ZaJe4r5nWOnRk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-Ozmn7qqJNAiNT6eetvEwPw-1; Mon, 18 Apr 2022 15:48:36 -0400
X-MC-Unique: Ozmn7qqJNAiNT6eetvEwPw-1
Received: by mail-qv1-f70.google.com with SMTP id fw9-20020a056214238900b0043522aa5b81so12830125qvb.21
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 12:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xoFC0RlqU29MoZ59ErURITWrPmQFVCqFinpLIIkANfM=;
        b=inJyhEbXnrP+Odc43fGcWZKo5Qb3dvlDg9QNvK3vIweqaIw5tCcAbgCOJNHxOzDIZd
         pYNDOpAV7os3cF8LFkFEm2ib8D9rLR5TsKJ97UR9Vz/4AItc2IPd1STVCmBxv3tPtFpB
         Wu5zAmzQQVUSu2xDIArVW6cqZ5pdTFebeOdn1O0tPQ1e/qr031XHWpJX07AELYRPRHRu
         3IAfI/ahqyweL/0+6/+xQdA8omuJMCAMyo4Bo9YNscM+aAiGfSHP05Rj7vzQgt58mU/e
         CYF9lFgYlgdYIQM9gsE5t5H0qlRT2PKELzTM7IDH2qqsrG53oViKEGrHREUFnBrnai63
         QKKA==
X-Gm-Message-State: AOAM530hdx/a8xVYguDFy749+ijirKe/AtZMCvME33umGV1EO/qJMi1E
        Wx5GsJMY+nGDiKnjhBERfHuPJ6udn7PbsXrm6NX65AdtxoU5jJUbicUGNjs3XIQOsFc8G/u6xAu
        wRnt4uFwAFOZYnWYh5UxZ0mbK
X-Received: by 2002:a37:5502:0:b0:67e:a143:80da with SMTP id j2-20020a375502000000b0067ea14380damr7634837qkb.329.1650311315542;
        Mon, 18 Apr 2022 12:48:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygpNhttVMJUTFKmX/4Fl6amPuHUl9AtPkfNHtmHbJyX+T1xlwpJ6/GzrDPFtzLWBf4yMrmnA==
X-Received: by 2002:a37:5502:0:b0:67e:a143:80da with SMTP id j2-20020a375502000000b0067ea14380damr7634826qkb.329.1650311315300;
        Mon, 18 Apr 2022 12:48:35 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 3-20020ac85903000000b002ee83037459sm8393773qty.42.2022.04.18.12.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 12:48:34 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, stylon.wang@amd.com, Jun.Lei@amd.com,
        wenjing.liu@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/display: add virtual_setup_stream_attribute decl to header
Date:   Mon, 18 Apr 2022 15:48:30 -0400
Message-Id: <20220418194830.3266024-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports this issue
virtual_link_hwss.c:32:6: warning: symbol
  'virtual_setup_stream_attribute' was not declared.
  Should it be static?

virtual_setup_stream_attribute is only used in
virtual_link_hwss.c, but the other functions in the
file are declared in the header file and used elsewhere.
For consistency, add the virtual_setup_stream_attribute
decl to virtual_link_hwss.h.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.h b/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.h
index e6bcb4bb0f3a..fbcbc5afb47d 100644
--- a/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.h
+++ b/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.h
@@ -28,6 +28,7 @@
 #include "core_types.h"
 
 void virtual_setup_stream_encoder(struct pipe_ctx *pipe_ctx);
+void virtual_setup_stream_attribute(struct pipe_ctx *pipe_ctx);
 void virtual_reset_stream_encoder(struct pipe_ctx *pipe_ctx);
 const struct link_hwss *get_virtual_link_hwss(void);
 
-- 
2.27.0

