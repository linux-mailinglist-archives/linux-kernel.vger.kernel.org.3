Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08D44C955A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbiCAUEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiCAUEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:04:07 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D74B5F25F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:03:26 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id c9so14394911pll.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 12:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fSMui3hb8vcTDMe5kaPLIXg5UWvv+kUKTIPpRbR8NwY=;
        b=n8wjHVOWwurhgpdgv7LpXZyaTnkSbmFtSp5Ig+Nn/e1LDHrYCKBt5DR1D/2AmsLz2h
         YQK2zK/WutUGij2Ru5R3SNjZSgQGgfX0IZhNaK7ULjYy70WT2eKCrSnC+MJSmZqlwOVk
         b0UlcZ7p5Rwj6ehsI7gtY4LRh8wpYPVGgTsc6hsx6ZBw5rkAYBEkP8RCJnUdZolyCH+j
         xyxlNMdQT/kVzSyo8K0uo1Eh1ZYj8JKx4G+96x4ttCgNS2MEo13yK39WJU9qRPE2t9c9
         yaG/e4t7WaEuRsMc0jJXkgpdVKywf0lxIQnH0LngUyxRCOBUMYi6HhTb+YpkgLfnrxHY
         V6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fSMui3hb8vcTDMe5kaPLIXg5UWvv+kUKTIPpRbR8NwY=;
        b=QRior09y0/WWONnDbCoj5BCiOzVmZNGfClcSeoRWvJMQb5N6/1EmHRCmqQTzZxisdM
         27nEgkAYcUXMRAZujv0eRnf2FVF532THVwRcoSkfDPYiRVZF/oqtXO/phi6kb0RculC7
         6WF+79HamLI2KPkQoJ0eH+iWF5myNQTEidyJM0supvDKBeaO5wrSk2EBtcN7AZtgCkeE
         fHVIpNZKgAteowWPuoMlapLXVOlst/1DgHjtRqZzuOff60EJAM+ZKg4ru9qECpW5/gMR
         czpoap92X2UP617+6s4ceYCDDeRmU+b2o19ejes8RWjN7lwNMDc6sYaWxbcZueEPgYIa
         DQuw==
X-Gm-Message-State: AOAM530KvlHe+R0Hoqh83y1TtSKunNE1gjCufXY393aVKkJA+R9T3UwS
        acjREXpdgVvDt4PAngaMqXvE35s2sss0zeb9YK9lMQ==
X-Google-Smtp-Source: ABdhPJyre94rPDWXttSaBX95VPuuVGyfvgxrpPugorBDjc0/0U0mWLmGUjdWT9l8QfMRcfE4Ef/A532YkCfcN2A4Wi4=
X-Received: by 2002:a17:902:ec88:b0:14f:de5b:2fbe with SMTP id
 x8-20020a170902ec8800b0014fde5b2fbemr27266532plg.123.1646165005203; Tue, 01
 Mar 2022 12:03:25 -0800 (PST)
MIME-Version: 1.0
References: <20210805043503.20252-1-bvanassche@acm.org> <20210805043503.20252-4-bvanassche@acm.org>
 <20210809145953.GB21234@lst.de> <bcf5fd83-b30a-8887-361e-603821562d9a@acm.org>
 <20210810165029.GA20722@lst.de> <9b1e5c35-1d11-0afa-d382-6f5dc0b14a23@acm.org>
 <e329b0a1-ffe4-9bfa-2bea-33e17da70f58@linuxfoundation.org> <CAFd5g45hMt9OwAVDVuxLNa2EfkTH0tY=KS_qxoUmndPYDvnyig@mail.gmail.com>
