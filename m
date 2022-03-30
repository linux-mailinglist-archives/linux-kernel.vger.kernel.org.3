Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6043D4EC3AA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 14:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344612AbiC3MUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 08:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347284AbiC3MGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 08:06:08 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8407FF3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 05:03:16 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id b13so16626706pfv.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 05:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v0/H3G2XFiR4LVmAPedHiWgw4TnVBjO8kBG30Rx6UL8=;
        b=mL8TYadv8FwnRuRKoTITRg23I+zj3YpjUkS/HxsO1mXhazrpiNa/gQ9ZhqpLDQUrqI
         Y4H2jEfLUG4ejF2Bhyey9dkFvUs/W7aQIxqRp7nhurrbYn5LEk8qic5kstmJh4wXg7BW
         Vdk2mKx1nPOwuwOvdqhVdNM5wUN1AsyMVOeIItxhTubGPYT2Q8biMXZkuzyQGVRcL8TD
         vLAWHCkbUHL5ygmf5oFmiadYdSKWECmwoPmeze/QJEwdiUr0+MG7BhrV7gvPojJCLQft
         q9izu8XueDRFAoQOtCX/qStvq7xqphJMDjzgUjUwfkywmVU/2xgyEbSfGahUW3czat4F
         z9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v0/H3G2XFiR4LVmAPedHiWgw4TnVBjO8kBG30Rx6UL8=;
        b=vlj5zlA4WwCiANx1zaBRhBVpYGkaqAPMGWDaLZ2LcvRNvSBcDdrHxHbLDqUrEHQ3ll
         65DOLql0MIshjbab360Gg/a4OCfxXz44aeeIczrmwflVH2vH0dsVnUqN0zOepxpn57GZ
         y/m84CFzsdl7ETXlF6OW3xyJkwUJ994m6jxgU9L0/8rDMVAVkTKr4+WMJuzvg8LG6v58
         wa08AKoxid1K9wIk+xJS3ZUF6EJoXmV6HmDutoC98J9YHhHJetSIY3H+pcp14lzvsQkq
         jWmeK6e7996pdJU6w4u/88pqEIz0aQ1pnsC6rOzhNTS+Ickrb7gt4FhnE3FIWdFehlUk
         cmlg==
X-Gm-Message-State: AOAM5316v3J7sclmnHzwANVnnktrNjrGnnaPoVJcczwoCVK35rfwq6dB
        +uuCmxK8btxNX7GsoBEl11c=
X-Google-Smtp-Source: ABdhPJyR8BQ3qxaZE8/z/Z4rWYLqKvWludsfxnyPd4gxVs9v0cM5heIjKQAvYMUgNX8NERHX+rcSSw==
X-Received: by 2002:a05:6a00:194e:b0:4fb:32b9:dfd2 with SMTP id s14-20020a056a00194e00b004fb32b9dfd2mr19805610pfk.10.1648641796180;
        Wed, 30 Mar 2022 05:03:16 -0700 (PDT)
Received: from localhost ([119.3.119.18])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00130900b004f73df40914sm23142978pfu.82.2022.03.30.05.03.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Mar 2022 05:03:15 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     patrik.r.jakobsson@gmail.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     rob@ti.com, yakui.zhao@intel.com, airlied@redhat.com,
        alan@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH 1/5] gma500: fix a missing break in oaktrail_crtc_mode_set
Date:   Wed, 30 Mar 2022 20:02:42 +0800
Message-Id: <20220330120246.25580-2-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220330120246.25580-1-xiam0nd.tong@gmail.com>
References: <20220330120246.25580-1-xiam0nd.tong@gmail.com>
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
will certainly lead to a invalid reference to list itereator variable
'connector' after the loop pointing an bogus address at an offset
from the list head, and could lead to multiple 'is_*' flags being set
with true mistakely too.

The invalid reference to list itereator is here:
	drm_object_property_get_value(&connector->base,

To fix this, when found the entry, add a break after the switch
statement.

Fixes: a69ac9ea85d87 ("drm/gma500: drm_connector_property -> drm_object_property")
Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
 drivers/gpu/drm/gma500/oaktrail_crtc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/gma500/oaktrail_crtc.c b/drivers/gpu/drm/gma500/oaktrail_crtc.c
index 36c7c2686c90..eb2d79872bd5 100644
--- a/drivers/gpu/drm/gma500/oaktrail_crtc.c
+++ b/drivers/gpu/drm/gma500/oaktrail_crtc.c
@@ -409,6 +409,8 @@ static int oaktrail_crtc_mode_set(struct drm_crtc *crtc,
 			is_mipi = true;
 			break;
 		}
+
+		break;
 	}
 
 	/* Disable the VGA plane that we never use */
-- 
2.17.1

