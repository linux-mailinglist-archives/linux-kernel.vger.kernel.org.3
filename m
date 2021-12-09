Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F5C46E64E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhLIKM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:12:27 -0500
Received: from mga04.intel.com ([192.55.52.120]:55341 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232999AbhLIKMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:12:25 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="236802569"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="236802569"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 02:08:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="750299273"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 02:08:49 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 09 Dec 2021 12:08:47 +0200
Date:   Thu, 9 Dec 2021 12:08:47 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Chris Chiu <chris.chiu@canonical.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: Discrete Thunderbold Controller 8086:1137 throws DMAR and
 thunderbolt fails to work
Message-ID: <YbHVryQ+QTnyMmTB@lahna>
References: <CABTNMG0zcoCqVue8-3cJQ+iTPkJAgjxEN4FB6_ASX2rgXbWunw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABTNMG0zcoCqVue8-3cJQ+iTPkJAgjxEN4FB6_ASX2rgXbWunw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Baolu]

Hi,

On Thu, Dec 09, 2021 at 05:39:41PM +0800, Chris Chiu wrote:
> Hi,
>     We created a ticket
> https://bugzilla.kernel.org/show_bug.cgi?id=215265 that is pretty
> similar to https://bugzilla.kernel.org/show_bug.cgi?id=214259. So I
> tried the patch on https://lkml.org/lkml/2020/6/17/751 but it doesn't
> fix the issue. I also tried to boot with the kernel parameter
> `pci=nocrs` but it changed nothing either. I attached the kernel log
> with thunderbolt dynamic debug on and lspci output on the ticket. Also
> tried to disable the intel_iommu, the DMAR failure seems to go away
> but thunderbolt still fails to work. Can anyone suggest what kind of
> information is required to help identify the cause of the problem?
> Thanks

At least the RTX370 log seem to have lots of issues, not just
Thunderbolt. The PCIe root port has AER enabled and it seems to be
getting errors from the Maple Ridge card. Typically using AER with
hotpluggable PCIe devices is not a good idea.

Can you get rid of the patch that adds these:

  arch_remove_reservations remove e820 region

and boot with "intel_iommu=off", and provide full dmesg? Did not find
one from the bugzilla bug.

Also does the USB 3.x work? I mean if you have IOMMU enabled and you
plug in USB 3.x device does that work, or you get similar DMAR faults?

Alos is this a production system and do you have installed the latest
firmware upgrades?
