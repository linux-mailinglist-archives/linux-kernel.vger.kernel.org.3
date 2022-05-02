Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28C9517612
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386668AbiEBRqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 13:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240598AbiEBRqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:46:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 872E65F89
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 10:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651513352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oX2QCt8rCc+oF9sCgtcKZ1Q9e7gcbTc5DzDbSOW56p0=;
        b=H94h5zunRvh1G35cMT4aeOykk6mVSZadh3EmhNXAod364t5toQxl5bnxUcsLbDHIYq4C1P
        /e3e4bR8xJB6/1MFFAD6RUx1Mum013QcgH3waW5bZWfzdwlW6q9ARHgOw/Gu5SWIWz8T/J
        qWfE3DBucDO3BFE71Fq7DXJOoIN33Pw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-Yngn1uy-P9WBs60nX9vPQg-1; Mon, 02 May 2022 13:42:31 -0400
X-MC-Unique: Yngn1uy-P9WBs60nX9vPQg-1
Received: by mail-qt1-f197.google.com with SMTP id g20-20020ac87d14000000b002f393cf350cso7100598qtb.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 10:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=oX2QCt8rCc+oF9sCgtcKZ1Q9e7gcbTc5DzDbSOW56p0=;
        b=0OTyW2+WMErman2PIg9DNFvfCCWaKCSjBmXtaMFKcCHwQ/Egwxmlwqt3OmFA5ZGXmY
         LVqoxziOwuQm0iYpDHKEK7nCB9kVHvNWA2J9Eek7Cipw6KMhqvsbxtNhDNEJaC/TwDOi
         bswlrdWeth+6jhc3pfUWqo+VzCtXR+AialZhqdEHfYSsyy7atunlrVWyf35Ivjyu7yQi
         c/Yl5e/42U9JTbw8gw9/+gEd6Xb2JUglCWTftTf2sGFzasHSmdLwdWJXaIcytiOcwD8R
         j09KS8KrUcjSIOYPR5dNyH7ED/tA3wMghhhsaw2I+DxNGWCj/+y8jtiR+ThHNdR855vZ
         8Q/Q==
X-Gm-Message-State: AOAM532or5yi26KfbtrMvgX8nCh4tPyj4yGgmZBWZWEIadgDce3IJlvc
        RZwgD5peNWU8mU0kPLYnND0NkVFbAWT5mg3izrGXRQf4iPhkwpLFZuytM8Sl9g/ZqfU72z66bzb
        bOpQ8ppNprqZv26TRMa8GuayM
X-Received: by 2002:a05:622a:1456:b0:2f2:4ff:39a1 with SMTP id v22-20020a05622a145600b002f204ff39a1mr11395132qtx.164.1651513350893;
        Mon, 02 May 2022 10:42:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVlI+WvWSeI1gCt0yxhCHNFIeT/+R26JugPN+2OgpT4RSLl4o9vy34Ma1ONh6I84/8Qm9tqg==
X-Received: by 2002:a05:622a:1456:b0:2f2:4ff:39a1 with SMTP id v22-20020a05622a145600b002f204ff39a1mr11395121qtx.164.1651513350693;
        Mon, 02 May 2022 10:42:30 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net. [71.184.137.158])
        by smtp.gmail.com with ESMTPSA id i2-20020ac871c2000000b002f39b99f66asm4474637qtp.4.2022.05.02.10.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 10:42:29 -0700 (PDT)
Message-ID: <2769588a352e9c3b43a4e09afff100d52a9ba524.camel@redhat.com>
Subject: Re: [External] [PATCH 1/2] platform/x86: thinkpad_acpi: Restore X1
 Carbon 9th Gen dual fan quirk
From:   Lyude Paul <lyude@redhat.com>
To:     Mark Pearson <markpearson@lenovo.com>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <markgross@kernel.org>
Date:   Mon, 02 May 2022 13:42:28 -0400
In-Reply-To: <d3461670-a905-4956-4f4d-d847adf4289b@lenovo.com>
References: <20220429211418.4546-1-lyude@redhat.com>
         <20220429211418.4546-2-lyude@redhat.com>
         <d3461670-a905-4956-4f4d-d847adf4289b@lenovo.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some answers/comments down below

On Fri, 2022-04-29 at 21:25 -0400, Mark Pearson wrote:
> Hi Lyude
> 
> On 4/29/22 17:14, Lyude Paul wrote:
> > The new method of probing dual fan support introduced in:
> > 
> > bf779aaf56ea ("platform/x86: thinkpad_acpi: Add dual fan probe")
> > 
> > While this commit says this works on the X1 Carbon 9th Gen, it actually
> > just results in hiding the second fan on my local machine. Additionally,
> > I'm fairly sure this machine powers on quite often without either of the
> > two fans spinning.
> > 
> > So let's fix this by adding back the dual fan quirk for the X1 Carbon 9th
> > Gen.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Fixes: bf779aaf56ea ("platform/x86: thinkpad_acpi: Add dual fan probe")
> > Cc: Mark Pearson <markpearson@lenovo.com>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> > Cc: Mark Gross <markgross@kernel.org>
> > Cc: ibm-acpi-devel@lists.sourceforge.net
> > Cc: platform-driver-x86@vger.kernel.org
> > ---
> >  drivers/platform/x86/thinkpad_acpi.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/platform/x86/thinkpad_acpi.c
> > b/drivers/platform/x86/thinkpad_acpi.c
> > index c568fae56db2..9067fd0a945c 100644
> > --- a/drivers/platform/x86/thinkpad_acpi.c
> > +++ b/drivers/platform/x86/thinkpad_acpi.c
> > @@ -8699,6 +8699,7 @@ static const struct tpacpi_quirk fan_quirk_table[]
> > __initconst = {
> >         TPACPI_Q_LNV3('N', '2', 'E', TPACPI_FAN_2CTL),  /* P1 / X1 Extreme
> > (1st gen) */
> >         TPACPI_Q_LNV3('N', '2', 'O', TPACPI_FAN_2CTL),  /* P1 / X1 Extreme
> > (2nd gen) */
> >         TPACPI_Q_LNV3('N', '3', '0', TPACPI_FAN_2CTL),  /* P15 (1st gen) /
> > P15v (1st gen) */
> > +       TPACPI_Q_LNV3('N', '3', '2', TPACPI_FAN_2CTL),  /* X1 Carbon (9th
> > gen) */
> >         TPACPI_Q_LNV3('N', '3', '7', TPACPI_FAN_2CTL),  /* T15g (2nd gen)
> > */
> >         TPACPI_Q_LNV3('N', '1', 'O', TPACPI_FAN_NOFAN), /* X1 Tablet (2nd
> > gen) */
> >  };
> I just double checked this on my X1C9 - and it's working correctly. 2nd
> fan is detected correctly.
> 
> I'd rather understand why it's not working on your setup then just
> re-introduce the quirk.

Of course! I figured as much, it's just easy to start conversations with a
revert :P

> 
> What happens on your system when the
>   res = fan2_get_speed(&speed);
> is called? If that is failing it means your 2nd fan isn't responding and
> that's not supposed to happen. Could you let me know if you get an error
> code, if it happens every boot, etc
> I assume when the function is called later it works successfully?

It definitely seems to happen every boot, not sure about the error code it
returns. I will check and get you this info asap

> 
> Also please confirm which BIOS and EC version you have.

BIOS version N32ET75W (1.51) release date 12/02/2021, embedded controller is
0.1.32


> 
> Thanks
> Mark
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

