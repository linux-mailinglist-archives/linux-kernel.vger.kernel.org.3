Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF68D510979
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354397AbiDZUHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354400AbiDZUHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:07:20 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E00111F63C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651003452; x=1682539452;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dromec/Ydk2Hkk4HIn4HSHHP6uhLiyN8IN4OIxV7VWs=;
  b=C59yiId47xuKBxu1TJe9KvEM6XJIZT9/aONia7L9EMCldHdA54RiSTS0
   Grdfzz1WbDJTn3O6eQBz96lubB8xkSxDGY9SEt8S0oIpOeyrUJQ/Gtz2r
   6mxSXvS1QYuUMgVv9eBIXmT6itxVJC/1ejkRTlqKgOPIDdVbnLu5hsOZd
   PK1BLmPS/lbXw0rjnIWSWOhbr/kN7seAlg8lftukkM6HwrHHeRtvXVVNk
   hjx7qCNAFumAwQF1GAknwx5SqKVjK0rGf9DWEyrr1dk+HooyT3dyWD4zP
   Ub0co6RuEbNOks3utcYXNOmRFSiTX2Ri3ldSDmYYtnX7mTtdvFioVNy/c
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="253082442"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="253082442"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 13:03:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="580129109"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.212.180.158])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 13:03:57 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, marpagan@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v1 0/2] Fix-up patches for Firmware Uploads
Date:   Tue, 26 Apr 2022 13:03:54 -0700
Message-Id: <20220426200356.126085-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two fix-up patches for the new firmware upload functionatlity:

(1) firmware_loader: Fix configs for sysfs split
Fix up the handing for CONFIG_FW_LOADER_SYSFS,
CONFIG_FW_LOADER_USER_HELPER, and CONFIG_SYSCTL as pertains to:
  register_sysfs_loader()
  unregister_sysfs_loader()
  register_firmware_config_sysctl()
  unregister_firmware_config_sysctl()

(2) firmware_loader: Move definitions from sysfs_upload.h to sysfs.h
This does not change behavior, but places some symbol declarations more
appropriately.


Russ Weight (2):
  firmware_loader: Fix configs for sysfs split
  firmware_loader: Move definitions from sysfs_upload.h to sysfs.h

 drivers/base/firmware_loader/sysfs.c        |  3 ---
 drivers/base/firmware_loader/sysfs.h        | 25 +++++++++++++++++----
 drivers/base/firmware_loader/sysfs_upload.c |  1 -
 drivers/base/firmware_loader/sysfs_upload.h | 23 +++++--------------
 4 files changed, 26 insertions(+), 26 deletions(-)


base-commit: 26360a8c9732cff2ee5bc2f180e9716b63e9f650
prerequisite-patch-id: 76b6e2481b3a66a9c3242fc01e0f55be687debb8
-- 
2.25.1

