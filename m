Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0219247CB4A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 03:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238569AbhLVCLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 21:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238536AbhLVCLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 21:11:08 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5542C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 18:11:07 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id g79-20020a9d12d5000000b0058f08f31338so896738otg.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 18:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l4q5emREBpkHjWRlAYtg7cUXF1z/GzcXmEP05i5MvYE=;
        b=TRLllojdHVLsgW7MZKujGqQuIIRYplYu5kyNtNpmyG4/qHUmimhl9X47k1g7e2WzK+
         K7baIFw2oTE0r3LBJhcck5jGXikTjSf2UacDdmZyQX+gS2OKMekd4xwLyogBt9aDAA6H
         9BKgp2qEhQf4U362fekAAWEnTc3RRFwnEkflVXK2/3zDA6z9ePx60a8415zn16JdxcI2
         LJsWIL5eZiRmDQZZWS4g+yH6n8VKW6YPbLkwQz0taFTXhmYkQIf8r3A+qbR0p5luaf3u
         wGqp0A0MPLHwvwYhNQnc6G5j7/QBF02r1ORDNjYjQfRQmxoYlqey14jRqQjyDornN7fc
         pjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l4q5emREBpkHjWRlAYtg7cUXF1z/GzcXmEP05i5MvYE=;
        b=VcULPpuWHJZ+DUjDXqc2MSoKfOU9hdEiPPaJ6ImOlTO02zAcS1aQxdiDOqf0FcCuHi
         F3eocMOcsZZdRFFGIYUxThQphxniaDDLxMoWIm5JnA7c6u5awKmo8r6e3td7DsNTmbvS
         Fwf5/zAwFQSaQWc0dpmRQLVFEfscSpIUTaEHWl+xwd7zBNygVGrAX/ITU575Wj4ec6cB
         HhuANEm3wg5u6jx3CCm7A9hVTtikiqfY0H8WiWBdgBavw/JRDRwtxIvsOaFvNxHnFmVQ
         0sWknmDLzRLQmJBvJl+Qvx++t9Q4VNByrpsqaURGtWvOAzFIt+YckOb1k/+mDh57hOg7
         HgTw==
X-Gm-Message-State: AOAM5333B/+bbJKnSdxHbxCg+S2rDSY0vIe0g1GIXS3d2dc9HMp7dYG0
        HbIE+4rplAbS+ghKi3YzPAoJpKeRyilC4DY/9RTpOIjKUnI=
X-Google-Smtp-Source: ABdhPJypdJNBEKk+OSsTACvzXarOOCBDL3wVWI+BM2Czbk+zy/DrvPRZ36NvkSRqlqPpBmlUyeD6RtBPgfIWcEpeapw=
X-Received: by 2002:a9d:ed6:: with SMTP id 80mr752044otj.35.1640139067056;
 Tue, 21 Dec 2021 18:11:07 -0800 (PST)
MIME-Version: 1.0
References: <20211216151227.58687-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211216151227.58687-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 22 Dec 2021 03:10:54 +0100
Message-ID: <CACRpkdYe5FHpzvey_hHMLxpYpX0ad9eu0JsaNk_zUkj-1qtQTw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] pinctrl: Propagate firmware node from a parent device
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Support Opensource <support.opensource@diasemi.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 4:12 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> When creating MFD platform devices the firmware node is left unset.
> This, in particular, prevents GPIO library to use it for different
> purposes. Propagate firmware node from the parent device and let
> GPIO library do the right thing.
>
> While at it, slightly modify the headers to reflect the usage of APIs.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: fixed more compilation errors brought by header reshuffling (LKP)

Patch applied! Thanks Andy.

Yours,
Linus Walleij
