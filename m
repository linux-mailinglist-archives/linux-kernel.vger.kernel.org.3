Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF8154C57B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244351AbiFOKIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244130AbiFOKIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:08:18 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5FB1EAD4;
        Wed, 15 Jun 2022 03:08:17 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m24so14635365wrb.10;
        Wed, 15 Jun 2022 03:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=QLLYtowXNn5Kd+fYfaW0L3yaND/8MmGwC9nsF1e9Zds=;
        b=ZrhqiSBSUuoikbNsL9nbZZdr4JVTXFZfEwlWWGpqR+vLoL803NPaeKYPNdYiGUR+VW
         E/yubTLSJ3OLEQg13EUmlpayNiOsKUFu7moSrEgtmDEO6xbkydBxfycqGSTaFCFOj5+f
         WcZaOrgV9BAEpUf9TeYBFAbxVwABik1DZit0Y0ScMPjbrnLrkPQIPithzbGCNpgJ8cjr
         uNqgp4LBOQyV9ao5OZqoJ08XiavtLPdcxNyJ7kwH0yHFJgZz4QKylHV0OtddBYVgWpFe
         CUd0EVsabfTgB+CQvF0CT9EtTFTBFoQdy3eONd0BMtjl1ioi9TZykOll/bG40OsdDYaG
         d20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=QLLYtowXNn5Kd+fYfaW0L3yaND/8MmGwC9nsF1e9Zds=;
        b=fh8MKlEOHbFm0tjgrgeC+Y8Gl/z6IwIgjf1F/9zGy2OsJuGHivPIRJbZeE3sqmJvc5
         o9zMXWeqT0nFWLfj315kJG7vTc4wI+ReFiPs+pejzI64m91vy5rof39NNS2eNYUxPnR8
         wAArMP++Il/vnw6QGALLZ0icASB4dt0FfKvhYaqDw6J2w359uXv+Ve2E132lS6J2YlPd
         ZggdyZBcr7ZGboVhD5mLD8EtEAZ2AAUEEXZ1uJpKSnAMQWY165kn9NTCFTLKTOrBJ4ar
         av9dDakE443lk70W6Zxethu29rrEs3xEFlNJiGZG9vzFGb03TNSDNnrJ4Y7QmJOpOYJn
         4MTA==
X-Gm-Message-State: AJIora/aTC4wbmJCfWrc/fmagJl4XcvtJYX+Ktvznu2KdLIRnV1YhSX9
        Bl78mm9Vq5yi/Y2EKW6JeXk=
X-Google-Smtp-Source: AGRyM1veOOcXFyre8aA9E4f9aFZ1JFCSCoVMvrjz5AD34wSDdUViDxX9/yOAgEh44W5GnjoZ7SOejg==
X-Received: by 2002:adf:e5d0:0:b0:210:313a:e4dc with SMTP id a16-20020adfe5d0000000b00210313ae4dcmr9045259wrn.152.1655287695717;
        Wed, 15 Jun 2022 03:08:15 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id v1-20020a7bcb41000000b0039c7c4a542csm1788790wmj.47.2022.06.15.03.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 03:08:15 -0700 (PDT)
Message-ID: <62a9af8f.1c69fb81.56ead.2c48@mx.google.com>
X-Google-Original-Message-ID: <YqmkSdXGUo1mM63X@Ansuel-xps.>
Date:   Wed, 15 Jun 2022 11:20:09 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] PM / devfreq: Fix kernel warning with cpufreq
 passive register fail
References: <20220614230950.426-1-ansuelsmth@gmail.com>
 <20220614230950.426-3-ansuelsmth@gmail.com>
 <5848a10e-e5bf-108f-3e3e-15e16332922d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5848a10e-e5bf-108f-3e3e-15e16332922d@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 04:11:13PM +0900, Chanwoo Choi wrote:
> On 22. 6. 15. 08:09, Christian 'Ansuel' Marangi wrote:
> > When the cpufreq passive register path from the passive governor fails,
> > the cpufreq_passive_unregister is called and a kernel WARNING is always
> > reported.
> > This is caused by the fact that the devfreq driver already call the
> > governor unregister with the GOV_STOP, for this reason the second
> > cpufreq_passive_unregister always return error and a WARN is printed
> > from the WARN_ON function.
> > Remove the unregister call from the error handling of the cpufreq register
> > notifier as it's fundamentally wrong and already handled by the devfreq
> > core code.
> > 
> > Fixes: a03dacb0316f ("PM / devfreq: Add cpu based scaling support to passive governor")
> > Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/devfreq/governor_passive.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> > index 95de336f20d5..dcc9dd518197 100644
> > --- a/drivers/devfreq/governor_passive.c
> > +++ b/drivers/devfreq/governor_passive.c
> > @@ -331,7 +331,6 @@ static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
> >  err_put_policy:
> >  	cpufreq_cpu_put(policy);
> >  err:
> > -	WARN_ON(cpufreq_passive_unregister_notifier(devfreq));
> >  
> >  	return ret;
> >  }
> 
> I think that it is necessary to free the resource when error happen.

Thing is that it should not be done in the register. Following the flow
of the devfreq core code, if a gov fails to START, the gov STOP is
called and we correctly free our resources. In the current
implementation we call the free 2 times and the second time will always
print error as the notifier is already unregistered.

> Also, after merging the your patch1, I think that cpufreq_passive_unregister_notifier(devfreq)
> will not return error. Instead, just 0 for success.

With path1 we removed the error with the parent_cpu_data deletion but
the unregister error is still there.

> 
> Instead, 'err_free_cpu_data' and 'err_put_policy' goto statement are wrong exception
> handling. If fix the exception handling code in cpufreq_passive_register_notifier
> as following and with your patch1, I'll handle the resource for free/un-registration
> when error happen during cpufreq_passive_register_notifier.
> 

Don't know the main problem here is calling unregister 2 times.

> 
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index a35b39ac656c..0246e0731fc0 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -289,22 +289,23 @@ static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
>                 parent_cpu_data = kzalloc(sizeof(*parent_cpu_data),
>                                                 GFP_KERNEL);
>                 if (!parent_cpu_data) {
> +                       cpufreq_cpu_put(policy);
>                         ret = -ENOMEM;
> -                       goto err_put_policy;
> +                       goto err;
>                 }
>  
>                 cpu_dev = get_cpu_device(cpu);
>                 if (!cpu_dev) {
>                         dev_err(dev, "failed to get cpu device\n");
>                         ret = -ENODEV;
> -                       goto err_free_cpu_data;
> +                       goto err;
>                 }
>  
>                 opp_table = dev_pm_opp_get_opp_table(cpu_dev);
>                 if (IS_ERR(opp_table)) {
>                         dev_err(dev, "failed to get opp_table of cpu%d\n", cpu);
>                         ret = PTR_ERR(opp_table);
> -                       goto err_free_cpu_data;
> +                       goto err;
>                 }
>  
>                 parent_cpu_data->dev = cpu_dev;
> @@ -326,10 +327,6 @@ static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
>  
>         return ret;
>  
> -err_free_cpu_data:
> -       kfree(parent_cpu_data);
> -err_put_policy:
> -       cpufreq_cpu_put(policy);
>  err:
>         WARN_ON(cpufreq_passive_unregister_notifier(devfreq));
>  
> 
> 
> 
> -- 
> Best Regards,
> Samsung Electronics
> Chanwoo Choi

-- 
	Ansuel
