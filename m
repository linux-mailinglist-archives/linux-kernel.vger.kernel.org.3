Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860EB525E37
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378717AbiEMI6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243338AbiEMI63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:58:29 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6769D104C90
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:58:28 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id m25so9424735oih.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NpSINpDETSbqQ8kuCYB8/3th0pcSa+77c/avszgXaYU=;
        b=oVgumAXJ+VQc7CQO3qYv73vAoQnhh0vFgw3BxSBiCr2EYIifreB+9BrI6ZNmnhIKBx
         92Uc0Gpwu1ET19ShHNwi4x3AsOWl3s7NSQILJ0J+IdAnhwortPYFAoDGWIRmg+5GxQHw
         2xxGUqcIotThN96zCVpp7grCwO6X/NIohPfQZEYmiX21UMcniP4hAHvp/fEubjP1cfh/
         cEEmCGT4ja2naAQGleImvN0huyjfCQlzr2P1MYg8bRfn95MALtdvPMIOB+AJGoqCgL/5
         Rd6mUvUB7QhIyHuZHfBebJqxyN7wksjrjF02Ah/+0OZQWJlSi1wyYqvQqtHkJ//4fAdb
         lFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NpSINpDETSbqQ8kuCYB8/3th0pcSa+77c/avszgXaYU=;
        b=Kd5sXqPJS3wj6ZRNSaMhcAYXuhFWAp5kQpZfsb38gyOk3TADq961WWGJ18cesXjRss
         0cFp0KvNeXL6yR0t90229wHwqqqeqhllhZdrKAelvB4duPR3oM69qnl4jQWCgLLr5Xvk
         O3QpVmEq+Ipmpt23Lkt92vTrXgh+jITMmE40JFFviXqgbrrAR5L/cnF60g5GyfhzcOVN
         yU7fZi1Owi9ESaJovOq0hgqQs39bCIdd75JToGBE3uO5htpd8O0pHNdtX3hl4nED5uSO
         wk2MWzgLhiwfMN+hS2Yn2rx8WWUs3Hke5TatOytlNIjxmeIRCVtQvtqKzprANQnIFK4G
         0zNw==
X-Gm-Message-State: AOAM533Q4+74mNbKMLuJ8R0gVHhHxwq9cx77N5IcLzKpbBd+Fc8QgQrw
        PaaJmiFuyzW2/8MYHR2mkB7ilZ89I265exwIwQ2X7C9Yz6F5lHyc
X-Google-Smtp-Source: ABdhPJwiCK0EUi1xGHK6lBz/6ilajF8YcQlrhGJneXXIEE1Iymq3Olk69LvLfn6/mYieWW2CC7eBLTUy7riubBnnF+U=
X-Received: by 2002:a05:6808:114d:b0:328:aaa2:10c9 with SMTP id
 u13-20020a056808114d00b00328aaa210c9mr1828896oiu.217.1652432307735; Fri, 13
 May 2022 01:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <1698297.NAKyZzlH2u@archbook> <YnOEwuuyO2/h7c1G@e120937-lin>
 <CAN5uoS_MgBiTVZCRSZyYCH4cnUZD_bHj2+mZu661bFV8TKWScw@mail.gmail.com>
 <6587375.6lpfYT6tjA@archbook> <Yn0a9nSD7Yu6aOkt@bogus>
In-Reply-To: <Yn0a9nSD7Yu6aOkt@bogus>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Fri, 13 May 2022 10:58:17 +0200
Message-ID: <CAN5uoS8KXJZS52eys-ko0e_UpQCwiTvg42h-hJ3=ZAbvit99Qg@mail.gmail.com>
Subject: Re: [BUG] New arm scmi check in linux-next causing rk3568 not to boot
 due to firmware bug
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>, linux-kernel@vger.kernel.org,
        Kever Yang <kever.yang@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

On Thu, 12 May 2022 at 16:34, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, May 12, 2022 at 01:11:22PM +0200, Nicolas Frattaroli wrote:
> > Hello,
> >
> > sorry for the late reply, completely missed that there was a question
> > for me in this mail.
> >
> > On Donnerstag, 5. Mai 2022 11:40:09 CEST Etienne Carriere wrote:
> > > Hello Nicolas, Cristian,
> > > [...]
> > >
> > > Indeed the firmware implementation is wrong in TF-A.
> > > And also in OP-TEE by the way:
> > > https://github.com/OP-TEE/optee_os/blob/3.17.0/core/drivers/scmi-msg/base.c#L163-L166
> > >
> > > @Nicoals, do you want to send a patch to TF-A, or do you want me to do it?
> >
> > I have no experience with TF-A, so I'd prefer if you could do it.
> >
> > In good news, Rockchip has confirmed they're preparing to release RK356x
> > TF-A sources, so I'll be able to port the patch over to their sources once
> > they are released, if they don't already apply it themselves.
> >
>
> So, there is no way to get a blob release with the patch applied ?
> We know it is a bug in TF-A and if Rockchip is using that codebase, it
> will be the same bug there too causing this issue. Waiting until the
> code is released and the proper TF-A port is done may not be acceptable
> for many developers. So someone from the rockchip doing these tf-a blob
> release must get involved here, understand the situation and get the fixed.
>
> We can workaround, but I want to hear that it will be fixed instead of
> getting ignored until proper port is available.
>
> Etienne, are you not the author for the related TF-A code ? How can we
> get that fixed in the TF-A code base. If you are not, then I will try to
> get my repo login credentials sorted so that I can only push TF-A change.

Yes, I'm the author of the code.
I have created a gerrit change in TF-A to fix the issue:
https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/15196

OP-TEE implementation also embeds the same scmi-msg drivers and have
the same issue.
I should be fixed by P-R: https://github.com/OP-TEE/optee_os/pull/5334
I will ask TF-A if this specific change can hit TF-A release v2.7 tag,
if posisble.

Feedbacks are welcome on these 2 forums.

Regards,
etienne


>
> --
> Regards,
> Sudeep
