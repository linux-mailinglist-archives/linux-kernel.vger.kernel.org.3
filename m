Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B01D5AB214
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 15:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbiIBNvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 09:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbiIBNus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:50:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEDF4504B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662125124; x=1693661124;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+HasZQGD/dK7/z/ep2cvAoa6qEef3JudFUKpRtdWqMg=;
  b=Qz579+DETtn0Vw9lB9jKZwdRS6D3TLmTm9KZGdLQAbFvEPRjbja5/g0q
   CtV0f8BYqA41yD7Wiy6MTa+bheY58fp26sVkgraUYPd4fTzK8XysA1prk
   /HbEImHHKwBQ1BY8rc5gbxFQAI4XG0FwtUcCvI0T7ElRuQjdd+qFjCGHh
   FH5qwrpvryysuTrR7KGez4Bcs2A+X6S987d5i6SidMUtoHRCfH23UPvFx
   dtOZyVWOTnFixPzLtWDdpIq2ORTnirzn6fnFmJUVtGtaVBM3FgzsKCOCD
   MxTzImiS2e8A+u9u4RC7ZD4g3wBsmUYeoyRcXLxOUUz1nzP8yssKcGHRT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="278994222"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="278994222"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 06:23:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="674352535"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmsmga008.fm.intel.com with ESMTP; 02 Sep 2022 06:23:06 -0700
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
Subject: [PATCH v5 0/2] lib/string_helpers: Introduce parse_int_array_user()
Date:   Fri,  2 Sep 2022 15:32:54 +0200
Message-Id: <20220902133256.789165-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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


Changes in v5:
- fixed kernel doc for parse_int_array_user()

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
  Both suggested by Andy, thanks for thorough review


[1]: https://lore.kernel.org/alsa-devel/20220707091301.1282291-1-cezary.rojewski@intel.com/


Cezary Rojewski (2):
  lib/string_helpers: Introduce parse_int_array_user()
  ASoC: SOF: Remove strsplit_u32() and tokenize_input()

 include/linux/string_helpers.h    |   2 +
 lib/string_helpers.c              |  44 +++++++++++++
 sound/soc/sof/sof-client-probes.c | 104 ++++++------------------------
 3 files changed, 64 insertions(+), 86 deletions(-)

-- 
2.25.1

