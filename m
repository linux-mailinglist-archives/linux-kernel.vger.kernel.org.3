Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749C74AE88B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 05:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348186AbiBIEOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 23:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347340AbiBIDmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:42:11 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B2DC06174F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:42:09 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 192so2293333ybd.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 19:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CnPuieAA45R+Cn7cQOpi068J2AYd/JgSUtDlGNknSQI=;
        b=AZnwjfRshXyPzqPIPPOZIBwXE2OBB4TSrGQFToT0R0Wu4pzLEYJsDVs4oqb2JDdI2b
         NeQPh3dKpSqjUmhkIiEdUcdC2WLGHHYULSJfRHoCj+J0nyHK9KzthFi386KJOowopwvZ
         00fFIXDuuJiUp0TZD2Sdh8n1KE2SAwXh0+i+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CnPuieAA45R+Cn7cQOpi068J2AYd/JgSUtDlGNknSQI=;
        b=fyITL1FeE9d0wA4JNgwXhKxFBjUjMeTnP4jIqlqIVRgoU6to6E2ruB9qUbUbdY+EsZ
         VQsAvWJ1DbsI2vw3j7f0ZaP+6rVq67G3sybVPwjZkUwrcLTDgrIqeyBsukFPU/6qAuaW
         DuHMaqbSAQ04kUaepCIYGyx6lUvWnGLohzm1foNRJXGlxYEriJ9Qc7YwqT4Ru1iElt9K
         TFS0nc2LYOD7pm89Di6fgK2+VSFIahsd7bl23SYzURpk2t+lUoohYqSG6cvwxPDBY6oh
         A2CbQRbYHuyhw2J+W/OngepwB8++Iecn3Grovpj4Rp110lnGFhtMEig3rE8Dv0TSheLS
         YLig==
X-Gm-Message-State: AOAM530mSRDZikN/te8epHNBMjiCft5UXEjMUfjy/s4DO+G2U/AbCJge
        7NWO2uaMXQh4PZLrbXw2sh0TCUwf7toS8L0tqWDiJw==
X-Google-Smtp-Source: ABdhPJy4AuPuBilZB61l9fPeAtLlFGVf2W2h4Ha6zFYFfX08a8Ah4rVomwclUlKHdtLJRVjmPUVCKLciLbTpFwKoUPo=
X-Received: by 2002:a81:34d7:: with SMTP id b206mr290747ywa.489.1644378128857;
 Tue, 08 Feb 2022 19:42:08 -0800 (PST)
MIME-Version: 1.0
References: <20220207214026.1526151-1-pmalani@chromium.org>
 <20220207214026.1526151-4-pmalani@chromium.org> <YgIBv2SQdwXm7RLt@google.com>
 <CACeCKaezRNgsqrq3QJ1ViHjYScFrjpC-kCaYmE8kOXCcW9MRrw@mail.gmail.com>
 <YgJQ30D8nc4LWvUy@google.com> <CACeCKaf4+jxSkKFqx9g3YSPWj-FkbL=jrmHE3YEu7oU0ySPJ4Q@mail.gmail.com>
 <CACeCKadujMj4pJqf_jNNmO4UkQinw9QNu_MXe5zkTySUn6R=dw@mail.gmail.com> <YgM1pjwN2MHaMQCJ@google.com>
In-Reply-To: <YgM1pjwN2MHaMQCJ@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 8 Feb 2022 19:41:58 -0800
Message-ID: <CACeCKafm3o2Ht3F0njQZ+JptDM=yZMpi0qUS=DR07LiCC_O4Ww@mail.gmail.com>
Subject: Re: [PATCH 3/4] platform/chrome: cros_ec_typec: Configure muxes at
 start of port update
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROMEOS EC USB TYPE-C DRIVER" 
        <chrome-platform@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 8, 2022 at 7:31 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Tue, Feb 08, 2022 at 02:58:51PM -0800, Prashant Malani wrote:
> > On Tue, Feb 8, 2022 at 10:35 AM Prashant Malani <pmalani@chromium.org> wrote:
> > > In general, I think you may benefit from reading:
> > > - The entire cros_ec_typec driver
> > > - The EC Type C state machine [2] and interfaces [3][4]
> > >
> > > The above 2 will help understand how this entire stack works. Without
> > > it, it is challenging
> > > to process the flow (just from code review).
> > >
> > > If you have further questions our would like to better understand the
> > > drivers, feel free to reach
> > > out to me over IM/email. I don't think public list code review is the
> > > best option for this
> > > sort of explanation.
> > >
> > > [1] https://elixir.bootlin.com/linux/latest/source/drivers/platform/chrome/cros_ec_typec.c#L549
> > > [2] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/common/usbc/
> > > [3] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/driver/usb_mux/usb_mux.c
> > > [4] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/common/usb_pd_host_cmd.c
>
> Thanks for the link pointers.  It would take me some time to understand the
> background for reviewing the patch though.
>
> But in general, I would suggest to change the title for a stronger signal
> that it fixes something (per [1]).  Otherwise, the title and the description
> in cover letter looks like a move refactor.

I'm hesitant to use the term "fix" in the title; IMO the commit
message describes the potential race involved.
Since it is an unlikely edge case, brought about by limitations in how
the EC updates its state,
I'd like to avoid assigning it a "Fixes" label  too.

I can perhaps add some info to the cover letter, but I don't think
that alone is worth a v3.
I'll let this series hang for a few days; if there are other comments
which necessitate a respin, I'll
reword the cover letter.

-Prashant

>
> [1]: https://patchwork.kernel.org/project/chrome-platform/patch/20220207214026.1526151-4-pmalani@chromium.org/#24727676
