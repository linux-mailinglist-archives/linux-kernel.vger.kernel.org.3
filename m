Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20AC52DBE5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240717AbiESRvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243350AbiESRug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:50:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AE7B226D
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652982587; x=1684518587;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B2kzj5sN8O2TnTpQLQG4+I3RUEEMnuN8jnc0ayhrlRk=;
  b=jNjGF3AJ1csovafX8qqCg2/ZsInCB0ntp9yB6ZtFfvDwMJ9WwBwmO5a/
   q3qDyKugBQr/0P7B2BohoIOj7aBPfNtt5NkQdWWyNWgAAYeWCBNJYjr7A
   dlpOI18I55UTeHpYSmOhCDx8bw/RyT8C1IVEIWFCFbl/4V7k30aRNm6wI
   TtloSNADUtA3n7Nde74SzaMYDPPhv3tlnzxrTgf2aSMCrzlWMEXn+WKwQ
   tyxb3Uab52vUOOoCe7prwkzLKPkYNNZl7Xrwm3x4Ne33pl7PF5hfhxEXR
   yOYkFFkQ5ZowTyNLikjQiKVVq9Jl4Qw1sGewHP9tUB5HyAt+aMW5EEZ3V
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="297606447"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="297606447"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 10:49:47 -0700
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="639912650"
Received: from vrgokulr-mobl1.amr.corp.intel.com (HELO [10.251.4.170]) ([10.251.4.170])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 10:49:46 -0700
Message-ID: <d14fddd9-20f9-fe7e-6c12-b5a57c6855da@linux.intel.com>
Date:   Thu, 19 May 2022 12:49:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH] ASoC: max98090: Remove unneeded check in
 max98090_put_enab_tlv()
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     ldv-project@linuxtesting.org, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
References: <1652980212-21473-1-git-send-email-khoroshilov@ispras.ru>
 <YoZ+dmprwb5Ohto3@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <YoZ+dmprwb5Ohto3@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/22 12:29, Mark Brown wrote:
> On Thu, May 19, 2022 at 08:10:12PM +0300, Alexey Khoroshilov wrote:
>> Variable sel is of unsigned int type, so sel < 0 is not required.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
>>  	val = (val >> mc->shift) & mask;
>>  
>> -	if (sel < 0 || sel > mc->max)
>> +	if (sel > mc->max)
> 
> The check needs to be moved, not removed.  The userspace ABI allows
> passing in of negative values.

I was about to send the same cleanup, cppcheck reports the same issue
with a useless test.

The problem is that the values coming from userspace are cast to unsigned...
