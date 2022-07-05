Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B9856722F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiGEPKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiGEPKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:10:25 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C201186F9;
        Tue,  5 Jul 2022 08:08:55 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-31cac89d8d6so42297817b3.2;
        Tue, 05 Jul 2022 08:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sPBaAYKtdBQqeaHLjJ6iAYafP3zFv94RDSHIBhViGdE=;
        b=WNusVV39RST0pnQUXN8oz0TQdpmAlVCoFuQ2IevpA4OqbDlvWgnP0+e4FdejrvOKmS
         mkf6XJ7lol1njA2uKujFxWw8CDTDiVuZ40km/g75KZn1Kev4JggYqXDP8RqEh+vIVbZx
         9DWvFUBKgP4qJMoSBAe41j7xyK29kZy5jnzW9/jVz6F1orutBDk6licIsnMYCFluoQ1o
         RTc7GfY/hDx2E8xUBFW7CwVl91O1cr4fGjcl+LICC6rX/2pOO+QPGkyQm1KQOJjOk1oD
         CtlZfueqdSNsm+AO/zWDbZQNDjx/LRQPzQpeQgelyTwgC1tn762MdQSmWjQHQfBqO9tq
         kMGg==
X-Gm-Message-State: AJIora9RgvKMFaSt/0tAcjEpeuDf0F1TLYsAFBaGGFSj440pLCEomWxl
        tQ+02Sk9CRQFqHV3IgdzU4p5JYwr4vVbZ57fZFhBPivi
X-Google-Smtp-Source: AGRyM1tPco0HbPprtHcs7VOv2MFOAPaGUs3UnekDJDT23BYJYkgPuZCZv/mTPfaWpZ4Cqup4ZqKcQrWDBiM/TRCgInE=
X-Received: by 2002:a0d:d8c8:0:b0:31c:92b1:5dec with SMTP id
 a191-20020a0dd8c8000000b0031c92b15decmr13840166ywe.19.1657033734398; Tue, 05
 Jul 2022 08:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <12026357.O9o76ZdvQC@kreacher> <2657553.mvXUDI8C0e@kreacher>
 <5606189.DvuYhMxLoT@kreacher> <e9666883-3285-36a6-6278-ace219b88f3c@huawei.com>
 <CAHp75Ve-Cm43HhqqxxfmKTbC_Gkx=0aAcj0jJmA=-Nr-NT1FqQ@mail.gmail.com>
 <CAHp75VdT1YZUQbdHupA2RmucUBSzypcPwKBgSa4=sVQAhC+Vsw@mail.gmail.com>
 <61fbd71b-9c36-345c-7aed-561b81c34259@huawei.com> <CAHp75VdxaBG8Sj3j7Wa7BrZOrn1j2eAtJMw0N8z255HwMSohYw@mail.gmail.com>
 <df8c0a5d-e950-1726-5d30-80dcc8b20ff9@huawei.com> <CAJZ5v0hv7nm57QrCYX+aX=fVoE0s0BxEpJfz+a8bsPzzSZt7+g@mail.gmail.com>
 <71dfc3cd-c2ae-8096-9280-67e77c21055e@huawei.com>
In-Reply-To: <71dfc3cd-c2ae-8096-9280-67e77c21055e@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Jul 2022 17:08:43 +0200
Message-ID: <CAJZ5v0jZqHfZrObyZb=e3faZNrdq+3CMA75AgwgLcJhpj22sSw@mail.gmail.com>
Subject: Re: [PATCH v3] hisi_lpc: Use acpi_dev_for_each_child()
To:     John Garry <john.garry@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yang Yingliang <yangyingliang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 5, 2022 at 10:37 AM John Garry <john.garry@huawei.com> wrote:
>
> On 04/07/2022 20:02, Rafael J. Wysocki wrote:
>
> Hi Rafael,
>
> > I've applied the patch from Yang Yingliang and I thought it would be
> > OK to add your ACK to it based on the conversation so far (please let
> > me know if that's not the case).  Next, I've added my patch rebased on
> > top of it with the tags from you and Greg.
> >
> > The result is on my bleeding-edge branch:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=bleeding-edge
> >
> > and these are the commits in question
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=d674553009afc9b24cab2bbec71628609edbbb27
> > https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=54872fea6a5ac967ec2272aea525d1438ac6735a
> >
> > Please let me know if you see any issues with them.
> >
>
> I gave these a quick test on my board and they look fine.
>
> Acked-by: John Garry <john.garry@huawei.com>

Thank you!
