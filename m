Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB11534E39
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242598AbiEZLnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242381AbiEZLn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:43:27 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8777393E3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:43:24 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id i1so1222278plg.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kq02GySVi94nZ9Mc+L7RCzpSrSe7oKjAYDJQaI+i1/M=;
        b=jozl4ktxfx3kr41Xwo8mDlqT0z+gvOtnOWlJyYgee9yUgxgyfuOYUr1lx4RnOCQ6/1
         EBChnizEhkGg98Qpb9CpWmqjZ9uwiJaLdKFSO74efjp/2WlLeF/PdqTf24D+LPN1P8LG
         ut0mRRmlv8336aUyZvx8kApwOfcK8sDhtM7WuIfl2MBmS6ZuL17nr1XnMweom7zSFLQr
         SU1LW9cXuv0oj342u5+FBEYK8zvWP3Ncp6alE6PlZBLutNfav0Wkn2mPAAiG73k05zRM
         KXagAGOXvyhZJWcXTLNF9MpM0OMfwxpf1lgKnc+SiFLpACDo558o3HfUfDT5kBkmCL4j
         kpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kq02GySVi94nZ9Mc+L7RCzpSrSe7oKjAYDJQaI+i1/M=;
        b=UaTcxVSANwMwa1vGK7SdG6nxKUvShnk89fhmhxZDl8Rr2WIKifzk7isInHYLFCa5vJ
         SIxzhnDw5kB9uymsnewieg4yMjNYqUSvfGuzJJlzFkKfYX5kJqGZ+8kClGWFJpp4PGhl
         WmIiiBjmXlzqRC+7NCAThfpiR0loqOxaSOY3xS7PUqTpEdS/knI/vB/mQTuoLQDib6Yq
         3Xa0OHih2lU1CSYWX8Tf7nNv9Is4qDOL5fYIDUKISAyciaAtVL8CdqCBW9yBZVyjH2ME
         GqHnpaRsXBQSRkPIAkEn6q95lNJTLZGZXR8S1lR2tLOb0ulp1CU0+pfjUjEyarNogL/n
         jPgQ==
X-Gm-Message-State: AOAM533ajCaizE7YtmKtCNp5Km7NhzhU9IQXV7TjramUlYgOh82QVSL4
        Quxbz6j2eSlUB9W6a2VaHYumKg==
X-Google-Smtp-Source: ABdhPJxfALbrt1KmDbthK4aKVj2I9eMN8ID458hdF4feL14JAdfjm2AEeZoz0NS/AVyWmIjpPI7ETg==
X-Received: by 2002:a17:902:7781:b0:161:c85a:8fff with SMTP id o1-20020a170902778100b00161c85a8fffmr37569596pll.97.1653565404194;
        Thu, 26 May 2022 04:43:24 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id a16-20020aa78650000000b0050dc7628137sm1320375pfo.17.2022.05.26.04.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:43:23 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, NXP Linux Team <linux-imx@nxp.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Qiang Yu <yuq825@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>, Rob Herring <robh@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sean Paul <sean@poorly.run>, Shawn Guo <shawnguo@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        lima@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org
Subject: [PATCH 00/31] OPP: Add new configuration interface: dev_pm_opp_set_config()
Date:   Thu, 26 May 2022 17:11:59 +0530
Message-Id: <cover.1653564321.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We have too many configuration specific APIs currently, six of them already,
like dev_pm_opp_set_regulators(). This makes it complex/messy for both the OPP
core and its users to manage. There is also code redundancy in these API, in the
way they add/manage the OPP table specific stuff.

This patch series is an attempt to simplify these interfaces by adding a single
interface, dev_pm_opp_set_config(), which replaces all the existing ones. This
also migrates the users to the new API.

The first two patches help get the API in place, followed by patches to migrate
the end users. Once all the users are migrated, the last few patches remove the
now unused interfaces.

I have lightly tested this on Hikey960 for now and also getting help from
various build/boot bots, gitlab and lkp, to get these tested. It would be
helpful if someone with access to the affected platforms can give it a try.

This is pushed here:

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/config

The entire patchset shall get merged via the OPP tree in 5.20-rc1, please do not
merge individual patches.

Thanks.

--
Viresh

