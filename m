Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF6F4A6425
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242022AbiBASnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236825AbiBASnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:43:17 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB494C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 10:43:17 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id c3so16112429pls.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 10:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=6fPJFl5vrGTy5wN+6iyLxqMIH5fB+nup+utSNi7xCFI=;
        b=JFoC8kCvrk6PVaxIzJ3yNULiqngFgKPktXk6Uy8wQFysm1RKVZ1yng4MaoFknXvCl5
         w50qhHlMbRZ8qg5eKV6q+aY5S+AexzLC726J3dITlnzwKwKhUY767Yiyu26rk+dQR4El
         iZvrQ5OXzLrsR3koSAnpyPb59rfDdrSWlYmb60GBs2NxZFkpnfsPJzTJ8DtB93E6/SBN
         QkNs0I0nrAyVRUHmTRYTQzBWuI3eXJm22L+kdU283/sdSJsaqA8Df8BqbkfppInv6RoC
         uAXJAXYBK/e8ighPrDnAm3bCLsXg0Bcl5Wd5q2oUbLpOXMUV0ZRNnJukZqWzHkdHX9cL
         4FCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=6fPJFl5vrGTy5wN+6iyLxqMIH5fB+nup+utSNi7xCFI=;
        b=qWHqvxSfp0TGy8ZWFQfPb9/z2dCHzne/fbprM/Ph5oLut2mYE7jl4VMYF4KyeHNBc+
         V9cVcbIn2ifRpZptqPka0OefOMHhYpLcepBRPPTy4rhQF2PVlLIuldow9Rjt0DVJY91V
         JCYlv/h9x/ZwNBW7czDbeS06KTDuBIpc0a7tcsXN6Ud9TAASi6TVaNKeArOdkfC5kLmN
         WORufC8qh8QW5taBWFLKFggB0trt94Hxr8VYGPL3gtUTnEd6Y82NqLUzEBfM/aVl0oFe
         Zol3Po1nQj0pTrwDewJz4ms6Bi6/9rxYXNyThtpGdOSP26WPjq2Qj25/BwpuXOFdu7rI
         mDmQ==
X-Gm-Message-State: AOAM5315u3VQTdrbb1dI0PrwgHTqdmAzXgkaeC1kqx2jA25V0E0ezlZt
        QSuOyb/7tzKqeVWr64xh2QRhHA==
X-Google-Smtp-Source: ABdhPJyaOJVKaHFfRhEGAmObqlO5/p6vKN4OSc6RYhmsGbTY9lg7Dx448+JitmRXoD1gp5a8X4QMsw==
X-Received: by 2002:a17:902:710c:: with SMTP id a12mr26847513pll.108.1643740997274;
        Tue, 01 Feb 2022 10:43:17 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id s19sm9183477pfu.34.2022.02.01.10.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 10:43:16 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ben.tseng@mediatek.com, Matthias Kaehlcke <mka@chromium.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: [PATCH v4 RESEND 0/2] Add a generic virtual thermal sensor
In-Reply-To: <CAJZ5v0iX=SSaPzZNBX8gNMDPCUewiQA_bHxka2pxvtFHxmPxww@mail.gmail.com>
References: <20220111103346.2660639-1-abailon@baylibre.com>
 <7hilu9xe7n.fsf@baylibre.com>
 <CAJZ5v0gZFBEKDt6S0H91F5xCjC3qtT6B+cTnv6u1nijMHkc8jA@mail.gmail.com>
 <7h35lcygin.fsf@baylibre.com>
 <CAJZ5v0iX=SSaPzZNBX8gNMDPCUewiQA_bHxka2pxvtFHxmPxww@mail.gmail.com>
Date:   Tue, 01 Feb 2022 10:43:16 -0800
Message-ID: <7hbkzqmnqz.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Mon, Jan 24, 2022 at 10:23 PM Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>>
>> > On Mon, Jan 24, 2022 at 5:58 PM Kevin Hilman <khilman@baylibre.com> wrote:
>> >>
>> >> Daniel, Amit,
>> >>
>> >> Alexandre Bailon <abailon@baylibre.com> writes:
>> >>
>> >> > This series add a virtual thermal sensor.
>> >> > It could be used to get a temperature using some thermal sensors.
>> >> > Currently, the supported operations are max, min and avg.
>> >> > The virtual sensor could be easily extended to support others operations.
>> >> >
>> >> > Changes in v2:
>> >> > - Fix some warnings / errors reported by kernel test robot
>> >> > - rename some struct and functions with a more accurate name
>> >> > - update the dt bindings: rename type attribute to aggregation-function
>> >> > - factorize a little bit the aggregation functions
>> >> > Changes in v3:
>> >> > - Aggregate thermal zone instead of thermal sensors
>> >> > - Use try_get_module / put_module to prevent thermal providers to be removed
>> >> > - Update the bindings, to be more accurate
>> >> > Changes in v4:
>> >> > - Fix two warnings reported by kernel test robot
>> >>
>> >> Any more feedback on this series?
>> >
>> > Hopefully, I'll get to it this week and I'll let you know.
>>
>> Thanks Rafael,
>
> Done, please see
> https://lore.kernel.org/linux-pm/CAJZ5v0jejFG76OfewYg3kmKv4xwLdRBpC+zRpJ9Jom+tqo7qyg@mail.gmail.com/

Thank you.
