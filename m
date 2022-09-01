Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBDA5A9965
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbiIANtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiIANth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:49:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335C72A1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:49:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC8E8B826E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 13:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EA4C43142
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 13:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662040172;
        bh=rHXw5sVv5WMfWsxEPoXEF6n0ilTq5kDU1NXGKIkZMYI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H+ANCUg3VI+BtD6d9jMWiBBX7j/T7aVCxWhO/u7TShBxut0FsI9iPoDOy8RPfwNwE
         x5CzL7kGZ6k+WFJ3rd/qcJTBvCfuYAyKaY/q4WRuRJs+dpFEvDsxH/MeW/p7mpE4++
         +wYgSBAZ5a29LsnYzbRYJBsvjw7pJ076w0BAfYdBVjM2WpEDIzSVe0J9prenOveVGW
         zHTgZYciIyeEW57IshXjfbtmlvwo27ZHSqdAMjjvamEQM81otVeDFwgPJBS6Mjcm/9
         oVXlBN/wXN6+PBPB6Wq6RrliLJjUusTBdQgAdiY3u0LKpqfiBHG3GDrsPXdybecuV0
         TKTNDD/wDXLNA==
Received: by mail-vk1-f176.google.com with SMTP id x66so8270917vkb.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 06:49:32 -0700 (PDT)
X-Gm-Message-State: ACgBeo2mSwm7J6cg9T6pNhIFCGphWKRaArPdrDpwOQvOsNI53RitiSYr
        VsHXk49Splqo5gRR7owjavi2F8x8j7PdEVPZQw==
X-Google-Smtp-Source: AA6agR7v/gjrUTw/+LOwIeQca8GoyfkVRvhyWx+E7koOG+O+cp4+UuArZTXAVQwsRRf5fOHXqQ4DAAKECRWGe147IvI=
X-Received: by 2002:a1f:e9c3:0:b0:394:4cff:bde5 with SMTP id
 g186-20020a1fe9c3000000b003944cffbde5mr7140462vkh.26.1662040171183; Thu, 01
 Sep 2022 06:49:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220316023356.120595-1-victor@allwinnertech.com>
 <CGME20220831115257eucas1p20d37a01c51e42767860920a936255bd7@eucas1p2.samsung.com>
 <9a425a51-9460-6c4d-e331-5cd5873f8a43@samsung.com> <dda053b1-2d4f-153b-b811-78021eae3882@allwinnertech.com>
 <6c14e174-cdb6-c1fc-58cc-d579111d2328@allwinnertech.com> <CAL_JsqKEEc=sWdNURUoM8mR675Fz-4VfsFQXxnPCtiOQ5QfM0w@mail.gmail.com>
In-Reply-To: <CAL_JsqKEEc=sWdNURUoM8mR675Fz-4VfsFQXxnPCtiOQ5QfM0w@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 1 Sep 2022 08:49:19 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+croyhct_=c3OGDnqd0N6GjL8aUgpD8D3YSDU3-VB1qw@mail.gmail.com>
Message-ID: <CAL_Jsq+croyhct_=c3OGDnqd0N6GjL8aUgpD8D3YSDU3-VB1qw@mail.gmail.com>
Subject: Re: [PATCH] ARM: mmu: fix access to illegal address when using
 earlycon & memblock=debug
To:     Victor Hassan <victor@allwinnertech.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        yanfei.xu@windriver.com, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
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

On Thu, Sep 1, 2022 at 8:21 AM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Sep 1, 2022 at 7:54 AM Victor Hassan <victor@allwinnertech.com> wrote:
> >
> >
> >
> > On 2022/8/31 20:37, Victor Hassan wrote:
> > > On 8/31/2022 7:52 PM, Marek Szyprowski wrote:
> > >> Hi Victor,
> > >>
> > >> On 16.03.2022 03:33, Victor Hassan wrote:
> > >>> earlycon uses fixmap to create a memory map,
> > >>> So we need to close earlycon before closing fixmap,
> > >>> otherwise printk will access illegal addresses.
>
> How? Due to recent changes in how printk and the consoles work or just
> because create_mapping() can print? In the latter case, the only
> variable input is the phys address. I think most if not all prints
> cannot occur.

Ah, I missed the memblock debug part on the subject...

Rob
