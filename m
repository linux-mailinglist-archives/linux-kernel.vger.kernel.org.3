Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C46D566648
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiGEJkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGEJkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:40:20 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE17E2F;
        Tue,  5 Jul 2022 02:40:19 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id q8so1354449ljj.10;
        Tue, 05 Jul 2022 02:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Df3QijW0kvmr3BuoLTdJ4C5Vwi2YldVGdw9uGtfWcc8=;
        b=pZqL6IJgmE1OpnmQP2yrIdT6XzkCqfIIrQcKdGvN+6j+S8E5ZZZcVaUVjmEqwzgVtX
         Z6MiZ51h+IL7i6HvkAEoYYC3UiKmaKXQOFk5VFAjSkRYUjRxwJcSLCiuQUSFJADK86Vq
         vZe4QY0KD7QANWbVot1vRMe4rVloLD7uXx+fac3MfSW9QU66/1A5cJkeFaKL8re9dQMh
         XXWOtTdIbqWJ/SpOp2GIxyRYAHbBibCoWaqLdamopxO6RdTa6MrWgyC65pqwy0oMU6jU
         lQ7HJojkI0FZf7GyYPAW/Kk8FFaprBNkD/SDBS5pYTMHzSIMNebjxVlFwESRJhmCS1SB
         erkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Df3QijW0kvmr3BuoLTdJ4C5Vwi2YldVGdw9uGtfWcc8=;
        b=1+Ntmtfsp4OU7jSPs7W4e9adSMD//694lbloODv3cjnb/FhummDWQe/7k214IScSZc
         0IzZI1PJCyM9c09IiGPxNGcYxQszxxsQSdtnqUaK+zZBnRDm8f+AmzUZrnci1QJRbw6k
         0giaobVgbKCyPq7x7sKtG3H4MtaWz8uROVmct7urB9VfYft4zgU2eCKtCEe/N8gr+24o
         hZiRiI8yyhMM74ukgJe+cDwC4fgOH8ZZnc+72bujcDNFF9Hr7+DaaruXMrdQJ+Q3dvIP
         7BFubnYafMdBznKlIqYeLiPUr5mynCPCNvcllDyUr83m9yxJ5YdvDH3fX2RT0ddpzJC+
         Gi1g==
X-Gm-Message-State: AJIora85tjUSGH0XRq78E7Kkh1hwHnMu1mtheiY+pXOMJKeKaJW9rmqj
        eHEFyk78vODWiWpS1PXVtVHTsDaNPbSlhygnmVo=
X-Google-Smtp-Source: AGRyM1sX9otqPYxd4QarO+Z8ibi/HkiwVAYOjs2mNJYZ0TUU6TnJwlYqL9OTEYZOjTfPGNEHLh5Gv2DtfiD7/7CvgI4=
X-Received: by 2002:a2e:92c6:0:b0:255:84cb:4eea with SMTP id
 k6-20020a2e92c6000000b0025584cb4eeamr18602435ljh.204.1657014017686; Tue, 05
 Jul 2022 02:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <12026357.O9o76ZdvQC@kreacher> <2657553.mvXUDI8C0e@kreacher>
 <5606189.DvuYhMxLoT@kreacher> <e9666883-3285-36a6-6278-ace219b88f3c@huawei.com>
 <CAHp75Ve-Cm43HhqqxxfmKTbC_Gkx=0aAcj0jJmA=-Nr-NT1FqQ@mail.gmail.com>
 <CAHp75VdT1YZUQbdHupA2RmucUBSzypcPwKBgSa4=sVQAhC+Vsw@mail.gmail.com>
 <61fbd71b-9c36-345c-7aed-561b81c34259@huawei.com> <CAHp75VdxaBG8Sj3j7Wa7BrZOrn1j2eAtJMw0N8z255HwMSohYw@mail.gmail.com>
 <df8c0a5d-e950-1726-5d30-80dcc8b20ff9@huawei.com> <CAJZ5v0hv7nm57QrCYX+aX=fVoE0s0BxEpJfz+a8bsPzzSZt7+g@mail.gmail.com>
 <71dfc3cd-c2ae-8096-9280-67e77c21055e@huawei.com> <CAHp75VfqJwF4YypH3QE0MRgZAyjEMKche-4czUuiC=aTYoYwig@mail.gmail.com>
In-Reply-To: <CAHp75VfqJwF4YypH3QE0MRgZAyjEMKche-4czUuiC=aTYoYwig@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Jul 2022 11:39:40 +0200
Message-ID: <CAHp75VfpQfBYD-AmVhbxm4tp_1EVv8xqCChYpuuRKOC=P_Y_og@mail.gmail.com>
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

On Tue, Jul 5, 2022 at 11:38 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jul 5, 2022 at 10:37 AM John Garry <john.garry@huawei.com> wrote:
> > On 04/07/2022 20:02, Rafael J. Wysocki wrote:
>
> ...
>
> > I gave these a quick test on my board and they look fine.
> >
> > Acked-by: John Garry <john.garry@huawei.com>
>
> John, I believe now you may send a formal clean up to convert to platform_device

Hit Enter too early :-)

...to platform_device_register_full().

-- 
With Best Regards,
Andy Shevchenko
