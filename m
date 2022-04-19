Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66D250790F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357111AbiDSSag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357587AbiDSSXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:23:32 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4F94477E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:16:37 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id md20-20020a17090b23d400b001cb70ef790dso2610011pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=AjgDpPskVV4R4Ry4hrbWpc/9hMmAwQ0eTwMouf2MnOU=;
        b=bMihXYjxDYd70FBAdkcUWSX+XlWzIAfBgJnYw0igXRFV+04YT4oMj+OjOTM2ojX4W9
         GYMwFCZU1Xdt5BZHTbv+NmWWboVjFsrVaTtRXcXquMXtE2er7IqkVjMBBOBs6ZFROx1K
         cN5J3DB05qfDIzqnwP5O1+1DPUaGJQV6AyBLoyiOLvRbNcSQS3QiiYDnqLdgWGiDUCUS
         W5r14jEvv37KT53Roabxlk4ixJo7v1FMya2s0VY9D1HEtwlz3DsNCHsPx7u9jekYBzVs
         hZwkblG+Dl9GnFGir7Sr1y2O6tI5+nKUgBTdUrkm20VgY0lwgfwLyq59kXH5GSoVK05+
         ItnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=AjgDpPskVV4R4Ry4hrbWpc/9hMmAwQ0eTwMouf2MnOU=;
        b=XH5ctznB+fEbwDOTr5KLF4QlFyTbCc2SvLE2i+n+xP/d5UHtygXcHaDcEk1v7xdZDw
         +Y3Baoyi7cZJ7xBaVvDGTnq14mtX5SAIlGfNXLf4rGrFPWQFM1jEmW9YNuUJP+DcE3CB
         DWPypSFAK2GRMvnEGwUdCkD1Bg8izqF6iRV0WJPiapc8CR8l4VV1L5OjvSZQ9G65DZFr
         Oq3cEApE283ytBfOMSZsNteKAUIRFyH0Yto3BoaHU+RqkNx/WYuNq48pdYQ9EmBWVc4m
         N4tLFUJSY7mu7/+SWIbYsgUJiCrQS+XeEtzw3dQvzWwv5rBogjsTb37ivUNKFpmLzA05
         3Djg==
X-Gm-Message-State: AOAM532MnlHFIj4X7tTrti+ztEx6lFNZagt1Dn0fxmhIMiqQthUrwnYG
        Rxffhy7lSHwWUbHfcwcL9zjaVZRN3dNqVo3e
X-Google-Smtp-Source: ABdhPJzob3GzCfSoCXKRmPqceM7UO6pOMBdQF/W+KIIoJ8hpD8bUMg3PD/l5kz2paua0Q592Ix7PwA==
X-Received: by 2002:a17:902:bb94:b0:157:2ce:fac1 with SMTP id m20-20020a170902bb9400b0015702cefac1mr16955546pls.25.1650392196359;
        Tue, 19 Apr 2022 11:16:36 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id g12-20020a056a001a0c00b004e1307b249csm18036219pfv.69.2022.04.19.11.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:16:35 -0700 (PDT)
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
In-Reply-To: <3fc36d6b803ff3e1bef601839aaca3f4f03e62ad.camel@mediatek.com>
References: <7hbkx3fiac.fsf@baylibre.com>
 <3fc36d6b803ff3e1bef601839aaca3f4f03e62ad.camel@mediatek.com>
Date:   Tue, 19 Apr 2022 11:16:35 -0700
Message-ID: <7hwnfldjlo.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rex-BC Chen <rex-bc.chen@mediatek.com> writes:

> On Thu, 2022-04-14 at 14:48 -0700, Kevin Hilman wrote:

[...]

>> 
>> You explained this well, but it's still not an appropriate solution
>> IMO,
>> because you're still not setting the target that is requested by the
>> CPUfreq core.
>> 
>> The job of ->set_target() is to set the frequency *requested by
>> CPUfreq
>> core*.  If you cannot do that, you should return failure.  What you
>> posted
>> in the original patch and what you're proposing here is to ignore the
>> frequency passed to ->set_target() and do something else.  In the
>> orignal patch, you propose do to nothing.  Now, you're ignoring the 
>> target passed in and setting something else.  In both cases, the
>> CPUfreq
>> core things you have successfuly set the frequency requested, but you
>> have not.  This means there's a mismatch between what the CPUfreq
>> core &
>> governer things the frequency is and what is actually set.  *This* is
>> the part that I think is wrong.
>> 
>> Instead, the proper way of restricting available frequencies is to
>> use
>> governors or policies.  This ensures that the core & governors are
>> aligned with what the platform driver actually does.
>> 
>> As I proposed earlier, I think a clean solution to this problem is to
>> create a temporary policy at probe time that restricts the available
>> OPPs based on what the current CCI freq/voltage are.  Once CCI driver
>> is
>> loaded and working, this policy can be removed.
>> 
>> Kevin
>> 
>> 
>
> Hello Kevin,
>
> In new proposal, we DO set the cpufreq passed by cpufreq core.
> We just not set the corresponding voltage of target frequency which
> is lookedup from opp table.

OK, this makes more sense.  I thought you were ignoring frequency change
also.

[...]

> In summary, we think it's a proper solution to cover the situation
> when cci is not probed.

Yes, this is OK with me.

> I think there is something to improve:
> We can choose to lookup cci opp table using cci freq to determine
> the voltage instead of voltage_on_boot.
> But IMO, it's not neccessary to register cci opp table inside cpufreq
> driver just for the short period.

I agree.

> Because I finish to prepare other patches and I think we also can
> take a look at other patches which are including some cleanup, I will
> send next version today.
> If there is any concern and question, we can discuss in next version.

OK, I'll have a closer look at the new version.

Kevin

