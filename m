Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8630B5A9E59
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbiIARnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiIARnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:43:10 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019B49F0EF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662054053; x=1693590053;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3QvqwoKmEMN+x9/aOyZ4aYdsCNDJDt7LdBDTdqRDPL8=;
  b=SOidFlMHNNksyZVFDlvrQM43EYfpSLu5sM0zWuWHEvDImkglszloXPq+
   7vqwkCSxkooEnmSltEXc0M3jFa+CFBT7OCtGuMnsXMEjI/VebfWdcwu1h
   kYKBoH421PbWAAlDywXBIKjLX1Eky54wnF222oJjzZse4aa90I2VM3M/7
   XyzSt22eoO7/ohmjRQioQm0RyPVLt2i5azE105VCruYpcYLDvBJ08SmNS
   jiflN2iqZnDRF7Agj3Nba9FygYHcmfe5WhJTTstZYeZm6LJL9C4Cck4SJ
   c+P+Lw+G7YJJOsO7yc+ISdxEQhckvSrTKBGlruaJwk5/6Es5YQALclRom
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="293360759"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="293360759"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 10:40:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="680960348"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2022 10:40:26 -0700
From:   Cezary Rojewski <cezary.rojewski@intel.com>
To:     alsa-devel@alsa-project.org, broonie@kernel.org
Cc:     tiwai@suse.com, perex@perex.cz,
        amadeuszx.slawinski@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com,
        lgirdwood@gmail.com, kai.vehmanen@linux.intel.com,
        peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com,
        yung-chuan.liao@linux.intel.com, andy@kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v3 0/2] lib/string_helpers: Introduce tokenize_user_input()
Date:   Thu,  1 Sep 2022 19:50:20 +0200
Message-Id: <20220901175022.334824-1-cezary.rojewski@intel.com>
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

First, tokenize_user_input() is introduced to allow for splitting
specified user string into a sequence of integers. Makes use of
get_options() internally so the parsing logic is not duplicated.

With that done, redundant parts of the sound driver are removed.

Originally similar functionality was added for the SOF sound driver. As
more users are on the horizon, it is desirable to update existing
string_helpers code and provide a unified solution.


Changes in v3:
- relocated tokenize_user_input() implementation to string_helpers as
  requested by Matthew

Changes in v2:
- reused get_options() so no parsing logic is duplicated
- simplified __user variant with help of memdup_user_nul()
  Both suggested by Andy, thanks for thourough review


[1]: https://lore.kernel.org/alsa-devel/20220707091301.1282291-1-cezary.rojewski@intel.com/


Cezary Rojewski (2):
  lib/string_helpers: Introduce tokenize_user_input()
  ASoC: SOF: Remove strsplit_u32() and tokenize_input()

 include/linux/string_helpers.h    |  2 +
 lib/string_helpers.c              | 45 +++++++++++++++
 sound/soc/sof/sof-client-probes.c | 93 ++++---------------------------
 3 files changed, 59 insertions(+), 81 deletions(-)

-- 
2.25.1

