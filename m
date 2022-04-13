Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0048F50014A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiDMVn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbiDMVnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:43:53 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFE627CD2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:41:29 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id mm4-20020a17090b358400b001cb93d8b137so7482045pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=SfoDmkk530wshO3slXTZtiI0F2WjtIKkqUFd0Gpj3l0=;
        b=0Vl0rKzEHtcgIFrinPbJd5uJsmwc724wKh4qfOM8rKzFHmxW8UZoO6IAqF9wBLu34d
         pPV6iyo01K/E7H8ZiavcBMdqf0CRkaSQbhjSJJRj7Ts19En0qGBww8lWX29+l14gN6vW
         cksutE4ofHqbv6clurhG64VqK8dHsYYhdWqKAYrm8jRYX2VsBYzs30yXnjNIMTwMlYS+
         hwSbvSDSHZHpY7kWBKPzl46VqWuCg7TBzx/LxVGaeNYoHbskbjlOThWen3A3l3rAtrwe
         0m5tm6avY1ERvUDpkLksEEoZtmBtn/nxciulWQcxSbtGmXqeEnXFxVKDMtgcGSyHgqWh
         YNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=SfoDmkk530wshO3slXTZtiI0F2WjtIKkqUFd0Gpj3l0=;
        b=3InHh0GUhnaSu3G5H8/A1CLTG5EnlNyHuKoFLpc1ZFqfTzPo9/k/k61mgGdb8wfpRS
         3F6pqcaOpWc22ZHJ6X6UselxBgPap5kaN1Kd8QQPSMyhsCytKnVEwdqWk1mq6b6PREvt
         MyI79Vjhtj+Yeqvf/VhxiOaBAysmGkVQy5YxIIK2IJWDmHnrcQRcsuFZqs2zQWBz8tKU
         /uCCsh05ix8oZS+wlwy6pThlh7isPtXwUZcGeCBh490ytw07yJRnFYV9eKnFlrA0TkYO
         jfJKjd6PBwH3jK/UCly5slcKQ0qXZnDCkfSbw6wRoc+k30SmA4ocJ3PsYJGychuJfr1+
         3hMw==
X-Gm-Message-State: AOAM5327KW+FFaeZLceo5G2erA4mtsPYQyMMN9kSOXjfAKh2dnAqIUNL
        59OHDAIfzlCOrrZsUjJyNx+3XQ==
X-Google-Smtp-Source: ABdhPJyGFmnzNC3pTBW2D7XaCwphac5mMo0z2X+wQ7DzCjDKA2ZH9jGplIWSOU9tVq6aTFlgaVJTCw==
X-Received: by 2002:a17:902:cec4:b0:158:5584:7c46 with SMTP id d4-20020a170902cec400b0015855847c46mr18784795plg.80.1649886088253;
        Wed, 13 Apr 2022 14:41:28 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id j13-20020a17090a840d00b001ca89db9e6esm24311pjn.19.2022.04.13.14.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 14:41:27 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH V2 13/15] cpufreq: mediatek: Link CCI device to CPU
In-Reply-To: <98957e61b040b6c5b6a6b39e6eb661e07e510277.camel@mediatek.com>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
 <20220408045908.21671-14-rex-bc.chen@mediatek.com>
 <7hfsmn5m9f.fsf@baylibre.com>
 <bc6dd020a1cc3f00f5be2bf2929046b9116bbeef.camel@mediatek.com>
 <7hwnfv4hfr.fsf@baylibre.com>
 <f00e3df2e270e5edc160f8ff1bd8c52a49bf71d5.camel@mediatek.com>
 <7h5yne3zlx.fsf@baylibre.com>
 <98957e61b040b6c5b6a6b39e6eb661e07e510277.camel@mediatek.com>
Date:   Wed, 13 Apr 2022 14:41:27 -0700
Message-ID: <7hlew83blk.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rex-BC Chen <rex-bc.chen@mediatek.com> writes:

[...]

> From the Chanwoo's devfreq passive govonor series, it's impossible to
> let cci devreq probed done before cpufreq because the passive govonor
> will search for cpufreq node and use it.
>
> Ref: function: cpufreq_passive_register_notifier()
>
> https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-testing&id=b670978ddc43eb0c60735c3af6e4a370603ab673

Well this is a problem, because CCI depends on CPUfreq, but CPUfreq
depends on CCI, so one of them has to load and then wait for the other.

> After I discuss with Angelo and Jia-wei, we think we are keeping the
> function in target_index and if the cci is not ready we will use the
> voltage which is set by bootloader to prevent high freqeuncy low
> voltage crash. And then we can keep seting the target frequency.
>
 > We assume the setting of bootloader is correct and we can do this.

I'm still not crazy about this because you're lying to the CPUfreq
framework.  It's requesting one OPP, but you're not setting that, you're
just keeping the bootloader frequency.

In my earlier reply, I gave two other options for handling this.

1) set a (temporary) constraint on the voltage regulator so that it
cannot change.

or more clean, IMO:

2) set a CPUfreq policy that restricts available OPPs to ones that will
not break CCI.

Either of these solutions allow you to load the CPUfreq driver early,
and then wait for the CCI driver to be ready before removing the
restrictions.

> For the SoCs that including ci hardware (8183 and 8186), we think it's
> not ok if we don't probe cci correctly.
> If we failed to get cci node, I think we sould return -ENODEV and the
> probe of cpufreq failed.
>
> What do you think the solution?

I think it would be better if CPUfreq probes sucessfully, but restricts
the OPPs available until CCI is ready.  If CCI fails to probe/load, you
still have a working CPUfreq driver, it just has a restricted set of
OPPs.

Kevin
