Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9097D485BD7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245173AbiAEWus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245153AbiAEWul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:50:41 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9308C0611FD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 14:50:40 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id k27so1217248ljc.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 14:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uln6zKD/HQzKjt4Ma4cxepIDn7duhLxDVJK94jYG4fw=;
        b=kVpuGsrBz+dk+CTGSHwdK8fIAFithCbvq1m3fZy7g17wo1ss4nBYEyGDnDreLwXe55
         ffodiK26HGtWGRnxTs6PfpAoTSa4cUgHllGmCfjMHT7JbApcibuU/wk5WHiUydVeZ9sf
         RvgZTVoraC3K77beq05LaQUFQAiHlrAEnnR+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uln6zKD/HQzKjt4Ma4cxepIDn7duhLxDVJK94jYG4fw=;
        b=sxueK6rUbCeLIRbivTZcZODClpy0r2asmtYM5BWkHzelwtmRohX3zqBLt6FZNTtqgU
         jImTK5EnteqPom9FaPoMW+2qGEVz0aq0IKYvGoll2KTOdPPoXUKCpALvlAX+Ys8stPaI
         eJm22bsT2/ZnzgK6R33GflCVXmEAmel0JqrcNSCITRmkAx6iEvz5nCRJVRkN7rZZBgjC
         xYv3WyMjfyaRZVC+wOzWRRdiKkBrKqZzRIF421o1Hq52BKI/xuBMUFJYFGVrHXqvxNKO
         80USEa1GIsHgq7F9y+rQGLjr5syP+0TMZpo+Jw+hEWf317lqTS3D4eisgeItyioBFfJC
         jlyA==
X-Gm-Message-State: AOAM530P/UztS7wsOrM1Yyw91bgV4sR1vspA/boDWiBLQZQTZhck+Bis
        toFIjGWV2o+/0Y07k753Qja3cCrnCvcg1w==
X-Google-Smtp-Source: ABdhPJwF69uXPiSl2NZSaXdW0vVuyC3lk8sW9rgysYSPhaNII6nHDDfvqEs6p/gFVwPCRYrQbySa5Q==
X-Received: by 2002:a2e:575d:: with SMTP id r29mr45768204ljd.39.1641423038668;
        Wed, 05 Jan 2022 14:50:38 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id t7sm16889lji.43.2022.01.05.14.50.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 14:50:36 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id by39so1236628ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 14:50:35 -0800 (PST)
X-Received: by 2002:a2e:3007:: with SMTP id w7mr36858879ljw.429.1641423035463;
 Wed, 05 Jan 2022 14:50:35 -0800 (PST)
MIME-Version: 1.0
References: <20220105220653.122451-1-gwendal@chromium.org>
In-Reply-To: <20220105220653.122451-1-gwendal@chromium.org>
From:   Dmitry Torokhov <dtor@chromium.org>
Date:   Wed, 5 Jan 2022 14:50:19 -0800
X-Gmail-Original-Message-ID: <CAE_wzQ_DTnrU9QbADZuNyt4fszAiTwa04D9muC-xE_S3MM9eGQ@mail.gmail.com>
Message-ID: <CAE_wzQ_DTnrU9QbADZuNyt4fszAiTwa04D9muC-xE_S3MM9eGQ@mail.gmail.com>
Subject: Re: [PATCH 00/17] Add export symbol namespace PL_CHROMEOS
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     bleung@chromium.org, groeck@chromium.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, benjamin.tissoires@redhat.com,
        jic23@kernel.org, hverkuil-cisco@xs4all.nl, mchehab@kernel.org,
        lee.jones@linaro.org, pmalani@chromium.org, sre@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lgirdwood@gmail.com, a.zummo@towertech.it, cychiang@chromium.org,
        perex@perex.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gwendal,

On Wed, Jan 5, 2022 at 2:07 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Add a symbol namespace for functions exported by the plaform chromeos
> subsystem.

It would be great to explain why this is needed/desirable. What are
the benefits of introducing this namespace? What problem are you
trying to solve?

> Add depenencies for all drivers using these function.
>
> 'make nsdeps' is used to fix the dependencies.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>
> Gwendal Grignou (17):
>   plaform: chrome: Add PL_CHROMEOS export symbol namespace
>   iio:cros_ec_sensors: Add PL_CHROMEOS dependency

I wonder if ordering patches this way breaks compilation (patches
should be structured in such a way that one need not apply entire
series to get to buildable kernel). Isn't putting symbols into new
namespace makes them unavailable to modules unless they explicitly
import it?

Thanks.

-- 
Dmitry
