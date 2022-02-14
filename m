Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B044B5DFE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 23:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiBNW7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 17:59:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbiBNW7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 17:59:07 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ACE1901A6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 14:58:58 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id h18so7013629edb.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 14:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H4CDzrFaAIRXP+JfJQjZSpyvl+auCY5ZKASrSIHcfZ4=;
        b=g1eWBAr03pbHIGky/Et9stEsa62hM8KOUIVkJ/UAyGbCj4E+TeHxDAH3ngnjFzbGfy
         6KPQbUeolripHdS/5FHHM9Osf86vxMO7KIsfUjlLd1M3dNyM0u8fmJH+j+mm3iJ7z63G
         JR5bLt0DPZE2syU6n0PxTOgFYdHlbSn8G6gXjktIi3ecNeuPuQWXqQTOZ6pD2qS1EnUj
         5CI5MEwdruQArTTBNk5mEiO2WdgEek1emiOymwL1PvsONdPEK3OOEIaEqvwcIFHKrrFr
         4JHZGQ3/Gfz/G39IRSC2r0IejJFYpkNCwItA4+7Y1kGBMvRC/fc9ZY7Fwo/zsr8YvW0o
         1rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H4CDzrFaAIRXP+JfJQjZSpyvl+auCY5ZKASrSIHcfZ4=;
        b=GigqJoL78N/V6AlBDt+34VLICaPBiTBHEkEIbDJue2Xuiz5M7Vk2aB+kDLxpZTGutz
         CTcWMuNlgV77Do8JrgJ9kqM/dRcYfeMK3riVOzYvUZsWEV3G4vFX78lWT+mI+VOAl7Ks
         WHwwFOwo3u9fn+OvKnB9lik2pmhFf0ARdh6/FXT7X3bCoAqlj0OIuMMq20DHvaSOnWOR
         /BqhW+Nhl0NvuKGho6HKwMLRmNMk6KQ9VsTrYUZDOI/qhj+q3qMWXQP/0HDIb6dZyxdh
         nGxlKpz3d4JOsMUQ/nCixSCIw4wBnAO/cnPppaflg6qia2jgjBeEkpPuzevVlCfArCA6
         40cQ==
X-Gm-Message-State: AOAM531/hXgJv5FjtSp9bXtXpgvsbPO4+C8OeAYr6ZkWv2W3a2AmcCfi
        +LCFBHF5p25uY7msxLAJ1tV/K0ijEqy6uwSLJMSuDQ==
X-Google-Smtp-Source: ABdhPJwpXtBphXPJ50QihP13rNz4U0amvRgAmy4aDk1Wwxy0Bg+4yuTFVEPXPDcZi9Valn6eEkT1vrL25RQAh8jRaLY=
X-Received: by 2002:a05:6402:50d4:: with SMTP id h20mr1175034edb.90.1644879536587;
 Mon, 14 Feb 2022 14:58:56 -0800 (PST)
MIME-Version: 1.0
References: <20220211023008.3197397-1-wonchung@google.com> <CAJZ5v0gD4zs3uBAYv6M4_1gNpkZ-g9XKOywJnf5007e6GwoGVA@mail.gmail.com>
 <CAOvb9yjpruiHxkZyZ8BOT0Hi_iV7xMOnBCr59BZX3eah_Zcy_w@mail.gmail.com>
In-Reply-To: <CAOvb9yjpruiHxkZyZ8BOT0Hi_iV7xMOnBCr59BZX3eah_Zcy_w@mail.gmail.com>
From:   Won Chung <wonchung@google.com>
Date:   Mon, 14 Feb 2022 14:58:44 -0800
Message-ID: <CAOvb9yh7jo27NH32tbAOtkJrnC9LwUFgFbHRbdbArwiU+YSmdw@mail.gmail.com>
Subject: Re: [PATCH v6] ACPI: device_sysfs: Add sysfs support for _PLD
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 12:30 PM Won Chung <wonchung@google.com> wrote:
>
> On Mon, Feb 14, 2022 at 11:12 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Fri, Feb 11, 2022 at 3:30 AM Won Chung <wonchung@google.com> wrote:
> > >
> > > When ACPI table includes _PLD fields for a device, create a new
> > > directory (pld) in sysfs to share _PLD fields.
> >
> > This version of the patch loos better to me, but I'm not sure if it
> > goes into the right direction overall.
> >
> > > Currently without PLD information, when there are multiple of same
> > > devices, it is hard to distinguish which device corresponds to which
> > > physical device in which location. For example, when there are two Type
> > > C connectors, it is hard to find out which connector corresponds to the
> > > Type C port on the left panel versus the Type C port on the right panel.
> >
> > So I think that this is your primary use case and I'm wondering if
> > this is the best way to address it.
> >
> > Namely, by exposing _PLD information under the ACPI device object,
> > you'll make user space wanting to use that information depend on this
> > interface, but the problem is not ACPI-specific (inevitably, it will
> > appear on systems using DT, sooner or later) and making the user space
> > interface related to it depend on ACPI doesn't look like a perfect
> > choice.
> >
> > IOW, why don't you create a proper ABI for this in the Type C
> > subsystem and expose the information needed by user space in a generic
> > way that can be based on the _PLD information on systems with ACPI?
>
> Hi Rafael,
>
> Thank you for the review.
>
> I was thinking that _PLD info is specific to ACPI since it is part of
> the ACPI table. Could you explain a little bit more on why you think
> exposing _PLD fields is not an ACPI-specific problem?

Hi Rafael again,

Sorry for the silly question here. I misunderstood your comment a bit,
but I talked to Benson and Prashant for clarification. I understand
now what you mean by it is not an ACPI-specific problem and exposing
PLD would depend on ACPI.

>
> I gave an example of how _PLD fields can be used for specifying Type C
> connectors, but it is not Type C specific. For Chrome OS, we plan to
> initially add PLD to not only Type C connectors but also USB port
> devices (including Type C and Type A). Also, PLD can be used in the
> future for describing other types of ports too like HDMI. (Benson and
> Prashant, please correct or add if I am wrong or missing some
> information) Maybe my commit message was not detailed enough..
>
> I am also curious what Heikki thinks about this. Heikki, can you take
> a look and share your thoughts?

I am still curious what you and Heikki think about this since it may
not be a Type C specific issue. We can start from adding generic
location info to Type C subsystem first, as you suggested, then
consider how to do the same for USB devices and Type A ports
afterwards. I would appreciate sharing any thoughts or feedback. Thank
you very much!

Won

>
> Thank you,
> Won
