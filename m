Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44354E5AB9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 22:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344956AbiCWVfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 17:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240867AbiCWVfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 17:35:00 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6CC26AEC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 14:33:29 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id p17so2813261plo.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 14:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:date:message-id:mime-version;
        bh=2LhMk9zJI14VlAHepOXbNN8GLBArCKtkLBl/JZencgQ=;
        b=NQREswWAuJqXlrTwtsO9W0l5FL1ZGF9oNGaqoVnzvn7QYtZJLsrRRxLVJyewSPbhLl
         Vd2dx5/5lPVgOrMzSekExBniLmwbqDIldBU5dJHwI7PJBlw6K7QvKjy7ekckiPZqDaIv
         edrg9/mJCTjdULdwcA/jj1topOuPK4AEo2TsJ71o0y7R5hZSDSNZ+d/eXkq4geieI4w0
         ZH386zhFMVuB+L0Q7pb7z28eUC4subqepAamKhN/sVYolu905s2O7+6EEKKj43X+heAO
         Mevi1ryPZl2KLilEG9+76+huEUmhyXzU6LMB3sUXRtwL8CeIBUr/6mWjbNGP/Taq9aUu
         M2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=2LhMk9zJI14VlAHepOXbNN8GLBArCKtkLBl/JZencgQ=;
        b=Penh6MQtEZ7dG0jPGywHqhy5iQ5B632zJLAiqIKMhf7+R7vHjLdHQQl5Ndw4imNian
         2UiqOnNnwSbrilL1LSG1dzIbOgAHmbbKdj5GO1n86PSVP6ubnjRgCSpGFpyhk96jhT/K
         xRHUxRlRFed3MY9JCx15klUZivnflTGX5lwQDkMjC9Ts2t6/CBSobdWWjZ0lyVkZXn2Z
         MLmUt+x43QPaJ+pRyif6hxSDLfFRyvsITvfbJ44AZUtYE5lebVlR2X9lhdTMCgTa/quy
         WIM8iYHdZHyLZRwKwrjLjlr6mxItJtthadDY5T4i4HiDmPNMj/RDXplRZjQSJa0YFmbQ
         Qe6A==
X-Gm-Message-State: AOAM530O7wuqkZNjtl5Jfj3aB/xH9YorYUbr4h+1OmY2UJpQU0JPGQEB
        cA3ydqaTkLl3T5jZD+wZldrX4A==
X-Google-Smtp-Source: ABdhPJxCPBAivJPBjtl5b1if01CCcldTJ4n2shqfNkjDe8ptep3xT6vuvGG/4TxR2sr99SptDot3Xw==
X-Received: by 2002:a17:902:a3cb:b0:151:e52e:fa0c with SMTP id q11-20020a170902a3cb00b00151e52efa0cmr2200676plb.70.1648071208748;
        Wed, 23 Mar 2022 14:33:28 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id w24-20020a639358000000b00385fcbf8e55sm653826pgm.28.2022.03.23.14.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 14:33:28 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Eduardo Valentin <eduval@amazon.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, rui.zhang@intel.com, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, mka@chromium.org
Subject: Re: [PATCH 0/2] thermal: Add support of multiple sensors
In-Reply-To: <20220225235203.GH10536@uf8f119305bce5e.ant.amazon.com>
Date:   Wed, 23 Mar 2022 14:33:27 -0700
Message-ID: <7hlex0s6ag.fsf@baylibre.com>
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

Hi Eduardo, Daniel,

Eduardo Valentin <eduval@amazon.com> writes:

> On Fri, Feb 18, 2022 at 09:46:02AM +0100, Alexandre Bailon wrote:
>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>> 
>> 
>> 
>> Following this comment [1], this updates thermal_of to support multiple
>> sensors.
>> 
>> This has some limitations:
>> - A sensor must have its own termal zone, even if it is also registered
>>   inside a thermal zone supporting multiple sensors.
>> - Some callbacks (such as of_thermal_set_trips) have been updated to support
>>   multiple sensors but I don't know if this really make sense.
>> - of_thermal_get_trend have not been updated to support multiple sensors.
>>   This would probably make sense to support it but I am not sure how to do it,
>>   especially for the average.
>
> Great to see this having somewhat a form now!
>
> Overall the idea is sane and aligned to what I had in mind back during the 2019 Linux plumbers: one thermal zone should have multiple sensor inputs.
> https://lpc.events/event/4/page/34-accepted-microconferences#PMSummary
>
> In fact, that is aligned to what I originally wrote in the thermal device tree bindings:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/thermal/thermal-zones.yaml#n79
>
> The only major concern with your series is the usage of of-thermal to achieve the multiple sensors per thermal zone.
> While that solves the problem, it has the following limitations:
> (1) limited to devices described in device tree. everybody else is left out.
> (2) it keeps extending the code duplication in of-thermal. 
>
> My suggestion here is have the thermal core aware of the multiple sensors per thermal zone.
>
> That has the advantage of:
> (a) cleanup the sensor handling within of-thermal
> (b) expand the multi sensor per zone to all types of thermal drivers
> (c) standardize the way to handle the multi sensor.

This cleanup all sounds like the right direction to be headed, but since
this has been planned since 2019 and nothing has happended, what is the
level of urgency is for this of-thermal -> thermal core cleanup/rework?

In $SUBJECT series, we have a fully functional series that solves an
existing problem and takes a big step in the right long-term direction.
While it indeed has the has limitations you mention, I don't think that
should block the merging of this series.  More importantly, there are
existing drivers[1] as well as forthcoming ones from MTK that depend on
this series. Those are blocked if you require the of-thermal -> core
move first.

As a maintainer also, I fully understand that maintainer bandwith is
limited, and it's always nice to have contributors do core framework
development when possible, but IMO, in this case I don't think it should
be a prerequisite since a follow-up series to do the core work would not
affect any functionality or bindings etc.  I don't see any reasons not
do to this incrementally.

So I would kindly request (read: beg, plead & grovel) that you seriously
consider merging this series as a first phase and the of-thermal -> core
change be done as a second phase.  Yes, I fully understand that punting
this to a second phase means it might not get done soon.  But it's been
waiting for years already, so it seems the urgency is low.  Meanwhile,
there are OF users that are ready to use this feature today.

Thanks for considering,

Kevin

[1] https://lore.kernel.org/linux-mediatek/20210617114707.10618-1-ben.tseng@mediatek.com/
