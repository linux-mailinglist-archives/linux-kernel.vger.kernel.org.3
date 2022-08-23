Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF0E59EAAC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiHWSNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbiHWSMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:12:44 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0416E896;
        Tue, 23 Aug 2022 09:25:16 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-3376851fe13so360342757b3.6;
        Tue, 23 Aug 2022 09:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=e1ByaHgjT5aI+pkPeAiB/CuoKQTWUEVfvmAhYGOVHzY=;
        b=UpztGszl4Wk+OEvdstrECX4nGznd/K/1k7PPcYYUWr15a00jm6biTrLYpOoKZdQFBj
         Ergw/levxJRrWU9QWSgZ22f0zduysxtthR30+25BPmxW89+EUQx4haA+p+rK29ge5aCF
         g21lnU+6ryAEEhbS3cav/aPQReR9LsMvvWFNSVgmjIzh4/2gOrCSoLfk6fJK7tBHnNVj
         34OXubS0it7qwTIFalfXLlhxx+VQf/b2cSuzKgJYcqolmPPcvUW7Vw4r+pNo5TK4DYQR
         FFkvov5J2Roi9J9BBZN4eCSUmHgW4HPJdPRd//O2W3e3TwBpsiICx2DPw8RDuIbtl0mY
         kZMw==
X-Gm-Message-State: ACgBeo0GwCqwp+LMKfiAYBAeATG0t06KNDhVvhd7b32ouCaiq0qrv66V
        4l5sgtZ07yN7yfaSctLXrkximLMv+jp6DfllbmIHxTON
X-Google-Smtp-Source: AA6agR4ufkdeFlSVd0hEGz/ZxKyiVvu1D9etm5aEB4P1tHJPl+mKMBJ35SUVfBRAP1kGsBOnUtpamNoW7FA41r623lU=
X-Received: by 2002:a0d:f647:0:b0:328:317c:9069 with SMTP id
 g68-20020a0df647000000b00328317c9069mr25955261ywf.301.1661271916000; Tue, 23
 Aug 2022 09:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <12036348.O9o76ZdvQC@kreacher> <875yixk3ng.fsf@stealth>
In-Reply-To: <875yixk3ng.fsf@stealth>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Aug 2022 18:25:04 +0200
Message-ID: <CAJZ5v0jeZZLP9nPWrEwxct61UnabrMqifZZgcBbLy0u8-z4xmg@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] ACPI: Device enumeration rearrangements and parent
 field elimination
To:     Punit Agrawal <punit.agrawal@bytedance.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
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

On Fri, Aug 12, 2022 at 3:11 PM Punit Agrawal
<punit.agrawal@bytedance.com> wrote:
>
> Hi Rafael,
>
> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>
> > Hi All,
> >
> > There are still opportunities to clean up the ACPI support code and
> > this series is part of the effort in that direction.
> >
> > It makes changes without functional impact (AFAICS) to the core ACPI
> > code related to devices and to some of its users.
> >
> > Please refer to the patch changelogs for details.
>
> Other than the single typo I noticed in Patch 2,

I've fixed that one while applying the patch.

> the changes look good!
>
> If it helps,
>
> Reviewed-by: Punit Agrawal <punit.agrawal@bytedance.com>

Thank you!
