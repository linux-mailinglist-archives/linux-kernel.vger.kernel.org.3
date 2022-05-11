Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6363152350F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242368AbiEKOJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244413AbiEKOJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:09:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C556569B5F;
        Wed, 11 May 2022 07:09:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD7D661D27;
        Wed, 11 May 2022 14:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE16C36AE2;
        Wed, 11 May 2022 14:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652278170;
        bh=+0H6gFb/VeSqm9vqYa3ldn+EnFBMQSUhPvw7v+bkmOA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rUSyd8/S/us9XnUBJxPTwHBrwdZgb1404C0wJ7zFX7u+g9+GWfy7WFYg57C2LI2PD
         yvCsdPvsUn1nVzqXGi0goQsiy/m+PcP86C+0lSG45G3UvABtzoC4UH7ahBtL0FCEA6
         b9fT/qX4bnKZvWh1PeSPIVcgY/3umaizEw5BimXmUJr7I0SLiK+zUDN7PDrFbW3JPk
         KI/CVpfarbE+jBRan2hDJZCMYbuCho9YTsfYZouqyrd6KR3/vgfJvsjjfiL11hdULU
         x9iEqXQs1HvUkZI5pO1kbi6R/cgVdgyn4vWJBxE/F3Ccadr3vIX4aKPZGJCTigaSRA
         JEIjsNaiYZlhg==
Received: by mail-wr1-f42.google.com with SMTP id x18so3241207wrc.0;
        Wed, 11 May 2022 07:09:30 -0700 (PDT)
X-Gm-Message-State: AOAM533PSMUhnDC/kE2ezvt5vYJBT/b+lJ+FrArsBl9mn5zBktQOC8aL
        fnYsnuZzqxLr7qvr3Z7ZMWMYv0KK6EjL1P/hg2I=
X-Google-Smtp-Source: ABdhPJyZ7VyHU0D2iD+WmZaZQR50a12I+D9GIH7Fs0uzmVPtQP6DFOMpRvkPbl76Kb3awK/xRJyg6mgK3pU0Wf8HjDA=
X-Received: by 2002:a5d:5228:0:b0:20c:b986:469d with SMTP id
 i8-20020a5d5228000000b0020cb986469dmr17271270wra.34.1652278168509; Wed, 11
 May 2022 07:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220510114852.1719018-1-zheyuma97@gmail.com> <CAPybu_2NCEmjVi2FZC+dPePkfZJQG9QT5qc=cRdHY4tHPEkVDg@mail.gmail.com>
 <CAMhUBjktiUAgXcYzVaF1SUsz_0P4w5D1WHgB7op29J2rwYaBkA@mail.gmail.com>
In-Reply-To: <CAMhUBjktiUAgXcYzVaF1SUsz_0P4w5D1WHgB7op29J2rwYaBkA@mail.gmail.com>
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
Date:   Wed, 11 May 2022 16:09:12 +0200
X-Gmail-Original-Message-ID: <CAPybu_0mxZ=HyZQ7r4ic3GfRLU5FKrgNbQBbJL9H4dKp0rZ6TQ@mail.gmail.com>
Message-ID: <CAPybu_0mxZ=HyZQ7r4ic3GfRLU5FKrgNbQBbJL9H4dKp0rZ6TQ@mail.gmail.com>
Subject: Re: [PATCH] media: imx214: Fix the error handling in imx214_probe()
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Wed, May 11, 2022 at 4:04 PM Zheyu Ma <zheyuma97@gmail.com> wrote:
>
> On Wed, May 11, 2022 at 8:19 PM Ricardo Ribalda Delgado
> <ribalda@kernel.org> wrote:
> >
> > Hi Zheyu
> >
> > Do you have seen this issue in a real hardware?  The device enters
> > idle state unconditionally after power_on during probe.
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/media/i2c/imx214.c#n1008
>
> Actually I didn't, I found the "bug" manually.
> Thanks for your reminder and sorry for the false alarm.

Thank you for looking at the code :)

>
> Zheyu Ma
