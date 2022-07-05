Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EC05672C1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiGEPfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiGEPe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:34:58 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD821165B4;
        Tue,  5 Jul 2022 08:34:57 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id e80so15232083ybb.4;
        Tue, 05 Jul 2022 08:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05H09XnT3WZbiSMH9r/MVR5bDYs6xgTwQVYFnBFoc7g=;
        b=s1/+YjlzLriaP4I5SETHiRZBMX7ZE8Qh8LGluD4fi/cNapHYeggPPbzu6npp/34oBI
         OlkachEKTOc2q3jyPLq282W+zS4IiTlCRVnqrO+tV7nbLEosBwrH0ffAWp9RCH11g6mg
         N1J3OpyRhCkmF10UmYEM09GsM6KQsiBFJiZcdvaj2/OiBgr0yO139tKUzuBiKbecAelG
         O2BwDnxzuoZF23DBDzm9t/Bs3B/9AaziSz9c8tJoo8SUpTsW4t3huRCmOp85VX00w+fT
         j1d2sm7gTp2DxHbIzQrG2Q0/YZHk8l+ZoPNW55AnuAj/q4Zk94iyLhTnmiz9sgxyq1Vs
         k01g==
X-Gm-Message-State: AJIora+Wk/zzw29NyXD+lKYanM1d6Afqv+MsKBlKebTvSL4JsxD8Ub11
        NzRc/IJbueGtR+KNgr5hln/WOjJq85cf1lnfvdncwZ1A
X-Google-Smtp-Source: AGRyM1tuDF+EANxQ0ZkrD6kGUfMTAnQ/+/Wd9MeSdNYjtrpy0WML0J8pXHRBHLcy03+z5VKBSPTcaRc98Eh2+qJ/rhE=
X-Received: by 2002:a25:6b50:0:b0:64f:4b33:664 with SMTP id
 o16-20020a256b50000000b0064f4b330664mr40085416ybm.153.1657035297103; Tue, 05
 Jul 2022 08:34:57 -0700 (PDT)
MIME-Version: 1.0
References: <12026357.O9o76ZdvQC@kreacher> <2657553.mvXUDI8C0e@kreacher>
 <5606189.DvuYhMxLoT@kreacher> <e9666883-3285-36a6-6278-ace219b88f3c@huawei.com>
 <CAHp75Ve-Cm43HhqqxxfmKTbC_Gkx=0aAcj0jJmA=-Nr-NT1FqQ@mail.gmail.com>
 <CAHp75VdT1YZUQbdHupA2RmucUBSzypcPwKBgSa4=sVQAhC+Vsw@mail.gmail.com>
 <61fbd71b-9c36-345c-7aed-561b81c34259@huawei.com> <CAHp75VdxaBG8Sj3j7Wa7BrZOrn1j2eAtJMw0N8z255HwMSohYw@mail.gmail.com>
 <df8c0a5d-e950-1726-5d30-80dcc8b20ff9@huawei.com> <CAJZ5v0hv7nm57QrCYX+aX=fVoE0s0BxEpJfz+a8bsPzzSZt7+g@mail.gmail.com>
 <71dfc3cd-c2ae-8096-9280-67e77c21055e@huawei.com> <CAHp75VfqJwF4YypH3QE0MRgZAyjEMKche-4czUuiC=aTYoYwig@mail.gmail.com>
 <CAHp75VfpQfBYD-AmVhbxm4tp_1EVv8xqCChYpuuRKOC=P_Y_og@mail.gmail.com>
 <050e5a2f-42b9-f851-ec6e-e2a9d3fdbe1c@huawei.com> <CAJZ5v0j++HZJfL2+0uWgDRqVeZPviaZSWyL3Yn7T2Ky=bcRQMQ@mail.gmail.com>
 <752f92ba-4957-545c-51f7-7e71648d92e4@huawei.com>
In-Reply-To: <752f92ba-4957-545c-51f7-7e71648d92e4@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Jul 2022 17:34:46 +0200
Message-ID: <CAJZ5v0hkiOqhWyOcd2vjj-tcyHWB-cK=Dae-3sifhRfcbKWWGg@mail.gmail.com>
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

On Tue, Jul 5, 2022 at 5:17 PM John Garry <john.garry@huawei.com> wrote:
>
> > Next, I'd look at introducing something like
> >
> > acpi_create_platform_device_ops(struct acpi_device *adev, const struct
> > property_entry *properties, const struct *platform_device_create_ops
> > *ops);
> >
> > where ops would be a set of callbacks to invoke as a matter of customization.
> >
> > Then, acpi_create_platform_device() can be defined as a wrapper around
> > the above.
> > .
>
> ok, that seems easiest. But alternatively do you see any scope to have
> that platform_device_create_ops * ops in the acpi_device struct (so that
> we don't need to create this new API)?

Well, ops and struct acpi_device have different life cycles (the
former is only needed at the init time whereas the latter lives as
long as the platform device based on it), so I'd rather keep them
separate.
