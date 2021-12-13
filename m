Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0694E47341B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241876AbhLMSer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237355AbhLMSep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:34:45 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCD7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:34:45 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id r11so54411381edd.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vIyY6p2EZlLqvkpDw90dPzbnUYj0Y0TXgSTtv3pwKXg=;
        b=J7ur5TAWevBbsI8h6USlM3dUQ7+7Mv2HnRlkEJYzPRTHEhMSVi7T4fY7vtSC5i4QT4
         M5td+aQXfDFkd2CikoPDIe/wfA9nL8Y9/g2b7PaKxa0TADHyRzziV5xWtI9N1fvmsRYh
         R0dAF1+8ln0zPDbFV22IkTj+2kwIeH3CYlWLcav6wi4lDUkCPsdIlyUYil+rWMiQwh2J
         NhmPcRjRunsRZ1cZVOZfztw3zlLQh7Eecq7oGnLBZukhodOWLpiLg/UVY8BNvSYf9Ns0
         OksgSO1g8sY5AUpmDQ8wpnQLZ+bq7LRDLKdN5Tvg5maeOZsdOHNw8nKyNdzLdZgKUCiW
         uNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vIyY6p2EZlLqvkpDw90dPzbnUYj0Y0TXgSTtv3pwKXg=;
        b=fri7fnAuZmfkdpC7FgxHx5gdI74mJAUhRLjuicHit7kIVYeOY/OJsyORcrGNfob6FY
         zX/56LsF8WB0YGBGCNzRdzjloZARpKCfz8Am4PvHmjjL4QCGjylAIO1GHZSizeBiSUiS
         oBvoBJtDyEH9xjtGxO6ZIpGEwmHQSClv2nRO9GElmIUYq0lty/EMfuCWDYJOPZKmRcCH
         Zx0G8TgT5FlfDiol0W+U3fgHc6E3PKVwbLwwjUMiOxfoB4htXY0lS4J09zBKIogv5WPJ
         DwGzGdiSMHVNxi2CEC6yMD7NcpbDF/FCP/Q2De2koFqkQ/OIQ3RyBWM5XdgXiLEScGAe
         YBEA==
X-Gm-Message-State: AOAM530To+Dbmx2JXL7245BQpayaoy1zMkHaY9c466qSuTMmoyI7rVr9
        oG3IKrFpIlRUmhzuUZux1qfcxG3BMg==
X-Google-Smtp-Source: ABdhPJzJFloF5r6zXDs6qopBcUai3Uq45DVzW1MoEH4XsxcjMTx/w27ev6S8ZnBq24tfAcFbfHBF3Q==
X-Received: by 2002:a17:907:7e95:: with SMTP id qb21mr86775ejc.678.1639420483986;
        Mon, 13 Dec 2021 10:34:43 -0800 (PST)
Received: from localhost.localdomain ([46.53.251.150])
        by smtp.gmail.com with ESMTPSA id w7sm6758846ede.66.2021.12.13.10.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 10:34:43 -0800 (PST)
Date:   Mon, 13 Dec 2021 21:34:41 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] fs/binfmt_elf.c: disallow zero entry point address
Message-ID: <YbeSQfdSuo5CmIub@localhost.localdomain>
References: <20211211173447.4155374-1-hjl.tools@gmail.com>
 <CACVxJT-k664=aYp4VkG1LH3PsGHEf50PqP5EA+JWiFVb_JVs2Q@mail.gmail.com>
 <CAMe9rOqM+S_uBO-t5jJ1TLVD0R-LOJEiR6htb+k05c+ak7gF-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMe9rOqM+S_uBO-t5jJ1TLVD0R-LOJEiR6htb+k05c+ak7gF-g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2021 at 05:52:14AM -0800, H.J. Lu wrote:
> On Sat, Dec 11, 2021 at 11:38 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > On 12/11/21, H.J. Lu <hjl.tools@gmail.com> wrote:
> > > According to gABI, the entry point address in the ELF header gives the
> > > virtual address to which the system first transfers control, thus
> > > starting the process.  If the file has no associated entry point, this
> > > member holds zero.  Update the ELF loader to disallow an ELF binary
> > > with zero entry point address.  This fixes:
> > >
> > > https://bugzilla.kernel.org/show_bug.cgi?id=215303
> > >
> > > Tested by booting Fedora 35 and running a shared library with zero entry
> > > point address:
> > >
> > > $ readelf -h load.so | grep "Entry point address:"
> > >   Entry point address:               0x0
> > > $ ./load.so
> > > bash: ./load.so: cannot execute binary file: Exec format error
> >
> > Why not let it segfault?
> >
> > > +     if (elf_ex->e_entry == 0)
> > > +             goto out;
> 
> Why let it segfault?

Such babysitting adds a branch for everyone to catch small number of
binaries.

e_entry can point to kernelspace, and it should segfault on the first
instruction (correctly).

It can iincorrectly point to unmapped area or VMA with wrong permissions,
with the same effect. But now check is more costly.
