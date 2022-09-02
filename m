Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04A95AAF72
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 14:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237112AbiIBMic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 08:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237085AbiIBMhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 08:37:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DEC2FC
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 05:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662121184; x=1693657184;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fS3Zg6CR41DlCRJ3YlObPpVsOET9vzxsmZZDS1sOMxU=;
  b=SH/scYvvmnMCUsLpGS8cvXdETz61DaPLMRCCwWxQ0Innso3urnAiF9La
   62BRhlDaqh8dpkJo9ICeEmbLWps7M6YRzJLSURpLG9GCEW+EOHXJ4otTX
   82ZHsrerHCxaNxOGH+oAZAYzDSGb/+AKLM0ahyAj9kt5laTo2qFferDJh
   utT2VqwU7M1aAqVFQKNxKz2ASOxj4OIWZiWy4c/0ANcpYYpxFrg0eXDB0
   CquqgYSa/qHU/L19Up/Lm20GbqOX0H+3G/qzI8n+/qVVRA77TOALtZCcI
   2/tmHoHtXslpBFR1YUnBtvbeP8N2u93HBMS7rtRAJdUx4tz5PldWuKn7f
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="295974597"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="295974597"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 05:19:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="563946986"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by orsmga003.jf.intel.com with ESMTP; 02 Sep 2022 05:19:40 -0700
From:   Cezary Rojewski <cezary.rojewski@intel.com>
To:     alsa-devel@alsa-project.org, broonie@kernel.org
Cc:     tiwai@suse.com, perex@perex.cz,
        amadeuszx.slawinski@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com,
        lgirdwood@gmail.com, kai.vehmanen@linux.intel.com,
        peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com,
        yung-chuan.liao@linux.intel.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, andy@kernel.org,
        intel-poland@eclists.intel.com, andy.shevchenko@gmail.com,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v4 0/2] lib/string_helpers: Introduce parse_int_array_user()
Date:   Fri,  2 Sep 2022 14:29:26 +0200
Message-Id: <20220902122928.632602-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Continuation of recent upstream discussion [1] regarding user string
tokenization.

First, parse_int_array_user() is introduced to allow for splitting
specified user string into a sequence of integers. Makes use of
get_options() internally so the parsing logic is not duplicated.

With that done, redundant parts of the sound driver are removed.

Originally similar functionality was added for the SOF sound driver. As
more users are on the horizon, it is desirable to update existing
string_helpers code and provide a unified solution.


Changes in v4:
- renamed the function to parse_int_array_user()
- at the name several local variable names have been reworded to match
  the above

Changes in v3:
- relocated tokenize_user_input() implementation to string_helpers as
  requested by Matthew

Changes in v2:
- reused get_options() so no parsing logic is duplicated
- simplified __user variant with help of memdup_user_nul()
  Both suggested by Andy, thanks for thourough review


[1]: https://lore.kernel.org/alsa-devel/20220707091301.1282291-1-cezary.rojewski@intel.com/


Cezary Rojewski (2):
  lib/string_helpers: Introduce parse_int_array_user()
  ASoC: SOF: Remove strsplit_u32() and tokenize_input()

 include/linux/string_helpers.h    |   2 +
 lib/string_helpers.c              |  45 +++++++++++++
 sound/soc/sof/sof-client-probes.c | 104 ++++++------------------------
 3 files changed, 65 insertions(+), 86 deletions(-)

-- 
2.25.1

