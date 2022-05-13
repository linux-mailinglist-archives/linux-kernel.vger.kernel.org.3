Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5545260D2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379836AbiEMLQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379849AbiEMLQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:16:14 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40932497D;
        Fri, 13 May 2022 04:16:12 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id y63so9721975oia.7;
        Fri, 13 May 2022 04:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vBhBc4igSr5lkTEDPBacehSjxXJjowFEHzx5Vf8m4fc=;
        b=Y3HANqTF+N/856tejKBCenQuJ0ulUY/RfjPBUwD3eBBkEHkFnYR8KRQrl1vqY7AJRN
         dciWsFYxtSoy5Rszs1C9tUXo7kcJUzwMsLHVtoe1bbB2hUlZue4gsvGLSiM7hEVfed/W
         ZVtEHMXHxmcgk/4el0nRixdpwveu4ab8p5bS+XvfPA5IfNgu8sr+1apNsaHscqwSeGcL
         /8cnEtTva+LSO7DiSRIriIG8Df5OMbL5lCxA5v3RBat2pEBU4HgCpH6mCFthLyEA8cfg
         OZamTyZhG/33/L5fBA6Dot3n/t3aa8zSHPsmTrplg8eOrV2ulCcvPR05KO5UT0Kncv1u
         hlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vBhBc4igSr5lkTEDPBacehSjxXJjowFEHzx5Vf8m4fc=;
        b=0e0MaZM3najvv560bDKQH3Q+E4wNzD2HBj3vq8P/lY3y9z+5PgJlbFESGGIxKz/dOR
         vmOo8+4PV0iK1OpiXCmHlVYCEymLs7cuxGLe5EAp2GuMTS/GVpg5POBtm/Y+O0KDoMQ2
         LDk4oxnwoOUP3jsJhqnlQMYnzo7xDHUfhkGdBUrmAT0yYLK4rshVA0acjgMtPymeiVF0
         tUkjwgYZzVQmLdVqeMI80Ceh+IHurFlPUWAhoazhhEQOyrWFEkF698ZO40dLCqDs3YC0
         +Vrx0qsLwuQWAweCwnKbB5Wi+NfkSiJR3EwOIv1Uvv4L1H+cJFZy24kYhQYRqiGnlug0
         h4Vw==
X-Gm-Message-State: AOAM533hT5xvr+dbwlrsBb9t8Re54l0EELF24Zqj2nHA1d8eXvPAsw7s
        eEUMKlp1WSAxmKaJFTIAYjfa2/s6dbblzQRp7oY=
X-Google-Smtp-Source: ABdhPJz2QtgAfkKunulDO5CncAdA8wyHmU0kqVg93DGCgowosP9LEUAB5IFLOc33MgO2fcqNxfvldw5KwhAe7ViZf2E=
X-Received: by 2002:a05:6808:690:b0:325:9655:d782 with SMTP id
 k16-20020a056808069000b003259655d782mr2197475oig.276.1652440572190; Fri, 13
 May 2022 04:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220512135231.10076-1-schspa@gmail.com> <20220513041833.mcubozfhl2qd2rps@vireshk-i7>
 <CAMA88Tpjms4HEos0GJHmQR5YZd4hhdqpgMO7JmxTxVpF0oMUCg@mail.gmail.com> <20220513061343.wndyhjeehoqmfofp@vireshk-i7>
In-Reply-To: <20220513061343.wndyhjeehoqmfofp@vireshk-i7>
From:   Schspa Shi <schspa@gmail.com>
Date:   Fri, 13 May 2022 19:16:01 +0800
Message-ID: <CAMA88Trc143Zaeua_AEt0ynukACYdPqXMG6R50Zoz-sXmMbX4A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] cpufreq: fix race on cpufreq online
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Viresh Kumar <viresh.kumar@linaro.org> writes:

> On 13-05-22, 14:06, Schspa Shi wrote:
>> Viresh Kumar <viresh.kumar@linaro.org> writes:
>> > On 12-05-22, 21:52, Schspa Shi wrote:
>> >> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> >> index 80f535cc8a75..35dffd738580 100644
>> >> --- a/drivers/cpufreq/cpufreq.c
>> >> +++ b/drivers/cpufreq/cpufreq.c
>> >> @@ -953,7 +953,10 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
>> >>              return -EIO;
>> >>
>> >>      down_read(&policy->rwsem);
>> >> -    ret = fattr->show(policy, buf);
>> >> +    if (unlikely(policy_is_inactive(policy)))
>> >> +            ret = -EBUSY;
>> >> +    else
>> >> +            ret = fattr->show(policy, buf);
>> >
>> > I like it the way I have done earlier, initialize ret to -EBUSY and
>> > get rid of the else part and call show/store in if itself. Same for
>> > below.
>> >
>>
>> I add a unlikely here, to avoid branch prediction failed.
>
> I am not asking you to drop it, I also added the unlikely within the
> implementation of policy_is_inactive() then. It can be written as:
>
> if (likely(!policy_is_inactive(policy)))
>         ret = fattr->show(policy, buf);
>
>> And move the
>> to the fail path to avoid a register assignment to -EBUSY.
>
> We don't care about such assignments for performance to be honest.
> This makes the code smaller by few lines, that's enough.

OK, I have uploaded a v5 patch for this. Please review it.


--
Schspa Shi
BRs
