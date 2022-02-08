Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3E34ACDC8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345530AbiBHBLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344253AbiBHAu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:50:27 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E56C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 16:50:25 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id x65so1477930pfx.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 16:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P4dVbEFdi/JUsP7B7tBGXHD+ETv7S+cY00xBr/7Gj+s=;
        b=kcpKAm4jzm1OsPMjGPrgkbvJS/LbWlj2YvFZdqf3Okn+ptsEFxEPILhJ07fEaQkCCS
         fxKQWER27n8E8CWkUIbx2aQ6znFoabJ/UgYrpQI0jgKeRF+9vG+j9s42cFGBK1Br/g0t
         qGS/Ay3ZMQcH6ko2T/B3L9IaD3Q8qDzeltD0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P4dVbEFdi/JUsP7B7tBGXHD+ETv7S+cY00xBr/7Gj+s=;
        b=21ap8ZmKChzKVq3udf7RytVnRplXXq/f0bNUo3nQewONAL+8TfZ9qs6Ub2g7jmPQc9
         lbiui1j+cMnUtoJKO5gHJFg7Kp3HcYa7Ml8l+BQa/2HL0UGIcVtvA1mTOV7xzFeVZMJV
         S+/SkWUmeqqCuyVXyJRVxMxgtaa2xbqGVRhUgxVWP7iRfrPV3Mmjx57kHgLCBKxiG9K2
         ZKHcR7WVZeE19VS+U6EHF8l7Tri4bIINVXgDEnUxZtDzz4lubbK0SP4bpHEZfW/krCH1
         LulyRBngznI9tBsd8TXKVmzHaPcjp4LZ5/uqNObchIW4+V0ByChF2nW8zGF7c8zjHoqR
         +yWg==
X-Gm-Message-State: AOAM533ZuYpnHKJkXzuWWFRVd83Mgt/UFNQ3JM0r/Od9dhiu1B4lqOFK
        v3Yaj7UU9q3fMTyPgOyNhBNLSA==
X-Google-Smtp-Source: ABdhPJyOItaFwB1a6V9pdWDOozh78FaEp+dooWqUDO7ZAS63J5y1+pQX1elO5BGpl/iyCEDyedzaaw==
X-Received: by 2002:a05:6a00:1486:: with SMTP id v6mr1932729pfu.73.1644281424964;
        Mon, 07 Feb 2022 16:50:24 -0800 (PST)
Received: from localhost ([2620:15c:202:201:45cc:a522:8718:fc78])
        by smtp.gmail.com with UTF8SMTPSA id nv13sm515627pjb.18.2022.02.07.16.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 16:50:24 -0800 (PST)
Date:   Mon, 7 Feb 2022 16:50:22 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, dietmar.eggemann@arm.com,
        Pierre.Gondois@arm.com, Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 1/2] thermal: cooling: Check Energy Model type in
 cpufreq_cooling and devfreq_cooling
Message-ID: <YgG+TmLrCSXX4Bvt@google.com>
References: <20220207073036.14901-1-lukasz.luba@arm.com>
 <20220207073036.14901-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220207073036.14901-2-lukasz.luba@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 07:30:35AM +0000, Lukasz Luba wrote:
> The Energy Model supports power values either in Watts or in some abstract
> scale. When the 2nd option is in use, the thermal governor IPA should not
> be allowed to operate, since the relation between cooling devices is not
> properly defined. Thus, it might be possible that big GPU has lower power
> values in abstract scale than a Little CPU. To mitigate a misbehaviour
> of the thermal control algorithm, simply not register a cooling device
> capable of working with IPA.

Ugh, this would break thermal throttling for existing devices that are
currently supported in the upstream kernel.

Wasn't the conclusion that it is the responsability of the device tree
owners to ensure that cooling devices with different scales aren't used
in the same thermal zone?

That's also what's currently specified in the power allocator
documentation:

  Another important thing is the consistent scale of the power values
  provided by the cooling devices. All of the cooling devices in a single
  thermal zone should have power values reported either in milli-Watts
  or scaled to the same 'abstract scale'.

Which was actually added by yourself:

commit 5a64f775691647c242aa40d34f3512e7b179a921
Author: Lukasz Luba <lukasz.luba@arm.com>
Date:   Tue Nov 3 09:05:58 2020 +0000

    PM: EM: Clarify abstract scale usage for power values in Energy Model

    The Energy Model (EM) can store power values in milli-Watts or in abstract
    scale. This might cause issues in the subsystems which use the EM for
        estimating the device power, such as:

     - mixing of different scales in a subsystem which uses multiple
            (cooling) devices (e.g. thermal Intelligent Power Allocation (IPA))

     - assuming that energy [milli-Joules] can be derived from the EM power
            values which might not be possible since the power scale doesn't have
	           to be in milli-Watts

    To avoid misconfiguration add the requisite documentation to the EM and
        related subsystems: EAS and IPA.

    Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


It's ugly to have the abstract scales in the first place, but that's
unfortunately what we currently have for at least some cooling devices.

IMO it would be preferable to stick to catching incompliant configurations
in reviews, rather than breaking thermal throttling for existing devices
with configurations that comply with the current documentation.
