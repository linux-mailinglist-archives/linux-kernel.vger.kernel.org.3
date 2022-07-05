Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5205672BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiGEPed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiGEPe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:34:28 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B4215FF4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:34:28 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3137316bb69so112490517b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 08:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NMiJfnuB9E8oSfD8q3hXX0dz5a3dBhL6ICVpLeG7Qi8=;
        b=mYEpFjQNeokVX/aLWI26f3fU2HS/juOCGx0/m9LYGgTft11OkCep1akwsDz5NgUmnN
         +rHLC40R1nQBfUXmMa/KEUDebn+nQvG1rAQ5DURS9nwGsot3QNgNv+y2G0Pshd4e+6v5
         vsBTm6udQnxyDreNH6RZsd0gJPT0y1qWaeYUEsAO5PvFWp2f6CBE4LF3gl1FsjBmfHwz
         U6KKM00690q6sHK2mDfWXtYyZXHHAtKr4Xpuaxv0MtzKULjxPaUS7/A9fvTkHywmR1zy
         dhl75/cmY4DIqGF3bFaTc7mKfBUmJ3uYHKd/IHE8xzfaOIAnQtxMsy6N7f/cubkRDkQO
         LSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NMiJfnuB9E8oSfD8q3hXX0dz5a3dBhL6ICVpLeG7Qi8=;
        b=nj/m7QiSzgFJdg+KedF43DJB2zWBMDplOGgIZ8bRY9bP2UfJ44AyIB/imKOYdgpAFZ
         cJhe9t160CRzy/TiW3qj9qZTaU6CTsGcLsQRa/KKg9pKggKYben+YfDpi3IBZswbinXD
         zD6kWgpiRLZHGhkt5VBVrmQ6d7B6d87y6uMPv5k2uOa0XBdwk80mS0hCr/wXTbb5tDLb
         94N9QUMSNHNgKHGdJmuwII7xlQi2xVgH5YZR1UjGCX4bEcM8dn7DnJmXHSnUlnsrFDos
         +6k/L7mgMkrEwNUrV/M1imM388YaQcmMVA7oeYcSK2wuNPY5iSgN3ymQJfN+OrR3/Uns
         Cskw==
X-Gm-Message-State: AJIora/tCXJ9CPX8cT4Tif0scfMo4QXi9xlkGcJExO5Uw9iq1H4dciv+
        de7SiwaPdde++kD7pls0/BLi4pv2adTiPhhFufE=
X-Google-Smtp-Source: AGRyM1tHlOOEZ+YGBBwNVGcEkLJmjTThfw81bZn46U0aLo+GszGzPrpdUkkU4QhMIHnidQP6GtMMYL542n8cXjZ3iKM=
X-Received: by 2002:a81:4bd7:0:b0:31c:91da:5a20 with SMTP id
 y206-20020a814bd7000000b0031c91da5a20mr14885422ywa.131.1657035267360; Tue, 05
 Jul 2022 08:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220705114312.86164-1-andriy.shevchenko@linux.intel.com>
 <20220705114312.86164-4-andriy.shevchenko@linux.intel.com>
 <f85d13df-b3b9-5cde-6f4c-a68507cedee9@huawei.com> <CAHp75Ves4VZHRWGW9hP1cz-Cytx_c2GsK3BHuNiCyRqCufB1Hg@mail.gmail.com>
 <5cd65a67-4289-23f7-3bec-c166e96aa9e2@huawei.com>
In-Reply-To: <5cd65a67-4289-23f7-3bec-c166e96aa9e2@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Jul 2022 17:33:51 +0200
Message-ID: <CAHp75VfjZ=RRWbcV4oVK9RMsq_5QhCweYOLsfgK_iak6Gw=hmQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] bus: hisi_lpc: Don't guard ACPI IDs with ACPI_PTR()
To:     John Garry <john.garry@huawei.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 5, 2022 at 5:27 PM John Garry <john.garry@huawei.com> wrote:
> On 05/07/2022 16:15, Andy Shevchenko wrote:

...

> >>> The OF is not guarded, neither ACPI needs.
> >> This doesn't read well.
> > "The OF is not guarded, neither ACPI needs it."
> >
> > Better? Otherwise please propose how it can be amended here.
>
> How about "The OF ID table is not guarded, and the ACPI table does not
> needs it either."?

FIne with me.

...

> > Strictly speaking, yes we need mod_devicetable.h. But of.h and acpi.h
> > include it.
>
> acpi.h does not include it for !CONFIG_ACPI, which is the only one which
> I had checked. But now I see that of.h always includes it, so what you
> are doing is ok.

What a surprise. I was under the impression that acpi.h always
includes it. Hmm... Probably we never had drivers that in Kconfig have
something like "depends on ACPI || COMPILE_TEST (and at the same time
have no explicit mod_devicetable.h inclusion nor implicit providers
like of.h), which should immediately point to the issue.

-- 
With Best Regards,
Andy Shevchenko
