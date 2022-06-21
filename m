Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D97553E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 00:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354725AbiFUWBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 18:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiFUWA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 18:00:58 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052B82BB19
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 15:00:58 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id u37so14312895pfg.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 15:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EZIbuxBI2vXlx9alO7M1qKlxyC2NDeWjgWUw9yax3xY=;
        b=OLvrKQsmaWY+4H6Iza8bjw1306MSVN8kIcHTlih6pjSp3hmaK5k9cnzRUYXbmMa7V5
         J1/3XOR8pEm4uoHSxXi/HwcFBOWLgjZ12Scdh0msdhnxMdncBTEFHgoGwTNavs8aE/Rj
         TFoBZbJxHvAzLdSPHFNth6VGytbwBXiW8sOm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EZIbuxBI2vXlx9alO7M1qKlxyC2NDeWjgWUw9yax3xY=;
        b=s9fy2+4I+RLtHuMfUqNKMP7UrOL3mKZqQiEDjouXVJZIym0Nly8VgeAkVc2KvDpedE
         qTo1Zu7W98JDvwPfKeqSOTw39Lu9L2+wlJ3ZYCpQChMR1zaJpcIGXBUF30aymNfvVpgA
         90PSaZ4rK7QyALRd7Tz4hGrRHpLcLb0vfijMX/FIz6FfyCJnsF0gF6Uh+H6Ru5cXaoHk
         6rEJhtO4PoQxkEUq90RKVVmXkIdQCZpENmVA8gOP51Y3xB//AjR0ViUu7ja6JZ8ZGjFD
         ws68Js+omSoZ2XL5wxA3LJFmcS0OJnE+c8LePPraz2pj2IdFa89ZJUo2Taxd3Gvou04O
         OeUQ==
X-Gm-Message-State: AJIora+hw9Gk9pLHJMKc/JNe5d6W6+LlaGN8AtC8/hfI/S2p05j/XdDc
        Ram+5Un+0VoOY8tUOwsBfOdc5Q==
X-Google-Smtp-Source: AGRyM1vDCb8yw5CEmb7daNB5E44dsxC1bLHVLMwYiWQiVeC/9vM6jGGEKpS7QNAvl3vmHEX8sOg6tg==
X-Received: by 2002:a63:84c8:0:b0:40c:7d4a:ac66 with SMTP id k191-20020a6384c8000000b0040c7d4aac66mr97592pgd.424.1655848857515;
        Tue, 21 Jun 2022 15:00:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v9-20020a056a00148900b0051829b1595dsm11880008pfu.130.2022.06.21.15.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 15:00:57 -0700 (PDT)
Date:   Tue, 21 Jun 2022 15:00:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2 4/9] efi: pstore: Omit efivars caching EFI varstore
 access layer
Message-ID: <202206211500.B4B9EEB8@keescook>
References: <20220621153623.3786960-1-ardb@kernel.org>
 <20220621153623.3786960-5-ardb@kernel.org>
 <202206211357.C66CD742E5@keescook>
 <CAMj1kXGPi+Cy-D8am8tr-rm8gbmUQ-G0bfibD3R3nx=rL7-XVw@mail.gmail.com>
 <202206211419.014C341BE@keescook>
 <CAMj1kXEWnXd3CyygbQpB8n1srqVA+vTOztevcYTQnDAWZ6-HiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEWnXd3CyygbQpB8n1srqVA+vTOztevcYTQnDAWZ6-HiA@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 11:33:29PM +0200, Ard Biesheuvel wrote:
> On Tue, 21 Jun 2022 at 23:21, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Jun 21, 2022 at 11:12:17PM +0200, Ard Biesheuvel wrote:
> > > On Tue, 21 Jun 2022 at 23:00, Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > On Tue, Jun 21, 2022 at 05:36:18PM +0200, Ard Biesheuvel wrote:
> > > > > Avoid the efivars layer and simply call the newly introduced EFI
> > > > > varstore helpers instead. This simplifies the code substantially, and
> > > > > also allows us to remove some hacks in the shared efivars layer that
> > > > > were added for efi-pstore specifically.
> > > > >
> > > > > Since we don't store the name of the associated EFI variable into each
> > > > > pstore record when enumerating them, we have to guess the variable name
> > > > > it was constructed from at deletion time, since we no longer keep a
> > > > > shadow copy of the variable store. To make this a bit more exact, store
> > > > > the CRC-32 of the ASCII name into the pstore record's ECC region so we
> > > > > can use it later to make an educated guess regarding the name of the EFI
> > > > > variable.
> > > >
> > > > I wonder if pstore_record should have a "private" field for backends to
> > > > use? That seems like it solve the need for overloading the ecc field,
> > > > and allow for arbitrarily more information to be stored (i.e. store full
> > > > efi var name instead of an easily-colliding crc32?)
> > > >
> > >
> > > We could easily add that - we'd just have to decide how to free the
> > > memory it points to.
> >
> > I assume the pstore core could do that since it manages the record
> > lifetime already?
> >
> 
> So if priv is non-NULL when it frees the record, it passes it to kfree() ?

That's my idea, yeah. I *think* it'll work; I haven't taken a
super-close look, though.

-- 
Kees Cook
