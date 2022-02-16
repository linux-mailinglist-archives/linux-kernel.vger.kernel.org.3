Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A9B4B8F0F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 18:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbiBPRVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 12:21:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237059AbiBPRVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:21:48 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45DF220D0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 09:21:34 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id y20so529057iod.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 09:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jieIWT6FT4bLoUaa3Mb3Usj/bynv3zx0Z4wW8RvTfsk=;
        b=O+gPJszUY4gMydUN6T17bxf9YrJsSN2JGPvPYspIkDcDT6xa/cBHSZoZM3DleEqYoO
         SU5sA/uVXJze9UFXNyyOYK78aO8P5OzXOpxkQa8+jZXwy3JmFa9GytjwiKAIlnZ4dRBF
         pwiPmlf/pazGRyp9nnaB7FUPUgMl97ZRLkyYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jieIWT6FT4bLoUaa3Mb3Usj/bynv3zx0Z4wW8RvTfsk=;
        b=mfT6TZ7rlpF9HmxLSAqHjzGBXJShYgpViHgKe963ncKL5+ivpkTlWIsKJg4yolElFp
         +bk1RYFNTUVgnGwVtwEEZAxxkQ42y4N+gIsuzz0Dybf7Ha9TcNnMcCtPgXUcPV4jjdAN
         uBAMU0VLp65N0ADxpa3IHOBAxQdSmHT+GmzWqOEek8fFUJEPAMViwMCUync7QB9wtmd2
         o1YIYFjrOjWWX0e/RN3h8mZNSXQHb5bX8iGDmwCB8VZD5jBh9SmiacPuUGerUKoDW3uc
         dmNwZFS7o9bYOWa46SS7yhsj5iHNMlu8HW63bwr+3Bktb8OjhKWzQKVwuLyEBQ86yuBZ
         4Wkw==
X-Gm-Message-State: AOAM533Ot02UPajpQki+O2/ef/RcZjFfbGlMJBGNBtosfmC5svcH0/+J
        Mzlt4sne3qx/Sc8//VLqKK3peawJh7G3cA==
X-Google-Smtp-Source: ABdhPJxu6G8hmYaiOejn93TG3bQowu0OOUEyrVO02BsYPuo6pUqzVv/JniGzvnERygRMDEMz+NtB2A==
X-Received: by 2002:a05:6602:1547:b0:632:dd44:87cc with SMTP id h7-20020a056602154700b00632dd4487ccmr2591271iow.186.1645032093973;
        Wed, 16 Feb 2022 09:21:33 -0800 (PST)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com. [209.85.166.51])
        by smtp.gmail.com with ESMTPSA id s10sm168104ild.84.2022.02.16.09.21.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 09:21:32 -0800 (PST)
Received: by mail-io1-f51.google.com with SMTP id q8so524624iod.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 09:21:32 -0800 (PST)
X-Received: by 2002:a05:6638:25cf:b0:314:5652:b95d with SMTP id
 u15-20020a05663825cf00b003145652b95dmr2344965jat.207.1645032091709; Wed, 16
 Feb 2022 09:21:31 -0800 (PST)
MIME-Version: 1.0
References: <20220207073036.14901-1-lukasz.luba@arm.com> <20220207073036.14901-2-lukasz.luba@arm.com>
 <YgG+TmLrCSXX4Bvt@google.com> <4a7d4e94-1461-5bac-5798-29998af9793a@arm.com>
In-Reply-To: <4a7d4e94-1461-5bac-5798-29998af9793a@arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 16 Feb 2022 09:21:19 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UtQgrwPXg4zTZtBin3LWY1yTgCKQ05MmCNqK_6F5S8VA@mail.gmail.com>
Message-ID: <CAD=FV=UtQgrwPXg4zTZtBin3LWY1yTgCKQ05MmCNqK_6F5S8VA@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: cooling: Check Energy Model type in
 cpufreq_cooling and devfreq_cooling
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        amit daniel kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pierre.Gondois@arm.com, Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 8, 2022 at 1:32 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> >    Another important thing is the consistent scale of the power values
> >    provided by the cooling devices. All of the cooling devices in a single
> >    thermal zone should have power values reported either in milli-Watts
> >    or scaled to the same 'abstract scale'.
>
> This can change. We have removed the userspace governor from kernel
> recently. The trend is to implement thermal policy in FW. Dealing with
> some intermediate configurations are causing complicated design, support
> of the algorithm logic is also more complex.

One thing that didn't get addressed is the whole "The trend is to
implement thermal policy in FW". I'm not sure I can get on board with
that trend. IMO "moving to FW" isn't a super great trend. FW is harder
to update than kernel and trying to keep it in sync with the kernel
isn't wonderful. Unless something _has_ to be in FW I personally
prefer it to be in the kernel.

...although now that I re-read this, I'm not sure which firmware you
might be talking about. Is this the AP firmware, or some companion
chip / coprocessor? Even so, I'd still rather see things done in the
kernel when possible...

-Doug
