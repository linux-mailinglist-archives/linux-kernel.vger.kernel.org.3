Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5508059F499
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbiHXHzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbiHXHze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:55:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FEF84EE0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 00:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661327733; x=1692863733;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LqeA44e0s1YgXUHt9917oOHWEVJ8rkKa9fdQohJrry8=;
  b=oFS6fdT4+JI8k4BF5tIKQLAdAVZAa7WeqoQXDaazfoyyh5CeOLndVw9U
   c75Q4wF5Ub541UFbXODCSWRMm2iyutUOEkkqF4FH/cneNTCwLkAktOdNk
   EKWi8yRyohrTophiloWjZue12yAcqyWZDal+seWbcX7KrICTc2E130Uzf
   lhlDHSYpzTITyBFkGodab+0hY+XJZQYHvPPLqGAhFA44CWnjOO+EVNHRK
   PoMvu5M0agOberg5EKJI+jxXIwj+M04+uvcPfcFhwStUj2GgGQJ11EcFh
   UNSCx07SaOovSNS/WXrDkd0ltjEc0efYFKBG4k3GSXTdAs2FNAeayjQSe
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="291462499"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="291462499"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 00:55:32 -0700
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="639008184"
Received: from tleistix-mobl2.ger.corp.intel.com (HELO [10.249.43.72]) ([10.249.43.72])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 00:55:30 -0700
Message-ID: <6a9ad9b1-a6f2-c380-77a9-f10317f7054f@linux.intel.com>
Date:   Wed, 24 Aug 2022 09:42:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] soundwire: allocate device_number with IDA
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bard.liao@intel.com
References: <20220823045004.2670658-1-yung-chuan.liao@linux.intel.com>
 <YwUHp3ivSktx6/Lo@matsya>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <YwUHp3ivSktx6/Lo@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

>> The device_number is currently allocated in the scope of each bus and does
>> not need to be unique at the system level.
>> This leads e.g. on Dell devices with three or four Device1 on different
>> bus segments. 
> 
> And how is that an issue that should be fixed?

1. this makes things simpler for debug. You can look at the logs and see
what the device is without having to look at the link. It's been much
easier to track complicated issues when each device is tracked with a
unique system level number.

2. Intel hardware has a requirement that the device number be unique for
all links managed by  a given controller. This patch prepares that
transition. I cannot disclose more details at the moment, you will have
to trust me on this one.

>> To make the device_number unique at the system level, and
> 
> Why should we do that...
>> unified with the HDaudio/iDISP SDI values, this series allocates the
>> dev_number with an IDA restricted between 4 and 11 (inclusive).
> 
> Does this not place an artificial restriction that a system can have
> only 12 devices if we have unique device

It does indeed, but it simplifies debug and it allows future hardware to
be supported.

In practice, the most we've seen on Intel platforms is 4 devices at the
system level. Even if the SoundWire spec does allow for 11 devices per
link, it's way over-engineered due to capacitive load and signal
integrity issues. We've seen an absolute maximum of 4 devices on a
single link in test rigs, and that was never deployed. Two devices per
link were also only used in prototypes which never hit the market.

At any rate, this in an opt-in solution, not a requirement for non-Intel
platforms at all. Others can keep using as many devices as they wish,
within the bounds allowed by the standard.

Note that the device_number creates a de-facto priority, and it would be
perfectly acceptable for some platforms to tweak the current first-come
first-serve allocation to improve interrupt response time on each link,
etc. The standard says nothing about how the device numbers should be
allocated, only that they be unique on each link. In other words, you
should expect additional changes to the existing way of allocating
device numbers.

> Perhaps a better way would be to use dus:dev combination while dealing
> with a device always..??

That is not compatible with Intel hardware requirements. This wasn't a
decision where Bard and I were consulted, it is what it is.

Does this clarify things?
Thanks
-Pierre


