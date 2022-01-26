Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229F449C083
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbiAZBRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:17:33 -0500
Received: from mga09.intel.com ([134.134.136.24]:5135 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235593AbiAZBRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643159852; x=1674695852;
  h=from:to:cc:subject:date:message-id;
  bh=rqczjyKj/SlLMVDMYtVBQmFXTLQ/61Vrv+fruQKZRP8=;
  b=JU16ZavyzyrfaRw9KmKZyT0WoOCo+AAuUfph7kafjsAECswu625VgryN
   o8X0I6Zz8UoOy74GYvdNf1DhaS4MBT58mtrHFMfQHS+XEqfzAhg22qwi1
   sb+ornjS/yQaHFbIvUJhRUH6ZSfXcJepXd2CM0pVnUSbqISKTsfI+F+k3
   qdT3NQnmu0g2U44EDlVMXe+R6jh3Zl7QhVINnW7nB5P9q0wYDvA/IZiJ9
   RnHC1f9z5Jvtq5v2PYdoeIrUqM8pATVhYNQVtWmUFvu/9OXqWGkGzyjJB
   Kv+bSABFVHguk+oYAo2/Uu3q+WqGIMYYwFjsGOa0TqatfbImGWUowIaR/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246236101"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="246236101"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:17:30 -0800
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="520617308"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:17:27 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 00/19] soundwire: stream: cleanup of 'stream' support
Date:   Wed, 26 Jan 2022 09:16:56 +0800
Message-Id: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series revisits the SoundWire 'sdw_stream' support to split allocation
and configuration steps. This is necessary if for example the routines are
called multiple times from the hw_params stage. This also helps with better
error handling.

Pierre-Louis Bossart (19):
  soundwire: stream: remove unused parameter in sdw_stream_add_slave
  soundwire: stream: add slave runtime to list earlier
  soundwire: stream: simplify check on port range
  soundwire: stream: add alloc/config/free helpers for ports
  soundwire: stream: split port allocation and configuration loops
  soundwire: stream: split alloc and config in two functions
  soundwire: stream: add 'slave' prefix for port range checks
  soundwire: stream: group sdw_port and sdw_master/slave_port functions
  soundwire: stream: simplify sdw_alloc_master_rt()
  soundwire: stream: split sdw_alloc_master_rt() in alloc and config
  soundwire: stream: move sdw_alloc_slave_rt() before 'master' helpers
  soundwire: stream: split sdw_alloc_slave_rt() in alloc and config
  soundwire: stream: group sdw_stream_ functions
  soundwire: stream: rename and move master/slave_rt_free routines
  soundwire: stream: move list addition to sdw_slave_alloc_rt()
  soundwire: stream: separate alloc and config within
    sdw_stream_add_xxx()
  soundwire: stream: introduce sdw_slave_rt_find() helper
  soundwire: stream: sdw_stream_add_ functions can be called multiple
    times
  soundwire: stream: make enable/disable/deprepare idempotent

 drivers/soundwire/stream.c | 960 +++++++++++++++++++++----------------
 1 file changed, 547 insertions(+), 413 deletions(-)

-- 
2.17.1

