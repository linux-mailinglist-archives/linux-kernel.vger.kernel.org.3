Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A79482FC3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 11:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbiACKFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 05:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbiACKFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 05:05:39 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B445CC061784
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 02:05:38 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id j21so133788714edt.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 02:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zyqrhqFrOjKgAQ/NgiI6myye+ZTSj+oGpoQCEyxK7I8=;
        b=hh82xL5h3iuQi0w0UWmziHKDei2V7WmW8Q1scEW+3QAUMeU9NQzjI4tQbE7SdjFtf1
         jSJxTC6JXmJC30t8UiD4KSbWgFjgI5vzj/f4kgXCMMF1cXpyBUaEbmKaciHqvMxsbzsA
         s6srxiCjzdc1gKO+ggXM4XDCqtT2PwzGVzkb/jUr2J2ZhWo5kOfS2MJEdIdlgYONwV+r
         8UXM2kZvxf61JNCPztpCEKlCSclwA8LLCiKZq9s5TG2Hj+M4q7kIxpkcgP2mbBpk/j8b
         XueqCMflL2VGG7B2jaKdv/ucS5zBVJXPEWQ01p2ABMjOQzlW4lcBw20nefVTfWSS2F8G
         U11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zyqrhqFrOjKgAQ/NgiI6myye+ZTSj+oGpoQCEyxK7I8=;
        b=t7hHbNGeU/HDnkiZb4GoraCchHgqJjVOoDA3O8O660HPV/++L1wzB7QERo/WxduJq/
         ewVcah3j+Caq/qubZ2RnqgMnkHTFtVR3Fad+G7+h3f9oyxakhiWjsTrjw7Es2ObJqg9D
         +zMd0A4MEZQEjmjoch7blOMNcVHObjH3sUYZvRzHOsGPMf/pV2szWd3W3Q54EBqQc1Ov
         jwzi04YJeE6rOmTOnhv+/PGmN2DAuUSfF+nuuk1zyTbhyEfya1k/MaxGXEELwyzFYYEg
         6TwWndvOkKiMUnUD+fY5E4g4PmKaM96IESUej8drAnaFBmBcZf1PyCCPxeU4Akd/nxGZ
         tYcQ==
X-Gm-Message-State: AOAM5325swlRyEHBwy66DjmNwGTpHk4BaM/dv2JF2GO4BoxjRmBTNHyz
        9R80YF0f0qk1QpWVjVvvLJTrSRxB2mRDWHEHtLbHiTfedAk=
X-Google-Smtp-Source: ABdhPJz0LLpdg5ZlhYjWS1ccr4u0SOQqQpZlRsNizsQSMtlQ61aLAXVlFvutkF5sr+/qADHHxZmu4uWBVmQTZlrVwhI=
X-Received: by 2002:a50:9556:: with SMTP id v22mr43073644eda.69.1641204336956;
 Mon, 03 Jan 2022 02:05:36 -0800 (PST)
MIME-Version: 1.0
References: <20211223103809.12343-1-andriy.shevchenko@linux.intel.com> <20211223103809.12343-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211223103809.12343-2-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 3 Jan 2022 11:05:26 +0100
Message-ID: <CAMRc=MfCu8Z-FLdyz8eAqjj+soARUk3zoL8jDFpe2VyLCd2r5Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] gpio: dwapb: Switch to use fwnode instead of of_node
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 11:38 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> GPIO library now accepts fwnode as a firmware node, so
> switch the driver to use it and hence rectify the ACPI
> case which uses software nodes.
>
> Note, in this case it's rather logical fix that doesn't
> affect functionality, thus no backporting required.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Applied, thanks!

Bart
