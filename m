Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2F74E4DC9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 09:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242440AbiCWIKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 04:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242445AbiCWIKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:10:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D935B74871
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648022908; x=1679558908;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bKWUYaPmRwZBXbIQvYluCzRLQ9byY907LwzxS8aSO4k=;
  b=REAvQ9NyE17g5RFupR8A2MrjkFuSGo5Sx7rET5qbltc54pTtxGOTfCxC
   cCkcWtAqXAa/xFHk4vmqiN8glMpKkuyxfuV+wXNGqKISo6/sCnyQ8jyo6
   v5lyQvut8/vK6PgkJP43l66rG/6hOA4mLSLQWdTQ1D8tc0a8uuPGXf4vT
   ZZgKU1kGpSavzsyQGz/D8tRvce0wgjWJERRbepaIpy/sdRtvy0Wp29SvM
   JtVOcRuu/kWONrkunoCAuxpRSGyS+Df+vTfIFwQ7yY3dIR11FEt45l+4/
   5LBt4OTp8v9MrtIdZJuIAhFJBR6LjnOUcdRMCoSgJa9DnTPY+B768KfXc
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="245523663"
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="245523663"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 01:08:28 -0700
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="560790474"
Received: from arturlex-mobl1.ger.corp.intel.com (HELO [10.99.249.37]) ([10.99.249.37])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 01:08:27 -0700
Message-ID: <db933c9e-bf7b-dec6-8022-75074f9cebf7@linux.intel.com>
Date:   Wed, 23 Mar 2022 09:08:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/4] ALSA: pcm: Fix races among concurrent prepare and
 hw_params/hw_free calls
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc:     Hu Jiahui <kirin.say@gmail.com>, linux-kernel@vger.kernel.org
References: <20220322170720.3529-1-tiwai@suse.de>
 <20220322170720.3529-4-tiwai@suse.de>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20220322170720.3529-4-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/2022 6:07 PM, Takashi Iwai wrote:
> Like the previous fixes to hw_params and hw_free ioctl races, we need
> to paper over the concurrent prepare ioctl calls against hw_params and
> hw_free, too.
> 
> This patch implements the locking with the existing
> runtime->buffer_mutex for prepare ioctls.  Unlike the previous case
> for snd_pcm_hw_hw_params() and snd_pcm_hw_free(), snd_pcm_prepare() is
> performed to the linked streams, hence the lock can't be applied
> simply on the top.  For tracking the lock in each linked substream, we
> modify snd_pcm_action_group() slightly and apply the buffer_mutex for
> the case stream_lock=false (formerly there was no lock applied)
> there.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/core/pcm_native.c | 32 ++++++++++++++++++--------------
>   1 file changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index 266895374b83..0e4fbf5fd87b 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -1190,15 +1190,17 @@ struct action_ops {
>   static int snd_pcm_action_group(const struct action_ops *ops,
>   				struct snd_pcm_substream *substream,
>   				snd_pcm_state_t state,
> -				bool do_lock)
> +				bool stream_lock)
>   {
>   	struct snd_pcm_substream *s = NULL;
>   	struct snd_pcm_substream *s1;
>   	int res = 0, depth = 1;
>   
>   	snd_pcm_group_for_each_entry(s, substream) {
> -		if (do_lock && s != substream) {
> -			if (s->pcm->nonatomic)
> +		if (s != substream) {
> +			if (!stream_lock)
> +				mutex_lock_nested(&s->runtime->buffer_mutex, depth);
> +			else if (s->pcm->nonatomic)
>   				mutex_lock_nested(&s->self_group.mutex, depth);
>   			else
>   				spin_lock_nested(&s->self_group.lock, depth);

Maybe
	if (!stream_lock)
		mutex_lock_nested(&s->runtime->buffer_mutex, depth);
	else
		snd_pcm_group_lock(&s->self_group, s->pcm->nonatomic);
?

> @@ -1226,18 +1228,18 @@ static int snd_pcm_action_group(const struct action_ops *ops,
>   		ops->post_action(s, state);
>   	}
>    _unlock:
> -	if (do_lock) {
> -		/* unlock streams */
> -		snd_pcm_group_for_each_entry(s1, substream) {
> -			if (s1 != substream) {
> -				if (s1->pcm->nonatomic)
> -					mutex_unlock(&s1->self_group.mutex);
> -				else
> -					spin_unlock(&s1->self_group.lock);
> -			}
> -			if (s1 == s)	/* end */
> -				break;
> +	/* unlock streams */
> +	snd_pcm_group_for_each_entry(s1, substream) {
> +		if (s1 != substream) {
> +			if (!stream_lock)
> +				mutex_unlock(&s1->runtime->buffer_mutex);
> +			else if (s1->pcm->nonatomic)
> +				mutex_unlock(&s1->self_group.mutex);
> +			else
> +				spin_unlock(&s1->self_group.lock);

And similarly to above, use snd_pcm_group_unlock() here?

>   		}
> +		if (s1 == s)	/* end */
> +			break;
>   	}
>   	return res;
>   }
> @@ -1367,10 +1369,12 @@ static int snd_pcm_action_nonatomic(const struct action_ops *ops,
>   
>   	/* Guarantee the group members won't change during non-atomic action */
>   	down_read(&snd_pcm_link_rwsem);
> +	mutex_lock(&substream->runtime->buffer_mutex);
>   	if (snd_pcm_stream_linked(substream))
>   		res = snd_pcm_action_group(ops, substream, state, false);
>   	else
>   		res = snd_pcm_action_single(ops, substream, state);
> +	mutex_unlock(&substream->runtime->buffer_mutex);
>   	up_read(&snd_pcm_link_rwsem);
>   	return res;
>   }

