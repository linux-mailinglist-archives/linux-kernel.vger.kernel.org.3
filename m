Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6BA4D3862
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbiCISEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236524AbiCISET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:04:19 -0500
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3027665C9;
        Wed,  9 Mar 2022 10:03:20 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id w16so5987545ybi.12;
        Wed, 09 Mar 2022 10:03:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c3a48oLLkjSGkQnL2WkjoDyztkm4ooACKXJyQszVdjI=;
        b=OLTrPKjyTP1qQ9a0WZcWH3qfTIM7LZxYG6G98Kl0kVMPtR4DmpGs44lkM7xuAntviZ
         gxPZUnYmU0aGlOgGk1PgR332+L7N59fTRN7zfqdQeZSy12neEzFtDpk0UBZYdYHFAaK3
         pXPBhS5eCQjc+zdfGRWYOEELWwCpLv4cBiY425awjLZWb0FypwzNTwrdQKXiyRWEy9Kl
         mOj1RcXsIasoJ7P4WpTuSiymUpwZxQDd4Jnmq4VluRjC5ME1+USo7UUoAN91Oix5Xnhp
         xI2Y2FyfDknORf8RKNl8Lc3ysYMQX+rY+QjT6ANpk1GU1JwhKLbPCBmLE1u7ONnvgR59
         9d6w==
X-Gm-Message-State: AOAM531vFHMHJWHrhb6kLYNE8mx+Z29E8SeGrkUHHliNPL8+hTTT2NrC
        ZhRmto6V4ivxQwQjjDhmb6aDVtwKELB0nlFGXmHP/Wzw
X-Google-Smtp-Source: ABdhPJyFIzJT9II3hyzJSUIzk1lEe013GVdTGaNPFaKPwsguBkhgAPwOP/ti4JbmOes0lbZ8NFFUjyJqbYBqgeDwS1k=
X-Received: by 2002:a25:4052:0:b0:628:cdca:afb7 with SMTP id
 n79-20020a254052000000b00628cdcaafb7mr790485yba.81.1646848999300; Wed, 09 Mar
 2022 10:03:19 -0800 (PST)
MIME-Version: 1.0
References: <e1b3112fd6c8c889408915e9a849301d13acf2f1.camel@fifi.org>
 <a52f9cfb-818f-6ed9-42aa-1385584c8103@intel.com> <427c153f2d34997e2131bdeb0fe851c74083f21a.camel@fifi.org>
In-Reply-To: <427c153f2d34997e2131bdeb0fe851c74083f21a.camel@fifi.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Mar 2022 19:03:08 +0100
Message-ID: <CAJZ5v0hKXyTtb1Jk=wqNV9_mZKdf3mmwF4bPOcmADyNnTkpMbQ@mail.gmail.com>
Subject: Re: Bisected regression: 4287509b4d21 causes HP Spectre 14t-ea100 to
 overheat while suspended
To:     Philippe Troin <phil@fifi.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
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

On Wed, Mar 9, 2022 at 7:02 PM Philippe Troin <phil@fifi.org> wrote:
>
> On Wed, 2022-03-09 at 16:21 +0100, Rafael J. Wysocki wrote:
> > On 3/9/2022 4:50 AM, Philippe Troin wrote:
> > > Linux 5.16.9 was working fine, but starting with 5.16.10 my main laptop
> > > has been overheating while suspended.
> > > I've also tried 5.16.11, 5.16.12 and 5.16.13 and they also show the
> > > same issue (overheating while suspended).
> > >
> > > I could not spot any difference between the dmesg messages issued
> > > during suspend between a working version (5.16.9) and the the broken
> > > ones (5.16.1[0-3]).
> > >
> > > I've bisected the regression down to commit 4287509b4d21
> > > https://lore.kernel.org/lkml/20220214092510.074083242@linuxfoundation.org/
> > >
> > > I have also tried reverting that change on top of 5.16.12, and the
> > > overheating behavior is gone.
> >
> > OK, so it is not clear if this is a regression in -stable only or in the
> > mainline.
> >
> > Would it be possible to try 5.17-rc7 and see if the issue is still there?
>
> Tried 5.17-rc7, and the issue is not appearing when running it (the
> laptop does not overheat when suspended).
>
> So it looks like the problem only appears on the 5.16 branch, starting
> on 4287509b4d21.

Thanks for the confirmation!
