Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E74547DDA3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 03:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345672AbhLWCMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 21:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhLWCMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 21:12:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC515C061574;
        Wed, 22 Dec 2021 18:12:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1887561C2C;
        Thu, 23 Dec 2021 02:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758F0C36AF2;
        Thu, 23 Dec 2021 02:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640225569;
        bh=CDmqTRF2LGRmxpzLtcjy4Vzvp8M7nfS3Pyz+9roYHtU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=roGTWb1in5sqhq0reNrozfr5WBrjXPwekIdfHy6Cxb3A2Bo/PXLfahluePDrv5bpe
         GWF08i8o5GeDS7uL0X2/F/Dm/cESZZkL9wIXx4sKWHjc5AUiDRUtHOmbACKhOH6HUg
         eBApsrwXggQBzFxhaspprA273ELiejffZiBEpWvIWAv8mGnDWkytEP1DhIb7GiWaKD
         VC65lgzNe0yOCtz8B96bLYGaZxWS27cioWEQMebP1DtApSi0Nj4dpguPZS561bsAZi
         c70syXDVgYME0fqEXn7IMMh63RrRPLI51Q+mhcqbznC6sX8JxsGTQcEhinva/n3oaw
         g+7oM3+0bJPQQ==
Received: by mail-ua1-f47.google.com with SMTP id p37so7306280uae.8;
        Wed, 22 Dec 2021 18:12:49 -0800 (PST)
X-Gm-Message-State: AOAM530uBc3FIHUULAY56LAJvcasq368v81fxvBY5C9WGQahv3GEJ4vj
        iDCTkifUdNiCEq5p71gW0PmD/kaAq64g7T3fA98=
X-Google-Smtp-Source: ABdhPJxTedV2XFghjTyRC5imf+6XJLTz0d7aL0KW95ASmjx0K+4ZXtdiAtvy82fd5Cp6FWJ53e/V4Vw7XdzFTXrg9DU=
X-Received: by 2002:a05:6102:a83:: with SMTP id n3mr138109vsg.2.1640225568308;
 Wed, 22 Dec 2021 18:12:48 -0800 (PST)
MIME-Version: 1.0
References: <20211221163532.2636028-1-guoren@kernel.org> <20211221163532.2636028-3-guoren@kernel.org>
 <CAK8P3a3dS=Ne0Pd2qZc8vB2whM7AUcJ1BNbhtf6EEboWAPpSug@mail.gmail.com>
 <CAJF2gTTN1HZeycK-WOFH0EjmjtBB4T=9de6Qrjs=uhAsLoOFaQ@mail.gmail.com>
 <CAK8P3a3m2Mz4Tvu+3cdji6iq_wvFZsYoyKvnaNKTEjE+ivex6A@mail.gmail.com>
 <CAJF2gTQEp0hEousuEyp5cPCa5Remb_8HMZ-BXZ393_z7hbne7g@mail.gmail.com> <CAK8P3a165oWeGOgsM=U3F54e4HFvhJxr2sG0qoGLOe_WK8qAtw@mail.gmail.com>
In-Reply-To: <CAK8P3a165oWeGOgsM=U3F54e4HFvhJxr2sG0qoGLOe_WK8qAtw@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 23 Dec 2021 10:12:37 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR4TXXWQ5Ubnz6HdoOmV=EkL9AsEH07RzmVypyeK353vw@mail.gmail.com>
Message-ID: <CAJF2gTR4TXXWQ5Ubnz6HdoOmV=EkL9AsEH07RzmVypyeK353vw@mail.gmail.com>
Subject: Re: [PATCH 02/13] riscv: Fixup difference with defconfig
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 9:52 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Dec 22, 2021 at 2:06 PM Guo Ren <guoren@kernel.org> wrote:
> > On Wed, Dec 22, 2021 at 8:51 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Wed, Dec 22, 2021 at 12:34 PM Guo Ren <guoren@kernel.org> wrote:
> > > Given that there are no specific rv32 SoC implementations supported
> > > by the kernel today (other than SOC_VIRT), the number of users
> > > would be close to zero anyway.
> > I really agree with you, but we still need the rv32 user mode
> > ecosystem for memory footprint.
>
> Sure, I just meant there are few users that would have to relearn typing
> "make defconfig 32-bit.config" instead of "make rv32_defconfig" even
> without the added Makefile target.
Emm... I got you.

Next version, I would send delete rv32_defconfig patch. If Palmer
object, I would change to make rv32_defconfig target. ;)

>
>          Arnd


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
