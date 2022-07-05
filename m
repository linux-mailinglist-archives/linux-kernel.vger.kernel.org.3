Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B0E566645
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiGEJjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGEJjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:39:40 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB26E2F;
        Tue,  5 Jul 2022 02:39:39 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id j13so608498ljo.7;
        Tue, 05 Jul 2022 02:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YBwn8GswjKLhf53ockHlKSzvllSizbaKgXkfXlDSJ/8=;
        b=eT9F6s9ulKTCG9TYTp+7Vz3zITzszwNHjcUjyPKOCLS4A8DBcUE+I56BBifN1ABYsi
         WJnmC7bXGB34adpPTpS6hJs+gPmft35PbdfAAB92EEsE03yIm2ouTf7MXNDq+ZIeOYVs
         m7a3mvsQsl7iSWnTsTYmyWBfWPW66vffy1tbci3f4lyNFlzgfsMz3uVWL6a3brxJijxA
         EtUIRWaeAVWginzONCkmOgI5RaBVbUfQLlz+Lzr278a21rhM37VNZHYEIdrdzbONn+9b
         j89PYPe4JDigWniSf2dNyrxe5k6NNXa4tFWh43wD22TAOQHY9AZVSSWFbJiEIvfuBuea
         7Evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YBwn8GswjKLhf53ockHlKSzvllSizbaKgXkfXlDSJ/8=;
        b=4eBwDHWXmzNXOPJAYkpIkWiyzzMOVCHfboHBoPv+gOb3efql/VjFIWN+q00Vya/2Ug
         YotEdvCi3Yih5tKZ4jmH+I+lSomCA3j/zaVXQjx93UumQkKV/UX50WgqPzQUx96gJnSa
         HVflSem+v/glvIVQeGknZBgFVwqfvZzz4BE1V3yWwAfsdMtMGPXa2ERn6h4WEcKuvFfl
         8IOeKPSRlS8iYbIqvlzERd5QlRtZ8FxqbWY8b5ZlqTyDamggVGJ5rdpB/ofNh0GO7BZR
         YoJhEpqbBShEqXfpYHim72ouWkaWYWd/1b8Vn4Fdl46UnmUkBQOOC2E2wcEV3tnm4xJV
         2heQ==
X-Gm-Message-State: AJIora9k0bDIuB+b60zoEZVzKd4qSdkXisApYbufeHufFkTLnhmbgfGE
        K55AwxOoN2LniWtUtgRqeMObXsSKwxPsWY6xEh8=
X-Google-Smtp-Source: AGRyM1t6yISdyXQTBapWlPeRxsV+d1mtsDnzO34oPcXKVgtKF3XYHBxQfSB4fAaXtxjhKkUYKZ+VeL6zBr5ziaRovlE=
X-Received: by 2002:a05:651c:1549:b0:25b:d2dc:2e8f with SMTP id
 y9-20020a05651c154900b0025bd2dc2e8fmr18592708ljp.334.1657013977620; Tue, 05
 Jul 2022 02:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <12026357.O9o76ZdvQC@kreacher> <2657553.mvXUDI8C0e@kreacher>
 <5606189.DvuYhMxLoT@kreacher> <e9666883-3285-36a6-6278-ace219b88f3c@huawei.com>
 <CAHp75Ve-Cm43HhqqxxfmKTbC_Gkx=0aAcj0jJmA=-Nr-NT1FqQ@mail.gmail.com>
 <CAHp75VdT1YZUQbdHupA2RmucUBSzypcPwKBgSa4=sVQAhC+Vsw@mail.gmail.com>
 <61fbd71b-9c36-345c-7aed-561b81c34259@huawei.com> <CAHp75VdxaBG8Sj3j7Wa7BrZOrn1j2eAtJMw0N8z255HwMSohYw@mail.gmail.com>
 <df8c0a5d-e950-1726-5d30-80dcc8b20ff9@huawei.com> <CAJZ5v0hv7nm57QrCYX+aX=fVoE0s0BxEpJfz+a8bsPzzSZt7+g@mail.gmail.com>
 <71dfc3cd-c2ae-8096-9280-67e77c21055e@huawei.com>
In-Reply-To: <71dfc3cd-c2ae-8096-9280-67e77c21055e@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Jul 2022 11:38:59 +0200
Message-ID: <CAHp75VfqJwF4YypH3QE0MRgZAyjEMKche-4czUuiC=aTYoYwig@mail.gmail.com>
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

On Tue, Jul 5, 2022 at 10:37 AM John Garry <john.garry@huawei.com> wrote:
> On 04/07/2022 20:02, Rafael J. Wysocki wrote:

...

> I gave these a quick test on my board and they look fine.
>
> Acked-by: John Garry <john.garry@huawei.com>

John, I believe now you may send a formal clean up to convert to platform_device

-- 
With Best Regards,
Andy Shevchenko
