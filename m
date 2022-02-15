Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A602D4B78F2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242046AbiBOQ7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:59:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240210AbiBOQ7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:59:23 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E11E6C33
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:59:13 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v5-20020a17090a4ec500b001b8b702df57so3587260pjl.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FZyiKLAW9BbRnWoxkEpL7S0ZZmPXy7UVMTqOLD6cAI4=;
        b=Hx/sDbEqZCh1Y9ds0uDdK7HLp2F9lWoREIgaEuWcivvHgIDNmfh6XmAKKVlnPqVUA0
         rKQdkDONXxVxATIPsjOE5VZedrrm7H2y4K0rjdHVNFCdIEyzy8aWVGZo+iuFxarjUduk
         Av54hcFQHQy/oydYj3d3wSDY+rm1hnmi5tEj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FZyiKLAW9BbRnWoxkEpL7S0ZZmPXy7UVMTqOLD6cAI4=;
        b=Se8yr2lf2JxDXUZJZz3vr4SZzaSK6DbH+Z53tYPlC46sFsiXX6pFM69EAthOhu2gNR
         4bTYeXfuLvx+3fGCBHOcH1O9pDRIgmjdnjOfzYjygcqA0/MErbUcJNJZJWhyZ5VAVOzU
         P2W9S25GRNvgClyFHo7JWSSJiOEpTUDfD7tfCvrTu/qOJy6oMFNgvfvOWzb8Nqizwvof
         dwQi6pmUX1J3wbq8oBfPi9wLQ7GXZ/ZGUoxahqPPJK1/y+GBlZY/uUj5rnH6DsipctGI
         Tnvg7mpS5rC7dhLOyIsmDv+d0REeYPjB3NqxOIkzQ6uW7y0pm5at4LncrxzJZxwbE7xH
         slew==
X-Gm-Message-State: AOAM5325MEpCrk+0StwQ1UDC9xu/df/cczJ1zC97LPfidPqW6ind/Rq9
        YbqPlvayx39z6vN98cQ3P5/J6EkjnaVHCA==
X-Google-Smtp-Source: ABdhPJxP3ror6tXJ9OvOepiPuz2V2mg5HSvFBpBlXxjmNzqEzv46ysXk1+cg1B8JwbSgDwRduTNPJw==
X-Received: by 2002:a17:90a:5302:b0:1b9:ba0a:27e5 with SMTP id x2-20020a17090a530200b001b9ba0a27e5mr5269852pjh.91.1644944352859;
        Tue, 15 Feb 2022 08:59:12 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ml19sm17641552pjb.52.2022.02.15.08.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 08:59:12 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] lib/test_stackinit: Expand variable size for correct testing
Date:   Tue, 15 Feb 2022 08:59:10 -0800
Message-Id: <20220215165910.1246018-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1054; h=from:subject; bh=tMzFz6sTvyZ1pCP6R5gpFvU6+FL0UFjQuAjYo3xvwvs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiC9veD9cDequg8cOBRgQHWh2TA4IxlFixVpCBvufd /2VoEZ+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYgvb3gAKCRCJcvTf3G3AJpzaD/ 9RpMX41GM8zYrUXRgXOXHfxzPB2qe2eqpwRmiI67tWN1zGjTIdgar4lAtFbTBa+1P9FYizlfla9qXm gCQhV86QEmIG+NwQiiX2J7aHrSGCvNVCjDzIm7WO2jFov+j/ySIu6Odx+1OHVdoj7S5KafZY2PTrUm jfu9AIlLbfdKWrP6bMQYYXiVRO75GIk120Jwyth6EftNkO8RHQG66Hxnk5bSCIiS7MuyecWnUcz+/6 ylRHA2tK2siZ8pShdGC+aSXeOLATIAHNFv66WB6S/qCcCKCSmocze3zs4cZBv6O0czFgWMX4czKsp1 hiRmAVi76FKFg3cmD5itQlITlf4RxifKQ08LVcfjfiRHaYsleac4wewbG0OjboqQZlnGCnLClXXb2U kdGSGZnH/t9qvjEqw5CaV05BhsCAd7cYAchQc89IgfK0cnLAc7yo1eyl2l3xScPVglidfjaJAq1+69 PFbfb1gH5nKzfdyfQj7OhgSfZd9Ot6YrckKQY+JWRLvO+OkBw5Hl+MbuiLbwEsoa7bjD6lyFAf4stA xJJ/aYwhB2jmSVz5mL5HpQRz/KaUfqGniE9rOgRgvwUISjx6UbMnIaUmmPxlqwgDoIhUc1H/XGR/oI LJWw1zffPJeVfOVmJ9CaoCp6WB3BalG82iqIaUCaRtJwMqfO+qa7U0bO8neA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pre-case switch variable was too small for the test to detect
missing initialization. Expand the variable so the test will start to
(expectedly) fail again.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/test_stackinit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/test_stackinit.c b/lib/test_stackinit.c
index a3c74e6a21ff..70bb4f7dea38 100644
--- a/lib/test_stackinit.c
+++ b/lib/test_stackinit.c
@@ -398,7 +398,7 @@ static int noinline __leaf_switch_none(int path, bool fill)
 		 * This is intentionally unreachable. To silence the
 		 * warning, build with -Wno-switch-unreachable
 		 */
-		uint64_t var;
+		uint64_t var[10];
 
 	case 1:
 		target_start = &var;
@@ -423,8 +423,8 @@ static int noinline __leaf_switch_none(int path, bool fill)
 		memcpy(check_buf, target_start, target_size);
 		break;
 	default:
-		var = 5;
-		return var & forced_mask;
+		var[1] = 5;
+		return var[1] & forced_mask;
 	}
 	return 0;
 }
-- 
2.30.2

