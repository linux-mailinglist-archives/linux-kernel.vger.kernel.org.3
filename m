Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6970F48F9FC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 01:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbiAPAYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 19:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiAPAYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 19:24:15 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4056C06161C
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 16:24:14 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id y14so18026523oia.9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 16:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MIpFQ0NWKHK372rOvfeCdj6iTC0QFLwCmnvuB/iqxlA=;
        b=vgfcxaLPoXv0oRKS2JpHt+YiKcG5RSnLUSxbYb67ya9QoOL9XOSL2AgOzt08tuLkFn
         Tjkf+WTIQh2nu2NslRnVDTRFcqWxISGeteUJDxzwxttOoGzORCMEhuT1p/m5qXxEldsK
         siWym5ay4v8tzJTniaRjiixnJxcqpyz4Zc3ylf3yByWuqo/z96ksVH9ta3j7grNWxFNA
         tOvOEsugcozymAUB+JQw4FLbfwxLzKpwAEwTMnzQO2zZdzzfCYDO4OHdBMBqGozyUgDk
         Q85Pzo4LazfA3Jhc+QwSsKbOkQ18LGmD8f4yu/qeLs36AIfPHcAGAcq9DUPVYYfeMlsN
         h7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MIpFQ0NWKHK372rOvfeCdj6iTC0QFLwCmnvuB/iqxlA=;
        b=VuTi2izsm0qpXDH2BjmltAkO9Vbu15L5zvPm82YmsCksNJooS3I3VOJPro7CV0HPAG
         SbXNoXVLVqhl4IUSYeJQq1ULNytK5A0jKpCxCzBpKEWrgwReMhqiqRV12mTK1MhHJou3
         y224M7jXvLEC8L3vkJCvzacff64T7EWx84th4WaPgVPiY+9XydanPXiKoIYzKTjbJDFo
         G58/930b3GSzjOTOkpwOKzI3HfIA6sMlfUv6NimBycXJ6ulPsdfp3RpezuO7dp6zhwEl
         uU7T0QLtC59yRgL2gPE696nd2M9SY8nw2BfKikdVk0YzM34cgdKAIm5Dc9z6WfiEYbSs
         gpqQ==
X-Gm-Message-State: AOAM532ruHkff/TOTGh9kLFW1mPOP5lufCgu2WoAHTlxf2kCejDzK/+o
        xhNXE9cfC2cg7p/4qBpHB58x5+o69NlltEq/xosUzw==
X-Google-Smtp-Source: ABdhPJzA+tC41gL2AlmSa6pO4PQg8+FtZDiKk9KX4GHsoWMAA6xxI2pS2gVpQQMpOeuX0q2p579lDHexpzi7fT3UEMY=
X-Received: by 2002:a05:6808:2097:: with SMTP id s23mr8288439oiw.132.1642292654159;
 Sat, 15 Jan 2022 16:24:14 -0800 (PST)
MIME-Version: 1.0
References: <20211223122733.86981-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211223122733.86981-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jan 2022 01:24:02 +0100
Message-ID: <CACRpkdYRLDqgKjuW8W6NobaTP4dTjnkmepu=T-GhO7fMNcMEzA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: altera-a10sr: Switch to use fwnode instead
 of of_node
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alexandru Ardelean <aardelean@deviqon.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 1:27 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> GPIO library now accepts fwnode as a firmware node, so
> switch the driver to use it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

LGTM!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
