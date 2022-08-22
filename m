Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06DD59C020
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbiHVNGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbiHVNGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:06:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA531E3CE
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661173568; x=1692709568;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G4hBATmLM/5HOkJqWP9Jt5co1zzgbB7M4mIwYzwwRe8=;
  b=TfyVeX07RSsaDF0IzjVYSK99XWzChNL4YShTKN2rwoe7i0GELxPvY7of
   v0YVxHZ/VH86R3RkOAQhAWcZ8ac8T+JZzsrjxzDaCl/s4//3r0fANEWxQ
   4l8kYJBku16wK7m8MzEiNeyIEGLp9vP654voQpsxPJvBdIbG0r7jBZPvq
   tC6vHdtIGQV+lSA4kSdXa6lg7G0bmClMfjQni0TLiqYlyWhZUMEuk6RQM
   m1k+xZie7n/m2DERJE90ZNVIu8LeY8SbaCG2NZmN/IsVjwJ8Nu6T8lS44
   jEONlSFIiuPfjOZ1O3rnSF3aUefHRsa6TBKQekJB9NVSIjUSO1udtVj6V
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="379698498"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="379698498"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 06:06:07 -0700
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="712176290"
Received: from mhakkine-mobl4.ger.corp.intel.com (HELO [10.249.43.69]) ([10.249.43.69])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 06:06:06 -0700
Message-ID: <19b60ea9-6bee-1cc9-5384-89231fce3a99@linux.intel.com>
Date:   Mon, 22 Aug 2022 15:06:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC: dapm: Export new 'graph.dot' file in debugfs
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-kernel@vger.kernel.org
References: <20220822095242.3779-1-povik+lin@cutebit.org>
 <YwN2Pd4Ez08yDFno@sirena.org.uk>
 <3234D74E-0DFF-4BB5-87ED-6135BAC1F31D@cutebit.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <3234D74E-0DFF-4BB5-87ED-6135BAC1F31D@cutebit.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> Provide a DOT summary of the DAPM graph in a newly added 'graph.dot'
>>> file in debugfs, placed in the card's DAPM directory.
>>
>> There was a tool floating about in the past (last copy I knew about was
>> on Wolfson's git but they took that down) - can we not just continue to
>> do that?
> 
> I don’t know the tool or where would I find it. I think it’s neat
> simply having a ‘graph.dot’ at hand, especially since it requires
> little code. (Although sure there’s the danger of it growing.)

The Chrome folks used an 'asoc_dapm_graph' python script since 2014
according to the copyright information. IIRC it was python2 so might
need a bit of work.

https://chromium.googlesource.com/chromiumos/third_party/adhd/+/refs/heads/master/scripts/asoc_dapm_graph
