Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF77553DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 23:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356435AbiFUV0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 17:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355114AbiFUVZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 17:25:51 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D0233A39
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:21:44 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id jb13so31562plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=noyB4+CxZoyCTKHs0dTg5LBLfX8Yod/2XNEpNnqj5O0=;
        b=M7/+bQxbdIqrHg07yo4H2tzWqGeUFfifcKJR93Ec0U/jX/VjuADwdTxt2HeF2vKb2A
         wKUY+hWLjWWo/nv+pgBYRm9BkcQsViJyqNodteC/gDk+MvUs8tbe0wpDShathwJro1PT
         YaCv3OhsV6qF2Xj3AXoKoR+Z5YKTj3VIlrr+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=noyB4+CxZoyCTKHs0dTg5LBLfX8Yod/2XNEpNnqj5O0=;
        b=dDWzVp3yvho1RSoGbMLPvvjoNt3e2LLcLhnelekndEHDnTgRrt3JcYd1Y0fZDn2MHy
         +MceQlf69xInoBNRxDcnfMbC8JnyFls/kUNunrOdpp752lCEoNTPPY7y/AM9bGUAz772
         Pb82ZqJF+9kkZuky/RP4IB+gg4neISYCYBx8p/TbnoQ1gRP2PyW1ic6IBdpyREOAuGz0
         3b6x7l2+2GRSIQfnJBv7acN3S16QFm0j9O+DMtaamO7nxOYVHHHq0mALWGeQCwAvJuZM
         C2ZwiFWJtapXejt8c4dSTojZnqyc1g/tMuDCiN6L0NgaipQSN8NxWA3f/AU3qjoB2Hch
         kMhQ==
X-Gm-Message-State: AJIora+tASxbS68+zm9Eg/xgS25J/NDPd+pva9LK4bnOZtHi9hHR3h4Z
        osEsfbHBBeOzk0kxSxK4tkOBtQ==
X-Google-Smtp-Source: AGRyM1stt3v1CBhDg324txXlqUCBENEFXI2PugHtW/8ZNv0B+qyrKeLvGUR8vPlEHw9m0IKsaw/Ikg==
X-Received: by 2002:a17:903:2347:b0:16a:33cd:5308 with SMTP id c7-20020a170903234700b0016a33cd5308mr7046699plh.122.1655846504346;
        Tue, 21 Jun 2022 14:21:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709028eca00b0016368840c41sm9553869plo.14.2022.06.21.14.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 14:21:44 -0700 (PDT)
Date:   Tue, 21 Jun 2022 14:21:43 -0700
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
Message-ID: <202206211419.014C341BE@keescook>
References: <20220621153623.3786960-1-ardb@kernel.org>
 <20220621153623.3786960-5-ardb@kernel.org>
 <202206211357.C66CD742E5@keescook>
 <CAMj1kXGPi+Cy-D8am8tr-rm8gbmUQ-G0bfibD3R3nx=rL7-XVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGPi+Cy-D8am8tr-rm8gbmUQ-G0bfibD3R3nx=rL7-XVw@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 11:12:17PM +0200, Ard Biesheuvel wrote:
> On Tue, 21 Jun 2022 at 23:00, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Jun 21, 2022 at 05:36:18PM +0200, Ard Biesheuvel wrote:
> > > Avoid the efivars layer and simply call the newly introduced EFI
> > > varstore helpers instead. This simplifies the code substantially, and
> > > also allows us to remove some hacks in the shared efivars layer that
> > > were added for efi-pstore specifically.
> > >
> > > Since we don't store the name of the associated EFI variable into each
> > > pstore record when enumerating them, we have to guess the variable name
> > > it was constructed from at deletion time, since we no longer keep a
> > > shadow copy of the variable store. To make this a bit more exact, store
> > > the CRC-32 of the ASCII name into the pstore record's ECC region so we
> > > can use it later to make an educated guess regarding the name of the EFI
> > > variable.
> >
> > I wonder if pstore_record should have a "private" field for backends to
> > use? That seems like it solve the need for overloading the ecc field,
> > and allow for arbitrarily more information to be stored (i.e. store full
> > efi var name instead of an easily-colliding crc32?)
> >
> 
> We could easily add that - we'd just have to decide how to free the
> memory it points to.

I assume the pstore core could do that since it manages the record
lifetime already?

-- 
Kees Cook
