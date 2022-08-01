Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A9A587404
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 00:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbiHAWgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 18:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiHAWgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 18:36:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A72474C2;
        Mon,  1 Aug 2022 15:36:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D36360E74;
        Mon,  1 Aug 2022 22:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BA4C433D6;
        Mon,  1 Aug 2022 22:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659393400;
        bh=9JcV2Q8bWTkqF5wLFIVQqKEZQK5g+SQKeAUa9wTSna4=;
        h=From:To:Cc:Subject:Date:From;
        b=aaMkcyp8Z3oMKRU20Cx4NyvY1XiEb1rsN5sSHyAWp+FU4zCHgIuJm4gKB0pu1nwim
         sBse/O8TqWuavA5cppkOgj3824ZhTEumiVSrDrcBPqLttK/v33kXEWDCE0s1m9LaRl
         AvnmWSO7I97YcfdEGIYwdREwav5AdcOqkqgV1oGytk8HGKw99fYJX9hXPDnTsck0Uv
         jkZs4rggg/4/QIPLi059giGYjKH/lU92MHBL0IlKoLWzf5IVmUWQikE7CNl/FAzJQb
         /aeFWQlOmYECJ37qMt3B/DQI5+KaKhpDi1dR70Egih9TcNcqEBBq+s9F9fpbKMXGvy
         776nnQ2jS0fGQ==
From:   broonie@kernel.org
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-samsung-soc@vger.kernel.org
Subject: linux-next: build failure after merge of the thermal tree
Date:   Mon,  1 Aug 2022 23:35:09 +0100
Message-Id: <20220801223509.3613888-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After merging the thermal tree, today's linux-next build (x86
allmodconfig) failed like this:

/tmp/next/build/drivers/thermal/samsung/exynos_tmu.c:753:44: warning: 'struct thermal_zone' declared inside parameter list will not be visible outside of this definition or declaration
  753 | static int exynos_tmu_set_emulation(struct thermal_zone *tz, int temp)
      |                                            ^~~~~~~~~~~~
/tmp/next/build/drivers/thermal/samsung/exynos_tmu.c:1002:19: error: initialization of 'int (*)(struct thermal_zone_device *, int)' from incompatible pointer type 'int (*)(struct thermal_zone *, int)' [-Werror=incompatible-pointer-types]
 1002 |  .set_emul_temp = exynos_tmu_set_emulation,
      |                   ^~~~~~~~~~~~~~~~~~~~~~~~
/tmp/next/build/drivers/thermal/samsung/exynos_tmu.c:1002:19: note: (near initialization for 'exynos_sensor_ops.set_emul_temp')
cc1: some warnings being treated as errors

Caused by commit

  a5e9a144258bf898 ("thermal/drivers/samsung: Switch to new of thermal API")

which looks like it missed some conversions.

I'll figure out how to handle this tomorrow since I don't expect to
release today, I'm just droping the tree for now.
