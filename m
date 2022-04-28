Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EF5512CA9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245102AbiD1H2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbiD1H2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:28:30 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8C21A3BE;
        Thu, 28 Apr 2022 00:25:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KpnFh33nTz4ySY;
        Thu, 28 Apr 2022 17:25:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1651130713;
        bh=C4UdvvBeWY91RIypqvjFLe8UHWVKtFwPIG23O7DBFW8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CPxAsekmTKCpn041eRTbmR2p7d+DCOZs+wTm/EvvQf+hNyaGcNArusaXqKJs6ONxW
         UosN18FRzbo4g0ROwCDiYBEEdgXw7k+Auv5HyQuv0ZHavLgWJTBY3gDR0aMeqI5+JN
         HodlYm2qK9nJycUJNQ+NUHESR8lDtZEzbOiOs1J+Kk2jc8qcwwT+dYC6el8gRKPEiP
         KBsN8b1z0sWIEwLX/RpeT0uE0GLVGui0CKCIFMlYzu1BX4MHiRKEWpMWrbMY+uIC+0
         D0qeTOP2iGhRVpKHh0RszaxhLXCKkcCeZSAysbdS39WVlSb9tp4hs/sGjFGOjoEhWM
         kgCB0Tzrqreeg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Helge Deller <deller@gmx.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Subject: Re: Build regressions/improvements in v5.18-rc1
In-Reply-To: <CAMuHMdX45omg_3pUPYnOdkwQC+wP89L3RE-GZq5A=jTHDqDJFA@mail.gmail.com>
References: <CAHk-=wg6FWL1xjVyHx7DdjD2dHZETA5_=FqqW17Z19X-WTfWSg@mail.gmail.com>
 <20220404074734.1092959-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2204041006230.1941618@ramsan.of.borg>
 <545e68c7-2872-9ee7-0b39-59c39f2bb9d1@gmx.de>
 <CAMuHMdX45omg_3pUPYnOdkwQC+wP89L3RE-GZq5A=jTHDqDJFA@mail.gmail.com>
Date:   Thu, 28 Apr 2022 17:25:08 +1000
Message-ID: <87fslxacvf.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:
> Hi Helge,
>
> CC Michael
>
> On Tue, Apr 5, 2022 at 8:45 AM Helge Deller <deller@gmx.de> wrote:
>> On 4/4/22 10:16, Geert Uytterhoeven wrote:
>> > On Mon, 4 Apr 2022, Geert Uytterhoeven wrote:
>> >> Below is the list of build error/warning regressions/improvements in
>> >> v5.18-rc1[1] compared to v5.17[2].
>> >>
>> >> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/3123109284176b1532874591f7c81f3837bbdc17/ (all 96 configs)
>> >> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f443e374ae131c168a065ea1748feac6b2e76613/ (all 96 configs)
>> >>
>> >> *** ERRORS ***
>> > parisc64-gcc8/generic-64bit_defconfig
>> > parisc-gcc8/generic-32bit_defconfig
>> > parisc-gcc8/parisc-allmodconfig
>> > parisc-gcc8/parisc-allnoconfig
>>
>> Someone needs to adjust how the parisc kernel is built on kisskb...
>>
>> The parisc platform got vDSO support, so now the 32- and 64-bit
>> hppa compiler needs to be installed when building (for 64-bit).
>>
>> In addition, it changed how to build a kernel:
>>  make ARCH=parisc                         # to build a 32-bit kernel
>>  or
>>  make ARCH=parisc64                       # to build a 64-bit kernel
>> (before ARCH=parisc was sufficient to build either for 32- or 64-bit).
>>
>> And, in case "CROSS_COMPILE=" is given, you need to give "CROSS32_COMPILE=" as well.
>> It's preferred to leave out both CROSS[32]_COMPILE= parameters and let
>> the environment detect the compilers automatically. They just need to be in $PATH.
>>
>> Who can change that on kisskb ?
>
> Michael (CCed).

Hi all,

Sorry for the delay, I don't have much time to work on kisskb these days :}

I've updated things to work. It required a bit of fiddling because the
cross compilers I use from kernel.org don't have hppa and hppa64 in the
same prefix. But I just rsync'ed them into a shared directory and that
seems to be working.

The two parisc configs we have are here, everything recent is green:

  http://kisskb.ellerman.id.au/kisskb/config/507/
  http://kisskb.ellerman.id.au/kisskb/config/508/

I also added gcc11 for parisc.

cheers
