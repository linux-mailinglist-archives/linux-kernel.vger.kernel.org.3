Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723E7566807
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbiGEKa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiGEKa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:30:29 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D50A15833;
        Tue,  5 Jul 2022 03:30:06 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-31caffa4a45so32519027b3.3;
        Tue, 05 Jul 2022 03:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8etHjP9NB2AEzDxGeqW3akKDdSo8OiEzz0+PEyCVcMI=;
        b=e40iovbVTXulHSh0GwhgN51kUXvZf4ISbfavw4qKV94xUm+8MdOKNcXq/EgWgUz5d8
         BD9EyVlmIknBG+DOhCFTczbbpElxqDUOMAzRaYlQ/pZMcBzj/jxiol+KMxiZcTLPfg7c
         ZSXMeNy/Qb9z+thnamxGnmOMNtjZjqVMe6cWnldkEVYUJCDsX2I5OFpcznriK+CYWnai
         sHVEJ7MEzYL2DTIbWgf2sOjWZbIergf3EfBxrnlmQHSJdodopzgkUckqGOlv+TqU86b5
         sHpK0dSod4Ah58nnOOLL9RCjIfXqBGQQM/TGTCUWW/eZHrx39k7vN3f+Et5P9czC6hRv
         dKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8etHjP9NB2AEzDxGeqW3akKDdSo8OiEzz0+PEyCVcMI=;
        b=aZjztgCWoafc7LeggEXjSppc9SuNVDbqOnvy+65zEirRE1oTol9paAbXCNe2mEdtRN
         BFM+0lTkWzo5I0L5Rb7aDwaj/ZsPGDrcA7Y8bATjg+iyUcZJSjvp97O6dfSoMZdeICmg
         o/IjoJI/H6G0I4ZvcDdsuRjnZD4jDSQ/HeUSAs1QSpiaToUjny+xbCUM9LfzntHmMszE
         yf0K6214Y57Q9DQDGVsfyG3pdsSNmXvh1kaVU1L5091B2jjXIXXnXW69e5oPzekSr2wp
         tA+ZaBchXWF7e808GumuU3xibUqVNiQRAHiWGDGjF0pIXVJ8JaSBFwWYloOIMgUGfwln
         bIKQ==
X-Gm-Message-State: AJIora9N79klqOmt5kIxmHGBsJm7rmVKWhXmt58l10QMiXCKNDt5jJIY
        eZSoWJRyZPKtguRDSACSM96hdzYmujdy+SlJNZI=
X-Google-Smtp-Source: AGRyM1u4An9CGm86TWkOCZ6rN+Gp+qniI7fES8Od55cX8SpJNJq4/vULFL0zRs0viV5Xdm7bnUQc5liTVBX8LGJ601I=
X-Received: by 2002:a81:3984:0:b0:31c:b59e:a899 with SMTP id
 g126-20020a813984000000b0031cb59ea899mr6131611ywa.195.1657017005324; Tue, 05
 Jul 2022 03:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <12026357.O9o76ZdvQC@kreacher> <2657553.mvXUDI8C0e@kreacher>
 <5606189.DvuYhMxLoT@kreacher> <e9666883-3285-36a6-6278-ace219b88f3c@huawei.com>
 <CAHp75Ve-Cm43HhqqxxfmKTbC_Gkx=0aAcj0jJmA=-Nr-NT1FqQ@mail.gmail.com>
 <CAHp75VdT1YZUQbdHupA2RmucUBSzypcPwKBgSa4=sVQAhC+Vsw@mail.gmail.com>
 <61fbd71b-9c36-345c-7aed-561b81c34259@huawei.com> <CAHp75VdxaBG8Sj3j7Wa7BrZOrn1j2eAtJMw0N8z255HwMSohYw@mail.gmail.com>
 <df8c0a5d-e950-1726-5d30-80dcc8b20ff9@huawei.com> <CAJZ5v0hv7nm57QrCYX+aX=fVoE0s0BxEpJfz+a8bsPzzSZt7+g@mail.gmail.com>
 <71dfc3cd-c2ae-8096-9280-67e77c21055e@huawei.com> <CAHp75VfqJwF4YypH3QE0MRgZAyjEMKche-4czUuiC=aTYoYwig@mail.gmail.com>
 <CAHp75VfpQfBYD-AmVhbxm4tp_1EVv8xqCChYpuuRKOC=P_Y_og@mail.gmail.com> <050e5a2f-42b9-f851-ec6e-e2a9d3fdbe1c@huawei.com>
In-Reply-To: <050e5a2f-42b9-f851-ec6e-e2a9d3fdbe1c@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Jul 2022 12:29:27 +0200
Message-ID: <CAHp75VfQDtvUbOYvjXsCg9q62iHwc-SwqZ+XD2yiJe=o12c9xA@mail.gmail.com>
Subject: Re: [PATCH v3] hisi_lpc: Use acpi_dev_for_each_child()
To:     John Garry <john.garry@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yang Yingliang <yangyingliang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 5, 2022 at 12:16 PM John Garry <john.garry@huawei.com> wrote:
> On 05/07/2022 10:39, Andy Shevchenko wrote:
> > On Tue, Jul 5, 2022 at 11:38 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com>  wrote:
> >> On Tue, Jul 5, 2022 at 10:37 AM John Garry<john.garry@huawei.com>  wrote:

...

> >> John, I believe now you may send a formal clean up to convert to platform_device
> > Hit Enter too early:-)
> >
> > ...to platform_device_register_full().
>
> Sure, I can look at that now. But I just found where we previously
> mentioned the possibility of factoring out some of the ACPI platform
> device creation code:
>
> https://lore.kernel.org/linux-acpi/CAHp75VfOa5pN4MKT-aQmWBwPGWsOaQupyfrN-weWwfR3vMLtuA@mail.gmail.com/
>
> There is actually still a comment in the hisi_lpc driver - I should have
> checked there first :)
>
> So my impression is that the hisi_lpc code is almost the same in
> acpi_create_platform_device(), apart from we need do the resource fixup
> in hisi_lpc_acpi_set_io_res().
>
> So we could factor out by dividing acpi_create_platform_device() into 2x
> parts: resource get and then platform dev create. But that does not seem
> wise as we have 2x parts which don't make sense on their own. Or else
> pass a fixup callback into acpi_create_platform_device(). Any other
> ideas if we want to go this way?

I prefer having an ops or so structure where you can pass ->fixup()
and/or ->xlate() function, Btw, it looks like the code in hisi_lpc
needs a lot of cleanups.

-- 
With Best Regards,
Andy Shevchenko
