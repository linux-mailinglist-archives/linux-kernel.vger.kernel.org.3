Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F64C470665
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244043AbhLJQzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244062AbhLJQzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:55:39 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81AEC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 08:52:03 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d9so15964700wrw.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 08:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=6jkSpMJfNd9r7LQT0uy72Yz4mfeYDUDC0fjOscd0N1k=;
        b=iGOgj1fbQ/drGb+TwOyMPQ6UCT2JquvNvFSm0fvlxxFEsy3Zokh9fkkH0QsCqGFUkE
         WUe3IwkI65wAvckFw/q46KHc/inTzRct5e/Xpdq3V4s4jG2DKAyIQlmuV+iBu7bGAbCZ
         PoBsGd386keBNCL0HDCA4AJTofGVB8hCfRg0LZz9PlEoSl7V9bh8VZohI0Lkm4Uc0J2/
         23wnEKsVK39s0SZg8sv9aD3r/TgDZ/Pi9Gx27GSTQXnLLBHbhG388vl++Z7jBrxXxcLx
         SyhIXc28XolaOKfgW51tyOGyOWrrOtZBZpeButdqrviOPYvsBaXK9bpbtFoPl1Nwx5OG
         Aiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=6jkSpMJfNd9r7LQT0uy72Yz4mfeYDUDC0fjOscd0N1k=;
        b=nwK/Jrn2DtvvijOwluqPLj2W3lOsJO8K3USHtgoZAqRThO4nX/nMlvNgz62pk1jFv6
         7GTMV6bV9VEXfS+MBUE9ynzuL2SV3aNYhODxImY5ZlsEQeVXUPuBa5Yz127vP5tnabIJ
         8Vq0IRzWpkN5bjypYCBzCbKPSxEJd8Pt3NAEzmdD4xG2IbfPVhPsUrDlesCnBWNPX24x
         U5DXNbuWuQakMoybTUAr9r9ofQCq4q3lZXxBxr8uesWWlLGO37vgmXDqFHV1XtRafhkf
         U5NKwQtkAz5Te23ya0CRgO/gT12tJBk+GWpTjKC1AmR91XrZF2nTfFNi3chROvTOtmOm
         IQ9g==
X-Gm-Message-State: AOAM531BwNoZVbvJHT83hUPsc0AzNXZPypH7C9a3lQgkEHKRrtVxWmAc
        zm7B0wIKdUqUQV1h7+TDTqv/zA==
X-Google-Smtp-Source: ABdhPJzl/J6fZ3lGBbjTsxxHPp8t6CqEj8H0Um6sUnxvtWI6peWaKYJiK1uGvPBnhLLDWP5PyUxwLA==
X-Received: by 2002:a5d:6d88:: with SMTP id l8mr15155530wrs.270.1639155122163;
        Fri, 10 Dec 2021 08:52:02 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:82f4:6d90:a1e5:21c9? ([2a01:e34:ed2f:f020:82f4:6d90:a1e5:21c9])
        by smtp.googlemail.com with ESMTPSA id p5sm3316650wrd.13.2021.12.10.08.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 08:52:01 -0800 (PST)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marc Zyngier <Marc.Zyngier@arm.com>,
        Alexey Sheplyakov <asheplyakov@basealt.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        "Vadim V . Vlasov" <vadim.vlasov@elpitech.ru>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers fixes for v5.16-rc5
Message-ID: <429b796d-9395-4ca8-81f3-30911f80a9a9@linaro.org>
Date:   Fri, 10 Dec 2021 17:51:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

The following changes since commit 53e87e3cdc155f20c3417b689df8d2ac88d79576:

  timers/nohz: Last resort update jiffies on nohz_full IRQ entry
(2021-12-02 15:07:22 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux.git
tags/timers-v5.16-rc4

for you to fetch changes up to 1edb7e74a7d3d64dc4e69e7059b4eea526d19a10:

  clocksource/drivers/arm_arch_timer: Force inlining of
erratum_set_next_event_generic() (2021-12-10 17:47:00 +0100)

----------------------------------------------------------------
- Fix build error with clang and some kernel configuration on the
  arm64 architected timer by inlining the
  erratum_set_next_event_generic() function (Marc Zyngier)

- Fix probe error on the dw_apb_timer_of driver by fixing the
  incorrect condition previously introduced (Alexey Sheplyakov)

----------------------------------------------------------------
Alexey Sheplyakov (1):
      clocksource/drivers/dw_apb_timer_of: Fix probe failure

Marc Zyngier (1):
      clocksource/drivers/arm_arch_timer: Force inlining of
erratum_set_next_event_generic()

 drivers/clocksource/arm_arch_timer.c  | 9 +++++++--
 drivers/clocksource/dw_apb_timer_of.c | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
