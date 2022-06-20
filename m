Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD895517EB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240671AbiFTMAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbiFTMAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:00:05 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63448FCB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 05:00:04 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x4so3697918pfq.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 05:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nWm1HuDYDniRiWG4QbCIzu8XBm9RdL4rAmU7DmwMgag=;
        b=TnIQURtTcrz69rPQXxoFw4lPoL3YiTafG5VwGyzk+3OCP83UrfYIXmTwN7UxNx95i6
         QySrwShr8gukdDKU4OlOmFyGwmdSHjOHwX7e0mIe11cWlpBVO+ER99SQtBLEOrMVncZV
         jhsmEH3K9UQetdyyI1m7Ba9uN+dSo0QryEfenw/Vc2BmFt1OeMNcOIXd9Hh/oxs/Z8/t
         D9UldAxzoDHts1avlU8ogeIZHMTSNqvD+2lGHA/lSaby28kr6uvBTfaw7zg6jzSnBXvl
         IkXbxW9rImeluyyzPWltydnA+FvIvJQf/2HIwDqNDXCaqcQmXEczVs442/Na328Kljcm
         X7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nWm1HuDYDniRiWG4QbCIzu8XBm9RdL4rAmU7DmwMgag=;
        b=ipB4h5+YnsLSiLofPRXWeOMN8gFSWSFYVf0PQHtAhDoEWHQA4I32/cLsNhklzU3Abs
         bcdBA7VnA1rTZB5Y5OVBCxeXfC/Ccmn/CK39XRdhuMU0moQ9kUG9hthhhn5hhw4oJRZP
         wBrMLAqYvwtS0bckkGF6cZkbFAeWmhVn2fqERhiAB3aqUXo5f8mPYW2+fdg36UlzhnJl
         pg3ZuQ1RXgDNEsXxEaqZ/CUSgvUiGzbGUAh6z7yyFYO3Jilj+QkPbVXDYAc5MMhN6Qua
         HJ+tHSII4tg8/JO5MwAY2TeWD2K4swojC5jubbEVflPkfZ60m8jvDuWzEZT1bf+SoKQN
         vOiA==
X-Gm-Message-State: AJIora+pMJtLkh7dZBwx4xLOvGAwuF5G+cg7x3frOFQW6noEfehw2nHh
        ucLrWtJ3WgFY+Bb9l+yz/NA=
X-Google-Smtp-Source: AGRyM1sZxtJChIafkQ//v0PvExkGTbn6NttZ0yNG8QxVW/Qp2Qb6OeR0R5t3Dvq5fb2otXRJhSTbZA==
X-Received: by 2002:aa7:814b:0:b0:525:1ada:329b with SMTP id d11-20020aa7814b000000b005251ada329bmr8360890pfn.34.1655726403372;
        Mon, 20 Jun 2022 05:00:03 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id w26-20020a62c71a000000b0051bbd79fc9csm8853516pfg.57.2022.06.20.05.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 05:00:03 -0700 (PDT)
From:   zys.zljxml@gmail.com
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     bob.beckett@collabora.com, matthew.auld@intel.com,
        thomas.hellstrom@linux.intel.com, kernel@collabora.com,
        linux-kernel@vger.kernel.org, katrinzhou <katrinzhou@tencent.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [PATCH v2] drm/i915/gem: add missing else
Date:   Mon, 20 Jun 2022 19:59:53 +0800
Message-Id: <20220620115953.1875309-1-zys.zljxml@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: katrinzhou <katrinzhou@tencent.com>

Add missing else in set_proto_ctx_param() to fix coverity issue.

Addresses-Coverity: ("Unused value")
Fixes: d4433c7600f7 ("drm/i915/gem: Use the proto-context to handle create parameters (v5)")
Suggested-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Signed-off-by: katrinzhou <katrinzhou@tencent.com>
---
Update from v1:
Fixed the code logic as suggested by Tvrtko Ursulin.

 drivers/gpu/drm/i915/gem/i915_gem_context.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
index ab4c5ab28e4d..1099a383e55a 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
@@ -933,7 +933,8 @@ static int set_proto_ctx_param(struct drm_i915_file_private *fpriv,
 	case I915_CONTEXT_PARAM_PERSISTENCE:
 		if (args->size)
 			ret = -EINVAL;
-		ret = proto_context_set_persistence(fpriv->dev_priv, pc,
+		else
+			ret = proto_context_set_persistence(fpriv->dev_priv, pc,
 						    args->value);
 		break;
 
-- 
2.27.0

