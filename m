Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778F156333C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbiGAMIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiGAMIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:08:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 389B883F00
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 05:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656677283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4MitOBaTFuNWGBWI6IjFwtubmr1bZjp+g6N0csw7RBw=;
        b=cOyx2TLJaQ7dG6Ci/ShNvKwVfChmA/o18rQYPdVZwuzqyXeFeFWYdFXoDvUgz2h8XYzW7z
        UA4MREFDmrVJkIeZOiLD93BkGZ+GDVUnWJJdHhvo6RACFnao4tJaqsj6CMMSr5IVm5pSKk
        xySPXCLwhgmlorAKOuCQdZ8pBuU1Wxk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-pYwm41-cP6yrU59Kj50L1g-1; Fri, 01 Jul 2022 08:08:02 -0400
X-MC-Unique: pYwm41-cP6yrU59Kj50L1g-1
Received: by mail-wm1-f70.google.com with SMTP id p22-20020a05600c359600b0039c7b23a1c7so2967130wmq.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 05:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4MitOBaTFuNWGBWI6IjFwtubmr1bZjp+g6N0csw7RBw=;
        b=RWkSVjDMwGINgVyP5eL7Cw/Wr7LB9A0rpRtZu0GOuG2ZT58YHpICqwB3eZPIjOnoRU
         rt10URGvRTO4t0+lxIAIcfsm0nO6Mjpcq1oPcTPQ1cbpNQVUwFRqY98NiG569jn9ISvA
         yPGylVt9uA+oQZeswfoNXlgeX028hDFfRBYL5ovIdqaF2oNcMf+3TTVAFnlWrJYRlgYB
         0/al9k3CZcERCxt5jc5gOuICMt7b5xA0HR+jjFwyOFIS+weeqrQ11jDRaeCwfrwX5Fbn
         wsdlWAdGdOFvH+NP/8yc5gscnCcxMYUk9s0tZvElJwto6IVGffZaQmETUmqrqrT/GYQ8
         jkLQ==
X-Gm-Message-State: AJIora9KmeCpv5/k+josVUtv5TGGDRmxQCv6OtuWiMz1X2SPAF8MyJKI
        7uN4d3PzEEX8mfwDqTuUBssNpgC+7lInGX514Uiif2B9ANOdOSxWUMCksYe2QwxvT40IWHt2/ZP
        PK2KNMER3J4Sep6HrRf7fCkWlM94pXsyPMOkxu5XDyqLEEOGlskd3EUdiPYNiV6kO5HrZOppOd1
        k=
X-Received: by 2002:a05:6000:70b:b0:21b:a816:85c6 with SMTP id bs11-20020a056000070b00b0021ba81685c6mr13134670wrb.639.1656677280964;
        Fri, 01 Jul 2022 05:08:00 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sfgsRUF1Y2CzqWiJIBUOimbTLgrvvPQu6gA9irx8HnpbPsGY6YUm8CtBXgbK24H9zlzE4cXg==
X-Received: by 2002:a05:6000:70b:b0:21b:a816:85c6 with SMTP id bs11-20020a056000070b00b0021ba81685c6mr13134625wrb.639.1656677280576;
        Fri, 01 Jul 2022 05:08:00 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v4-20020a7bcb44000000b0039746638d6esm9813160wmj.33.2022.07.01.05.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 05:08:00 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 0/2] drm: A couple of fixes for drm_copy_field() helper function
Date:   Fri,  1 Jul 2022 14:07:53 +0200
Message-Id: <20220701120755.2135100-1-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Peter Robinson reported me a kernel bug in one of his aarch64 test boards
and even though I was not able to reproduce it, I think that figured out
what the problem was. It seems the cause is that a DRM driver doesn't set
some of the struct drm fields copied to userspace via DRM_IOCTL_VERSION.

Even though this is a driver bug, we can make drm_copy_field() more robust
and warn about it instead of leading to an attempt to copy a NULL pointer.

While looking at this, I also found that a variable in drm_copy_field() is
not using the correct type. So I included that change in the patch-set too.

Best regards,
Javier


Javier Martinez Canillas (2):
  drm: Use size_t type for len variable in drm_copy_field()
  drm: Prevent drm_copy_field() to attempt copying a NULL pointer

 drivers/gpu/drm/drm_ioctl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.36.1

