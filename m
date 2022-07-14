Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA9F5752AD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238088AbiGNQXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238530AbiGNQXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:23:12 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D0F62A54
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:23:11 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id os14so4356795ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C9JWDT2rInqljNrrv1A4QkeX//3wZrC9s/rrqP8RPI4=;
        b=biRrvXxpwxJsg3+tNigbVdTNTspvK5SFmAxHPGxSaHTa56J24DZO/02Fdvq0s+34QI
         6N2sOrpDkSdvEQ01xBHmR+jUu1oL6W2vDJwndF09RJVo8qCC61Eh1XAkDuY6cqcin0OT
         ERa+ird+RYIO+pgxmXAOERclc0TpWhsxC24VjahPXHvmTSHGmfRC5X5mCuZrL8PB6PmQ
         6bGm0Q4+mWMXl137FgwEguf4tjEqJqUXooX11nZoEtzsHHdkZDcyEjf7x1XGm6hL9XLc
         3PHsiJQWFhHaYOirXMCDiagXqzDCCG7hA0zp4x95QF2ulknZ/F+yH6ewuTVFj2kqcSYI
         qsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C9JWDT2rInqljNrrv1A4QkeX//3wZrC9s/rrqP8RPI4=;
        b=Vvwsl2inzdASKsdaKGj58hKJkVeRkbhw6zhEyyKCWn6jiLip6QZ2EoVTPKM8pP5rRo
         +KOzG4x37aJwZwqv6AU1qgiK5FBIVmS7R9D+BlxhSi11ByZCzx9uJjgupu2LjaFetz77
         z/8K4l/msVBArTNrk2dX+1DyNE+MeQvMQmf8760z67+uu0ScwUNU/c57DFVDbliJ3Bby
         wTc84rITYQXNMIS1/eXcRbdRHRXuu1s+b+BEjCGIevE+0ph6Ao9ezBT6sjplpjVxDS4K
         HFtAFZl/AA+IBO8zkgvjHsFqqQugDtO9h99DIo66dS2Z2l6W/u4MH7W7goRMz8c0vb/g
         TgGw==
X-Gm-Message-State: AJIora/vC+n80n4N7JgxGWHzdTsFDFcHvw7INeMlPwU3uhnvHMYcKtwn
        XUxxngdKpnfqAexG27S8Cp04RYRlMj9OXqE+Cm0=
X-Google-Smtp-Source: AGRyM1t74GFLvvlY6Ne1/+x525lGyIMtfiNeayrb0wUJl46pK3cNyFCQ2Dzx/PoE8UZlfBqmTxDLZxCUykhrGkPU+OY=
X-Received: by 2002:a17:907:1623:b0:72b:64e3:878a with SMTP id
 hb35-20020a170907162300b0072b64e3878amr9617982ejc.185.1657815789930; Thu, 14
 Jul 2022 09:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220411221536.283312-1-dmitry.osipenko@collabora.com>
 <a78343c8-2a6d-b223-4219-6b6b0a4fcb1f@arm.com> <CAK4VdL2hCEoshWZbCh5mkHuS6wYMiPFR3v4MWTnrEKM9zyv6Mw@mail.gmail.com>
 <ef88ec2c-77b5-fa0d-49d1-fdd2451713b7@collabora.com> <573fae0d-c9ab-98b0-c6f1-5b0d4e52dd01@amd.com>
 <a33ab7b9-738f-db91-f6ba-78a9641365e8@amd.com> <b05f9861-1966-72f5-132b-aebb4b6e0c6b@collabora.com>
 <107fe968-8311-0511-cc31-22feb994a6d7@collabora.com> <3e07a8d0-2cbc-8f3e-8f9f-5b73fb82028b@amd.com>
 <CADnq5_MMmeWkiMxjYfrG7pip8BEkbkRc8ADUDLEi++kRF76sqg@mail.gmail.com>
 <bff42c98-045d-2e5a-2cf9-eb563425375e@collabora.com> <6e0c7590-6ffb-162b-a98d-0a39333453f6@collabora.com>
 <4ca27cee-eda0-0a65-f972-c69cc3b3e53e@amd.com>
