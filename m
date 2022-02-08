Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4334ADC09
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379486AbiBHPJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242199AbiBHPJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:09:56 -0500
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05D2C061577;
        Tue,  8 Feb 2022 07:09:54 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id j2so50917915ybu.0;
        Tue, 08 Feb 2022 07:09:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JO18xjG14k/rD/rECrWzxLQOq1JMGuVwgdKiluPLoY0=;
        b=dtf3QSQQkLM6MZhJMQYCGDcW5usHBDZcgYFuv99bl4b4vXj7NgWTKWelbTw0j8KxRN
         S2YYDTsImXciNIHL1pYRhNwZBTtcr1++B47uPcWsn3V7wXgQWtFC/IE8cpG35iIYZhZ1
         qz0hhTtvztq04swd7BjSXkttuVm+ZrgdCl6VfmETk604GIefhBu1oyip7YLJRl4AGYZw
         7R4O31jTXdn7U1gK7xEQGTul/x1WXloYd5ZTyItjvg/vQ24qAIpn7gjEZZHHKIHzI2i0
         W3cNGQfCHuWsCFigJbsJEP2Kv1gb5PvFw1RISsf6JN55jRbyYv9WVQwyojbAq1+KCfB6
         nslA==
X-Gm-Message-State: AOAM531YHmQTLqmMFMmIkRwTEBn1e12fgNKhVJAC71WiI4HAIgFD4qmh
        o5wNAv9FckRHpqyImA26OXlmZ2Z7QPsN9x9fYbWELydT
X-Google-Smtp-Source: ABdhPJzhlQn0WWpWX6p6gu00Wuzx9TlC47Nt4i6GUTkAtORmiZYVAhxcXZa2Qw5x/hh4nhMMfCi9qqkVoEzowm/Yp04=
X-Received: by 2002:a81:ae0c:: with SMTP id m12mr5105233ywh.19.1644332994143;
 Tue, 08 Feb 2022 07:09:54 -0800 (PST)
MIME-Version: 1.0
References: <10025610.nUPlyArG6x@kreacher> <20220208145913.GA1802@willie-the-truck>
In-Reply-To: <20220208145913.GA1802@willie-the-truck>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Feb 2022 16:09:41 +0100
Message-ID: <CAJZ5v0gJ3MjEdav2Ks=4tMKJAZBFz24hf34kkwTpfy8X06jMbQ@mail.gmail.com>
Subject: Re: [PATCH] perf: Replace acpi_bus_get_device()
To:     Will Deacon <will@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Tue, Feb 8, 2022 at 3:59 PM Will Deacon <will@kernel.org> wrote:
>
> Hi Rafael,
>
> On Tue, Feb 01, 2022 at 08:10:01PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Replace acpi_bus_get_device() that is going to be dropped with
> > acpi_fetch_acpi_dev().
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/perf/thunderx2_pmu.c |    6 ++----
> >  drivers/perf/xgene_pmu.c     |    6 ++----
> >  2 files changed, 4 insertions(+), 8 deletions(-)
>
> Acked-by: Will Deacon <will@kernel.org>
>
> Please let me know if you'd like me to take this for 5.18.

Yes, please!
