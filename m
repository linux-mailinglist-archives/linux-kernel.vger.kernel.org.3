Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B9D51979A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 08:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345065AbiEDGyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 02:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345049AbiEDGyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 02:54:33 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD34205F9;
        Tue,  3 May 2022 23:50:58 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-163-222.tukw.qwest.net [174.21.163.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 9CB18169;
        Tue,  3 May 2022 23:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1651647057;
        bh=u1be6Hsy9QkoZoQsBwtNHnw+57iMhXxgiUyN9o/iLGk=;
        h=From:To:Cc:Subject:Date:From;
        b=hZUIcqjnEATs2o08eIaqBvgjwRtC90gHuN6pS3KxQax0Udv7Reuh5Mf6lIirwPSoZ
         6jtYdDcA0BoGGHgNa914YenMHmE8QgFFAVBBG/vEF4b9F+WJP177UBbq8VFThWoUvS
         QnXR9mMn/9fGYHALpPYdtBfPNEYgZngnmDHzX/1M=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Zev Weiss <zev@bewilderbeest.net>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH 0/6] regulator: core: Add support for external outputs
Date:   Tue,  3 May 2022 23:50:35 -0700
Message-Id: <20220504065041.6718-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series is a new approach at implementing some functionality
I previously attempted as a separate driver in drivers/misc [0], but I
think (as suggested by Greg in that thread) ultimately makes more
sense being built into the regulator subsystem.

The hardware arrangement essentially amounts to a regulator whose
output doesn't supply any devices within the system, but instead
simply feeds a "dumb" external output -- picture a typical power
distribution unit (PDU), but with DC outputs instead of AC.  (The
specific system I'm targeting at the moment is the Delta AHE-50DC
Open19 power shelf [1], for which I'm working on a port of OpenBMC.)

Supporting this doesn't require much in the way of new functionality,
just some plumbing so that userspace (typically a human operator
manually switching outlets on and off) can access the necessary bits
of the regulator subsystem, and some DT bindings to describe this sort
of setup.

The DT bindings changes (patches 1 and 2) consist of a boolean
regulator property to mark it as supplying an external output, and a
reg-external-output binding to act as a downstream device representing
that output.  The redundancy between the two maybe isn't entirely
ideal, but it was the cleanest approach I've been able to come up with
so far in terms of working with the regulator subsystem; I'm certainly
open to suggestions for better ways of going about this.

Within the regulator core, patch 3 exposes the REGULATOR_ERROR_* flags
(for regulators that define a get_error_flags() operation) to
userspace as a set of read-only sysfs attributes, so that operators
can diagnose the cause of faults that may occur, such as current or
thermal limits being exceeded.

Patch 4 adds support for the regulator-external-output property with a
couple of small functional tweaks, making the 'state' sysfs attribute
writable and skipping the auto-disabling in regulator_late_cleanup().
Patch 5 adds a special-purpose regulator_get_type (EXTERNAL_GET), and
patch 6 adds a tiny driver acting as a placeholder for an external
output, using EXTERNAL_GET.

Review/feedback appreciated!


Thanks,
Zev

[0] https://lore.kernel.org/openbmc/20220308011811.10353-1-zev@bewilderbeest.net/
[1] https://www.open19.org/marketplace/delta-16kw-power-shelf/

Zev Weiss (6):
  dt-bindings: regulator: Add regulator-external-output property
  dt-bindings: regulator: Add reg-external-output
  regulator: core: Add error flags to sysfs attributes
  regulator: core: Add external-output support
  regulator: core: Add external get type
  regulator: core: Add external-consumer driver

 .../ABI/testing/sysfs-class-regulator         |  85 ++++++++++++
 .../regulator/reg-external-output.yaml        |  37 +++++
 .../bindings/regulator/regulator.yaml         |   6 +
 drivers/regulator/Kconfig                     |   9 ++
 drivers/regulator/core.c                      | 130 ++++++++++++++++--
 drivers/regulator/devres.c                    |   7 +
 drivers/regulator/internal.h                  |   3 +
 drivers/regulator/of_regulator.c              |   2 +
 include/linux/regulator/machine.h             |   1 +
 9 files changed, 272 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/reg-external-output.yaml

-- 
2.36.0

