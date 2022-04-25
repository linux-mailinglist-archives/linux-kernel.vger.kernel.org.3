Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758BD50DFC2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbiDYMQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbiDYMQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:16:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC006193C0;
        Mon, 25 Apr 2022 05:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650888823; x=1682424823;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=77eSWG+vDqvLpGLGigGNMWXsWIkml9QManZaZRRQdps=;
  b=hSM8cdsgwHD1l/KoGlkdXeONo9nJpRaLvPvYgIMsO5NuFgO/LJDiY0HB
   sYP4Yc6/fzIGjIIVkiGx9e27YqGtslGvcvwg2ozK1XFbma1bZVTs5Twp/
   Z7gtJ1osI0YlU0gEl98szmZvDBhtZHBSWSjE+UH+9ZNPx9O8RnScZnQEy
   aA7TSTdYy1P7T2i1UIzz+eT/jNWRFW8d2djJhXOxYGyN/d5vIDSVk37If
   Pg9BoufDFOT9S0qSOliTAazqyEz/KRyOSg6uy66z39FQju2qtrj/iiiIN
   mQ+4AANIktsTmiiAofZae7u8l5Kfu+VCLH3jY0QsQhqdtu+0o/5RI2qAL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="351676963"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="351676963"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 05:13:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="704535982"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Apr 2022 05:13:40 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] usb: core: acpi: Rely on the sysdev pointer
Date:   Mon, 25 Apr 2022 15:13:38 +0300
Message-Id: <20220425121340.1362-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since we have that sysdev pointer, we need to use it also when
assigning the ACPI companion for the root hub. That should remove the
need to "manually" assign the ACPI companion to the controller device
in the xhci glue drivers like dwc3-host.c.

Assigning the ACPI companion in those glue drivers is very
problematic, because it screws up the fwnode->secondary pointer. But
as said, since we have that sysdev pointer, there is no need to
manually set it. sysdev pointer should always point to the correct
physical device from firmware PoW.

thanks,

Heikki Krogerus (2):
  usb: core: acpi: Use the sysdev pointer instead of controller device
  usb: dwc3: host: Stop setting the ACPI companion

 drivers/usb/core/usb-acpi.c | 2 +-
 drivers/usb/dwc3/host.c     | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

-- 
2.35.1

