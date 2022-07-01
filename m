Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33149562E60
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbiGAIfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbiGAIfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:35:03 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262D7BCB6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:35:02 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 9so1787903pgd.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 01:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KOpKbX2Aw5S21DCHzWgLXRtFDwXd+N11MitmreJL0k4=;
        b=eR+LCpQvJUTzjbkZrb9tmsVKv3q/ovUMm3ZLSUurNuTMhio7FXaK65gUqR97e32TXb
         tnM1Y9mb5Krr+WHNJ7gp6Xt5TZbvBoEg8NEJ4K3fntk/21+q7/PUD0uaYqyzYLMYzl5W
         ftVvx2BWatW5F+sx/ZWtzu2+2104rkfi+4Y6eGScVVBA2ivcu7ctLk0Xr+IUbgW/Tg7a
         DCUP+ACTSk60AmJY3t13aviXjq7zHYY2ls7PbtR3HEjSMMrkapNGroo4iidlZuFfQwJ+
         0uoVfsfU59waY3ivJeEJNrgjY/q9EBE9dP6mQ/1DjiIFsvACLD2rKrPCKCfc0MfLXrjQ
         5dVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KOpKbX2Aw5S21DCHzWgLXRtFDwXd+N11MitmreJL0k4=;
        b=4fXCmniGjiyJrG+0NCymCVrYTq6GYoqEXE+8F9eq+Mq1ODi9iTnCI9R0sQVsIo8bbb
         fe84/8f99IeDC0+6nI7w4ECll1jUYxa3BOVigbzD3qJ8/mvvqefI1w5ZNFzObvCwsBSz
         blu2yxqrnlWBkRtqRlPxb/6KUBOfnzHMiX316zbnocdcNY+IlrYB5UerhGAxCJbxUKey
         /xXIcJLYOq3VtkwtRCMQvxiRr+MdlTv7Y2vgojyyejDuYOQlc7PdOdJbBCtzS8IwDHnU
         RyFjfk6vqM7+dDBc1du2tojJ8xFST/d1MqlhgK6a41xRy/0mOA8bD/WWq3PGcNYAg6jU
         fHtw==
X-Gm-Message-State: AJIora8ZtPj2tKOLAop2AImH4nuY5loXJEbNvML0s4hRRlFOPSasZljO
        VJ/nFeePWW+nn6ImwVZgzXPvgA==
X-Google-Smtp-Source: AGRyM1toiPtVO0qmNrWNF5/VSQwp2dZ4/kvA+LGSZXYv/Iys+O9E7DfO0GA/W8CHClG64kwbXdc/fA==
X-Received: by 2002:a63:105d:0:b0:40d:a82d:ef0e with SMTP id 29-20020a63105d000000b0040da82def0emr11627113pgq.57.1656664501648;
        Fri, 01 Jul 2022 01:35:01 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id ru10-20020a17090b2bca00b001e880972840sm3475376pjb.29.2022.07.01.01.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:35:01 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/5] OPP: Replace custom set_opp() with config_regulators()
Date:   Fri,  1 Jul 2022 14:04:50 +0530
Message-Id: <cover.1656664183.git.viresh.kumar@linaro.org>
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

Hi,

Currently the custom set_opp() helper, which is implemented only for OMAP, is
responsible to set both clock and regulators for the device and may end up doing
tricky stuff behind the scene. This makes the OPP core contain special code to
support it.

This patch series tries to streamline the code path in _set_opp() in the OPP
core and minimize the platform specific code within it. The platforms provide a
config_regulators() callback now, from which they should only program the
regulators in their preferred sequence. Rest of the code sequence to program
clk, bw, required-opps, etc is common across all device and platform types and
is present in the OPP core.

Keerthy/Dave: I couldn't test it on omap, can any of you do that please ? It
builds just fine though. Also maybe you can simplify the OPP driver to drop all
restoration logic on failures, as the OPP core doesn't do any of it as well. I
can add a patch for that if you guys are fine with it.

This is pushed here along with other dependencies:

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next

V1->V2:
- Moved back to 80 column width instead of 100.
- Rebased over updated set-config API changes, which forced minor changes to
  this series as well.

Thanks.

--
Viresh

Viresh Kumar (5):
  OPP: Add support for config_regulators() helper
  OPP: Make _generic_set_opp_regulator() a config_regulators() interface
  OPP: Add dev_pm_opp_get_supplies()
  OPP: ti: Migrate to config_regulators()
  OPP: Remove custom OPP helper support

 drivers/opp/core.c          | 218 +++++++++++++-----------------------
 drivers/opp/opp.h           |   9 +-
 drivers/opp/ti-opp-supply.c |  74 ++++++------
 include/linux/pm_opp.h      |  46 ++------
 4 files changed, 125 insertions(+), 222 deletions(-)

-- 
2.31.1.272.g89b43f80a514

