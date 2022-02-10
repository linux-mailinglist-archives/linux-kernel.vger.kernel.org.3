Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5161C4B0B79
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240269AbiBJKzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:55:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240231AbiBJKzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:55:22 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A486C24
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644490524; x=1676026524;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uRRbslkySxYHqPWjzBuWVAPZZpAh6rtYQZifothcSNc=;
  b=UdHTe0Gde4HCkSCMKXiYKBU7+y/XIjp5D+w9V8rz+AJ9D/6bXRPWmPmo
   gQ5do46hQBJDhAkKRe40Pj+LQcDFQHp6umvwC1DncoDssBTyFjvAVUdfO
   M+RLDALLaIaPoBrxdB/CHh7ruqxwuqHLWDQFK8rbAbJ+jhBVTkgNyPjqt
   6GYsgC5GOaFja2O1rkmingJq7jHjrl/gfzKwvUFCxtDNlMcD93OWk5Tvw
   R6w4/8njDlzzXNX4ISNurc2JdFd4F+a8JKEPWV0egZ0hNSdWaRbId+dtF
   zYRbKK9g2XGabcB5RNI1jLDMTmP+t3D2m+telY1PcOTKKIQlKFmQ6/rMG
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="310202817"
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="310202817"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 02:55:23 -0800
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="679106832"
Received: from barabano-mobl.ccr.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.41.18])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 02:55:20 -0800
From:   Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To:     lgirdwood@gmail.com, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com
Cc:     alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, tiwai@suse.com,
        linux-kernel@vger.kernel.org, fred.oh@linux.intel.com
Subject: [PATCH 0/9] ASoC: SOF: IPC client infrastructure
Date:   Thu, 10 Feb 2022 12:55:10 +0200
Message-Id: <20220210105519.19795-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The Linux SOF implementation is historically monolithic in a sense that all
features accessible in the firmware can be used via the snd_sof_dev struct in
one way or another.

Support for features can not be added or removed runtime and with the current
way of things it is hard if not impossible to implement support for dynamic
feature support when based on the firmware manifest we can easily enable/access
independent modules with the SOF.

In order to be able to support such modularity this series introduces a small
framework within SOF for client support using the Auxiliary bus.

Client drivers can be removed runtime and later re-loaded if needed without
affecting the core's behaviour, but it is the core's and the platform's duty
to create the Auxiliary devices usable in the platform and via the firmware.

There is still a need for SOF manifest update to convey information about
features to really make the full dynamic client device creation.

The series will introduce the core SOF client support and converts the generic
ipc flood test, ipc message injector and the probes (Intel HDA only) to a client
driver.

Regards,
Peter
---
Peter Ujfalusi (8):
  ASoC: SOF: Drop unused DSP power states: D3_HOT and D3_COLD
  ASoC: SOF: Move the definition of enum sof_dsp_power_states to global
    header
  ASoC: SOF: ipc: Read and pass the whole message to handlers for IPC
    events
  ASoC: SOF: Split up utils.c into sof-utils and iomem-utils
  ASoC: SOF: Introduce IPC SOF client support
  ASoC: SOF: sof-client: Add support for clients not managed by pm
    framework
  ASoC: SOF: Convert the generic IPC message injector into SOF client
  ASoC: SOF: Convert the generic probe support to SOF client

Ranjani Sridharan (1):
  ASoC: SOF: Convert the generic IPC flood test into SOF client

 include/sound/sof.h                         |   8 +
 sound/soc/sof/Kconfig                       |  33 +-
 sound/soc/sof/Makefile                      |  15 +-
 sound/soc/sof/core.c                        |  50 +-
 sound/soc/sof/debug.c                       | 565 --------------
 sound/soc/sof/intel/Kconfig                 |  19 +-
 sound/soc/sof/intel/apl.c                   |  13 +-
 sound/soc/sof/intel/cnl.c                   |  13 +-
 sound/soc/sof/intel/hda-dai.c               |  19 -
 sound/soc/sof/intel/hda-dsp.c               |   6 -
 sound/soc/sof/intel/hda-probes.c            |  72 +-
 sound/soc/sof/intel/hda.c                   |  10 +
 sound/soc/sof/intel/hda.h                   |  49 +-
 sound/soc/sof/intel/icl.c                   |  13 +-
 sound/soc/sof/intel/tgl.c                   |  13 +-
 sound/soc/sof/{utils.c => iomem-utils.c}    |  61 +-
 sound/soc/sof/ipc.c                         |  88 ++-
 sound/soc/sof/ops.h                         |  43 -
 sound/soc/sof/pcm.c                         |   7 +-
 sound/soc/sof/pm.c                          |  13 +-
 sound/soc/sof/sof-client-ipc-flood-test.c   | 396 ++++++++++
 sound/soc/sof/sof-client-ipc-msg-injector.c | 192 +++++
 sound/soc/sof/sof-client-probes.c           | 821 ++++++++++++++++++++
 sound/soc/sof/sof-client-probes.h           |  31 +
 sound/soc/sof/sof-client.c                  | 469 +++++++++++
 sound/soc/sof/sof-client.h                  |  67 ++
 sound/soc/sof/sof-priv.h                    | 139 ++--
 sound/soc/sof/sof-probes.c                  | 364 ---------
 sound/soc/sof/sof-probes.h                  |  38 -
 sound/soc/sof/sof-utils.c                   |  77 ++
 sound/soc/sof/sof-utils.h                   |  19 +
 sound/soc/sof/trace.c                       |   1 +
 32 files changed, 2415 insertions(+), 1309 deletions(-)
 rename sound/soc/sof/{utils.c => iomem-utils.c} (59%)
 create mode 100644 sound/soc/sof/sof-client-ipc-flood-test.c
 create mode 100644 sound/soc/sof/sof-client-ipc-msg-injector.c
 create mode 100644 sound/soc/sof/sof-client-probes.c
 create mode 100644 sound/soc/sof/sof-client-probes.h
 create mode 100644 sound/soc/sof/sof-client.c
 create mode 100644 sound/soc/sof/sof-client.h
 delete mode 100644 sound/soc/sof/sof-probes.c
 delete mode 100644 sound/soc/sof/sof-probes.h
 create mode 100644 sound/soc/sof/sof-utils.c
 create mode 100644 sound/soc/sof/sof-utils.h

-- 
2.35.1

