Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA16149EEBE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 00:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241220AbiA0XRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 18:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236765AbiA0XRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 18:17:38 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675F9C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:17:38 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id q19-20020a056830441300b0059a54d66106so4145328otv.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZHgjzy8t853W7I+7RWJNG2X4/bJj/NvMkuBTg7rJMyI=;
        b=lXfZj48otSZXbvvLK2IFxj2PbX/9TUU3oXrlHfV5EOgB8ydujVyzfPi/Y4WKkJVmvb
         3kCp+UaQ3QggL6uu4AMh5+RMEtNSAL4FZeHRAjpF08d+Q6o69AGfKYdsWVx51Pr0bfMZ
         CRK8rLd1m3YZC0XS7gMZnsZJbFLKG0EeL6vjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZHgjzy8t853W7I+7RWJNG2X4/bJj/NvMkuBTg7rJMyI=;
        b=b6NhEOn8meWBWdAjgRrn8Fq/J6nbUt0AeZZubOONa6SLc4Opw2dzYIKqfoKsf5mX9V
         F7uFTeCmuS7KhdUB/BQAI92U0S3iPZh+T/wDdPM4kGKj/L+OQilXDhyU25NyK1zDR1Kf
         RjAOeSNLitJKX1/1qVDrMrAC0/1x7JMbSWyljXx7FhtIAjdNGQ9Prko4/H0dY2wGJZlF
         h3GStfgcIMcmZ91fF+St87TzZ1+Z0FkXeK4IpJMmFz4HVzP6FkIdw5dB2K9R1MkcuhWD
         iDCdi46VJwDWeipy14LykPiJ8Etrzi9ASYd75tAI3fYwJnu2BF4E1HHknksn6VhsOCdo
         R7KQ==
X-Gm-Message-State: AOAM532jdMPxI6NbKl3O4xwGAMyacZg6FRY24dILuhxpPa7l3Ei7Tn1o
        7mcx/+6Z9MMjm1uRPahNGCeszR5b6bgauA==
X-Google-Smtp-Source: ABdhPJxdWnodK9cca7XUOh9b8Shg8+RALApc87AmtnRwTO8KV8r05RvKjAsEOFUNuNKRg20AJj2wXg==
X-Received: by 2002:a9d:1ec:: with SMTP id e99mr3314372ote.376.1643325457529;
        Thu, 27 Jan 2022 15:17:37 -0800 (PST)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com. [209.85.161.53])
        by smtp.gmail.com with ESMTPSA id n66sm9812570oif.35.2022.01.27.15.17.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 15:17:36 -0800 (PST)
Received: by mail-oo1-f53.google.com with SMTP id r15-20020a4ae5cf000000b002edba1d3349so1007289oov.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:17:36 -0800 (PST)
X-Received: by 2002:a4a:dd86:: with SMTP id h6mr3051054oov.87.1643325456364;
 Thu, 27 Jan 2022 15:17:36 -0800 (PST)
MIME-Version: 1.0
References: <20220127230727.3369358-1-briannorris@chromium.org> <20220127150615.v2.2.I5ba582cd678d34c03d647e5500db8e33b7524d66@changeid>
In-Reply-To: <20220127150615.v2.2.I5ba582cd678d34c03d647e5500db8e33b7524d66@changeid>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 27 Jan 2022 15:17:25 -0800
X-Gmail-Original-Message-ID: <CA+ASDXOnO1EgStrynPe1uSB4T8=qNUPj+wY2y3vGs0fnEHdE0Q@mail.gmail.com>
Message-ID: <CA+ASDXOnO1EgStrynPe1uSB4T8=qNUPj+wY2y3vGs0fnEHdE0Q@mail.gmail.com>
Subject: Re: [PATCH v2 02/15] dt-bindings: devfreq: rk3399_dmc: Deprecate
 unused/redundant properties
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Derek Basehore <dbasehore@chromium.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 3:08 PM Brian Norris <briannorris@chromium.org> wrote:
>
> These DRAM configuration properties are all handled in ARM Trusted
> Firmware (and have been since the early days of this SoC), and there are
> no in-tree users of the DMC binding yet. It's better to just defer to
> firmware instead of maintaining this large list of properties.
>
> There's also some confusion about units: many of these are specified in
> MHz, but the downstream users and driver code are treating them as Hz, I
> believe. Rather than straighten all that out, I just drop them.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
> (no changes since v1)

Apologies, I didn't include Rob's Reviewed-by tag on patch 2 and 3. If
this goes for version 3, I'll include them.

Brian
