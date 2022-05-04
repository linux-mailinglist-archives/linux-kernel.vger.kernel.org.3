Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8DE5198E9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345719AbiEDH4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345869AbiEDHzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:55:46 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A014A1AF02;
        Wed,  4 May 2022 00:52:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id E009741E64;
        Wed,  4 May 2022 07:52:00 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Apple SoC cpufreq driver
Date:   Wed,  4 May 2022 16:51:49 +0900
Message-Id: <20220504075153.185208-1-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Here's a second take on the cpufreq driver for Apple SoCs. This is a
complete rewrite using a stand-alone cpufreq driver instead of using the
cpufreq-dt infrastructure.

Since v1 we ran some experiments on the memory controller performance
switching and it turns out it doesn't make a huge difference, so it
makes sense to punt that feature to the future (perhaps once a proper
memory controller driver exists for other reasons, e.g. for error
handling).

One advantage of having a standalone cpufreq driver is that we can
support fast switching. This also means any future interaction with
the memory controller will probably use some bespoke mechanism instead
of the genpd infrastructure, so we can keep the fast path without
allowing sleeps/etc.

The driver is based on scpi-cpufreq.c, with some bits (e.g. the
apple,freq-domain stuff) inspired by how cpufreq-qcom-hw does it.
I'm not sure if that particular property should be described
in a binding, since it goes in the cpu nodes (qcom doesn't have it
anywhere...).

Changes since v1:
- Complete rewrite
- Reports current frequency to userspace properly (incl. if different
  from requested due to hardware constraints)
- Supports fast switching
- MCC latency control stuff no longer included, punted for later
- Supports exposing higher states as turbo states

Hector Martin (4):
  MAINTAINERS: Add entries for Apple SoC cpufreq driver
  dt-bindings: cpufreq: apple,soc-cpufreq: Add binding for Apple SoC
    cpufreq
  cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states
  arm64: dts: apple: Add CPU topology & cpufreq nodes for t8103

 .../bindings/cpufreq/apple,soc-cpufreq.yaml   | 121 +++++++
 MAINTAINERS                                   |   2 +
 arch/arm64/boot/dts/apple/t8103.dtsi          | 203 ++++++++++-
 drivers/cpufreq/Kconfig.arm                   |   9 +
 drivers/cpufreq/Makefile                      |   1 +
 drivers/cpufreq/apple-soc-cpufreq.c           | 330 ++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +
 7 files changed, 658 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/apple,soc-cpufreq.yaml
 create mode 100644 drivers/cpufreq/apple-soc-cpufreq.c

-- 
2.35.1

