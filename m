Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757E2540412
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344214AbiFGQuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237110AbiFGQuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:50:35 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4C43464A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 09:50:31 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4LHbvT0fRrz1qyc6;
        Tue,  7 Jun 2022 18:50:29 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4LHbvS6s9Wz1qqkC;
        Tue,  7 Jun 2022 18:50:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id OzqzI33oF718; Tue,  7 Jun 2022 18:50:28 +0200 (CEST)
X-Auth-Info: 1g4T+5031Hi3noBMLzrRy6buVNpO0fY89VJFB5X85JarwVF+T0y/Y419JziLBmyf
Received: from igel.home (ppp-46-244-165-19.dynamic.mnet-online.de [46.244.165.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue,  7 Jun 2022 18:50:27 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 87E3A2C39FE; Tue,  7 Jun 2022 18:50:27 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [git pull] drm for 5.19-rc1
References: <CAPM=9tw62EZfAm0PbiOPmMrpfR98QMFTWGEQcA34G4ap4xxNkA@mail.gmail.com>
        <CAMuHMdXb5-gOVRsQx6tDqjQMD9cC-p=o56VuF2cBPWyMFRgHMA@mail.gmail.com>
X-Yow:  Where do your SOCKS go when you lose them in th' WASHER?
Date:   Tue, 07 Jun 2022 18:50:27 +0200
In-Reply-To: <CAMuHMdXb5-gOVRsQx6tDqjQMD9cC-p=o56VuF2cBPWyMFRgHMA@mail.gmail.com>
        (Geert Uytterhoeven's message of "Tue, 7 Jun 2022 12:22:41 +0200")
Message-ID: <877d5s2zak.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 07 2022, Geert Uytterhoeven wrote:

> On Wed, May 25, 2022 at 4:49 PM Dave Airlie <airlied@gmail.com> wrote:
>>       drm/amdgpu: add nbio v7_7_0 ip headers
>
> These header files are heavy users of large constants lacking the "U"
> suffix e.g.:
>
>     #define NB_ADAPTER_ID__SUBSYSTEM_ID_MASK 0xFFFF0000L
>
> Assigning this to unsigned long on 32-bit will trigger a signed integer
> overflow, which is technically UB, and causes "error: initializer
> element is not constant" warnings with gcc-5 and -std-gnu11, cfr. [1]

That shouldn't happen here, as hexadecimal constants will be of unsigned
type if they don't fit in the corresponding signed type.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
