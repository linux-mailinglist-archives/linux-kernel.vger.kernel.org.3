Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA5656A2F4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbiGGM5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbiGGM4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:56:48 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF313190B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 05:56:15 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id t19so30327911lfl.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 05:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H6677ejFNXKglyi/84+y7ULfVLWnlMQ6vEtVbRnv+vI=;
        b=Mh7gtpR4GcdX4WcgpOC+AbgtdPP6eO6z1dw11i6JBWeX1ULeCBz+lpRR3pORehirTa
         86zxMqdsM7RuDU6w8EOL+0bNM0etAC2TTxfd4rjD2DVTQzvN0l2yN2NkcKW/SOItDMpU
         dFVvBoNMbXV0ILGAfklsAmdtRatKiwTaUIozP2JEbk7/qALXd9p+qfz20kNNYlYV1qWV
         WsTlyC+6KzVBm4GRcpUC6E5dhO3jWsgT93LvIVR6DWK6RLgMWU6M7UZiEttdlYL7cA14
         1HDKQnyd1ly1tq5a3Tn/QJaBOUD1v1VUs2HOlRK7LDuaJp9FoGvesu5Aen5x1orm1k3l
         DQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H6677ejFNXKglyi/84+y7ULfVLWnlMQ6vEtVbRnv+vI=;
        b=xbQSQGY6IV5uPaxa+VYmMzkYNEVfdg65qWI+wD5Z+GyWM/v4z4tc1IIQuwjVjJNVpF
         20TJiysyTIvIer39bCSmou7brV2+Lpcs828k1Wd2DCLfse1gHvfY02LU4NeQG1vT9F2b
         3mu2eOSeeRek5BHDv31swWHF0grURyQZ5eKVPq0MyjFM8gUjMXpsz3awHKcKdyAt/Rt7
         Vgz8iMm8ntB+ynyudyCaOoKMeGrp80dBrzyvCg5/YM/k0qGvrT1VEAH5MeUhjE0A4W97
         i5WEkyngBX7afQs+nxtefbYpX8/zV03WBj9Kmfn3SkYBIplyi3aTWj+6WzUzu8rS3OGu
         35Yw==
X-Gm-Message-State: AJIora+GWfJ1WddCkJgD0icvjs+LgYHXp3URP7ylktMUuRLN/jLDFHPF
        HJwHzLx/84oWN65rZsQMPX6ty+SOn1PMiA==
X-Google-Smtp-Source: AGRyM1tJ3jCvJ5a/DkRtsTuF+6ZetmEjN6/i+Wqc17/EryWUTrJPKEaxdDE3XdzFq4E7wl3HyOZznw==
X-Received: by 2002:a05:6512:3d89:b0:47f:c089:1c7f with SMTP id k9-20020a0565123d8900b0047fc0891c7fmr31065785lfv.72.1657198573447;
        Thu, 07 Jul 2022 05:56:13 -0700 (PDT)
Received: from jazctssd.c.googlers.com.com (138.58.228.35.bc.googleusercontent.com. [35.228.58.138])
        by smtp.gmail.com with ESMTPSA id d7-20020a05651221c700b0047255d2111csm6810361lft.75.2022.07.07.05.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 05:56:12 -0700 (PDT)
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
To:     linux-kernel@vger.kernel.org
Cc:     jaz@semihalf.com, dmy@semihalf.com, mario.limonciello@amd.com,
        seanjc@google.com, dbehr@google.com, upstream@semihalf.com,
        zide.chen@intel.corp-partner.google.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sachi King <nakato@nakato.io>,
        linux-acpi@vger.kernel.org (open list:ACPI),
        platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS),
        linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend,
        aka swsusp))
Subject: [RFC PATCH 0/2] x86: allow to notify host about guest entering s2idle
Date:   Thu,  7 Jul 2022 12:53:22 +0000
Message-Id: <20220707125329.378277-1-jaz@semihalf.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
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

According to the mailing list discussion [1] about the preferred approach
for notifying hypervisor/VMM about guest entering s2idle state this RFC was
implemented.

Instead of original hypercall based approach, which involves KVM change [2]
and makes it hypervisor specific, implement different mechanism, which
takes advantage of MMIO/PIO trapping and makes it hypervisor independent.

Patch #1 extends S2Idle ops by new notify handler which will be invoked as
a very last command before system actually enters S2Idle states. It also
allows to register and use driver specific notification hook which is used
in patch #2.

Patch #2 introduces new driver for virtual PMC, which registers
acpi_s2idle_dev_ops's notify handler. Its implementation is based on an
ACPI _DSM evaluation, which in turn can perform MMIO access and allow to
trap and therefore notify the VMM about guest entering S2Idle state.

Please see individual patches and commit logs for more verbose description.

This patchset is marked as RFC since patch #2 implements driver for non
existing device "HYPE0001", which ACPI ID was not registered yet.
Furthermore the required registration process [3] will not be started
before getting positive feedback about this patchset.

[1] https://patchwork.kernel.org/project/linux-pm/patch/20220609110337.1238762-2-jaz@semihalf.com/
[2] https://patchwork.kernel.org/project/linux-pm/patch/20220609110337.1238762-3-jaz@semihalf.com/
[3] https://uefi.org/PNP_ACPI_Registry

Grzegorz Jaszczyk (2):
  suspend: extend S2Idle ops by new notify handler
  platform/x86: Add virtual PMC driver used for S2Idle

 drivers/acpi/x86/s2idle.c       | 11 +++++
 drivers/platform/x86/Kconfig    |  7 ++++
 drivers/platform/x86/Makefile   |  1 +
 drivers/platform/x86/virt_pmc.c | 73 +++++++++++++++++++++++++++++++++
 include/linux/acpi.h            |  1 +
 include/linux/suspend.h         |  1 +
 kernel/power/suspend.c          |  4 ++
 7 files changed, 98 insertions(+)
 create mode 100644 drivers/platform/x86/virt_pmc.c

-- 
2.37.0.rc0.161.g10f37bed90-goog

