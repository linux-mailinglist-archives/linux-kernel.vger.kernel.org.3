Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F114AD75C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbiBHLcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349041AbiBHLBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:01:30 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AABC03FEC7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 03:01:27 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 939074004A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644318085;
        bh=h+cFJMi1xb4flwS0iIFDQtCt6NF1A16pKH4nxV2+IDA=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=GwoGAkqAffHGGy2fiA8iRsaYhkQspGwEEPLbENk8R/ULWYX0J6K1vWDiVnbxNbC1J
         hdf9+CtU9rNfRz5i2MzpG/Dbk62/2aPaz/KFRooiyDny+slXveSaamtLx1z21PbM0R
         sDmyGe3+UgL4ArRP0SKseuA+tGKo8fchyjN2+WZS2XV+guEGWMbXDuNCYhonQsKIHf
         BScLrDlAYsYo7B2cNpxSbeqScU9myWXjRD8J7pTO0UnVtLh6GbRByzdXjT2J6pdPsM
         HnM+u6qymF7tnSxgFHF82lNYaMT/pzrzEGpc3ytYbOe+p5ud63LDa6D7Dd/NDGq+c/
         UAnYbRQHm/4XQ==
Received: by mail-ej1-f71.google.com with SMTP id ka12-20020a170907990c00b006c41c582397so4077159ejc.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 03:01:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :accept-language:references:mime-version:content-disposition
         :in-reply-to;
        bh=h+cFJMi1xb4flwS0iIFDQtCt6NF1A16pKH4nxV2+IDA=;
        b=w/ETOkABi5JCrnk95JZ3v5A4sGvOAwoWej0PWAsLdvTacjEC9HC6hZ8as8fZlXuvkt
         XwjjOm7SUBqJxML1O9ghk849syQD39u01nvo4XWVQ2yetQX3loOHt0jSN4yy+NGD0IM3
         0cFlyDFkUingxi6k0VQfVZacX1RzKhHacoXyhcflzIf77GqjJZ+M5jPuC/pK5tmvTs6m
         NaLtWCeDzDW+oBxfrODFGYQWPHZ5tBg+Y/AhpaBATnp/fTCGqH2TcdPMc/90WY6YyPHy
         VzHEaomvYTFu7GAaZivjxDIbOU1TFm2Id//AYSXVw/irr6aP2tVwg3FhFbMSlPc/ayXN
         x1Fw==
X-Gm-Message-State: AOAM530wNi2ucEDj0Fd1MQh0IoNF7EkzRCBdJxHVfBW39WqD9vIzYxmf
        6w1ajY7AAg/svHK/gzVryEw/Txw6iXLYjVpntF+e0js5l9qPPJIOzP9NuZyBzfcpouWptmSnKsn
        YFMOZc4NU/Q4okdqiMe8qkdcHD8hoHiHkEMF0WANA8g==
X-Received: by 2002:a17:907:ca6:: with SMTP id gi38mr3161151ejc.353.1644318084999;
        Tue, 08 Feb 2022 03:01:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwxACgnXnX7fIEVvj4qxHqqw8VFmaLxZX4IbrZlxGRyJ060h9XkxffeP1tfwABTxY8px7NzyA==
X-Received: by 2002:a17:907:ca6:: with SMTP id gi38mr3161129ejc.353.1644318084766;
        Tue, 08 Feb 2022 03:01:24 -0800 (PST)
Received: from jak-t480s ([2a02:908:2816:fb20:f0af:b464:53a3:b411])
        by smtp.gmail.com with ESMTPSA id g15sm537137edz.100.2022.02.08.03.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 03:01:24 -0800 (PST)
Date:   Tue, 8 Feb 2022 12:01:22 +0100
From:   Julian Andres Klode <julian.klode@canonical.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        efi@lists.einval.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        debian-kernel <debian-kernel@lists.debian.org>
Subject: Re: [PATCH v2] builddeb: Support signing kernels with the module
 signing key
Message-ID: <20220208110122.2z4cmbqexmnxuxld@jak-t480s>
Accept-Language: de-DE, de, en-GB, en-US, en
References: <20211218031122.4117631-1-willy@infradead.org>
 <CAK7LNAQUChvX3NoukBnjBfJJGu+a96pfbM--xHEHOygWPgE9eA@mail.gmail.com>
 <YdSOV7LL0vWCMcWl@casper.infradead.org>
 <CAK7LNAQgixJSnDUMfjc+tg90oMdVoh+i5faEn-rqgmHR3Bk6dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQgixJSnDUMfjc+tg90oMdVoh+i5faEn-rqgmHR3Bk6dQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 09:33:46PM +0900, Masahiro Yamada wrote:
> Added "Ben Hutchings <ben@decadent.org.uk>"
> 
> On Wed, Jan 5, 2022 at 3:13 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Jan 05, 2022 at 12:39:57AM +0900, Masahiro Yamada wrote:
> > > > +vmlinux=$($MAKE -s -f $srctree/Makefile image_name)
> > > > +key=
> > > > +if is_enabled CONFIG_EFI_STUB && is_enabled CONFIG_MODULE_SIG; then
> > > > +       cert=$(grep ^CONFIG_MODULE_SIG_KEY= include/config/auto.conf | cut -d\" -f2)
> > > > +       if [ ! -f $cert ]; then
> > > > +               cert=$srctree/$cert
> > > > +       fi
> > > > +
> > > > +       key=${cert%pem}priv
> > > > +       if [ ! -f $key ]; then
> > > > +               key=$cert
> > > > +       fi
> > >
> > >
> > > I still do not understand this part.
> > >
> > > It is true that the Debian document you referred to creates separate files
> > > for the key and the certificate:
> > >   # openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform
> > > DER -out MOK.der -days 36500 -subj "/CN=My Name/" -nodes
> > >
> > > but, is such a use-case possible in Kbuild?
> >
> > If someone has followed the Debian instructions for creating a MOK,
> > then they will have two separate files.  We should support both the case
> > where someone has created a Debian MOK and the case where someone has
> > used Kbuild to create this foolish blob with both private and public
> > key in one file.
> 
> But, this patch is doing different things than the Debian document.
> 
> 
> The Debian document you referred to says:
>   "Ubuntu puts its MOK key under /var/lib/shim-signed/mok/ and some
>    software such as Oracle's virtualbox package expect the key there
>    so we follow suit (see 989463 for reference) and put it at the same place"
> 
> 
> 
> In Debian, MOK is generated under /var/lib/shim-signed/mok/,
> and its primary use is for signing the kernel.
> Then, you can reuse it for signing modules as well.

It's worth pointing out that in Ubuntu, the generated MOK key
is for module signing only (extended key usage 1.3.6.1.4.1.2312.16.1.2),
kernels signed with it will NOT be bootable.

-- 
debian developer - deb.li/jak | jak-linux.org - free software dev
ubuntu core developer                              i speak de, en
