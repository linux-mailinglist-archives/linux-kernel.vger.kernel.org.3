Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0794B1653
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 20:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344016AbiBJT3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 14:29:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241448AbiBJT32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:29:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB89BD62;
        Thu, 10 Feb 2022 11:29:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92DD0B8272A;
        Thu, 10 Feb 2022 19:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33503C340F1;
        Thu, 10 Feb 2022 19:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644521366;
        bh=KsJk+ps9W2hgAdwcaKMeGyDBTMYmji5RSjy28va9Oi4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MNB9qls7slFwlX6Q4IqR9XasLSWt5g1EEqHQqYRhYn/M9DvWCy/BGgMvVYlEbrE8z
         rbodVNPPsW623dL2IxQ2ipqwIunjutpmVh5LYTwVb0JukV0cywpmaV7L/i+NPD4Gyg
         VvpZ+dZrehYnjzZH70sN9rmcQpEmW0V0vJ1TfiwsJKhv7IbT5JpCN7CdNcNKORVF5I
         hMD2sUgOi61mugwawgLB7PwF8bCPARMLYNwbzQRf6LmGD/uLtJeSx3BAMkCC6RId7C
         BEkHpD0rLVqKm1df1+g9ux4X+pqjYgPom2dGGiRmbsvdgqY/WRo7bEdNhDjicxCCPn
         kjoBSRREmIoCg==
Received: by mail-wm1-f53.google.com with SMTP id x3-20020a05600c21c300b0037c01ad715bso1624900wmj.2;
        Thu, 10 Feb 2022 11:29:26 -0800 (PST)
X-Gm-Message-State: AOAM5337wa2Gtj5xF9ky7L5a84HaOg/VEJC3Wj1PAmL2btYshp/cRnXA
        LUXYQ075XDOFG5a5c8HSwr8MmTRzzvyAaEvVAb0=
X-Google-Smtp-Source: ABdhPJzifnR8wgjLijNCUU+WTqkH+Pl5c71QzTLevS//VLKboxczL2amoUPQo/C5QVahdSqfK1GsIPJwLsSmotFUuJ4=
X-Received: by 2002:a7b:c5d1:: with SMTP id n17mr3429440wmk.32.1644521364469;
 Thu, 10 Feb 2022 11:29:24 -0800 (PST)
MIME-Version: 1.0
References: <1644453141-1181-1-git-send-email-victor.erminpour@oracle.com>
 <CAMj1kXHUOJ-3CXFUJ9ULQuSoRh1=d3PJ15eFUsdGjQtUHozSpA@mail.gmail.com> <da35c076-52e3-293b-fd36-f4572e369e51@oracle.com>
In-Reply-To: <da35c076-52e3-293b-fd36-f4572e369e51@oracle.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 10 Feb 2022 20:29:12 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG49gt9OpYNDBh+LVSNyAzj71VC8Cb0S=ApcET+Ja7h5Q@mail.gmail.com>
Message-ID: <CAMj1kXG49gt9OpYNDBh+LVSNyAzj71VC8Cb0S=ApcET+Ja7h5Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI/IORT: Fix GCC 12 warning
To:     Victor Erminpour <victor.erminpour@oracle.com>
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

(cc Kees)

On Thu, 10 Feb 2022 at 18:36, Victor Erminpour
<victor.erminpour@oracle.com> wrote:
>
>
> On 2/10/22 1:11 AM, Ard Biesheuvel wrote:
> > On Thu, 10 Feb 2022 at 01:34, Victor Erminpour
> > <victor.erminpour@oracle.com> wrote:
> >> When building with automatic stack variable initialization, GCC 12
> >> complains about variables defined outside of switch case statements.
> >> Move the variable into the case that uses it, which silences the warning:
> >>
> >> ./drivers/acpi/arm64/iort.c:1670:59: error: statement will never be executed [-Werror=switch-unreachable]
> >>    1670 |                         struct acpi_iort_named_component *ncomp;
> >>         |                                                           ^~~~~
> >>
> >> Signed-off-by: Victor Erminpour <victor.erminpour@oracle.com>
> > GCC 12 is not released yet, and this is clearly a compiler bug (a
> > declaration is not a statement, and the hidden offending statement
> > [the zero-init] is emitted by the compiler itself), so please report
> > this to the GCC folks instead.
>
> Hi Ard,
>
> Thanks for the reply.
> This fix is similar to the following commits that have been integrated
> upstream:
> https://lore.kernel.org/linux-hardening/20211209043456.1377875-1-keescook@chromium.org/
> https://lore.kernel.org/linux-hardening/20211209043915.1378393-1-keescook@chromium.org/
>

If GCC 12 rejects valid C with this feature enabled, the compiler is
broken and needs to be fixed. Papering over this by making changes to
perfectly valid C code is a slippery slope that we should avoid.

Since GCC 12 is not released yet, there is time to get this fixed properly.

> You're not obligated to integrate this commit,

Why, thank you :-)

> but you may run into this
> issue once
> upstream starts using GCC 12 (or a patched version of GCC 11 in my case)
> with the
> CONFIG_INIT_STACK_ALL_ZERO option enabled.
>

Yes, that part was perfectly clear.
