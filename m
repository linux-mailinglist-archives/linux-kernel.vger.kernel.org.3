Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3775522B6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 19:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbiFTRYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 13:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiFTRYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 13:24:44 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E5F1EAC9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 10:24:44 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id e63so9333094pgc.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 10:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=378B6AarfCsUnZPRyvz8/gQguvAL2Hh1HBjIQaMIiAE=;
        b=yV0Kc6wRhdE/cj5b5juTpHMlvmkY8Nvv+/l9sm8yEizaKk7GOIW673f81bJTQDQJzF
         sdFFYLCBZZN/6eqKe2s7OJcEfTQ49zEEj4US/ZyyhuBTmznILrJvIb5Q0NEWgfiwFu1i
         emjfiXNBEr9IR3K9cLlhV9uMPT9E0toElufcP4KbeedtAA1y9G3kjPYO62nlEZRsD54g
         xfl1i3Up3BEwZWRbIhxWCFvBlC9J5e93ez35ddoCSmZlrRaSd41R3pH4ZOcphJK/inyO
         KcfUMcGTV0Ldf0ra5qFSxFaPkEOH7y/iOSc74OWkUY+U2Dfd2KbvsRrrml8ehsGdEQhw
         yoYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=378B6AarfCsUnZPRyvz8/gQguvAL2Hh1HBjIQaMIiAE=;
        b=CqmQ+U3HYaVzG8CB/OB4B9XPA1NYAXQvGrFuOosFymZWelNH5IM+GDHh/HD6qCBBCC
         hvOV6oZENtu0YrAO46sKrYbWmhiNkWJGK84hRWCd2yIyDzk/aDLNAxmRW2YR8z0yD5p7
         E/OkE9c01ettTdlFUhxn0ihGr0k7JlXXe/lKe15OXcaNMZejO3bTobtOWiQc889ySeA8
         DMxwyV7I5EpHS9q064GBVBj9go5c2qzvRFNkI1dBAhOCS8aTQYWMGPU0fjMz+borkH+Y
         IzSMvziz6yx7AIUXHXj/9DUg1sYr0Le0ndLy+ijhfFVasaNwlce3iWIl4/V/T4X9jw0z
         YyHg==
X-Gm-Message-State: AJIora+iOooiF1IYqLAgTHoqDnMJ66CqxKIWQUtswP0EQzuNbE8Hvggn
        SxXckEKPlkksf7giAiZtDVZJbg==
X-Google-Smtp-Source: AGRyM1tv9LoQREr/ywAotQ7isz2K+LlXji9NnQRojuO9bRW+atXaJ05eleyg0SdaNnDEaf5XknCMeA==
X-Received: by 2002:a05:6a00:164c:b0:50a:472a:6b0a with SMTP id m12-20020a056a00164c00b0050a472a6b0amr25843548pfc.77.1655745883108;
        Mon, 20 Jun 2022 10:24:43 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id o1-20020a629a01000000b0051bada81bc7sm9358861pfe.161.2022.06.20.10.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 10:24:41 -0700 (PDT)
Date:   Mon, 20 Jun 2022 11:24:38 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     john.garry@huawei.com, will@kernel.org, leo.yan@linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>, james.clark@arm.com
Subject: Re: [PATCH] perf cs-etm: Use swap() instead of open coding it
Message-ID: <20220620172438.GB1458883@p14s>
References: <20220506091718.82858-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506091718.82858-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Adding James]

Hi Jiapeng,

On Fri, May 06, 2022 at 05:17:18PM +0800, Jiapeng Chong wrote:
> Clean the following coccicheck warning:
> 
> ./tools/perf/util/cs-etm.c:418:34-35: WARNING opportunity for swap().
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  tools/perf/util/cs-etm.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 8b95fb3c4d7b..0cb555cc766f 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -406,18 +406,13 @@ struct cs_etm_packet_queue
>  static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
>  				struct cs_etm_traceid_queue *tidq)
>  {
> -	struct cs_etm_packet *tmp;
> -
>  	if (etm->synth_opts.branches || etm->synth_opts.last_branch ||
> -	    etm->synth_opts.instructions) {
> +	    etm->synth_opts.instructions)
>  		/*
>  		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
>  		 * the next incoming packet.
>  		 */
> -		tmp = tidq->packet;
> -		tidq->packet = tidq->prev_packet;
> -		tidq->prev_packet = tmp;

Those 3 lines have burned a lot of eyes...  As far as I can remember the idea is
simply to make sure that after that point, ->prev_packet is now set to ->packet
in preparation for the next iteration.  There is no point in setting ->packet to
->prev_packet.  As such the following would work just fine:

                tidq->prev_packet = tidq->packet;

... but I will let James and Leo have a final say on that.

> -	}
> +		swap(tidq->packet, tidq->prev_packet);

If we absolutely need to keep swapping the packets please add the header file
where swap() is found.

Thanks,
Mathieu

>  }
>  
>  static void cs_etm__packet_dump(const char *pkt_string)
> -- 
> 2.20.1.7.g153144c
> 
