Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875D94C3B35
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbiBYBq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbiBYBqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:46:51 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597692399E3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 17:46:20 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id bg16-20020a05600c3c9000b00380f6f473b0so838353wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 17:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8D32Z4Jfl8sLqg7xRSsfRiwnG++EtWCi7Lhikq04euE=;
        b=l3QmXw0NtFvNz9992w2tjuwjdvvzU++i3If62TDNx06AEScKBXlbFyDMPGEz8Hw+AB
         qco9bSvnTeYmlXqlx3zAytfjY6BQ9sQpxyxd6PK3T6nh7rhPlwXD7t7fbxkxhuTBSiFU
         UcBf2fW5Y8l4A7bMS1CVJ/l+LUU7z4rmJ/Tgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8D32Z4Jfl8sLqg7xRSsfRiwnG++EtWCi7Lhikq04euE=;
        b=7U5Jjwgux8LVsF7tQv8GhCN+yW+HJoFjSNlJGtsYJQOUxtJToEzJQyB8TgbSumTZ7a
         nH1x1HzsAeyDzuEHu4YELGCgHJkXCEn0i7PKELPe/mX5qpd6re10x/Deppc110djvROf
         kkEDE+s3N+dQKwcn2IqYtaByuVVMp/VQu2/rPYchZxbMLTgawQlG5G/z1Y+RVJTCx/nN
         lQg/7u00FLRRhoYIXTfTfBSkhWuM06t/KeWsvLW2050XMbDmt3mVROumWG9dJrf+8uCN
         DObawu7rFkdYDqxPenKyaq/0FKunQ4I+WeRgkLgAb96qRz9C2TUESD4NFz3foZFgfVaQ
         vDLA==
X-Gm-Message-State: AOAM533YYiIN2uSEarodMs9YqdQuCyx2nFMkrW2U9VwUXjT0HnSNku7h
        gqBzkPau4YTBGsY+VssZp2+yWpqeShZbVg0Gaz7HKQ==
X-Google-Smtp-Source: ABdhPJx9ckchgPqrrWZakeWmKsSvCWyW/XdK3Imx4SlI1Ids3uQZKekBjzG7EZdqdO9myhtX0yvyChyAzHEPa9N2DPY=
X-Received: by 2002:a1c:a916:0:b0:380:eb26:a580 with SMTP id
 s22-20020a1ca916000000b00380eb26a580mr622422wme.91.1645753578778; Thu, 24 Feb
 2022 17:46:18 -0800 (PST)
MIME-Version: 1.0
References: <20220224040136.1595119-1-davidgow@google.com> <c877cf8b-7dd0-9766-e4cb-123dba5075a3@cambridgegreys.com>
In-Reply-To: <c877cf8b-7dd0-9766-e4cb-123dba5075a3@cambridgegreys.com>
From:   Julius Werner <jwerner@chromium.org>
Date:   Thu, 24 Feb 2022 17:46:07 -0800
Message-ID: <CAODwPW8EyNr87ZMervpo0avoKpi+OvzOELrTgWV1S-1R1DSuwA@mail.gmail.com>
Subject: Re: [PATCH] firmware: google: Properly state IOMEM dependency
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     David Gow <davidgow@google.com>,
        Julius Werner <jwerner@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        LKML <linux-kernel@vger.kernel.org>, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-By: Julius Werner <jwerner@chromium.org>

On Thu, Feb 24, 2022 at 12:02 AM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
>
>
>
> On 24/02/2022 04:01, David Gow wrote:
> > The Google Coreboot implementation requires IOMEM functions
> > (memmremap, memunmap, devm_memremap), but does not specify this is its
> > Kconfig. This results in build errors when IOMEM is not enabled, such as
> > on some UML configurations:
> >
> > /usr/bin/ld: drivers/firmware/google/coreboot_table.o: in function `coreboot_table_probe':
> > coreboot_table.c:(.text+0x311): undefined reference to `memremap'
> > /usr/bin/ld: coreboot_table.c:(.text+0x34e): undefined reference to `memunmap'
> > /usr/bin/ld: drivers/firmware/google/memconsole-coreboot.o: in function `memconsole_probe':
> > memconsole-coreboot.c:(.text+0x12d): undefined reference to `memremap'
> > /usr/bin/ld: memconsole-coreboot.c:(.text+0x17e): undefined reference to `devm_memremap'
> > /usr/bin/ld: memconsole-coreboot.c:(.text+0x191): undefined reference to `memunmap'
> > /usr/bin/ld: drivers/firmware/google/vpd.o: in function `vpd_section_destroy.isra.0':
> > vpd.c:(.text+0x300): undefined reference to `memunmap'
> > /usr/bin/ld: drivers/firmware/google/vpd.o: in function `vpd_section_init':
> > vpd.c:(.text+0x382): undefined reference to `memremap'
> > /usr/bin/ld: vpd.c:(.text+0x459): undefined reference to `memunmap'
> > /usr/bin/ld: drivers/firmware/google/vpd.o: in function `vpd_probe':
> > vpd.c:(.text+0x59d): undefined reference to `memremap'
> > /usr/bin/ld: vpd.c:(.text+0x5d3): undefined reference to `memunmap'
> > collect2: error: ld returned 1 exit status
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> >   drivers/firmware/google/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
> > index 931544c9f63d..7ac866a985c6 100644
> > --- a/drivers/firmware/google/Kconfig
> > +++ b/drivers/firmware/google/Kconfig
> > @@ -21,7 +21,7 @@ config GOOGLE_SMI
> >
> >   config GOOGLE_COREBOOT_TABLE
> >       tristate "Coreboot Table Access"
> > -     depends on ACPI || OF
> > +     depends on IOMEM && (ACPI || OF)
> >       help
> >         This option enables the coreboot_table module, which provides other
> >         firmware modules access to the coreboot table. The coreboot table
> >
> Acked-By: anton ivanov <anton.ivanov@cambridgegreys.com>
>
> --
> Anton R. Ivanov
> Cambridgegreys Limited. Registered in England. Company Number 10273661
> https://www.cambridgegreys.com/
