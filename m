Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A17525B47
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377190AbiEMGNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350874AbiEMGNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:13:49 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD3826CC7D
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:13:46 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso6930792pjg.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kUZ2JsyK3ZUZK31g+pozQdNwm9zwv4kOdXsDjmRgytw=;
        b=b/B7oTtsYLzf9v+BgX7A5Op62ccI59r0/Gjhdo9XmmKLpZcCFvpRLYh0T1diKGFssq
         +D1oFMpGEgS3dedSc1hx7m+97/PBP5klDt+XFKkZOa+SOzIrkbz1GdHO++9ofGkrxJ8X
         OBDyJBz9lVt6T0PwBvZcESLXtdeww0QiyN1QSBOVKTRVdoug+uWnUXaqBTcI+SLZlGxW
         d/wFh1WGoXM3hXFZh7/R2JE+MWVpg8YQJxBo/MMDlZxsxswQtP3iucxs3+7+Pc7+G1bj
         VpvgDRFalC1lZluL98subl2H3sTFs2PpA4Lk0apLT2FNL5FZHn4AE6GtfzHwPMSkRun1
         p1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kUZ2JsyK3ZUZK31g+pozQdNwm9zwv4kOdXsDjmRgytw=;
        b=C1hWLyrHx0gTMUcMtvHsdtt1Upbd0hrZF0CzrAuEq9wupubSEVAIGuDDKzuHDkfiCo
         jmV++TIYV7zQzFgHAb4i8J63zICK9ydXcoF/P5HqllsllUrtEjEdaE1Vk1QDKnzMKITT
         nHt0d4SZf0E48l+kAD6IbPdAMK4K79W+BHSrErjOqCFlI9bQGzoin7EWef99/SNCigfa
         wIpt7cbM+J0RLBzU2SwIU+J41saw/8VGwVjMDKO+0jf4pzra4RH7cHaOKLZc+bhdk8pp
         T4hrHit9Xk4YRd14B8RIf+8q7RxfhpjHtk77681WNJT5PAaH10QarMSDw9vyHDTju0Bv
         rHdA==
X-Gm-Message-State: AOAM532zNECOwlx9kJSnQ+ABn8LL5BPVI4Yy12PjRfX9bxTM4p6aCVFs
        IGwLer83PYVS1hX7/g6z0CQWzw==
X-Google-Smtp-Source: ABdhPJwtZ+ZrOvv/RBk2TLd92omy7V3a10rbbih+EthlQBwXfimJ1ehIKFYHeBwhoactNuDqC2MxdQ==
X-Received: by 2002:a17:90a:e517:b0:1d7:5bbd:f9f0 with SMTP id t23-20020a17090ae51700b001d75bbdf9f0mr3233860pjy.77.1652422426455;
        Thu, 12 May 2022 23:13:46 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090341cb00b0015e8d4eb219sm941603ple.99.2022.05.12.23.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 23:13:45 -0700 (PDT)
Date:   Fri, 13 May 2022 11:43:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Schspa Shi <schspa@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] cpufreq: fix race on cpufreq online
Message-ID: <20220513061343.wndyhjeehoqmfofp@vireshk-i7>
References: <20220512135231.10076-1-schspa@gmail.com>
 <20220513041833.mcubozfhl2qd2rps@vireshk-i7>
 <CAMA88Tpjms4HEos0GJHmQR5YZd4hhdqpgMO7JmxTxVpF0oMUCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMA88Tpjms4HEos0GJHmQR5YZd4hhdqpgMO7JmxTxVpF0oMUCg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-05-22, 14:06, Schspa Shi wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:
> > On 12-05-22, 21:52, Schspa Shi wrote:
> >> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >> index 80f535cc8a75..35dffd738580 100644
> >> --- a/drivers/cpufreq/cpufreq.c
> >> +++ b/drivers/cpufreq/cpufreq.c
> >> @@ -953,7 +953,10 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
> >>              return -EIO;
> >>
> >>      down_read(&policy->rwsem);
> >> -    ret = fattr->show(policy, buf);
> >> +    if (unlikely(policy_is_inactive(policy)))
> >> +            ret = -EBUSY;
> >> +    else
> >> +            ret = fattr->show(policy, buf);
> >
> > I like it the way I have done earlier, initialize ret to -EBUSY and
> > get rid of the else part and call show/store in if itself. Same for
> > below.
> >
> 
> I add a unlikely here, to avoid branch prediction failed.

I am not asking you to drop it, I also added the unlikely within the
implementation of policy_is_inactive() then. It can be written as:

if (likely(!policy_is_inactive(policy)))
        ret = fattr->show(policy, buf);

> And move the
> to the fail path to avoid a register assignment to -EBUSY.

We don't care about such assignments for performance to be honest.
This makes the code smaller by few lines, that's enough.

-- 
viresh
