Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111704C2CEF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbiBXNZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiBXNZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:25:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF35415B3FE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 05:25:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8843EB81878
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 13:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9F4C340E9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 13:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645709103;
        bh=ihjEiojCSnV1LMhef37aTx3cvfAPGiS34FZwfhOGMmY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PJQpJ3pGkNV5FuwLSZ7sXXp0Vq6aWy0xOGuUo9eNI9S2WIqnI5TIKpnKSRJLZYCwc
         jE1TwXKunTy7g1uxXIqIHBABb+WsNbzgTs0v/Cl/ORn2RsUqV/J9WVZmKxjqMJwKyq
         6/6/O+iQTYtozeIA3zBEziQw0xEuo4iMIkgCGY9D3v7NFzdhypwRcd1UhNVczM5xQl
         GRO+SnsPvzHF/b1KoS0ih2e2lQXGOGpb9Sman+2N+aW2ChcOnxFOvtv74k+swy4PQx
         624yCqhEEgNfc0MxjArPovXxeOdLL8QlddRePUSWDvxPI9bgjKMIn9lJITf57e8VG+
         pB+R9gtnH5JDg==
Received: by mail-ed1-f47.google.com with SMTP id i11so2797654eda.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 05:25:03 -0800 (PST)
X-Gm-Message-State: AOAM5333bCoDwfOJl0bm5s7fNkIW+N4vvib5QfscsP1ObGEe6D9KQelC
        /0dddKDxh3BmlZyah/QGLJofAt1rRbWzaTNYQw==
X-Google-Smtp-Source: ABdhPJzbEqLJ99odN520EW4AVRJPIR04e5agSW7LB0u4D44aOo54T4MLXZhI47m/itYTFWJzx21D4UTwqWw5aPxKjos=
X-Received: by 2002:a05:6402:40c4:b0:412:d697:187 with SMTP id
 z4-20020a05640240c400b00412d6970187mr2318669edb.66.1645709101471; Thu, 24 Feb
 2022 05:25:01 -0800 (PST)
MIME-Version: 1.0
References: <20220223225257.1681968-1-robh@kernel.org> <YhdLKuv3D/tQ9ia8@kroah.com>
In-Reply-To: <YhdLKuv3D/tQ9ia8@kroah.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 24 Feb 2022 07:24:48 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLQ4piDoqFstODfexNkz7cMhbjGeKD1HSb1QFgFPwCpTg@mail.gmail.com>
Message-ID: <CAL_JsqLQ4piDoqFstODfexNkz7cMhbjGeKD1HSb1QFgFPwCpTg@mail.gmail.com>
Subject: Re: [PATCH 0/2] driver core: Refactor device unbind/probe fail clean-ups
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Thu, Feb 24, 2022 at 3:09 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Feb 23, 2022 at 04:52:55PM -0600, Rob Herring wrote:
> > The same sequences of device clean-up code are duplicated 3 times.
> > Changes to this code are prone to missing one of the copies. This
> > series refactors the code into 2 common functions as there's some slight
> > differences in the intermediate steps.
> >
> > Rob
> >
> > Rob Herring (2):
> >   driver core: Refactor multiple copies of device cleanup
> >   driver core: Refactor sysfs and drv/bus remove hooks
> >
> >  drivers/base/dd.c | 80 ++++++++++++++++++-----------------------------
> >  1 file changed, 30 insertions(+), 50 deletions(-)
> >
> > --
> > 2.32.0
> >
>
> What branch/tree did you make these against?  They do not apply at all
> to my "driver-core-next" branch of the driver-core.git tree on
> git.kernel.org :(

linux-next. It is dependent on commit d8f7a5484f21 ("driver core: Free
DMA range map when device is released") in your driver-core-linus
branch.

Rob
