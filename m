Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3486C568DC3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbiGFPjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbiGFPht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:37:49 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDDC25EB3;
        Wed,  6 Jul 2022 08:34:21 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-31c8a1e9e33so91637247b3.5;
        Wed, 06 Jul 2022 08:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e+Fsv8R6El10zE4fRO1Zb3LQa9YV3Qjec5+0V8sZOL8=;
        b=abA2kxiYOK5w7K6qOsyYQIZT4hWfSiQncZj/EO7rhLYaVAk6FGpU6Kr98ibYzDhH5Y
         oUgbjATbtc8CW95p7wGQgCqYGSEgL8QD6Mcg7T7Lj0HS3ghwrtlI/kxflVkm861jzK3N
         03x/T0/empdgiEvnlxIZWNloj8euVPnMObTXrIvMbVztLSA1hUb0EcseNozh8WpSfPzi
         Ocn3mTICmZ2lIZto4x4gXGIGNJxQZv6Hop0U3ETSKWv22x5b81WalOmLNTWM9CX+rF7s
         aa3+sOZ845mI96bXxCxxJdJmr53azPXBHoImOmdq54vrnj6ICLDZS0mqxP62rGvX2zuA
         5kVw==
X-Gm-Message-State: AJIora+ZUm1wIAlfeVCNpW41toSLZCq+b8F0KDutM6G8Njt+/V+MzgfT
        FJv4rQAhJehPy8VEOOM5xcAkEkWIEYVdpxe2e6T4CdXSeBg=
X-Google-Smtp-Source: AGRyM1u7ABPiXSFcDKj/c4I09BwgdOZnzeJIsTesqlFtEdqGMBzTO/wiiq9rxvUww5aXa3RBPwaMfL4Aazj2igIKYaE=
X-Received: by 2002:a81:6943:0:b0:31c:ee3e:47c6 with SMTP id
 e64-20020a816943000000b0031cee3e47c6mr3379106ywc.515.1657121660817; Wed, 06
 Jul 2022 08:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <8c3d50faf8811e86136fb3f9c459e43fc3c50bc0.1653565641.git.viresh.kumar@linaro.org>
 <426bf6edc80b2e944d459fa7b8dffbe8b73bb3d9.1653623526.git.viresh.kumar@linaro.org>
 <CAJZ5v0gswDEdK9-gC1dPr9BFPv3G9rs+JYe-7=1JZ11OMoBb-g@mail.gmail.com>
 <20220615045957.55ocdyddcac3vwct@vireshk-i7> <CAJZ5v0gDCS8mkoFjnqOAi9gGuhTheE79FwvRWgeoxagMj3Ok0Q@mail.gmail.com>
 <20220706152333.fvgybznz3j6ffmre@vireshk-i7>
In-Reply-To: <20220706152333.fvgybznz3j6ffmre@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Jul 2022 17:34:09 +0200
Message-ID: <CAJZ5v0hnjeTYDfGvwrAEY8hNa6bfD6MDGEiuTOgVV+g6LEaGLQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] cpufreq: Panic if policy is active in cpufreq_policy_free()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel test robot <oliver.sang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 6, 2022 at 5:23 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 06-07-22, 15:49, Rafael J. Wysocki wrote:
> > WARN_ON() would be somewhat better, but then I'm not sure if having a
> > full call trace in this case is really useful, because we know when
> > cpufreq_policy_free() can be called anyway.
> >
> > Maybe just print a warning message.
>
> The warning will get printed, yes, but I am sure everyone will end up
> ignoring it, once it happens.
>
> One of the benefits of printing the call-stack is people will take it
> seriously and report it, and we won't miss a bug, if one gets in
> somehow.

I'd rather not go into discussing things that people may or may not do and why.

My point is that if WARN_ON() gets converted to panic(), they will not
see the message at all and if the message gets printed, they will have
a chance to see it even in that case.  Whether or not they use that
chance as desirable is beyond the scope of engineering IMV.
