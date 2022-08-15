Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9228592B99
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiHOISm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiHOISk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:18:40 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866111EEFB;
        Mon, 15 Aug 2022 01:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660551519; x=1692087519;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0F0ny3POo01TN8PrWXSpbHLH0QJ4GeZOsaTCgDcIiKw=;
  b=DlyKSGRe4ZEkXDi/iEl2imdy/EmSb2sPnoUfSDZdGqIsCa+TSY3/Vuwa
   yJUWuqgILy5qu98koz/jYBmlghhcPeotbH4NJHW8aUTtwAhMNpaSsH66P
   GVYipqxnmcnekDxTvFRRrbGw4G0VehMNu6+R+v25OeqF176j9OvM60YsC
   6XN0RlWifS6uPJ/7SXQyhPNdvgvaFkggcnf+hyGcJroJCaLRdkTJeD5E6
   vW+Z138Br92IuErkfsSFI9Cl/L0ppw0z/CwmHlv3dKraQ+t8yY6A8lIHP
   iz91/TwcBEtXaXQQkO5IgzjmHzVg5qzgrYDfZzEqqP04Ly/d2rjcJr/uL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="274971002"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="274971002"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 01:18:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="674766312"
Received: from szujuchn-mobl1.gar.corp.intel.com (HELO [10.252.50.152]) ([10.252.50.152])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 01:18:34 -0700
Message-ID: <741edbf0-5835-eb89-bb6a-69d7e0d00e36@linux.intel.com>
Date:   Mon, 15 Aug 2022 10:16:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [RFC PATCH] Soundwire: Initialize multi_link with fwnode props
Content-Language: en-US
To:     Khalid Masum <khalid.masum.92@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
References: <20220814080416.7531-1-khalid.masum.92@gmail.com>
 <CAHp75Ve4UaLsUknGKm14_-f5=qsq1s_Ws+j6h0kAY5_XMkSmQw@mail.gmail.com>
 <54dd86bd-416b-3048-9bd0-368afa3aaf2f@gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <54dd86bd-416b-3048-9bd0-368afa3aaf2f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/22 06:28, Khalid Masum wrote:
> On 8/15/22 00:46, Andy Shevchenko wrote:
>> On Sun, Aug 14, 2022 at 11:31 AM Khalid Masum
>> <khalid.masum.92@gmail.com> wrote:
>>>
>>> According to the TODO, In sw_bus_master_add, bus->multi_link is to be
>>> populated with properties from FW node props. Make this happen by
>>> creating a new fwnode_handle flag FWNODE_FLAG_MULTI_LINKED and use
>>> the flag to store the multi_link value from intel_link_startup. Use
>>> this flag to initialize bus->multi_link.
>>
>> ...
>>
>>>          /*
>>>           * Initialize multi_link flag
>>> -        * TODO: populate this flag by reading property from FW node
>>>           */
>>> -       bus->multi_link = false;
>>> +       bus->multi_link = (fwnode->flags & FWNODE_FLAG_MULTI_LINKED)
>>> +               == FWNODE_FLAG_MULTI_LINKED;
>>
>> NAK (as far as I understood the context of the comment and the change
>> itself).
>>
>> These flags are for devlink, we do not mix FW properties with those
>> internal flags anyhow. The comment suggests that this should be az
>> property. Also commit message doesn't explain the relation to devlink.
>>
> That is a good information to know. Thanks.
> 
> I shall try to find out if I can somehow get multi_link's value from
> fwnode in any other way and look into devlink in the process.
> 
> If you have any suggestions regarding this TODO, please let me know.

The suggestion is to remove the TODO and leave the code as is: the
capabilities enabled for multi-link are required as part of the
programming sequences, even when a stream uses a single link we still
use the syncArm/syncGo sequences.

Please don't change this.
