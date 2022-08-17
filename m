Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64978596EDF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239516AbiHQM4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239474AbiHQM4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:56:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33404A10F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660740968; x=1692276968;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eRG0+qm4oBLh6lGn6yysc7LMWTIO44vPZQRuwGAcMZY=;
  b=B3RuwYOjsLTAYKFZYBDGGY/zqFXw9wJynCWpW7Sbt7z/fia975RIHrqn
   gKVN1RUKm+6poKzGhE10dugdcZkc9Y9OlBgUK9g10SybZQ4TFtSodYMRk
   7RbOJG+BHoGxc2pAXnwle1OclS0M1UDhWPqwFdK7u7K7Ra5t9I2ZMqSbB
   4gwvrlEi8KJ+llCEzcK0UDHK+KAq0QLjoq4JTAJtg/I4epXpcVdzpkq3C
   xDbDt0r6Gxrw8/2wc0OjQDSyhVRa3zORiGmEQouBtCsdIrdQuV51X4ST6
   exMTOnapeNnWeGLUWQitp/y7BS9jb93EgdlmPOPg7pikDODWfS4o3WTFJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="378775141"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="378775141"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 05:56:08 -0700
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="749696078"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.249.169]) ([10.99.249.169])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 05:56:07 -0700
Message-ID: <7324df1d-0424-a589-f7c9-df089a6cbefe@linux.intel.com>
Date:   Wed, 17 Aug 2022 14:56:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND][PATCH] ALSA: info: Fix llseek return value when using
 callback
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>
References: <20220817124924.3974577-1-amadeuszx.slawinski@linux.intel.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20220817124924.3974577-1-amadeuszx.slawinski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/2022 2:49 PM, Amadeusz Sławiński wrote:
> When using callback there was a flow of
> 
> 	ret = -EINVAL
> 	if (callback) {
> 		offset = callback();
> 		goto out;
> 	}
> 	...
> 	offset = some other value in case of no callback;
> 	ret = offset;
> out:
> 	return ret;
> 
> which causes the snd_info_entry_llseek() to return -EINVAL when there is
> callback handler. Fix this by setting "ret" directly to callback return
> value before jumping to "out".
> 
> 73029e0ff18d ("ALSA: info - Implement common llseek for binary mode")
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> ---
>   sound/core/info.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/core/info.c b/sound/core/info.c
> index b8058b341178..0b2f04dcb589 100644
> --- a/sound/core/info.c
> +++ b/sound/core/info.c
> @@ -111,9 +111,9 @@ static loff_t snd_info_entry_llseek(struct file *file, loff_t offset, int orig)
>   	entry = data->entry;
>   	mutex_lock(&entry->access);
>   	if (entry->c.ops->llseek) {
> -		offset = entry->c.ops->llseek(entry,
> -					      data->file_private_data,
> -					      file, offset, orig);
> +		ret = entry->c.ops->llseek(entry,
> +					   data->file_private_data,
> +					   file, offset, orig);
>   		goto out;
>   	}
>   

Doing resend, because I did copy paste mistake when pasting Takashi 
email to git command, additionally alsa-devel blocked my previous mail.
I've seen that Cezary already discussed this issue, and it doesn't seem 
to be fixed, can this be somehow investigated? I guess we can provide 
response we get from server when email fails?

For example lkml accepted both messages just fine...
previous mail:
https://lore.kernel.org/lkml/20220817124642.3974015-1-amadeuszx.slawinski@linux.intel.com/T/#u
and resend:
https://lore.kernel.org/lkml/20220817124924.3974577-1-amadeuszx.slawinski@linux.intel.com/T/#u
