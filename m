Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050704A433D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 12:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377566AbiAaLS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 06:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377569AbiAaLKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:10:12 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43410C061757
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 03:09:30 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id k17so39205707ybk.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 03:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AlZH+tDYLmF3Zzrk3imgIWNOsXQVmniQWCFRf+PIgeM=;
        b=jEFfnaCKWNR3SNY3xucQ07Pa9aApMh/R25SgjXNpurSnsC4mxVp4CpMsYdrBTWBkaD
         wlmTYCCDBYlp+7UAVZ8qKZOy3obMT5TzjBU3wyShfZfXtMEZdBfHDRXRxYv0GUgbkLUY
         h2o72aBH7Y60v0Txm0KFgrgHLpLiRvwOK0mIXeoosTikjjCP5b/8j49Ls3D+43WBmTCG
         ghgea+oiGYiXYvn24Ojs4/1UJibWyrgr68IJgSDosb4Hk6LG7pZvonwZv2hn6DjolZ0P
         /R/fWGp0LHR4R7xOzQlyYCVkydVOSHnNqy+LFOLU+tR8Fm+v8/zbI/rfxajvr/qBNAdP
         N/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AlZH+tDYLmF3Zzrk3imgIWNOsXQVmniQWCFRf+PIgeM=;
        b=7G2O8z4accq7CJKi5f0vQkrNrMHAv18IYHyKUfCIX5st8CZf0tdHbAZdHaRbTIKOfR
         u1zl58ln38bFSLLG3lz2+GiE6gDJK6ARSjpQsEWElceqqqvl0AbnwJdEh1l05IJQGn0P
         A9hv/v6togBw3yumvA4z9TbqYfG27Eb1Zh67rTiZ01xhN7aNAzO2vY+8iZdnQanKZbso
         6D+N57444/ZgUt7iE5Y9rzYAilnfp+012d4/mk3JxXch8UZ2oH2F3sgKcGrm0uFHIT4o
         3Ul6vmhHNkmY0O+9LFCPoUWHl6keusQgcxLdixwldlrZlHoOJgvLWHz47sJu5+p7Zuul
         oQNQ==
X-Gm-Message-State: AOAM530xJSOiUz9qg3OKUhw+FB3r1HMtQP+X67ORJtiKTBmglO3pXXXZ
        bApzLrfNGKuVqSK8sEtLTPh4pGuArYDoL/mCUx5DfA==
X-Google-Smtp-Source: ABdhPJxwl5kAKtfrO02F1W5bcEFmhrWdTklWGteiWHcX9Rg5J/4UmKrYw6TZuMEvz4WSj/2Gk9hSILJrEgLFS68S+bA=
X-Received: by 2002:a05:6902:124a:: with SMTP id t10mr26381408ybu.634.1643627369543;
 Mon, 31 Jan 2022 03:09:29 -0800 (PST)
MIME-Version: 1.0
References: <20220131085201.307031-1-horatiu.vultur@microchip.com>
In-Reply-To: <20220131085201.307031-1-horatiu.vultur@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 31 Jan 2022 12:09:17 +0100
Message-ID: <CACRpkdZgzd7_h9qnKeq2c4ERPzeOk0YdkQho5=4GcvY_zSvWjA@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: microchip-sgpio: Fix support for regmap
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
        UNGLinuxDriver@microchip.com, colin.foster@in-advantage.com,
        andy.shevchenko@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 9:50 AM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:

> Initially the driver accessed the registers using u32 __iomem but then
> in the blamed commit it changed it to use regmap. The problem is that now
> the offset of the registers is not calculated anymore at word offset but
> at byte offset. Therefore make sure to multiply the offset with word size.
>
> Acked-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> Reviewed-by: Colin Foster <colin.foster@in-advantage.com>
> Fixes: 2afbbab45c261a ("pinctrl: microchip-sgpio: update to support regmap")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Patch applied for fixes.

I didn't get last weeks fixes to Torvalds this weekend because linux-next
wasn't being compiled, will send the lot with this on top this week.

Yours,
Linus Walleij
