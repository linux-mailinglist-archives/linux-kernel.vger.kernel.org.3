Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B0D4BBD65
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbiBRQWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:22:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiBRQWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:22:06 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE72D3F880
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:21:48 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id 60so4519829uae.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MBFxmlsp+Ppol0M03sVOJPvD0cRtLe1wxV7SG8UW4lw=;
        b=MOS0ZKbjI8xl7ER0rzl/N7TIG//ZghuPB3+myCtK980sjjNtXfoG68cs7DQ3UmiurJ
         53FT/TZbLegmZ6S3INVntv8MYtcjmRCufuqBSeNGO4tBI/mAkEOicmpJju5Oe03jW8Q3
         IZ+mtwdUX19fa/ja86NtCvIPTxzgXmdOV5ZDF3iWcT0TIL8RySDfJ/Ra3IZqTG4ensmo
         6pU2bUhI8mOK3cmAcp/y//7nAQNcX2n94uC9SwYW/AUne1MkBgwDWqIzDt7EIEmn8IU0
         Hut28l0qhkrkAJCkwXqKGivrwsHPIICRZiVECgMaEzCvmpF7lllWCS7EihA5nEGZfIoQ
         vSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MBFxmlsp+Ppol0M03sVOJPvD0cRtLe1wxV7SG8UW4lw=;
        b=OXUK24VDx+g7wLYC85XkGNoLq1P1UzGW5q7FK0MVTj4zgef74djFjGCvU7ZaXWfQxD
         RNwHbcrfOcgeKyYUP6heiXcC7DNJPO5QAiRMErDiO5zMCt7DtuntQg+dPFstdWp5Q17f
         AAx48l6cd/7D2L/QRTsKsD0liXxGRNBvWk0iD59hJgpmw40kBSAOFHt7hRjmvCgyTkZn
         TE1PsxTRmGH2oZConHUa+fdHmd5DgvVUWpMqXmnhPbv/jtraWPvq1VwB6SDVUUWvP4wa
         +WoJCyJg5RJia4qeMcEjYjA5Be8/ZqLQ/ZF9hYxaoQF1DcOhriCwPt4XrRa8fdcK/+Gt
         Wi2g==
X-Gm-Message-State: AOAM533kVl/q1X8WwmSTY82JxH554Hj3uOxAI/H+7vrnrNyEeJCxML7Z
        e0FDA9pQuy7NDsWCjKIImIlBQ+FJhSFaFCfBSzNIwsx90riN+w==
X-Google-Smtp-Source: ABdhPJzAl3cdYfXDoi8IHapaMBToDE190zn9xog31chAYhWjAgGvCYxbQV9awiWUVLoK9PNPXBPYF9Eig5kuZXLh/Ok=
X-Received: by 2002:ab0:60b1:0:b0:341:543e:c388 with SMTP id
 f17-20020ab060b1000000b00341543ec388mr3270571uam.80.1645201307736; Fri, 18
 Feb 2022 08:21:47 -0800 (PST)
MIME-Version: 1.0
References: <Yg54nse5qNQO3sbW@zn.tnic> <20220218013209.2436006-1-juew@google.com>
 <Yg+2Hc78nfSRmh/j@zn.tnic> <CAPcxDJ4c3eGXTB9UPJmZ8dzyCNPW4Lv9s1QSeoCWq_LdNWTrJw@mail.gmail.com>
 <Yg/FyrvLWhZHB/UC@zn.tnic>
In-Reply-To: <Yg/FyrvLWhZHB/UC@zn.tnic>
From:   Jue Wang <juew@google.com>
Date:   Fri, 18 Feb 2022 08:21:36 -0800
Message-ID: <CAPcxDJ72dMOpbKXxyb__OeMaEyjYSPtsL_ubVsKOuRXefAQ3_w@mail.gmail.com>
Subject: Re: [PATCH v2] x86/mce: work around an erratum on fast string copy instructions.
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 8:14 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Feb 18, 2022 at 08:03:24AM -0800, Jue Wang wrote:
> > Since MSR_IA32_MISC_ENABLE is not a MCA register, I wonder if we want
> > to mix its read/write with the injected MCE code.
> >
> > I was a bit concerned about potential race with mce-inject and the
> > read/write to MSR_IA32_MISC_ENABLE.
>
> It won't inject anything:
>
>                 offset = msr_to_offset(msr);
>                 if (offset < 0)
>                         ret = 0;
>
Thanks.

My concern was that here returns 0 instead the value read from the msr.

Maybe this cannot happen?
>
> Besides, you need to use those routines due to EX_TYPE_{RD,WR}MSR_IN_MCE
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
