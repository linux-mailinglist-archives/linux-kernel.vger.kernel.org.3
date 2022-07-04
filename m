Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DCD565DB8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 21:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbiGDTDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 15:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbiGDTDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 15:03:11 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B026EE14;
        Mon,  4 Jul 2022 12:03:09 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2ef5380669cso89362027b3.9;
        Mon, 04 Jul 2022 12:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=73+jv/AeAqAxAP/tpX4j4oSr73iQ9NBGUy/dRbnUgxw=;
        b=GUn1VACBXn8cv86hTeXWHceTnZGXLLjv+P09LAz7Pomg3Zpqg/A8c1KKxJJGONT5g3
         7eT+lUue2ouDuOLQ/jigwFP6iuZ9KmidY6KEExw1yV1YUTI231YSeeC/XUtr5CUyQ6VC
         5caDEi83hM5l1u7LJK3RlQHLkMWEAHBBgJNmUOrH3/e5Hc5U0QhIDQ1hXbVnVuRy+wAX
         FQHxrC3Cpg9i1wd28/SKWGQbq0/LZZGL7ktwE9oQKs7tQPh5wZJ3KOMOIGJ1wLBu8Ovc
         z6GmWLUB7fh4J/LrolzYNXAiQQL5cneUqB24/z4TkfWvAA+dEmFHqT0JeJTrPGdSZPq9
         GVYQ==
X-Gm-Message-State: AJIora8eM6nqTSVxBuWSe2RhMBDHKHagaHhlppYDz+0sEI8/CWYRNMGm
        6e7jJWaAxiI26cJjA1ByX3M6qzSIQuMQOURpGIs=
X-Google-Smtp-Source: AGRyM1ud8JrYMuSzu6M3Q63NKTn373y1mY07EKXNIcBIupODvAV8DqzPDQ53J5gzgK5jxlyklygiFytoTUgOEfVJaBg=
X-Received: by 2002:a0d:d086:0:b0:31b:d0b2:e11f with SMTP id
 s128-20020a0dd086000000b0031bd0b2e11fmr34241161ywd.515.1656961388538; Mon, 04
 Jul 2022 12:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <12026357.O9o76ZdvQC@kreacher> <2657553.mvXUDI8C0e@kreacher>
 <5606189.DvuYhMxLoT@kreacher> <e9666883-3285-36a6-6278-ace219b88f3c@huawei.com>
 <CAHp75Ve-Cm43HhqqxxfmKTbC_Gkx=0aAcj0jJmA=-Nr-NT1FqQ@mail.gmail.com>
 <CAHp75VdT1YZUQbdHupA2RmucUBSzypcPwKBgSa4=sVQAhC+Vsw@mail.gmail.com>
 <61fbd71b-9c36-345c-7aed-561b81c34259@huawei.com> <CAHp75VdxaBG8Sj3j7Wa7BrZOrn1j2eAtJMw0N8z255HwMSohYw@mail.gmail.com>
 <df8c0a5d-e950-1726-5d30-80dcc8b20ff9@huawei.com>
In-Reply-To: <df8c0a5d-e950-1726-5d30-80dcc8b20ff9@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 4 Jul 2022 21:02:57 +0200
Message-ID: <CAJZ5v0hv7nm57QrCYX+aX=fVoE0s0BxEpJfz+a8bsPzzSZt7+g@mail.gmail.com>
Subject: Re: [PATCH v3] hisi_lpc: Use acpi_dev_for_each_child()
To:     John Garry <john.garry@huawei.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yang Yingliang <yangyingliang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Fri, Jul 1, 2022 at 2:18 PM John Garry <john.garry@huawei.com> wrote:
>
> On 01/07/2022 13:05, Andy Shevchenko wrote:
> > On Fri, Jul 1, 2022 at 1:54 PM John Garry <john.garry@huawei.com> wrote:
> >> On 01/07/2022 12:07, Andy Shevchenko wrote:
> >>> On Fri, Jul 1, 2022 at 1:06 PM Andy Shevchenko
> >>> <andy.shevchenko@gmail.com> wrote:
> >>>> On Fri, Jul 1, 2022 at 1:04 PM John Garry <john.garry@huawei.com> wrote:
> >>>>> On 30/06/2022 19:13, Rafael J. Wysocki wrote:
> >
> > ...
> >
> >>>>> However Yang Yingliang spotted a pre-existing bug in the ACPI probe and
> >>>>> sent a fix today (coincidence?):
> >>>>>
> >>>>> https://lore.kernel.org/lkml/20220701094352.2104998-1-yangyingliang@huawei.com/T/#u
> >>>>>
> >>>>> And they conflict. This code has been this way for years, so I just
> >>>>> suggest Yang Yingliang resends the fix on top off Rafael's change.
> >>>>
> >>>> Wondering if Yang can actually switch that to use
> >>>> platform_device_register_full().
> >>
> >> Maybe that would work and simplify things. Let me check it.
> >>
> >> BTW, when we originally upstreamed this driver there was some ACPI
> >> platform device registration code which you/we thought could be factored
> >> out later. I can't remember it. I was looking through lore but couldn't
> >> find it. I don't remember it being so important, though.
> >
> > My suggestion is definitely not for the fix itself, but as a follow up.
>

[cut]

> >>> And for the record, I think the Fixes even for very rare bug hits
> >>> should go first.
> >>
> >> ok, I have to admit that I was going to feel awkward asking Rafael to
> >> deal with this fix by having a v4 on top of it.
> >
> > I don't think it's a problem as long as we have an immutable branch /
> > tag with that patch. Another approach could be that Rafael can take it
> > as a precursor for his series and route via ACPI tree, but let's hear
> > what he thinks about this himself.
> >
>
> ok, fine.

I've applied the patch from Yang Yingliang and I thought it would be
OK to add your ACK to it based on the conversation so far (please let
me know if that's not the case).  Next, I've added my patch rebased on
top of it with the tags from you and Greg.

The result is on my bleeding-edge branch:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=bleeding-edge

and these are the commits in question

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=d674553009afc9b24cab2bbec71628609edbbb27
https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=54872fea6a5ac967ec2272aea525d1438ac6735a

Please let me know if you see any issues with them.

If not, I'll go ahead and move them to my linux-next branch.

Cheers!
