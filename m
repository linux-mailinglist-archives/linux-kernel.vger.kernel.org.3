Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CF84AC64A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382449AbiBGQoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiBGQis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:38:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D129C0401CE;
        Mon,  7 Feb 2022 08:38:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 968D260FA0;
        Mon,  7 Feb 2022 16:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379AEC004E1;
        Mon,  7 Feb 2022 16:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644251926;
        bh=d1P7xXA0sn7Ib/qlqtAf54sGUHU/Uu61l57wjUHrrsU=;
        h=From:To:Cc:Subject:Date:From;
        b=inbf3l7d4gkyu8w5vIZ7z24auQUKHzTjjg49M4baRxTUm2Iov61sRatRv0WoV0BUT
         Y3SdKlGn4iY26AGSoEXmDOKrF6dInPNWkLzU6/4pFGlgnYAd4wPx3T/w5iO5MkZ3l+
         gGWroPswyhZ6FptlIzI/B5D0W2ozDX7dw9j3jNFPBnNsZk3LvMSaj0Xrachd+7uJDz
         ImUqk3nl242sV7Yh3KXsxMaVrPxxh+RN10tfCH7O2NlPctIv0Ow8epTzdWw84WSe2o
         b30JZKMw81dGBSK8PlScZHcHZqJnKML15mNoc6Bq4K84cfYx6YS7wAbrkN7QTGH5OY
         18p+T7G2kiB4A==
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] thermal: netlink: Fix parameter type of thermal_genl_cpu_capability_event() stub
Date:   Mon,  7 Feb 2022 09:38:29 -0700
Message-Id: <20220207163829.1025904-1-nathan@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with CONFIG_THERMAL_NETLINK=n, there is a spew of warnings
along the lines of:

  In file included from drivers/thermal/thermal_core.c:27:
  In file included from drivers/thermal/thermal_core.h:15:
  drivers/thermal/thermal_netlink.h:113:71: warning: declaration of 'struct cpu_capability' will not be visible outside of this function [-Wvisibility]
  static inline int thermal_genl_cpu_capability_event(int count, struct cpu_capability *caps)
                                                                        ^
  1 warning generated.

'struct cpu_capability' is not forward declared anywhere in the header.
As it turns out, this should really be 'struct thermal_genl_cpu_caps',
which silences the warning and makes the parameter types of the stub
match the full function.

Fixes: e4b1eb24ce5a ("thermal: netlink: Add a new event to notify CPU capabilities change")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/thermal/thermal_netlink.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_netlink.h b/drivers/thermal/thermal_netlink.h
index 04d1adbbc012..1052f523188d 100644
--- a/drivers/thermal/thermal_netlink.h
+++ b/drivers/thermal/thermal_netlink.h
@@ -110,7 +110,7 @@ static inline int thermal_genl_sampling_temp(int id, int temp)
 	return 0;
 }
 
-static inline int thermal_genl_cpu_capability_event(int count, struct cpu_capability *caps)
+static inline int thermal_genl_cpu_capability_event(int count, struct thermal_genl_cpu_caps *caps)
 {
 	return 0;
 }

base-commit: 08615cb8c0e1deeca5489d672213fb205fa53c3b
-- 
2.35.1

