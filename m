Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED34254C550
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240825AbiFOKBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiFOKBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:01:16 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39563B023;
        Wed, 15 Jun 2022 03:01:15 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v14so14649266wra.5;
        Wed, 15 Jun 2022 03:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=+o+NJBHdLQtZQM+UxtBaEFTjpeaUrX4loLW3tV0gO1s=;
        b=QVeMBRfG3BUToGU1v1XZ7CJ9QLI63+40lCKkSLmLQXfgGTHxyMFt0n7AjX+Pz3N9Wx
         knxlRQIuqPkudGPlE/XLxxZhB3bi25I2J5P+4dJQzflaD7kiUK3N2R17+TT6B7RGaJSw
         mMLMOSSviRGDemiKOknuGtP6El5Egxsx1ievkQlfC+/twjNRd96r9BDHhHsCUpdGyM4P
         1U7iMfi+0HIu8YXy5ouyZ2oH/tL2d8d52ey4CFoBaYHC2EX5p5cCik32mN8d6HlhJx1U
         XNdgVYmsvHYog0ib8Djdms/nLQ9NFPqvNrtOaT390NEiKeMPJEqN227Vjs0IKnCr6SCV
         42Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=+o+NJBHdLQtZQM+UxtBaEFTjpeaUrX4loLW3tV0gO1s=;
        b=jziw+Bw1/3Mu9HTU6XLNOF7h6mF8h4owHDuSdrszGunt9ZwTGU8665wORSuRTuqUOc
         SxBLvP6RKFj9IEl5T2fjE1a4B0xiLPQvZJqNjrqe8lfjQ1WFyxur2WJMqH0+3OkVvv4J
         zNwjWHCcs/Qhnt1Oz6hSnRmcIvNrpDZXxZ0zVSwkZ8DQg8rCdw8q8lLyyHRsynqglt0k
         PjKBfxHTQ55WSS5y7HKqhdHDMdIdJZ1N5VeF4vDRtTB5SVW4+ZhwBCQoEttn25DJRFWU
         UBlOVRej5+5dv+G5gT8Hh/bOaH0g0Dh7BBYUZkOaQ1a2mKxq/lmaZ1Y++tkLV3jf9A6B
         OQZg==
X-Gm-Message-State: AJIora/g7E/8/ppXR34Gm3DA+uRVlm17HMTssoVNDwIJS+GIfjGYVKzO
        uYaHUMSeJqY6Fuk29AdnbDkhZBIks5o=
X-Google-Smtp-Source: AGRyM1tQN1gJfHu+PZG/moVgWglZwZbQYl52t6+KVwB4qjaP/q9GL6bkGYVnT877dLBWWwECh55HwA==
X-Received: by 2002:a05:6000:244:b0:210:cc02:889a with SMTP id m4-20020a056000024400b00210cc02889amr9398786wrz.141.1655287273944;
        Wed, 15 Jun 2022 03:01:13 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id j20-20020adfa554000000b002100316b126sm14655002wrb.6.2022.06.15.03.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 03:01:12 -0700 (PDT)
Message-ID: <62a9ade8.1c69fb81.76bfd.ae0b@mx.google.com>
X-Google-Original-Message-ID: <YqmioratM4EzT582@Ansuel-xps.>
Date:   Wed, 15 Jun 2022 11:13:06 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] PM / devfreq: Fix cpufreq passive unregister
 erroring on PROBE_DEFER
References: <20220614230950.426-1-ansuelsmth@gmail.com>
 <20220614230950.426-2-ansuelsmth@gmail.com>
 <17cb21c6-317a-3f70-8c4d-4d8fe20604d4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17cb21c6-317a-3f70-8c4d-4d8fe20604d4@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 03:48:03PM +0900, Chanwoo Choi wrote:
> On 22. 6. 15. 08:09, Christian 'Ansuel' Marangi wrote:
> > With the passive governor, the cpu based scaling can PROBE_DEFER due to
> > the fact that CPU policy are not ready.
> > The cpufreq passive unregister notifier is called both from the
> > GOV_START errors and for the GOV_STOP and assume the notifier is
> > successfully registred every time. With GOV_START failing it's wrong to
> > loop over each possible CPU since the register path has failed for
> > some CPU policy not ready. Change the logic and unregister the notifer
> > based on the current allocated parent_cpu_data list to correctly handle
> > errors and the governor unregister path.
> > 
> > Fixes: a03dacb0316f ("PM / devfreq: Add cpu based scaling support to passive governor")
> > Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/devfreq/governor_passive.c | 39 +++++++++++++-----------------
> >  1 file changed, 17 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> > index 72c67979ebe1..95de336f20d5 100644
> > --- a/drivers/devfreq/governor_passive.c
> > +++ b/drivers/devfreq/governor_passive.c
> > @@ -34,6 +34,20 @@ get_parent_cpu_data(struct devfreq_passive_data *p_data,
> >  	return NULL;
> >  }
> >  
> > +static void delete_parent_cpu_data(struct devfreq_passive_data *p_data)
> > +{
> > +	struct devfreq_cpu_data *parent_cpu_data, *tmp;
> > +
> 
> Need to add the validation checking of argument as following:
> 
> 	if (!p_data)
> 		return;
>

Considering this is called only by cpufreq_passive_unregister_notifier
and cpufreq_passive_unregister_notifier is called only by devfreq_passive_event_handler
where the check is already done, isn't that redundant.
We should never reach delete_parent_cpu_data with no p_data.
(Unless you want to use that function somewhere else)

> > +	list_for_each_entry_safe(parent_cpu_data, tmp, &p_data->cpu_data_list, node) {
> > +		list_del(&parent_cpu_data->node);
> > +
> > +		if (parent_cpu_data->opp_table)
> > +			dev_pm_opp_put_opp_table(parent_cpu_data->opp_table);
> > +
> > +		kfree(parent_cpu_data);
> > +	}
> > +}
> > +
> >  static unsigned long get_target_freq_by_required_opp(struct device *p_dev,
> >  						struct opp_table *p_opp_table,
> >  						struct opp_table *opp_table,
> > @@ -222,8 +236,7 @@ static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
> >  {
> >  	struct devfreq_passive_data *p_data
> >  			= (struct devfreq_passive_data *)devfreq->data;
> > -	struct devfreq_cpu_data *parent_cpu_data;
> > -	int cpu, ret = 0;
> > +	int ret;
> >  
> >  	if (p_data->nb.notifier_call) {
> >  		ret = cpufreq_unregister_notifier(&p_data->nb,
> > @@ -232,27 +245,9 @@ static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
> >  			return ret;
> >  	}
> >  
> > -	for_each_possible_cpu(cpu) {
> > -		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> > -		if (!policy) {
> > -			ret = -EINVAL;
> > -			continue;
> > -		}
> > -
> > -		parent_cpu_data = get_parent_cpu_data(p_data, policy);
> > -		if (!parent_cpu_data) {
> > -			cpufreq_cpu_put(policy);
> > -			continue;
> > -		}
> > -
> > -		list_del(&parent_cpu_data->node);
> > -		if (parent_cpu_data->opp_table)
> > -			dev_pm_opp_put_opp_table(parent_cpu_data->opp_table);
> > -		kfree(parent_cpu_data);
> > -		cpufreq_cpu_put(policy);
> > -	}
> > +	delete_parent_cpu_data(p_data);
> >  
> > -	return ret;
> > +	return 0;
> >  }
> >  
> >  static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
> 
> 
> -- 
> Best Regards,
> Samsung Electronics
> Chanwoo Choi

-- 
	Ansuel
