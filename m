Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5A95451C3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245479AbiFIQVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237389AbiFIQVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:21:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2241B55BE;
        Thu,  9 Jun 2022 09:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654791695; x=1686327695;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0CsSwkvejVm3bVTO7Azc2brKlKE9Yji53qGgFJwL8DY=;
  b=I/OSSC+LOPbYIcRBRIlnWwhEvDzUz4c76FAwOpo2jOZM48P+Lv6IvImX
   u/A5ydLhxMWG4BiOLwqklfK/Q0njFNb10u7bwPxzQEqtT5YalSQZsTs6a
   vG0xhgLCVgKsQCxoxlZQkdaDjZaQQoAL/+TNx9GpXVax2lD0UmWGmWKg+
   yaBiA5RZx928T9NlxqqEJFmbDFRkFBSxYKgQ/8lKXx6cJSW6HmBrxwyG4
   1KhRA3ZXPiXdl5Va5SqDUA9B5/knA8RFUYJZbEd0ueahMtyXOXLVowLAj
   Q4rYyZSDIwZMy4pKAurE1wUnATFavNqK5ZO9HcY5LvkpmpesBXCzBtvtY
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="277363613"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="277363613"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 09:21:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="585661484"
Received: from jeremywe-mobl3.amr.corp.intel.com (HELO [10.209.173.145]) ([10.209.173.145])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 09:21:33 -0700
Message-ID: <7652ddab-53a5-ac8e-33f5-d25527acb1a6@linux.intel.com>
Date:   Thu, 9 Jun 2022 11:21:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v1 14/16] soundwire: Use acpi_dev_for_each_child()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
References: <1843211.tdWV9SEqCh@kreacher> <5296779.Sb9uPGUboI@kreacher>
 <63d7f3ed-b5a9-c869-5d25-a33a1d4e63c8@linux.intel.com>
 <CAJZ5v0i7xtjrEOXgKiWP5St8OZoiZ4qq+gL62BFrmv-qpeaG_w@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CAJZ5v0i7xtjrEOXgKiWP5St8OZoiZ4qq+gL62BFrmv-qpeaG_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Shouldn't the return of sdw_acpi_find_one() be trapped, e.g. with
>>
>> return acpi_dev_for_each_child(parent, sdw_acpi_find_one, bus);
> 
> Sure, I'll do that.  Thanks!

I also added this EXPORT_SYMBOL to work-around link errors, not sure if
this is in your tree already?

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c

index 86fa61a21826c..ade6259c19af6 100644

--- a/drivers/acpi/bus.c

+++ b/drivers/acpi/bus.c

@@ -1113,6 +1113,7 @@ int acpi_dev_for_each_child(struct acpi_device *adev,



        return device_for_each_child(&adev->dev, &adwc,
acpi_dev_for_one_check);

 }

+EXPORT_SYMBOL_GPL(acpi_dev_for_each_child);