Viresh Kumar (31):
  OPP: Track if clock name is configured by platform
  OPP: Add dev_pm_opp_set_config() and friends
  cpufreq: dt: Migrate to dev_pm_opp_set_config()
  cpufreq: imx: Migrate to dev_pm_opp_set_config()
  cpufreq: qcom-nvmem: Migrate to dev_pm_opp_set_config()
  cpufreq: sti: Migrate to dev_pm_opp_set_config()
  cpufreq: sun50i: Migrate to dev_pm_opp_set_config()
  cpufreq: tegra20: Migrate to dev_pm_opp_set_config()
  cpufreq: ti: Migrate to dev_pm_opp_set_config()
  devfreq: exynos: Migrate to dev_pm_opp_set_config()
  devfreq: sun8i: Migrate to dev_pm_opp_set_config()
  devfreq: tegra30: Migrate to dev_pm_opp_set_config()
  drm/lima: Migrate to dev_pm_opp_set_config()
  drm/msm: Migrate to dev_pm_opp_set_config()
  drm/panfrost: Migrate to dev_pm_opp_set_config()
  drm/tegra: Migrate to dev_pm_opp_set_config()
  media: venus: Migrate to dev_pm_opp_set_config()
  media: tegra: Migrate to dev_pm_opp_set_config()
  mmc: sdhci-msm: Migrate to dev_pm_opp_set_config()
  OPP: ti: Migrate to dev_pm_opp_set_config()
  soc/tegra: Remove the call to devm_pm_opp_set_clkname()
  soc/tegra: Migrate to dev_pm_opp_set_config()
  spi: qcom: Migrate to dev_pm_opp_set_config()
  serial: qcom: Migrate to dev_pm_opp_set_config()
  OPP: Remove dev_pm_opp_set_regulators() and friends
  OPP: Remove dev_pm_opp_set_supported_hw() and friends
  OPP: Remove dev_pm_opp_set_clkname() and friends
  OPP: Remove dev_pm_opp_register_set_opp_helper() and friends
  OPP: Remove dev_pm_opp_attach_genpd() and friends
  OPP: Remove dev_pm_opp_set_prop_name() and friends
  OPP: Rearrange dev_pm_opp_set_config() and friends

 drivers/cpufreq/cpufreq-dt.c                  |  14 +-
 drivers/cpufreq/imx-cpufreq-dt.c              |  12 +-
 drivers/cpufreq/qcom-cpufreq-nvmem.c          | 107 +---
 drivers/cpufreq/sti-cpufreq.c                 |  22 +-
 drivers/cpufreq/sun50i-cpufreq-nvmem.c        |  11 +-
 drivers/cpufreq/tegra20-cpufreq.c             |  12 +-
 drivers/cpufreq/ti-cpufreq.c                  |  38 +-
 drivers/devfreq/exynos-bus.c                  |  14 +-
 drivers/devfreq/sun8i-a33-mbus.c              |   7 +-
 drivers/devfreq/tegra30-devfreq.c             |   8 +-
 drivers/gpu/drm/lima/lima_devfreq.c           |  11 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |   8 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |  10 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |   5 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c              |   5 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c            |   5 +-
 drivers/gpu/drm/panfrost/panfrost_devfreq.c   |   9 +-
 drivers/gpu/drm/tegra/gr3d.c                  |   6 +-
 .../media/platform/qcom/venus/pm_helpers.c    |  16 +-
 drivers/memory/tegra/tegra124-emc.c           |  14 +-
 drivers/mmc/host/sdhci-msm.c                  |   5 +-
 drivers/opp/core.c                            | 540 +++++++-----------
 drivers/opp/opp.h                             |   2 +
 drivers/opp/ti-opp-supply.c                   |   6 +-
 drivers/soc/tegra/common.c                    |  14 +-
 drivers/soc/tegra/pmc.c                       |   8 +-
 drivers/spi/spi-geni-qcom.c                   |   5 +-
 drivers/spi/spi-qcom-qspi.c                   |   5 +-
 drivers/tty/serial/qcom_geni_serial.c         |   5 +-
 include/linux/pm_opp.h                        | 118 ++--
 30 files changed, 444 insertions(+), 598 deletions(-)

-- 
2.31.1.272.g89b43f80a514

