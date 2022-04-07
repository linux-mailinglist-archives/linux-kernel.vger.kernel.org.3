Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6574F7862
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbiDGH64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242637AbiDGH6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:58:21 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94A93389F;
        Thu,  7 Apr 2022 00:56:22 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id w17-20020a056830111100b005b22c584b93so3358590otq.11;
        Thu, 07 Apr 2022 00:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0JpF6FdvVE++0ash3DDMnAOgfignQSbY1YMYFOOmNUo=;
        b=e7ihkt/7ndm1cu+/cMyQTalxNGDQwt7vevMop/YfCIkq6d9iOKnSa+s7YCIs4xnLUB
         MXFAcQitNQz/kfRdrB0Q8cQIV3KlCHW9XJ510/R28qxCOJkRy2JnKxki1/e0hJKlq/5x
         PL9BfeYw5w8LHPWpY7jg6rQ23rBOLNrWoYQLJ5m/qKyWsXBw7Q1fuMB2g6fhXdjbzYzX
         XLU9iL+SC+7Sg9El0WBRovNaXtAW6C0mwtuoSOHfPKO61XUQNN4g7wriLlotFteP0oH3
         Px56MQgnFQ8MMHrnW/xs30vnJZ8N02koH4FnOauQj2FQUfMs2e3YE+gVHaRqFamUo+4i
         Fadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0JpF6FdvVE++0ash3DDMnAOgfignQSbY1YMYFOOmNUo=;
        b=iRBg3VMOXQx6hGMuLa1bDF6nSpFCOI6FIxk0ZzWtxoLLVHhamAUFIkr+SZFsbpkCAp
         bl4PTJtIKbe0pyo6hsMRuhUQoX01uFh3RNgG+s3kiI9vokJkqsBpMzT/8ZvWcmCYYv0d
         7+YaFLXo1tV4HN6Ggvh50d+zqv1ukBAldvDK2hVDLsIM/bxglyAEZIMcYiCCC8ZmAHJK
         oIZ9qQBLujDH5aFvawOXiwUBPK0tzBYqjKnSSJhhL6flq7w5UJuwTJrZiGFJtcdyjszC
         YLcBSziPGxU3qWYAoTQqGQUgrQigNG/1//hBU8YLc+ZlW36HVVHkLBv4V09P2Je2jyCH
         klxg==
X-Gm-Message-State: AOAM533HMLfBsRd6c7S4aQTkSvfEq0e7DG7jns6eJnTmiOglS6jrGvNN
        ar0AdLTEwV/EkVRjh6L8U0CQS/LqIZ6ZIttbI3I=
X-Google-Smtp-Source: ABdhPJxKNt+PuLxnkz/9BXAT/3ofeUF5/0LyMXPorq3HJMHbwfG91YfyviEqB+KWKDmrmX76DT9JHWMENXWg35QRuTw=
X-Received: by 2002:a05:6830:2708:b0:5cd:a8c2:7665 with SMTP id
 j8-20020a056830270800b005cda8c27665mr4404110otu.144.1649318181831; Thu, 07
 Apr 2022 00:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <Yk6ODSxQTiGOrTj/@debian-BULLSEYE-live-builder-AMD64>
 <Yk6Pip7f3iUsIHTr@kroah.com> <abe69993-0180-a04c-56d5-10b80d339596@collabora.com>
In-Reply-To: <abe69993-0180-a04c-56d5-10b80d339596@collabora.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 7 Apr 2022 09:56:10 +0200
Message-ID: <CAFqH_53pPmk+JFws-nHWRd1553qo50hV2Yt=L_uUwL57dVjc1w@mail.gmail.com>
Subject: Re: [PATCH v5] platform: x86: Add ChromeOS ACPI device driver
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>, vbendeb@chromium.org,
        Andy Shevchenko <andy@infradead.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?Q?Bla=C5=BE_Hrastnik?= <blaz@mxxn.io>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missatge de Muhammad Usama Anjum <usama.anjum@collabora.com> del dia
dj., 7 d=E2=80=99abr. 2022 a les 9:36:
>
> On 4/7/22 12:15 PM, Greg Kroah-Hartman wrote:
> > On Thu, Apr 07, 2022 at 12:09:01PM +0500, Enric Balletbo i Serra wrote:
> >> --- /dev/null
> >> +++ b/drivers/platform/x86/chromeos_acpi.c
> >> @@ -0,0 +1,515 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * ChromeOS specific ACPI extensions
> >> + *
> >> + * Copyright 2011 Google, Inc.
> >> + * Copyright 2020 Google LLC
> >
> > You haven't touched this file in 2 years?
> This file has been changed. I'll discuss and update this. I'll also
> correct this patch's From and authorship. It got messed up.
>

Hi Muhammad,

I was about to reply about the patch's From ;-) when I noticed there
was an email from me that I didn't send. Also, the email address
should bounce as it does not exist anymore which is a bit annoying.

Thanks to work on this, before sending another version, apart from not
messing up the patch's From you should also need to look at the commit
notes, is basically a copy of my latest patch and is outdated, you
should explain what you did new and not copy what I did in the past,
so that also needs a rewrite. I suppose you already looked at the
the latest version which is at, it is a good practice to point to the
latest version so people can look at what was discussed before.

  * https://lore.kernel.org/lkml/20200610224305.GC248110@dtor-ws/t/

In the discussion there are some comments to address, please make sure
to address all of them, or explain why not, and give as much context
as possible because follow discussions that happened 2 years ago.
Sometimes it is difficult to follow.

Best regards,
  Enric

> --
> Muhammad Usama Anjum
