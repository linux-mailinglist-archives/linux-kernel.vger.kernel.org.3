Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC3C4B797E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239473AbiBOVta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 16:49:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237060AbiBOVtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:49:25 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5E0D0079;
        Tue, 15 Feb 2022 13:49:15 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id p22so175869lfu.5;
        Tue, 15 Feb 2022 13:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=v9C8Aj+XvUq6zf+q/jOW8sx/Y8EtmPnccvzaAF6cuDQ=;
        b=ZGYj2+Ht8tCun2NoavyLy8LQF4DXKyv3S1kMTc9Zc0CIaHBDnW/7c2zMLo+LOr71iy
         Lwz3YxBlmeD4L6TKlGlXtA1APyZUj9tsS02wK6jrSrMpTGpadbYwzUQYKovfeAdpUH5t
         nH47g0Grr9QDDnraF2Hq45dO+jzV49/SEj74fTRcjgVz1Z9ouQdaARLGTgc8+42nPypD
         w9ZS59NKSsvyCG2E8/nZVq7rX8236zDAlUkESMtE+46zswjYT2pCaJXCtu/Px3PXP7hk
         EXai+gDDk2UxXupjH0+fg6yRDzysAGhs2rxHqDowqcHU3nPPvrgQSA9UNFb/E6jqMPsh
         wgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v9C8Aj+XvUq6zf+q/jOW8sx/Y8EtmPnccvzaAF6cuDQ=;
        b=zo8UTUl+g1S5vW0EtXXNjSOQJd7VH8atLulatBOjtLVCLS9FJv62xVcggF+4Y8siDS
         p4QA+nopaekuhD1XMZskYqrfZMTDxBNoXAyLNI+yp5xLAj05L4S9UCLRn+gUW1UpoVIu
         bstIC0LOGrbax5pQp/q+qRNJaKZ6/2rqtdH8UXvx4oq0KWuaHigfG1E0drrfEe+9u05f
         TbX4e9b3wRtu8T7olZaCGxvK3dKrGGskrV9Tddm/i99CzES6LZjEfiV+Q4XcGMAN3efO
         oa9+cf5HfM9w/MW763YzvZJQKcgN4YUiPsnpvRJd0ZFdOqFuJpga4xpPtCsNwGmS5ra8
         J/LQ==
X-Gm-Message-State: AOAM531oCZHn0MIy+wqDkBiDKrRA5aV6OJIrugVR8pf5zrhoQLx+HX5y
        JIOt3Ieu3NCrpXoZInMFf+XaD6wSNSw=
X-Google-Smtp-Source: ABdhPJxlrdHRhxdQMuNwOGSx0N6n2ndjVBmW7vR5UxYDc6hx3pGw345GBYW/4ArFNY7L1PmHZa6Uig==
X-Received: by 2002:a05:6512:12c4:: with SMTP id p4mr832572lfg.39.1644961753465;
        Tue, 15 Feb 2022 13:49:13 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id k20sm725893ljk.62.2022.02.15.13.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 13:49:13 -0800 (PST)
Message-ID: <5e27fc63-5dd7-8da6-01f5-d7c7660874e3@gmail.com>
Date:   Wed, 16 Feb 2022 00:49:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] PM: domains: Prevent power off for parent unless child is
 in deepest state
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-kernel@vger.kernel.org
References: <20220131113743.52265-1-ulf.hansson@linaro.org>
 <b33ceac4-506a-65c8-7c80-b1b0a67ce65e@gmail.com>
 <CAPDyKFqsvF=Pm-vMXSUwPMPnjCr7nSYuy5AH+8rwLYm_NUPKww@mail.gmail.com>
 <400e45da-837a-c8ad-84b3-285e35f8462c@gmail.com>
 <CAPDyKFpLX0Jpz-tzYx3-g0YBZZNh6Bw731gQEFQub1SviLGoYg@mail.gmail.com>
 <2656099c-76bc-33a5-3b98-c46858025955@gmail.com>
 <CAPDyKFokevJSYoH009t3PA4h48tx-LK+DaWVpC_14L6xZF3iZA@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <CAPDyKFokevJSYoH009t3PA4h48tx-LK+DaWVpC_14L6xZF3iZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

14.02.2022 12:22, Ulf Hansson пишет:
> On Sun, 13 Feb 2022 at 13:14, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 07.02.2022 11:43, Ulf Hansson пишет:
>>>> In general, such changes usually are deferred from being upstreamed
>>>> until there is a real user, otherwise there is a risk of cluttering the
>>>> code with unused features. Do you have a time estimation in regards to
>>>> when STMicro may start to benefit from this change?
>>> The STMicro folkz are working on it right now, but I can't give you
>>> any estimates for their work.
>>>
>>> Moreover, I think the important point in this regard, is that the
>>> $subject patch doesn't really hurt anything else, so then what's the
>>> point of holding this back?
>>
>> If that work will never pan out, will you remove the unused code?
> 
> Sure, I will continue to monitor the situation, which is what I have
> been doing for many years by now.
> 
> In the past we have agreed to add new things to genpd, even if those
> didn't have in-tree users when the changes went in. The current
> dev_pm_genpd_set_next_wakeup() inteface, for example, is still lacking
> a user upstream. It's a balance, because I certainly agree with you,
> that we don't want to carry around dead code in the kernel - unless we
> have reasons to believe it's an intermediate step before there a user
> turning up.

I've seen enough of dead code while was doing a tree-wide changes, we
don't need more :)

Oh, well. Sounds like you're working closely with the STMicro people, so
should be fine.
