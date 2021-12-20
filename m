Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C8347AFCB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239615AbhLTPTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236245AbhLTPRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:17:48 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938D1C08ECB5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 06:58:54 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id r15so18194976uao.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 06:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QDssa22PhMGtbl20NqdUydglCsPzDhQ+/kIfIMV54VE=;
        b=VNARcXCfe63PrdPYsk3dsMjHDo34eHTOtCfDqLrExExXU3wO1DBiOP52cFcFmMtqic
         NbOPyzO2VDWuUqABih5Nm7vlUAOs0OXV2CKoMY7OWw3W2EJiZX1l5hNblqPvVSiOlSZ3
         zCCFE2NeNypdjcj2dF2djKZuRjoRXHzEMzWS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QDssa22PhMGtbl20NqdUydglCsPzDhQ+/kIfIMV54VE=;
        b=4JEHdMAInR0uadXaoB0icp6l0TWj/VoWisUvZeaNLf+sJ3bn0GkqlJBItClsGArBu/
         srEAWZ6p4Avkohu/sDW/DP00lR1o3pjC2sd+R2hLcEprDDRrYN3VzDuFyuTffoTxRT+4
         B+JXZdZ9Z7p6G3zbEa63/T/aPZna9Kp+PCryj8UyTTxmMZcsXkt3DiuFqq6dqfo//UaG
         X8R7S+eiqddayi0GbZNHvnUlTFMLIzZIAGpVaMEuAlY18gumFqyZ4XBqmfcTAWGRLExH
         VeWdMYALt2P2OVSbppBInL1vroz/zqe3snrIY4N5YMlRhiIR7aeFMXTbTHEFKeM7ecFH
         3FMA==
X-Gm-Message-State: AOAM5321mnhE2NOKoNXkOlxu0wL7/GmDmdNyxUzSe7nws4SucTU9pq6o
        RbEpx2MCxU9/GzWv2LdXD/86BpNQh7xscbZGf9HAfXf0KvgenA==
X-Google-Smtp-Source: ABdhPJyTQPfX4cHVqBvCyRUj4DqcBhzYOXOwS7xn4vLsweFAl3oW5gSqs6O2hZ7oAQ1/FsAxvoD3e28q68NQLEfwXYk=
X-Received: by 2002:a05:6102:3a0c:: with SMTP id b12mr4955593vsu.48.1640012333603;
 Mon, 20 Dec 2021 06:58:53 -0800 (PST)
MIME-Version: 1.0
References: <20211213094036.1787950-1-daniel@0x0f.com> <20211213094036.1787950-5-daniel@0x0f.com>
 <CAMRc=Md_2b-sBnPQL-E59byYSv+Z0+d3V8JrbPqpGSMjGS+tgA@mail.gmail.com>
In-Reply-To: <CAMRc=Md_2b-sBnPQL-E59byYSv+Z0+d3V8JrbPqpGSMjGS+tgA@mail.gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Tue, 21 Dec 2021 00:02:04 +0900
Message-ID: <CAFr9PXkkp8B5Vv0eu+2gPF2S4CNaxZDwjPg+UXRgvyUkAZBFpA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] gpio: msc313: Add support for SSD201 and SSD202D
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

On Mon, 20 Dec 2021 at 23:50, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Mon, Dec 13, 2021 at 10:40 AM Daniel Palmer <daniel@0x0f.com> wrote:
> >
> > This adds GPIO support for the SSD201 and SSD202D chips.
> >
> > Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
>
> I applied patches 1-3. This triggers a bunch of checkpatch errors.
> Please address them and resend this single patch.

The warnings about complex macros being wrapped in parentheses when
the things it's complaining about are defined lists not macros?
Not going to say I know better than checkpatch but I think the errors
there are wrong. Putting parentheses around the lists would break the
arrays they get put into.

Cheers,

Daniel
