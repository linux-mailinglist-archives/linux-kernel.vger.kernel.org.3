Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245AC513226
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345448AbiD1LOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345278AbiD1LOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:14:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF89220F7;
        Thu, 28 Apr 2022 04:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651144258; x=1682680258;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9b/ogsk/Vrw1tCXgALPfQltHHecqX2TfkDingMu31Ak=;
  b=mhk2c9C72yB955zbYXBUsatsd/v9CuyV1bMzMPdCf+yFCAt6JUwe88Ra
   U3HCcSQQ+SbQY9ECebFf8F2ncQFq2S4PYQAgLaiqB4CMUkl0OEQ+onmmT
   qNFg5dtISwqJKWLds6Qtg0triDX0VIlJQuFdWqJLyTD97n00S5K0rNVwQ
   +AVWbFHqwEoQAtmZTSrpxB5nEMuqYGV4+OpNn6rrbB5CdQGR0Ko4i4NKl
   Onk9vdUKpTUOd6VQY92RySU4zXUGMI3Mz34OvWgP3qod7ZF+w6DIipbrE
   CtuqDfqVJJps3z/djpbN3TeLMi9X9B1VwPLAipT9ziIQpelFtT6uz2BLA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="291414529"
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="291414529"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 04:10:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="706011954"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Apr 2022 04:10:55 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] usb: core: acpi: Rely on the sysdev pointer
Date:   Thu, 28 Apr 2022 14:10:54 +0300
Message-Id: <20220428111056.3558-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've added a comment in the first patch explaining that the sysdev
pointer is the host controller from firmware perspective like
requested by Andy. But please note that I did not make any comments
about the location of the sysdev ACPI companion in ACPI namespace on
purpose. We don't need to, and we actually can't make any assumptions
about that.


original cover letter:

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

 drivers/usb/core/usb-acpi.c | 7 +++++--
 drivers/usb/dwc3/host.c     | 2 --
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.35.1

