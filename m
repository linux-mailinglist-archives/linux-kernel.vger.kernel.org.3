Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72385454A1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbiFITIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbiFITIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:08:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD14C26CE49;
        Thu,  9 Jun 2022 12:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654801710; x=1686337710;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=c38Un+y998cp1mk//MudRgxdikF4s6RsjatPEg81vl0=;
  b=F05Oe/n/LDmEbUvDAFeOAiOuCAhMxvF7TtNLkWTaRXL0DC8KVnhNUgNl
   VDr1S9CYE1GcG1w5Gk/Lwun1CCPeKxbTnEY2BHnf8fre3mxtXYX4CBgRl
   eiF6eg3h4pYxhVSZ59S23mLYMA6Fj+U6Mvw5ITc05mpsgocZxh3he4oPC
   guVJt9rRMgZ5JpLkQFsg8XeVJyGgGzTfBCxTRtwTs4iaeeTRDDnNiXrbS
   Izag7k/RYuJLeB0SPKqpubeAs+tNZAjTsqRstCgw9u6U5MBiWYpCdh+9m
   MXFp5aVN/a+pjHk/dmhAnFoSvSeNjKW0ZBGSTwb5fglEiue7XtzQS7MFu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="278533566"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="278533566"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 12:08:14 -0700
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="585751984"
Received: from jeremywe-mobl3.amr.corp.intel.com (HELO [10.209.173.145]) ([10.209.173.145])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 12:08:12 -0700
Message-ID: <a7ec7867-453c-f22d-ed1c-b793a5351837@linux.intel.com>
Date:   Thu, 9 Jun 2022 14:08:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v1 14/16] soundwire: Use acpi_dev_for_each_child()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Linux PM <linux-pm@vger.kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <1843211.tdWV9SEqCh@kreacher> <5296779.Sb9uPGUboI@kreacher>
 <63d7f3ed-b5a9-c869-5d25-a33a1d4e63c8@linux.intel.com>
 <CAJZ5v0i7xtjrEOXgKiWP5St8OZoiZ4qq+gL62BFrmv-qpeaG_w@mail.gmail.com>
 <7652ddab-53a5-ac8e-33f5-d25527acb1a6@linux.intel.com>
 <CAJZ5v0jR1_tO_t90UKQFjYfyE+vOoToJSMCfZ8y37voaYO=wJQ@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CAJZ5v0jR1_tO_t90UKQFjYfyE+vOoToJSMCfZ8y37voaYO=wJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/22 12:35, Rafael J. Wysocki wrote:
> On Thu, Jun 9, 2022 at 6:21 PM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>>
>>
>>>> Shouldn't the return of sdw_acpi_find_one() be trapped, e.g. with
>>>>
>>>> return acpi_dev_for_each_child(parent, sdw_acpi_find_one, bus);
>>>
>>> Sure, I'll do that.  Thanks!
>>
>> I also added this EXPORT_SYMBOL to work-around link errors, not sure if
>> this is in your tree already?
> 
> One of the previous patches in the series is adding the export.

ok. I ran a bunch of tests with those two changes, so feel free to take
my tags:

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
