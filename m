Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EE750DF43
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241760AbiDYLtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241752AbiDYLtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:49:09 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14932403DA;
        Mon, 25 Apr 2022 04:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650887148; x=1682423148;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rgiGyZX6H+3caT4Vfhz7ZAHWIv86hUhLawBSz9Mm5wg=;
  b=HK28XE3MuWvA8Xcp2CUBHCTZAv/Yq68zzrIxwPy/TEh2LBywp/PnT8jH
   kBqpeMz/Nn+cBNOnuKGh92/v+zKNS478m2S/7BRF/7XfirvfcjgJajfr4
   eXpwxf/+G+mAaDXjaY0VnSUDl2cLiEBY0jnhjcRXELdk/Puqy8fh18CKR
   7bzuOHMYkgGWkd/gvE0E8szt71cJyZmRRILWWSXXVxXixqYP4AGDPGTNZ
   DmuYyH1IauBKWPTe3SV7Z0f1sWW7zWnIKFFduBsA/jvXgFnnBLylfsPNB
   SYtvPqTwixS0mWLAqdFTJlzioayRKygXiavNuedrI2dUrbYcc6FFFLeSI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="264075334"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="264075334"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 04:45:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="704526065"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Apr 2022 04:45:44 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v1 0/2] acpi: Remove acpi_release_memory()
Date:   Mon, 25 Apr 2022 14:45:42 +0300
Message-Id: <20220425114544.37595-1-heikki.krogerus@linux.intel.com>
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

It seems there never were and there never will be actual devices that
expose the UCSI ACPI mailbox interface. There are now PD controllers
that support the UCSI interface, but they do not use the ACPI mailbox.

So there is no point in mapping the mailbox with ioremap(), we can
just use memremap(). That should make it possible to also remove the
function acpi_release_memory(). That function was only there to make
it possible to use ioremap() in the UCSI ACPI driver.

thanks,

Heikki Krogerus (2):
  usb: typec: ucsi: acpi: Map the mailbox with memremap()
  acpi: Remove the helper for deactivating memory region

 drivers/acpi/osl.c                 | 86 ------------------------------
 drivers/usb/typec/ucsi/ucsi_acpi.c | 19 ++-----
 include/linux/acpi.h               |  3 --
 3 files changed, 4 insertions(+), 104 deletions(-)

-- 
2.35.1