In-Reply-To: <CAFd5g45hMt9OwAVDVuxLNa2EfkTH0tY=KS_qxoUmndPYDvnyig@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 1 Mar 2022 15:03:14 -0500
Message-ID: <CAFd5g44vkQ1jiKa1YQ2g8ByHMOiA0rFGS1nRuYk-Dunr-aFHyA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] configfs: Add unit tests
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Yanko Kaneti <yaneti@declera.com>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 5:00 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Tue, Aug 10, 2021 at 1:50 PM Shuah Khan <skhan@linuxfoundation.org> wr=
ote:
> >
> > On 8/10/21 12:45 PM, Bart Van Assche wrote:
> > > On 8/10/21 9:50 AM, Christoph Hellwig wrote:
> > >> On Mon, Aug 09, 2021 at 11:31:23AM -0700, Bart Van Assche wrote:
> > >>>>> +config CONFIGFS_KUNIT_TEST
> > >>>>> +    bool "Configfs Kunit test" if !KUNIT_ALL_TESTS
> > >>>>> +    depends on CONFIGFS_FS && KUNIT=3Dy
> > >>>>> +    default KUNIT_ALL_TESTS
> > >>>>
> > >>>> Why does it depend on KUNIT=3Dy?  What is the issue with a modular=
 KUNIT
> > >>>> build?
> > >>>
> > >>> The unit tests calls do_mount(). do_mount() has not been exported a=
nd
> > >>> hence is not available to kernel modules. Hence the exclusion of KU=
NIT=3Dm.
> > >>
> > >> You should probably document that.  But then again this is another
> > >> big red flag that this code should live in userspace.
> > >>
> > >>>> To me this sounds like userspace would be a better place for these
> > >>>> kinds of tests.
> > >>>
> > >>> Splitting the code that can only be run from inside the kernel (cre=
ation
> > >>> of configfs attributes) and the code that can be run from user spac=
e and
> > >>> making sure that the two run in a coordinated fashion would involve=
 a
> > >>> significant amount of work. I prefer to keep the current approach.
> > >>
> > >> But userspace is the right place to do this kind of pathname
> > >> based file system I/O.
> > >
> > > Shuah, as selftest maintainer, can you recommend an approach? How abo=
ut splitting patch 3/3 from this series into a kernel module (the code that=
 creates the configfs test attributes) and user space code (the code that r=
eads and writes the configfs attributes) and adding the user space code in =
a subdirectory of tools/testing/selftests/?
> > >
> >
> > I am missing a lot of context here. I don't see this series in my inbox
> > except patch 2/3 which says:
> >
> > "A common feature of unit testing frameworks is support for sharing a t=
est
> > configuration across multiple unit tests. Add this functionality to the
> > KUnit framework. This functionality will be used in the next patch in t=
his
> > series."
>
> Yeah, I mentioned this to one of the other KUnit people who said he
> might want to post some comments. Bart, could you CC
> kunit-dev@googlegroups.com and/or linux-kselftest@vger.kernel.org
> if/when you send follow-up patches?
>
> Actually, I suppose regardless of what you do with this patch, you
> will probably want to merge via the kselftest tree (KUnit changes and
> many tests go through the kselftest tree as well). So, you should
> probably CC linux-kselftest@vger.kernel.org no matter what.
>
> > That doesn't tell me much other than what happens that it is a common u=
nit
> > testing framework without explaining why it should be done this way.
> >
> > Taking a quick look at the original message on lore - I agree with Chri=
stoph
> > that this code belongs in userspace. I would like to see the division o=
f
> > kernel userspace.
> >
> > Why do the unit tests need to call do_mount() - can whatever the unit t=
ests
> > are currently doing can be done from userspace.
> >
> > If part of the test code must live in kernel space then kernel test mod=
ule
> > approach can be used.

I am not sure if you are still working on this test or not, but Kees
recently posted a patch to create a KUnit UAPI:
https://lore.kernel.org/lkml/20220227184517.504931-8-keescook@chromium.org/

Not sure if you have any interest, or even if this would be the right
tool for the job, but I figured it's worth a look because it might
save you the effort of having to completely rewrite your test.

Cheers
