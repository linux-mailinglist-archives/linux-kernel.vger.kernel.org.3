Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54D95958EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbiHPKtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbiHPKsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:48:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AB0FC307;
        Tue, 16 Aug 2022 03:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660644981; x=1692180981;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xF5gG7Oy9lHphcE7lhSpuLFD+wByK3zXWrKkUkteKYw=;
  b=CNI4YNi9oNULA7+YtJtoXygH4UBw/+5u0CI7naJE7NDpfV1PpxrmGpdH
   DbU3bDVvjtdDltPug/ZeoS6d9Jnbv1hQzD0uFbU68HErZCh+PQOfbNsOs
   wA81qs1B3H/lNRd4DoEzmfnchpd2Fg2bhZFyEuukqciwMAVpS7vEZgBDk
   t4vuELddrpw4bYY2Un2Ct2JKNsbDxE/nHJA9nN9nTQ2tvAgyQpgEDap0w
   6uzH4SrZXzeVZgw+JO1xPoUttKaVSZ/ZH9mJ8biWPR9xNCWh7IMgAS2rx
   z01axY+TgHoUt3CJnizAaYOWjzGdqx2Qy1I3doOItcDxJsIZXM5gJ5huK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="279141254"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="279141254"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 03:16:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="749260741"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 16 Aug 2022 03:16:16 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Utkarsh Patel <utkarsh.h.patel@intel.com>, rajmohan.mani@intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 0/6] ACPI: New helper function acpi_dev_get_memory_resources() and a new ACPI ID
Date:   Tue, 16 Aug 2022 13:16:23 +0300
Message-Id: <20220816101629.69054-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The helper function returns all memory resources described for a
device regardless of the ACPI descriptor type (as long as it's
memory), but the first patch introduces new ACPI ID for the IOM
controller on Intel Meteor Lake and also separately modifies the
driver so that it can get the memory resource from Address Space
Resource Descriptor.

An alternative would have been to introduce that helper function first
so we would not need to modify the driver when the new ID is added,
but then the helper would also need to be applied to the stable kernel
releases, and that does not feel necessary or appropriate in this
case, at least not IMO.

So that's why I'm proposing here that we first add the ID, and only
after that introduce the helper, and only for mainline. That way the
patch introducing the ID is the only that goes to the stable releases.

If that's okay, and these don't have any other problems, I assume it's
OK if Rafael takes all of these, including the ID?

thanks,

Heikki Krogerus (5):
  ACPI: resource: Filter out the non memory resources in is_memory()
  ACPI: resource: Add helper function acpi_dev_get_memory_resources()
  ACPI: APD: Use the helper acpi_dev_get_memory_resources()
  ACPI: LPSS: Use the helper acpi_dev_get_memory_resources()
  usb: typec: intel_pmc_mux: Use the helper
    acpi_dev_get_memory_resources()

Utkarsh Patel (1):
  usb: typec: intel_pmc_mux: Add new ACPI ID for Meteor Lake IOM device

 drivers/acpi/acpi_apd.c               |  9 +--------
 drivers/acpi/acpi_lpss.c              |  9 +--------
 drivers/acpi/resource.c               | 20 ++++++++++++++++++++
 drivers/usb/typec/mux/intel_pmc_mux.c | 12 ++++--------
 include/linux/acpi.h                  |  1 +
 5 files changed, 27 insertions(+), 24 deletions(-)

-- 
2.35.1

