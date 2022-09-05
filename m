Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35175AD161
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236617AbiIELSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbiIELSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:18:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3FC5AC67;
        Mon,  5 Sep 2022 04:18:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE86BB810EE;
        Mon,  5 Sep 2022 11:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84511C43147;
        Mon,  5 Sep 2022 11:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662376688;
        bh=VqDluIVUCa0cvkguJgqU0qU0mM2vHSOAmaSO20HhtAk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q6BmZ1QMF63HoDD/P7moeMLa+G1n88M4wOMcVbYClfBxzKmPMQ74uqDdaHwSku00i
         /IPgadj+DfsdTH/0T/kD8oU55dlB+s7yobE3ZWCVPguW8bL6ufitxHc/7f/OcdKlvA
         rJEsYPOu0mhYpikubnPNVWmFkAG0ZSR6v4S/c0ldh5FxqlmRZ7iWi6WrrhnhsaNykE
         PKuAE2qyazipp7WwSvqB4mlW4MlYsNw0F14tpXl32678ssVZo6gSMfgS6uIH3CZ14r
         wwODrSCcZdTazHd9orXEuwKIzq3hOjUIE/kQA3woApsD/yniXCW5SpwBe4bbs4jhoi
         asmoteEajmSMA==
Received: by mail-lj1-f170.google.com with SMTP id k22so8908507ljg.2;
        Mon, 05 Sep 2022 04:18:08 -0700 (PDT)
X-Gm-Message-State: ACgBeo1322twlth2xDs7zUirfnZmdc32Mck2zjtKHz2I5anf3QO33v9/
        4WAynM3Mx0SuXPsDJAQFCfWyYpyN7dRAImhmkds=
X-Google-Smtp-Source: AA6agR5KS/N7PwAIE1VgLmLrimzWOIJ66TyKWYDA3eq+4LJpciY5M1NhNEKFX77c9InbsebrMfDTY91CD1+6hxCAd/U=
X-Received: by 2002:a2e:9b0e:0:b0:268:cb68:575b with SMTP id
 u14-20020a2e9b0e000000b00268cb68575bmr5579388lji.152.1662376686339; Mon, 05
 Sep 2022 04:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220905105252.351795-1-ardb@kernel.org> <YxXYgNsug4BIWsoF@kroah.com>
In-Reply-To: <YxXYgNsug4BIWsoF@kroah.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 5 Sep 2022 13:17:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFuzXPmah+bO+tORQSWnBn_YktDA716FJA=_Psez0OTmg@mail.gmail.com>
Message-ID: <CAMj1kXFuzXPmah+bO+tORQSWnBn_YktDA716FJA=_Psez0OTmg@mail.gmail.com>
Subject: Re: [PATCH v2] usb: reduce kernel log spam on driver registration
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        Rob Herring <robh@kernel.org>
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

On Mon, 5 Sept 2022 at 13:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Sep 05, 2022 at 12:52:52PM +0200, Ard Biesheuvel wrote:
> > Drivers are typically supposed to be quiet unless they are actually
> > probed, but for some reason, USB host controllers seem to be exempt from
> > this rule, and happily broadcast their existence into the kernel log at
> > boot even if the hardware in question is nowhere to be found.
> >
> > Let's fix that, and remove these pr_info() calls.
> >
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Cc: Alim Akhtar <alim.akhtar@samsung.com>
> > Cc: Avi Fishman <avifishman70@gmail.com>
> > Cc: Tomer Maimon <tmaimon77@gmail.com>
> > Cc: Tali Perry <tali.perry1@gmail.com>
> > Cc: Patrick Venture <venture@google.com>
> > Cc: Nancy Yuen <yuenn@google.com>
> > Cc: Benjamin Fair <benjaminfair@google.com>
> > Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> > Cc: Vladimir Zapolskiy <vz@mleia.com>
> > Cc: linux-usb@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-samsung-soc@vger.kernel.org
> > Cc: linux-omap@vger.kernel.org
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> > ---
> > v2: - drop another couple of occurrences pointed out by Robert
> >     - drop hcd_name variables as well if the only reference to them is
> >       being dropped
> >     - pick up acks
>
> I've already applied your first version, so can you rebase this against
> linux-next and send just the fixups?
>

OK
