Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63D8507EDC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 04:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358950AbiDTCfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 22:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358939AbiDTCfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:35:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B20C1839A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650421978; x=1681957978;
  h=from:to:cc:subject:date:message-id;
  bh=P/LF63BZojFF1TydFmx94mDoFedoUAjUhNq7cH5d2nc=;
  b=EUHlW0vbtdw80EixVXRl5BeyYb4AjkZeXfcir/29UyVFD1eFQM3HaZ1L
   W1LT7FuV9hvXdVyjuwdwt8CJ0Tbbgtnm4oF+S+aEfEmw5XtWZ52OqiIwN
   fWGofJh2+l7KeKXQoeEv011a1be05b1UTBh6PH11IONjVZcTiVgu35jvs
   2imdH1UK6CPzoXLRg7sJuEnWWR5fMFvG+pwdNSVW1v9NoP6ee8YzJYnsB
   ZQU7DWkxvdZ//TMm2fFx9y9cX3g3lmEdaCiBuLJrXLudEnnTCmuc6VIo9
   MSB+5z8yS6lTbRBVAiOjwBk4pk7ZrPK10iiyIGotgeWjIiTWJaT2RQSuL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="261522434"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="261522434"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 19:32:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="529554550"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 19:32:55 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 0/3] soundwire: pm runtime improvements
Date:   Wed, 20 Apr 2022 10:32:38 +0800
Message-Id: <20220420023241.14335-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series provides a solution to solve a corner case issue where the
manager device may become pm_runtime active, but without ALSA/ASoC
requesting any functionality from the peripherals. In this case, the
hardware peripheral device will report as ATTACHED and its initialization
routine will be executed. If this initialization routine initiates any
sort of deferred processing, there is a possibility that the manager could
suspend without the peripheral suspend sequence being invoked: from the
pm_runtime framework perspective, the peripheral is *already* suspended.

Pierre-Louis Bossart (3):
  soundwire: intel: prevent pm_runtime resume prior to system suspend
  soundwire: intel: disable WAKEEN in pm_runtime resume
  soundwire: bus: pm_runtime_request_resume on peripheral attachment

 drivers/soundwire/bus.c   | 12 ++++++++++++
 drivers/soundwire/intel.c |  6 ++++++
 2 files changed, 18 insertions(+)

-- 
2.17.1

