Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30244B1677
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 20:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344054AbiBJTjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 14:39:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344029AbiBJTjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:39:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7233AD66;
        Thu, 10 Feb 2022 11:39:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE666616E2;
        Thu, 10 Feb 2022 19:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57062C340EB;
        Thu, 10 Feb 2022 19:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644521992;
        bh=MCUDen9JpjaHMTO+n5Axj6eiZjr+zQPk9bws+uU+69Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HjXOiKox0wwCaPR2wv0irMDL0H0Us/wf6AV/YuSoDS8lzy0zZIpWGJFvFIX+wKjtM
         HVmKq7RgF3JVeJRGs+lccEOwkes2a/p8G6Mvd9b2HX7nCTRbjmoEVfLysAdlsu7pmZ
         8BQwUlkzf8Le67ibq13z+mnZlCCJWyvAvPrAjwZEpVWE9RtNPtW1l8Sot5R0DcfxRg
         HFwl4+dtIUWzWIihTR8a8RdUj3UQzir6Juk37lxAjYlIehR/S/dBj5fdaH9utrXCa5
         3tJsWqMM9CJOCOulRAveDvES/0xxbaeY0wh7EowHRFILpP8YqIc4SwvX7QQRUn1ErN
         8yH+hv0tFydYQ==
Received: by mail-wr1-f44.google.com with SMTP id d27so11427082wrc.6;
        Thu, 10 Feb 2022 11:39:52 -0800 (PST)
X-Gm-Message-State: AOAM532bhQflBHkylT2oQVrDHTP1OwIhmR/Fbo2i0zlM5hD35Jyr75cK
        IxUVtTe6pedDHMFAkVCiEt49SyVma2FsqXPxhck=
X-Google-Smtp-Source: ABdhPJzIKBGn716Jf5wrnSPKmGJBTIEDU5Bd+hcsjB5zjAZXRB3tl2GMiQl/03+e08V2BD2Wny9gIUKbX44gKP81ikA=
X-Received: by 2002:adf:9123:: with SMTP id j32mr7507533wrj.189.1644521990682;
 Thu, 10 Feb 2022 11:39:50 -0800 (PST)
MIME-Version: 1.0
References: <1644453141-1181-1-git-send-email-victor.erminpour@oracle.com>
 <CAMj1kXHUOJ-3CXFUJ9ULQuSoRh1=d3PJ15eFUsdGjQtUHozSpA@mail.gmail.com>
 <da35c076-52e3-293b-fd36-f4572e369e51@oracle.com> <CAMj1kXG49gt9OpYNDBh+LVSNyAzj71VC8Cb0S=ApcET+Ja7h5Q@mail.gmail.com>
In-Reply-To: <CAMj1kXG49gt9OpYNDBh+LVSNyAzj71VC8Cb0S=ApcET+Ja7h5Q@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 10 Feb 2022 20:39:39 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGh_qbZQ+L5syVs8C9Vsf=x5xMr=j-r=8Ep7PuwR0nqEA@mail.gmail.com>
Message-ID: <CAMj1kXGh_qbZQ+L5syVs8C9Vsf=x5xMr=j-r=8Ep7PuwR0nqEA@mail.gmail.com>
Subject: Re: [PATCH] ACPI/IORT: Fix GCC 12 warning
To:     Victor Erminpour <victor.erminpour@oracle.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        trivial@kernel.org, Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2022 at 20:29, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> (cc Kees)
>

... for real this time :-)

> On Thu, 10 Feb 2022 at 18:36, Victor Erminpour
> <victor.erminpour@oracle.com> wrote:
> >
> >
> > On 2/10/22 1:11 AM, Ard Biesheuvel wrote:
> > > On Thu, 10 Feb 2022 at 01:34, Victor Erminpour
> > > <victor.erminpour@oracle.com> wrote:
> > >> When building with automatic stack variable initialization, GCC 12
> > >> complains about variables defined outside of switch case statements.
> > >> Move the variable into the case that uses it, which silences the warning:
> > >>
> > >> ./drivers/acpi/arm64/iort.c:1670:59: error: statement will never be executed [-Werror=switch-unreachable]
> > >>    1670 |                         struct acpi_iort_named_component *ncomp;
> > >>         |                                                           ^~~~~
> > >>
> > >> Signed-off-by: Victor Erminpour <victor.erminpour@oracle.com>
> > > GCC 12 is not released yet, and this is clearly a compiler bug (a
> > > declaration is not a statement, and the hidden offending statement
> > > [the zero-init] is emitted by the compiler itself), so please report
> > > this to the GCC folks instead.
> >
> > Hi Ard,
> >
> > Thanks for the reply.
> > This fix is similar to the following commits that have been integrated
> > upstream:
> > https://lore.kernel.org/linux-hardening/20211209043456.1377875-1-keescook@chromium.org/
> > https://lore.kernel.org/linux-hardening/20211209043915.1378393-1-keescook@chromium.org/
> >
>
> If GCC 12 rejects valid C with this feature enabled, the compiler is
> broken and needs to be fixed. Papering over this by making changes to
> perfectly valid C code is a slippery slope that we should avoid.
>
> Since GCC 12 is not released yet, there is time to get this fixed properly.
>
> > You're not obligated to integrate this commit,
>
> Why, thank you :-)
>
> > but you may run into this
> > issue once
> > upstream starts using GCC 12 (or a patched version of GCC 11 in my case)
> > with the
> > CONFIG_INIT_STACK_ALL_ZERO option enabled.
> >
>
> Yes, that part was perfectly clear.
