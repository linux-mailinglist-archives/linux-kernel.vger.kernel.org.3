Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AFA5A3DD3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 15:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiH1Ngn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 09:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiH1Ngl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 09:36:41 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C109A27B19
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 06:36:37 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id p16so7872569ejb.9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 06:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=KylSzsCbG5Y50VeFVUq/wxId+S+oA2SdPnkKQYFuGQA=;
        b=P/vZxCKI8hi+Ou7qQesWiXfrPKXDGXulKznD2F7gAdudAVF0rTWq97o+ZF6o5Fh1AK
         ldFEp6h+zAwq2ojJSkIiSxsrz04mHlh/gtgpSuYJLhtLILCgyE5c9pb6T+cBdfIOxetU
         QT7F7mtO5++5RlIH1ee7AULcSrEBR6JoxPqy48Z8Rtnf9C3sx4RUZQ0eSOpunV+SW9rf
         FvCG4T5cs+MMOVj7G10CRNvMakhveXRvybM1ktbCgPByt+E0yjt9PpX6+95L/VM1vM6I
         8Cr9Bpz5HlndC5CfTW1YRWyKYTB9ALzBTQBRSF4jXUppW9NeDf5tXxRZDQRwDWp/AOqw
         d5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=KylSzsCbG5Y50VeFVUq/wxId+S+oA2SdPnkKQYFuGQA=;
        b=J31sRiw0UoayxYl/gjim8WaXxBmZoRQ9nDnudoeqQCbQkpNmETKDdYjJIOXJaTat9A
         L+TwI/JR1Y2D9XKY7bMvMi0RuWbQxDmp2F+EZulZrWweS5DoMpRooxEu9PhygWy06lHf
         RHoiXLy7R59Pkvbg0gLGrhikfLt/eCUjr98tiXOaDZxMK2toLGOkjw44zMkUeQKN/njE
         p25OTund0DHPev/rzyG3So1s9qJdFiFOEDLFPauTSJMkZfV+ixD/1Swx5fs+wGIFPi50
         76s3hwp3WiokhMLaiJWfOR3R2Lh5JSDbO9Gar6n/Z+HGgc/2jVvGEOEajuBz8RroZmU2
         f9nQ==
X-Gm-Message-State: ACgBeo2OQXScHZqX4tgMeFwtK5KZpQ5S92S4Ov8wIZAkXhhGdF1XbAlZ
        0aEJeA0/i1Uql/OcxM1T60GgNpit4V32x3ic2UGNnA==
X-Google-Smtp-Source: AA6agR5b0GP1PNxq0DhS2DIhzbtjgJ6gXXYxE4LaPe+DB2soJcGSyu6I7XCcnLvqzC6ZdCmFRBFwJB+7lRuRJAJc7rY=
X-Received: by 2002:a17:906:8a4e:b0:730:9fcd:d988 with SMTP id
 gx14-20020a1709068a4e00b007309fcdd988mr10664664ejc.636.1661693796309; Sun, 28
 Aug 2022 06:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220825104422.14156-1-henning.schild@siemens.com> <34315356-f23e-34ff-98e6-a152b588f201@redhat.com>
In-Reply-To: <34315356-f23e-34ff-98e6-a152b588f201@redhat.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sun, 28 Aug 2022 15:36:25 +0200
Message-ID: <CAMRc=Mc0WSi=1UN8KGEBi42Afty7NPvfOZzxDSaVvVOnsduX0A@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] add support for another simatic board
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Henning Schild <henning.schild@siemens.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        simon.guinot@sequanux.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 4:25 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 8/25/22 12:44, Henning Schild wrote:
> > changes since v5:
> >   - adding patch to convert to pr_fmt
> >   - adding patch to prefix macros with "f7188x_"
> >   - rebased p1v4 to be p3v5 and added tag
> >
> > changes since v4:
> >   - remove int case from a printk in p1
> >   - include tags into commit messages
> >
> > changes since v3:
> >   - update Kconfig as well
> >   - drop chip names from comment in driver header
> >   - add manufacturer check for Fintek again, Nuvoton not possible
> >   - drop revision printing for Nuvoton
> >   - restructure defines again
> >   - add new model 427G
> >
> > changes since v2: (p1 only)
> >   - rename macros that change behavior
> >   - use chip type not device id in the macros
> >   - reorder defines a bit
> >
> > changes since v1:
> >   - remove unused define
> >   - fix bug where (base + 2) was used as second data bit
> >   - add macros for "inverted" and "single data bit"
> >
> > The first two patches apply some style refactorings before actual
> > functional changes are made.
> >
> > Later, This series enables a SuperIO GPIO driver to support a chip from
> > the vendor Nuvoton, the driver is for Fintek devices but those just are
> > very similar. And in watchdog and hwmon subsystems these SuperIO drivers
> > also share code and are sometimes called a family.
> >
> > In another step the individual banks receive a label to tell them apart,
> > a step which potentially changes an interface to legacy users that might
> > rely on all banks having the same label, or an exact label. But since a
> > later patch wants to use GPIO_LOOKUP unique labels are needed and i
> > decided to assign them for all supported chips.
> >
> > In a following patch the Simatic GPIO LED driver is extended to provide
> > LEDs in case that SuperIO GPIO driver can be loaded.
> >
> > Last but not least the watchdog module of that same SuperIO gets loaded
> > on a best effort basis.
> >
> > The very last patch enables a second model of that same board type.
> >
> > Henning Schild (7):
> >   gpio-f7188x: switch over to using pr_fmt
> >   gpio-f7188x: add a prefix to macros to keep gpio namespace clean
> >   gpio-f7188x: Add GPIO support for Nuvoton NCT6116
> >   gpio-f7188x: use unique labels for banks/chips
> >   leds: simatic-ipc-leds-gpio: add new model 227G
> >   platform/x86: simatic-ipc: enable watchdog for 227G
> >   platform/x86: simatic-ipc: add new model 427G
>
> So it looks like all these patches are ready for merging now,
> the only thing which is missing is an Ack from Pavel or
> one of the other LED people for patch 5/7.
>
> Pavel can have your ack for merging this through another tree
> please?
>
> So what is the plan for merging this?
>
> I see 2 options:
>
> Option a:
> 1. Merge the GPIO changes (patches 1-4) through the GPIO tree; and
> 2. Merge the leds + pdx86 changes through the pdx86 tree
>
> Option b:
> Merge everything through the pdx86 tree, and I will then provide
> an immutable branch + signed tag for other subsystems to pull
> (if they want to).
>

Hey! Sorry for the delay, I've just come back from vacation. I'm fine
with option b and to that end:

Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
