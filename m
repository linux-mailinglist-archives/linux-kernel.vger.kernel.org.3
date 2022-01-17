Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F7A491009
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242234AbiAQSG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:06:56 -0500
Received: from mga05.intel.com ([192.55.52.43]:51931 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232426AbiAQSGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642442815; x=1673978815;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=XXFdFLVJY5KBBZp6WHS4dhJVYZEvhL9b7ul4U2y0o8U=;
  b=YlworV7VmHXEo1lGFTPV2bdPnrhuBn7O28ES7MEG1IwsPPOdts3IiBJ0
   ZT7T5n5HVxksiTb6/EYpCQf3oXglsUveOQ8DzC5pIjpnwDvsagMYF5eE2
   veZZ3own5i2KOGUIthpTk/k+3samnYouSLD+ocKUIGX4hccT2gjQeuD9h
   vYbGIzHHCcvRjWf5JGWQo1awRczU4zMNlsXGXcKMuuzVunHwjK9oaz878
   RfN0fsIH2pTPU4KAwh0IwAJFvPx4wFTJV6J1yKa6QWjuSw5XlaaKmyYEL
   b+YT8q9dDIbfq268pVL0zBX1h4PccW2ty/9vX6Yutn6i8+S3hOhMk222J
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="331022070"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="331022070"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 10:06:55 -0800
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="625260176"
Received: from pthompso-mobl1.amr.corp.intel.com (HELO [10.213.168.97]) ([10.213.168.97])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 10:06:54 -0800
Subject: Re: [PATCH] ASoC: soc-pcm: use GFP_ATOMIC in
 dpcm_create_debugfs_state()
To:     Takashi Iwai <tiwai@suse.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     alsa-devel@alsa-project.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
References: <ed322b8821fa787907c1a4cce879564d1281b69d.1642331884.git.christophe.jaillet@wanadoo.fr>
 <s5hwniy21cl.wl-tiwai@suse.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <bbe18490-fba4-9307-fe5f-b02c00433d07@linux.intel.com>
Date:   Mon, 17 Jan 2022 11:11:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <s5hwniy21cl.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/17/22 2:49 AM, Takashi Iwai wrote:
> On Sun, 16 Jan 2022 12:18:17 +0100,
> Christophe JAILLET wrote:
>>
>> The commit below states that dpcm_be_connect() may be called from atomic
>> context. It changes a GFP_KERNEL into a GFP_ATOMIC to deal with it.
>>
>> Another memory allocation is done in dpcm_create_debugfs_state() which is
>> called by dpcm_be_connect(). Also use GFP_ATOMIC there to be consistent
>> and be compliant with atomic context.
>>
>> Fixes: d8a9c6e1f676 ("ASoC: soc-pcm: use GFP_ATOMIC for dpcm structure")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Not clear to me how dpcm_be_connect() can be called from an atomic context,
>> though. But better safe than sorry.
> 
> I don't think this no longer valid for the very latest code.
> The commit b7898396f4bb dropped the spurious dpcm_lock spinlock, so
> the code path you touched must be always sleepable.
> 
> Similarly, the commit d8a9c6e1f676 can be reverted now.

Can we really revert d8a9c6e1f676?

We did propagate the non-atomic FE property to the BE, but if both FE
and BE are both atomic that constraint would be required, no?


> 
> thanks,
> 
> Takashi
> 
>> ---
>>  sound/soc/soc-pcm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
>> index 7abfc48b26ca..1a536a2b9dc3 100644
>> --- a/sound/soc/soc-pcm.c
>> +++ b/sound/soc/soc-pcm.c
>> @@ -212,7 +212,7 @@ static void dpcm_create_debugfs_state(struct snd_soc_dpcm *dpcm, int stream)
>>  {
>>  	char *name;
>>  
>> -	name = kasprintf(GFP_KERNEL, "%s:%s", dpcm->be->dai_link->name,
>> +	name = kasprintf(GFP_ATOMIC, "%s:%s", dpcm->be->dai_link->name,
>>  			 stream ? "capture" : "playback");
>>  	if (name) {
>>  		dpcm->debugfs_state = debugfs_create_dir(
>> -- 
>> 2.32.0
>>