In-Reply-To: <4ca27cee-eda0-0a65-f972-c69cc3b3e53e@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jul 2022 12:22:58 -0400
Message-ID: <CADnq5_Mms=UbPc7D0-Z-HNUHfCHVWMO82NO+jh5Yg8DmkKwH3A@mail.gmail.com>
Subject: Re: [PATCH v1] drm/scheduler: Don't kill jobs in interrupt context
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Erico Nunes <nunes.erico@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Dmitry Osipenko <digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 10:14 AM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
>
> On 2022-07-14 05:57, Dmitry Osipenko wrote:
> > On 7/12/22 11:56, Dmitry Osipenko wrote:
> >> On 7/6/22 18:46, Alex Deucher wrote:
> >>> On Wed, Jul 6, 2022 at 9:49 AM Andrey Grodzovsky
> >>> <andrey.grodzovsky@amd.com> wrote:
> >>>> On 2022-07-06 03:07, Dmitry Osipenko wrote:
> >>>>
> >>>>> Hello Andrey,
> >>>>>
> >>>>> On 5/17/22 17:48, Dmitry Osipenko wrote:
> >>>>>> On 5/17/22 17:13, Andrey Grodzovsky wrote:
> >>>>>>> Done.
> >>>>>>>
> >>>>>>> Andrey
> >>>>>> Awesome, thank you!
> >>>>>>
> >>>>> Given that this drm-scheduler issue needs to be fixed in the 5.19-R=
C and
> >>>>> earlier, shouldn't it be in the drm-fixes and not in drm-next?
> >>>>
> >>>> I pushed it into drm-misc from where it got into drm-next. I don't h=
ave
> >>>> permission for drm-fixes.
> >>> The -fixes branch of drm-misc.
> >> Now I don't see the scheduler bugfix neither in the -fixes branch nor =
in
> >> the -next and today Dave sent out 5.19-rc7 pull request without the
> >> scheduler fix. Could anyone please check what is going on with the DRM
> >> patches? Thanks!
> >>
> >> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
thub.com%2Ffreedesktop%2Fdrm-misc%2Fcommits%2Fdrm-misc-fixes&amp;data=3D05%=
7C01%7Candrey.grodzovsky%40amd.com%7C68b627b8482a4fd28a5608da657f4375%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637933894551324163%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C3000%7C%7C%7C&amp;sdata=3DCDdLG%2F7SqCudEnjhBSsXqq15mfhlHlS3xAdAfB%2Bh%2F=
1s%3D&amp;reserved=3D0
> >> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fcg=
it.freedesktop.org%2Fdrm%2Fdrm-misc%2Flog%2F%3Fh%3Ddrm-misc-fixes&amp;data=
=3D05%7C01%7Candrey.grodzovsky%40amd.com%7C68b627b8482a4fd28a5608da657f4375=
%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637933894551324163%7CUnknown%=
7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M=
n0%3D%7C3000%7C%7C%7C&amp;sdata=3D4Vz40j6F%2FzHYckXEyPEunj9DRSoTXikhNxZDXeo=
cTss%3D&amp;reserved=3D0
> > The patch is in the drm-misc-next-fixes, so it wasn't moved to the
> > drm-misc-fixes.
> >
> > Andrey, don't you have access to drm-misc-fixes? Or you meant
> > drm-fixes=3Ddrm-misc-fixes?
>
>
> I have only accesses to drm-misc-next to which I pushed this patch.

anyone with drm-misc rights can commit to any of the branches in the
drm-misc tree.  You just need to check out and push the appropriate
branch.  then push the changes.  E.g.,
dim push-branch drm-misc-next
vs
dim push-branch drm-misc-next-fixes
etc.

Alex


>
> Andrey
>
>
> >
