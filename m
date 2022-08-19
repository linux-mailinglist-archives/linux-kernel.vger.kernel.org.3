Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAEF599A8C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 13:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348650AbiHSLJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 07:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348596AbiHSLI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:08:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8236C2E9C
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 04:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660907336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZdQAnurZVFdXXS4WbKVSyp7TafzRJAbZ0GKKLX98Mwk=;
        b=DqyFhg5BfT6E8fRpEieINgE7VboJYRVEDxSsQBt8UnfiLqMhn0yLJgWLZ2nzZvTBAvjCkl
        /MGh68Z4sSvKtmeWtHyRcUbDjgJYRFF7KfqpBQGcv3dP/73DByubkez9RKjrqBPDDld5TC
        D4AUU9X8ugqYU/Z2MaUBMCldkfR44yM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-523-AS4SRSMYOiep83MIEzKC3w-1; Fri, 19 Aug 2022 07:08:55 -0400
X-MC-Unique: AS4SRSMYOiep83MIEzKC3w-1
Received: by mail-ed1-f70.google.com with SMTP id v19-20020a056402349300b0043d42b7ddefso2627681edc.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 04:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZdQAnurZVFdXXS4WbKVSyp7TafzRJAbZ0GKKLX98Mwk=;
        b=lmClUMP3K2jGGoLjrfL4/nLFtpiyrPDEVTsXA3lOwDYyY1O800pG/8lcdRjU693dCv
         deUqAPWWBsLcZPDW6Y6Hz9p3Fbs920fJaqMn7ZoYj8jrQAuNO4RF6u/85UprI6l20+9Y
         +p+DLmWvKP05d9u+s65UW0vyaiWZYI0CRIYGWbqDLAKpw5zBc/AREhv7g2At6EdGvln5
         VrKJcHOHPd9Bn0pCUSoiMP2H3NXhNKtU95YTXOraTfmuEl/bJoCo0fuZjnJGEYwKWSyG
         /QX14VaFGIxxFCoSisMsWSRhO7q3gS5PyCQlA/9gi4YGSO8INKLnSqSO6iSTs9SOTAqK
         AQYA==
X-Gm-Message-State: ACgBeo1XMi/n5bv4HXc4bv08+0smc3x1Opu8Wfqc94diw9OMMOrqQhrw
        JlFC06uCIYHldZpV/3P5iWcyL+2Yk8OaRNmvmEEsIKsqWERpeA5YPRuez/LEwGBwfR9AHj5vRSN
        gb316a2fJcuOt18I9gCJf+iG0
X-Received: by 2002:a17:907:c10:b0:731:58aa:7783 with SMTP id ga16-20020a1709070c1000b0073158aa7783mr4727747ejc.19.1660907334721;
        Fri, 19 Aug 2022 04:08:54 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6WDs6mnNC4SmZKIMC1pcP1UBsEQ2H0aHnmJU1kPSrf3TZKof2KEiTrd1TmPeGkr3GplEZ4xg==
X-Received: by 2002:a17:907:c10:b0:731:58aa:7783 with SMTP id ga16-20020a1709070c1000b0073158aa7783mr4727734ejc.19.1660907334571;
        Fri, 19 Aug 2022 04:08:54 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id l17-20020a1709060cd100b007308fab3eb7sm2167827ejh.195.2022.08.19.04.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 04:08:54 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 1/4] drm/vc4: hdmi: unlock mutex when device is unplugged
Date:   Fri, 19 Aug 2022 13:08:46 +0200
Message-Id: <20220819110849.192037-2-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819110849.192037-1-dakr@redhat.com>
References: <20220819110849.192037-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vc4_hdmi_encoder_{pre,post}_crtc_enable() commit cd00ed5187bf
("drm/vc4: hdmi: Protect device resources after removal") missed to
unlock the mutex before returning due to drm_dev_enter() indicating the
device being unplugged.

Fixes: cd00ed5187bf ("drm/vc4: hdmi: Protect device resources after removal")
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 84e5a91c2ea7..4d3ff51ad2a8 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1425,7 +1425,7 @@ static void vc4_hdmi_encoder_pre_crtc_enable(struct drm_encoder *encoder,
 	mutex_lock(&vc4_hdmi->mutex);
 
 	if (!drm_dev_enter(drm, &idx))
-		return;
+		goto out;
 
 	if (vc4_hdmi->variant->csc_setup)
 		vc4_hdmi->variant->csc_setup(vc4_hdmi, conn_state, mode);
@@ -1436,6 +1436,7 @@ static void vc4_hdmi_encoder_pre_crtc_enable(struct drm_encoder *encoder,
 
 	drm_dev_exit(idx);
 
+out:
 	mutex_unlock(&vc4_hdmi->mutex);
 }
 
@@ -1455,7 +1456,7 @@ static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder,
 	mutex_lock(&vc4_hdmi->mutex);
 
 	if (!drm_dev_enter(drm, &idx))
-		return;
+		goto out;
 
 	spin_lock_irqsave(&vc4_hdmi->hw_lock, flags);
 
@@ -1516,6 +1517,8 @@ static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder,
 	vc4_hdmi_enable_scrambling(encoder);
 
 	drm_dev_exit(idx);
+
+out:
 	mutex_unlock(&vc4_hdmi->mutex);
 }
 
-- 
2.37.2

