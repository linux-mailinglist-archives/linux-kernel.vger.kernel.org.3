Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A96959997D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 12:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348262AbiHSKAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 06:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348318AbiHSKAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:00:35 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320C9F4C9B;
        Fri, 19 Aug 2022 03:00:35 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id m5so2931859qkk.1;
        Fri, 19 Aug 2022 03:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=94B01Gvctqm4iZb3YaOuzMT52V6OgD2x7D5RRY0ZFzw=;
        b=o1V0XSLJIWh+tpsX9B0VfDB/c4/woloHTVa4Ybbh+/3u2FxigROJrA+XJtfyQGS2E0
         MIw7LavzGksRp2yh4sxMocn55skcXS4M00j0vSRlit7DVS7uy7e+ITcSCGowRNUZ1lkX
         bZz7iOA1eENwi52gl1b9QI51PvEkfiJoRpzhb0vd3SE8/Zn20hHZH23U5OBsq6+4Yhph
         u1euertaisnMzwHSOy8hcsTs6YNmsXmbRlYoac19igsWFwhmlQQ5qB+4cLBHnr6Cx0Rj
         33eswkKqaGcnWDxGdrAWkMPm3wLuy3BJTAF4fBRR42lUDbdFaTHZLLcSvUw+8Fc9ZCqR
         tMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=94B01Gvctqm4iZb3YaOuzMT52V6OgD2x7D5RRY0ZFzw=;
        b=l9X33QUbAa1HXX5fHNor/4jPw5y15RGf5BV/317PNVK8p5v7+yoJZYxJjdT5k0PlIV
         KynA6zkG9qV8DF3xv3/29SOKnZxqdz6WlroSSrAxuDoZTvV25g9EaSFUB5ZDICqr+ujd
         Tm9VIo6yFwx/jPjvgIr+3DigpKygdooz3C9pEw404evhiKupCA8lKqpn/hV3fqJdZR4/
         iRlzXyhID+3rmjYeicOsDPLh0fOh51HRd9NA6vUAs5lglrMnLs4R8P+YL5zZ1CokNfVt
         00PEpIs2JzGa/kBa3MxPI8/7J1GtgahaXA4ETAAMRx54FncL6iqPdY3QSHwiVi+Dl3Ct
         KLxw==
X-Gm-Message-State: ACgBeo1o9vFptQdroe71ntPSmK2xcB+1QCxSvC4mtydxwJ6vF4dO6cYg
        sM+1TDvyIdkTEarU60gN7xUb4Fs5eT+yafUn2FXiAuNk3agE0g==
X-Google-Smtp-Source: AA6agR4r/NescIht+xrcloFRZqcGgcbOX6uxrKlpMqCoyrotftvCyob3MTIKp3pNbK4DIUlKXqGvDe+2eatlgavCtSI=
X-Received: by 2002:ae9:e311:0:b0:6ba:e711:fb27 with SMTP id
 v17-20020ae9e311000000b006bae711fb27mr4659635qkf.320.1660903234293; Fri, 19
 Aug 2022 03:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <1660649244-146842-1-git-send-email-john.garry@huawei.com>
 <1660649244-146842-2-git-send-email-john.garry@huawei.com>
 <CAHp75Vc4vT==hB=svhDBhSpNFCQXwzZ1RMxy4mQspFhmSjQ03g@mail.gmail.com> <366fd6dd-a37b-c7ec-fdf3-48f8a8024834@huawei.com>
In-Reply-To: <366fd6dd-a37b-c7ec-fdf3-48f8a8024834@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Aug 2022 12:59:58 +0300
Message-ID: <CAHp75Vd-6mfK=Or4MjXswUZsovHhMyDDJCv8srBH70f24MGvpA@mail.gmail.com>
Subject: Re: [PATCH PoC 1/3] ACPI / PNP: Don't add enumeration_by_parent devices
To:     John Garry <john.garry@huawei.com>
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
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

On Fri, Aug 19, 2022 at 11:05 AM John Garry <john.garry@huawei.com> wrote:
>
> On 18/08/2022 20:31, Andy Shevchenko wrote:
> >> For the  hisi_lpc driver, for the UART ACPI node we have a binding like:
> >>
> >>   Device (LPC0.CON0) {
> >>      Name (_HID, "HISI1031")
> >>      Name (_CID, "PNP0501")
> >>      Name (LORS, ResourceTemplate() {
> >>        QWordIO (
> >>
> >> We have the compat and hid string. The ACPI/PNP code matches the compat
> >> string first, and creates the PNP device. In doing so, the acpi_device
> >> created has physical_node_count member set in acpi_bind_one().
> >>
> >> The hisi_lpc driver also creates a platform device serial device for uart,
> >> which is the actual uart which we want to use - see
> >> hisi_lpc_acpi_add_child(). That function does not check
> >> physical_node_count value, but acpi_create_platform_device() does check it.
> >> So if we were to move hisi_lpc_acpi_add_child() across to use
> >> acpi_create_platform_device(), then the change in this patch is required to
> >> not create the PNP binding (so that physical_node_count is not set from
> >> PNP probe).
> > Hmm... The flag, as I interpret it, is equal to "the device in
> > question is a peripheral device to the non-discoverable bus, such as
> > SPI, I2C or UART". I.o.w. I do not see how PNP suits here. So, from my
> > point of view it seems like an abuse of the flag. Not sure the current
> > state of affairs in ACPI glue layer regarding this, though.

> Sorry, but I'm not following you here. Which flag are you talking about?

"enumerated by parent".

-- 
With Best Regards,
Andy Shevchenko
