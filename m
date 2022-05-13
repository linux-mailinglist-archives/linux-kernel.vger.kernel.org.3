Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62556525ABD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 06:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353573AbiEME1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 00:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiEME1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 00:27:10 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DE57A817
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 21:27:09 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d22so6829533plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 21:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F0tmkf1itlBqo51fYCdb6yZYCWOSUa1ToT2tuFC2yd0=;
        b=Ep/WmXG9qSh6VNzzzdQoPejBG9XngvM7qSIHetwFtAvQ2y0hGhBueGwWug1YXOjaeK
         WNFSU512/+f0yL1hfou8Tri4nTH2BrrL9WX4MbdXksa6HjMTYh56UFMzmOGia8kkNw3e
         X/aXdHvFAI0Aczocq0+TBdcrUkf/RmT886cEbd1OviR7gyiEiRQK8m6/DGEHUUMDfNsU
         12XbhCVdFbHNHnq1/91NuEqbQR+xKQy/EYa1HngIt1MOwFimwWrcr1byurZ6ylmAex0b
         35Pi7gh1Jwdmqbgo+62qfXzBWR5exoi/6xEJe7rza2DjyV38rSX5Celdq/yc8wH7Ok7l
         Xujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F0tmkf1itlBqo51fYCdb6yZYCWOSUa1ToT2tuFC2yd0=;
        b=RzDkXkoPdP55pEnfa9WADk1IB7jO4TOHeuA7bQunuK1f4vKpJ0XMS+mPCxd5MvAVDi
         nquRlqcAURA192plKAX+WKH66NRuUwKU07p+pyCO8juNCZsla2ZTtzNv6ufGnDYuJAbf
         U9q0HW8UtvPBKZw+p1exRIoPR/2RLl/15REFz0mqlk2gpMppzbgxsT65dyJZS1fs1lt9
         2wxMsJWnvx0z9W0g2C7FJOOejBqu3jdpg/EPJ3IeDwPwdsBhA7NQls+/8T1hQ0RZABca
         pNIMqCp3LiIYhJDF1lDUPTi0drsqHMQ3rlBR1+puE77yJFVwDKKOyjTrj4UQ/Hhau47j
         lCWQ==
X-Gm-Message-State: AOAM5302iw7MnJZPYzD68hOgpmEGB2+99juv/wCUDB2y51M8us6cg5kJ
        Sy2/pkxWq03cHpOgbjswtYpt5vaM2ecRgg==
X-Google-Smtp-Source: ABdhPJyz14jzxmRB9UbyjskBGTTCLhQhSLs2nCZgHPkHdEWO2qS3cO7tSUVYxJmeogYgn6jbMtIeVA==
X-Received: by 2002:a17:90b:4c07:b0:1dc:8491:c32f with SMTP id na7-20020a17090b4c0700b001dc8491c32fmr2913713pjb.242.1652416028565;
        Thu, 12 May 2022 21:27:08 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id d26-20020a634f1a000000b003c619f3d086sm575404pgb.2.2022.05.12.21.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 21:27:08 -0700 (PDT)
Date:   Fri, 13 May 2022 09:57:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Schspa Shi <schspa@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3] cpufreq: fix race on cpufreq online
Message-ID: <20220513042705.nbnd6vccuiu6lb7a@vireshk-i7>
References: <20220510035259.5ep52sgahd2a6rie@vireshk-i7>
 <20220510154236.88753-1-schspa@gmail.com>
 <20220511043515.fn2gz6q3kcpdai5p@vireshk-i7>
 <CAMA88TpefB=rnqea2u1zEvNUJNE_kdj4mYito7SGCuMj-o071Q@mail.gmail.com>
 <20220511122114.wccgyur6g3qs6fps@vireshk-i7>
 <CAJZ5v0gN_yDFpvCXRXv8rN-i3TugCi-HKpBKK2z4eWU0Zm1GUg@mail.gmail.com>
 <CAJZ5v0id+7vkqMQEyVRe29oF_dRtzZ0EhoYUn8=yzeENDeABJw@mail.gmail.com>
 <20220512065623.q4aa6y52pst3zpxu@vireshk-i7>
 <CAJZ5v0jeYiZ6esdxnJbOyDztNqOAbjcjxmpca3JTFWRh+cwdBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jeYiZ6esdxnJbOyDztNqOAbjcjxmpca3JTFWRh+cwdBw@mail.gmail.com>
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

On 12-05-22, 12:49, Rafael J. Wysocki wrote:
> Well, would there be a problem with moving the
> cpufreq_policy_put_kobj() call to the front of cpufreq_policy_free()?

Emptying cpufreq_cpu_data first is required, else someone else will
end up doing kobject_get() again.

> If we did that, we'd know that everything could be torn down safely,
> because nobody would be holding references to the policy any more.

With the way we are progressing now, we will always have policy->cpus
empty while we reach cpufreq_policy_free(). With that I think we will
be safe with the current code here. I would also add a BUG_ON() here
for non empty policy->cpus to be safe.

> > > TBH, I'm not sure why show() doesn't check policy_is_inactive() under the rwsem.
> >
> > I agree, both show/store should have it.
> >
> > > Moreover, I'm not sure why the locking dance in store() is necessary.
> >
> > commit fdd320da84c6 ("cpufreq: Lock CPU online/offline in cpufreq_register_driver()")
> 
> I get that, but I'm wondering if locking CPU hotplug from store() is
> needed at all.  I mean, if we are in store(), we are holding an active
> reference to the policy kobject, so the policy cannot go away until we
> are done anyway.  Thus it should be sufficient to use the policy rwsem
> for synchronization.

I think after the current patchset is applied and we have the inactive
policy check in store(), we won't required the dance after all.

-- 
viresh
