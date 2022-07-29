Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CAD585474
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 19:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237705AbiG2RZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 13:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbiG2RZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 13:25:38 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3646050B
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 10:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659115537; x=1690651537;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vj9Gd3F0ZFA+lxnvVFnGuGBsXg4J6Y0l+pUnAC5iJsg=;
  b=CZHAIUqU7Dc71LAM+ADhhRAHs6cLJwB40a1KJ/AFak+FILoN2YumzUa5
   nQbKMUGi9hLDgfzByXJnZl7AG9NKOp4lyyJCxsZpUbImPRn4p5mM0Ph+/
   HbNGoslpSZj1VViWaJWQmHC4vReQzAhMBfSkwwbrP4TmQ12TS9s5+2eJk
   rY+JWIRYEDq9rQ9ZaYGdkLlV28amebI+JXlUUqWqYJPvsfDRqSAsBtOlK
   OYox+Q4cDWY6U3QypvcaDOxAdwlwStQAXqR/7Gb5wcoQEi/an3aQS7uAE
   eC4CXr3/SwghC4MaL/TbqK9bnTk5WahzBMAeLa8+qsj7c0F6frIaFZm2h
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="350517423"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="350517423"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 10:25:36 -0700
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="605026163"
Received: from kaholo-mobl.amr.corp.intel.com (HELO [10.212.97.86]) ([10.212.97.86])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 10:25:35 -0700
Message-ID: <ac5a7524-4f9a-dc10-cd5e-b2dd5a478d75@linux.intel.com>
Date:   Fri, 29 Jul 2022 12:25:34 -0500
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
 <701aa1ba-9b25-51eb-8bd7-2389b501d79c@linux.intel.com>
 <YuQVrLEqPMu1V0zJ@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <YuQVrLEqPMu1V0zJ@kroah.com>
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



On 7/29/22 12:15, Greg Kroah-Hartman wrote:
> On Fri, Jul 29, 2022 at 11:46:32AM -0500, Pierre-Louis Bossart wrote:
>>
>>>>>>> That should be fine, tools should just be looking for the attributes,
>>>>>>> not the existance of a directory, right?
>>>>>>
>>>>>> The idea what that we would only expose ports that actually exist.
>>>>>> That's helpful information anyone with a basic knowledge of the
>>>>>> SoundWire specification would understand.
>>>>>
>>>>> Is "dp0" a port?  If so, why isn't it a real device?
>>>>
>>>> The SoundWire spec defines the concept of 'data port'. The valid ranges
>>>> are 1..14, but in all existing devices the number of data ports is way
>>>> smaller, typically 2 to 4. Data ports (DPn) are source or sink, and
>>>> there's no firm rule that data ports needs to be contiguous.
>>>>
>>>> DP0 is a 'special case' where the data transport is used for control
>>>> information, e.g. programming large set of registers or firmware
>>>> download. DP0 is completely optional in hardware, and not handled in
>>>> Linux for now.
>>>>
>>>> DP0 and DPn expose low-level transport registers, which define how the
>>>> contents of a FIFO will be written or read from the bus. Think of it as
>>>> a generalization of the concept of TDM slots, where instead of having a
>>>> fixed slot per frame the slot position/repetition/runlength can be
>>>> programmed.
>>>>
>>>> The data ports could be as simple as 1-bit PDM, or support 8ch PCM
>>>> 24-bits. That's the sort of information reported in attributes.
>>>
>>> Why not make them a real device like we do for USB endpoints?
>>
>> I don't see what adding another layer of hierarchy would bring. In their
>> simplest configuration, there are 6 registers 8-bit exposed. And the
>> port registers, when present, are accessed with a plain vanilla offset.
> 
> Who uses these registers?

The bus layer. When a 'stream' is created, the 'bit allocation' will
define who owns which bitSlots in the frame and the registers will be
programmed. The bit allocation may be dynamic or fixed depending on the
host.

>>> What uses these sysfs files today that would be confused about an empty
>>> directory?
>>
>> That's a good question. I am not aware of any tools making use of those
>> attributes. To a large degree, they are helpful only for debug and
>> support, all these read-only attributes could be moved to debugfs. That
>> could be a way to simplify everyone's life....
> 
> That would be much nicer, put it all in a single debugfs file and it
> would be so simple.
> 
> What attributes could we do that for?

All of them really - except maybe the device number which could be used
to figure what the device is when looking at power status and other
'standard' sysfs attributes. sdw:3:025d:0714:01 is not really
user-friendly, device_number 1 is.
