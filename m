Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3D049E4EA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242609AbiA0Ooy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242601AbiA0Oox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:44:53 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4628BC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 06:44:53 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id p63so2940305iod.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 06:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QmOVvHbNHo07Hdnh4i7Uqf4FrJ31JeDl4rLZwaJlkBs=;
        b=SvBC8I6xHJIt0BEuqxLiAD41TmiAo5pfVD3zEaL3tzWyxIE/eMIZYTirmoOeqr9j7P
         bxPgwWE/e0MDvH8Jh/Qh/6SxubnSmcavWYGQZPbsihEqLguoG2UVF9/FlR2oE1Ogp7ZY
         rRLwfwFEcL/YhTvS8f8hTnObZ2gGefxzARn6Kic+VvVTvAA9QPFgsB/dS0g/Ncn4yTXt
         ziuc3TprHqZW21DAZMNxy4u1RW+kbq/fggHxnOw8PfEzxy5CYVTAJCibLR3nXPV6OogL
         5rMUt2kFjQDxh4VTof3G5HtKJkQEPg7DHvqKSxzMWzQ4Zi4PyvxGIu+gQ3rLwy3iSnKA
         1XVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QmOVvHbNHo07Hdnh4i7Uqf4FrJ31JeDl4rLZwaJlkBs=;
        b=SJCoxdzjmy3ZlfDx83NqitXHBtwOysAu//qkZK//16s7azICj8A+x/1BCS7xXtxXsx
         mBhSZWODojPXlH6PzsQYjb5aw/a4/vOhAIoPm4dMlCt7hjm4DN+jWteqHpXe8TX/rv3z
         IUZCESIJEFFPBw7twfBUmtZjJCmNyt6yd14vIep/kRWkWQtqZAvi3a2Dn8xONvuEMjsm
         GVdAYXyjZWFLPEozFivya0s53Ma+MyFX9/zRuIfID9+WoFwKrLCt+Ba3rVclwB99jVqW
         ksm/4qTVyz7s+2kstfAIY2ELT60Wh1dvxA86nQeEVkysJXKBYOynN241/0ruIJoqvz6h
         HSfw==
X-Gm-Message-State: AOAM531zzwKTx8PRSdA2laKKYZGBn47tcv98Fb+vgjyEIK3Yn6Di0jHL
        JcakDNQzjHNb0c2jyJmkJmsU5fabO2vPwV7N4VU=
X-Google-Smtp-Source: ABdhPJyVHLOwW6nUCnVsw0VH8sqxmGwHxSc7t8ZZ0NdIOJIyUhVbx3utRR1PQ7fVDgnXrcoNCoTORt+c3DxoR2va37U=
X-Received: by 2002:a05:6638:4105:: with SMTP id ay5mr1091653jab.186.1643294692466;
 Thu, 27 Jan 2022 06:44:52 -0800 (PST)
MIME-Version: 1.0
References: <CANiq72n_FmDx=r-o9J8gYc6LpwRL5EGmhM6Xzwv27Xc7h1TNDw@mail.gmail.com>
 <cf6ac499-4190-cbe5-255c-f9edf07a4786@kaod.org> <CANiq72mV3AzmBDVJM+tQriEoDu_9LFBrK_vR6GC4qEmLw0UepQ@mail.gmail.com>
 <1643269597.wkij0f82dr.astroid@bobo.none>
In-Reply-To: <1643269597.wkij0f82dr.astroid@bobo.none>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 27 Jan 2022 15:44:41 +0100
Message-ID: <CANiq72kDhNCZXVW+yN8JM4ydRO8pnxm9yHH8+yTJ9H1uGoW81A@mail.gmail.com>
Subject: Re: ppc: hard lockup / hang in v5.17-rc1 under QEMU
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicholas,

On Thu, Jan 27, 2022 at 8:47 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> That sounds like my fault actually.
>
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2022-January/239178.html

Thanks for the reference & fix! I confirm it works in our CI too.

Closing the QEMU issue then.

Cheers,
Miguel
