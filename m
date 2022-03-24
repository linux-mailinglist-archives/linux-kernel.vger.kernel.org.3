Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3574E6979
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 20:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353172AbiCXTrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 15:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353073AbiCXTrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:47:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088C75FF04;
        Thu, 24 Mar 2022 12:45:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D83F561A8B;
        Thu, 24 Mar 2022 19:45:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1003C340F3;
        Thu, 24 Mar 2022 19:45:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pvNk/hk7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1648151127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3E5n0l/SMZrlGP6IQ3f3LYhfPfUyDZgYqNGS637EF4M=;
        b=pvNk/hk72AyPH1TUID10lKmEyRhXXn9E6xOmocoFqyxFGrGjKC+1Ojte2FOy7MdoSvx7Lh
        ziogSfIRrYf9nJ6pxcOAIKzOWgpw8BOpbW4yx5hwoGF1kY/v8iJj3aHRWct1xlqh6yptMj
        +jaf7COwHNLn3WDRs6CGsmmX7T8irOI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b1f63894 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 24 Mar 2022 19:45:27 +0000 (UTC)
Received: by mail-yb1-f182.google.com with SMTP id v35so10288739ybi.10;
        Thu, 24 Mar 2022 12:45:27 -0700 (PDT)
X-Gm-Message-State: AOAM531B3/SiuY5o6A7D84t28CK4DF/UuXAoAgAUQfxpKzxeqclZwjtM
        uF+7WF79TT2mBo3eHQ7XgC5O9ZJZxyODV63Om7U=
X-Google-Smtp-Source: ABdhPJzhXza5UPDGX/g6la7IovbrYmOcqC5lbjD9qeCcNBOP2puS+p6YQvNAU3dqTzJ5hbwjMOP6TVkdwcUX758HTu4=
X-Received: by 2002:a25:ad83:0:b0:633:abf6:5f69 with SMTP id
 z3-20020a25ad83000000b00633abf65f69mr6103638ybi.382.1648151125860; Thu, 24
 Mar 2022 12:45:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:4707:b0:171:cd8f:b3d2 with HTTP; Thu, 24 Mar 2022
 12:45:25 -0700 (PDT)
In-Reply-To: <PH0PR21MB30251D429344378FE8D47E35D7199@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <CAHmME9qHnvwrxEue4Pdm_E1qZQGXFuR9orJSKCWj8fH5TSh6fA@mail.gmail.com>
 <20220228183355.9090-1-Jason@zx2c4.com> <CAHp75VcjrD3kwN1BfWpjKXaVpG7MHfftMUscSGhcJfStm4b-Xg@mail.gmail.com>
 <CAMj1kXFmEAKJRHCiuXyGECCmOs0+xX9AVeBDxfuD0XuX2TQ2Uw@mail.gmail.com>
 <Yh0+LA8B1jw8tnl9@smile.fi.intel.com> <CAHmME9qW4EiYU6_kTffMdK5ijJY1DF6YRt=gDjj1vKqDxB0Raw@mail.gmail.com>
 <MN0PR21MB3098981B77F513976A62CA57D7019@MN0PR21MB3098.namprd21.prod.outlook.com>
 <CAMj1kXFZZoOeXnjxdU+gOJTN=Szn=eiXgRhSS9_nnHgwADNHjA@mail.gmail.com>
 <MN0PR21MB3098EC13B4E8488E692DB28AD7019@MN0PR21MB3098.namprd21.prod.outlook.com>
 <CAMj1kXFe-B=n1zp6M0yBuqJmmfOXTFbkzj29iK+QpPGK=LxRmA@mail.gmail.com>
 <PH0PR21MB30253A8BA8B189686B8E65EAD7179@PH0PR21MB3025.namprd21.prod.outlook.com>
 <CAMj1kXEExWbD9imqNUr1RYRzJmbQX5i3CdG7MPseQh8Q=N1y9g@mail.gmail.com> <PH0PR21MB30251D429344378FE8D47E35D7199@PH0PR21MB3025.namprd21.prod.outlook.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 24 Mar 2022 13:45:25 -0600
X-Gmail-Original-Message-ID: <CAHmME9pZW_nu3nACPHO063t8gViMRfV7JFXUjbzDt+f362NEgA@mail.gmail.com>
Message-ID: <CAHmME9pZW_nu3nACPHO063t8gViMRfV7JFXUjbzDt+f362NEgA@mail.gmail.com>
Subject: Re: [PATCH 2/3 v6] ACPI: allow longer device IDs
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/22, Michael Kelley (LINUX) <mikelley@microsoft.com> wrote:
> From: Ard Biesheuvel <ardb@kernel.org> Sent: Tuesday, March 22, 2022 3:07
> PM
>>
>> On Tue, 22 Mar 2022 at 20:59, Michael Kelley (LINUX)
>> <mikelley@microsoft.com> wrote:
>> >
>> > The Hyper-V guys pass along their thanks for your suggestion.  They
>> > have
>> > created an internal build with the change and verified that it
>> > preserves
>> > compatibility with Windows guests.  I've tested with Linux guests and
>> > Jason's new driver (modified to look for "VMGENCTR"), and it all looks
>> > good.
>> > It will take a little while to wend its way through the Windows/Hyper-V
>> > release system, but they are planning to take the change.
>> >
>>
>> Thanks for reporting back.
>>
>> Will the spec be updated accordingly?
>
> The Hyper-V team is looking into updating the spec.  The document
> is 10 years old, so they need to find the original source for the PDF.
>

Lol, here's the docx:
https://download.microsoft.com/download/3/1/C/31CFC307-98CA-4CA5-914C-D9772691E214/VirtualMachineGenerationID.docx
