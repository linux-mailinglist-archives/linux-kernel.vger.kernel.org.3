Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9594B5853E3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 18:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238207AbiG2QrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 12:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238206AbiG2Qqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 12:46:54 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4C689AA9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 09:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659113209; x=1690649209;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9jM9mztwAIfVEKsgETMmbLznTItKcbywHJIDqBixobk=;
  b=hAsuST5M0HjRr6DApr/KPaSY4QnErblvLhag+WnjTsWz4B/fI2KapGtg
   bvuJRWUHNRT/oahoIIYsInEb3bHAzReqF8K5fGZxeXwsv7tboYPCrD1Jf
   FhhyIw2sLwUtNopNjtMbvNYIUHYv5dcrHEjV23/IIDsUnUVLIlqT1IanP
   NrTXwGA+lt+cuWF3btbH36xeH1lkLwRGpPUjH7o1zaIIK7GHKLlHQoyD7
   kNYLa1uB6gt+t0KASTUOstbv8pqsLuYKDtgqV5KzFU/8Xskm+ENroDL1M
   fqUxsIRp2tmzTFTC5vcz8yWklXoE28nAvn/CB/t10hYEtlLxk9DjB0+Wd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="290005899"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="290005899"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 09:46:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="605014348"
Received: from kaholo-mobl.amr.corp.intel.com (HELO [10.212.97.86]) ([10.212.97.86])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 09:46:47 -0700
Message-ID: <701aa1ba-9b25-51eb-8bd7-2389b501d79c@linux.intel.com>
Date:   Fri, 29 Jul 2022 11:46:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 2/5] soundwire: sysfs: cleanup the logic for creating the
 dp0 sysfs attributes
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        linux-kernel@vger.kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20220729135041.2285908-1-gregkh@linuxfoundation.org>
 <20220729135041.2285908-2-gregkh@linuxfoundation.org>
 <9365e038-2146-98f8-f989-02827f221c34@linux.intel.com>
 <YuP0Ffs3G7ZBR0AC@kroah.com>
 <cfacb124-a9ff-0a93-8f92-93d164b15966@linux.intel.com>
 <YuP2pjhyKTTfpXQq@kroah.com>
 <5caffe2a-f5a6-e312-a564-5fe29c4e2323@linux.intel.com>
 <YuQMYRYFo9gTk1yL@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <YuQMYRYFo9gTk1yL@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>> That should be fine, tools should just be looking for the attributes,
>>>>> not the existance of a directory, right?
>>>>
>>>> The idea what that we would only expose ports that actually exist.
>>>> That's helpful information anyone with a basic knowledge of the
>>>> SoundWire specification would understand.
>>>
>>> Is "dp0" a port?  If so, why isn't it a real device?
>>
>> The SoundWire spec defines the concept of 'data port'. The valid ranges
>> are 1..14, but in all existing devices the number of data ports is way
>> smaller, typically 2 to 4. Data ports (DPn) are source or sink, and
>> there's no firm rule that data ports needs to be contiguous.
>>
>> DP0 is a 'special case' where the data transport is used for control
>> information, e.g. programming large set of registers or firmware
>> download. DP0 is completely optional in hardware, and not handled in
>> Linux for now.
>>
>> DP0 and DPn expose low-level transport registers, which define how the
>> contents of a FIFO will be written or read from the bus. Think of it as
>> a generalization of the concept of TDM slots, where instead of having a
>> fixed slot per frame the slot position/repetition/runlength can be
>> programmed.
>>
>> The data ports could be as simple as 1-bit PDM, or support 8ch PCM
>> 24-bits. That's the sort of information reported in attributes.
> 
> Why not make them a real device like we do for USB endpoints?

I don't see what adding another layer of hierarchy would bring. In their
simplest configuration, there are 6 registers 8-bit exposed. And the
port registers, when present, are accessed with a plain vanilla offset.

> What uses these sysfs files today that would be confused about an empty
> directory?

That's a good question. I am not aware of any tools making use of those
attributes. To a large degree, they are helpful only for debug and
support, all these read-only attributes could be moved to debugfs. That
could be a way to simplify everyone's life....
