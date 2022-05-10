Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AC9520C75
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 05:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbiEJD5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 23:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbiEJD47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 23:56:59 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E91E1B1769
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 20:53:03 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id iq10so14829771pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 20:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hReiOX69+mv1pt6YxzVEwJ7YYc7NAuaNgWxYK9q0lF0=;
        b=hWkL9E8kxRiwqYY6H1zR3E4Ao35pOjmTLDahP9HsOSAAEO8AcGr18Auk0HSWSJnA6w
         jDfwBY5QFS3lb5jC0nMSOKMoZzYNU3MS/9wKyGZRS8gg9cJsWFPY3x7pgzsC0cIRjXCg
         wv02jmEtgmar1TooIC9jIKSBEgW67TA6rEqpqAF3wbo49/OC64AU5Q732J3c26aZ0t8h
         GLNWshGu3Pgn89fmyrjydJFhPe3AI3rDDn+V9Um/f+oRLHNkEG45M46E8bCOJ98TXRcU
         RWwanft6968Jv6o/Mzk4QRLwmN8BvFP6Wj1lC4PZDVV/XZYvFQBHaTYwNgtpRu/kWcmC
         E4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hReiOX69+mv1pt6YxzVEwJ7YYc7NAuaNgWxYK9q0lF0=;
        b=Sj9sVHlbgEVQO96GVpcCwM20wW0shtJZbdtSMIBg/xA6HeZRPSzxXb8eUD1Ukgss+e
         MHF1jfDkJ8AGaVCxZOzJThkPOYu4WPAOoKlObeoKo9me3QyR6i8Wn+osmH8gD3+4Nom+
         l10DIxNd0RUUbWIFJq2DTCvZvMIuDlOcRAgxzkTwizlkJnUTR56bku4I5pLShHBIFibr
         BWIf7xnzkI3TUoa2y7YSF4SWhXRMxp8o2sbp6U+bpAQgnyhIWT4k40Vl098/1yG9uQgk
         SHZhyo7ujxAdwWHkkqVOL7Mi0qeq5HzFo/OjrAujnNQwQ+iJm+loGnUoyZ8+bcd+s92n
         0+rQ==
X-Gm-Message-State: AOAM531NeWtZ5c7q2+FMv069hcSP4F2u4B5PKNWw2ypyCBH4mXxCrEyw
        QjZRtEmlhhH2OSJhm2u0whCvgMsy9nI2pw==
X-Google-Smtp-Source: ABdhPJwyQo7aFq8SBKDox+aj6XJZyLun7T1NIGI4CSdhc4FLlzaDDjeN4zlr6cier4x5dr68hdydjg==
X-Received: by 2002:a17:90a:e2cb:b0:1da:35d6:3a08 with SMTP id fr11-20020a17090ae2cb00b001da35d63a08mr29482199pjb.223.1652154783083;
        Mon, 09 May 2022 20:53:03 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id s13-20020a17090302cd00b0015f186be48asm737847plk.36.2022.05.09.20.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 20:53:02 -0700 (PDT)
Date:   Tue, 10 May 2022 09:22:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Schspa Shi <schspa@gmail.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: fix race on cpufreq online
Message-ID: <20220510035259.5ep52sgahd2a6rie@vireshk-i7>
References: <20220420191541.99528-1-schspa@gmail.com>
 <20220509035746.aeggm4cut2ewcmmk@vireshk-i7>
 <CAMA88ToT5Jx1xM20X0DPv9S7hyQY2DuvO0TY6VLJxSwty3PfVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMA88ToT5Jx1xM20X0DPv9S7hyQY2DuvO0TY6VLJxSwty3PfVw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-05-22, 23:06, Schspa Shi wrote:
> I am very sorry for this oversight.

No issues, I am partly to blame for not reviewing it as well.

> To fix this issue, there is no need to move cpufreq_driver->exit(policy)
> and cpufreq_driver->offline(policy) to inside of &policy->rwsem.
> I made this change because they are inside of &policy->rwsem write lock
> at cpufreq_offline. I think we should keep offline & exit call inside of
> policy->rwsem for better symmetry.
> 
> static int cpufreq_offline(unsigned int cpu)
> {
>         ...
>         down_write(&policy->rwsem);
>     ...
>         /*
>          * Perform the ->offline() during light-weight tear-down, as
>          * that allows fast recovery when the CPU comes back.
>          */
>         if (cpufreq_driver->offline) {
>                 cpufreq_driver->offline(policy);
>         } else if (cpufreq_driver->exit) {
>                 cpufreq_driver->exit(policy);
>                 policy->freq_table = NULL;
>         }
> 
> unlock:
>         up_write(&policy->rwsem);
>         return 0;
> }
> 
> > The very first thing we need to do now is revert this patch. Lemme
> > send a patch for that and you can send a fresh fix over that once you
> > have a stable fix.
> 
> For the next version of the stable fix, I'd be willing to keep exit and
> offline calls inside of policy->rwsem. But it's OK for me to keep offline
> & exit calls outside of policy->rwsem.

Just send a patch with whatever you think is the right fix and lets
take it from there.

-- 
viresh
