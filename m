Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AAD5230A8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238394AbiEKK2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239660AbiEKK0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:26:35 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF88628716
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:26:24 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Kyrfk14BNz1r0mV;
        Wed, 11 May 2022 12:26:20 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4Kyrfh40nLz1qqkB;
        Wed, 11 May 2022 12:26:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id NxkthguitX5R; Wed, 11 May 2022 12:26:19 +0200 (CEST)
X-Auth-Info: tXIHxX5ZHslhb42XaJY3rZb8wZNgDXNyXF/IBEZkdDkmhIoND3kQLJkAM1OSuDJZ
Received: from igel.home (ppp-46-244-167-40.dynamic.mnet-online.de [46.244.167.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 11 May 2022 12:26:19 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 073C12C36A0; Wed, 11 May 2022 12:26:19 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] m68k: math-emu: Fix dependencies of math emulation support
References: <e0a9cf982a80f14efbf01cdc38e31128a9f41999.1652262437.git.geert@linux-m68k.org>
X-Yow:  I guess it was all a DREAM..  or an episode of HAWAII FIVE-O...
Date:   Wed, 11 May 2022 12:26:18 +0200
In-Reply-To: <e0a9cf982a80f14efbf01cdc38e31128a9f41999.1652262437.git.geert@linux-m68k.org>
        (Geert Uytterhoeven's message of "Wed, 11 May 2022 11:48:48 +0200")
Message-ID: <875ymcwek5.fsf@igel.home>
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

On Mai 11 2022, Geert Uytterhoeven wrote:

> Drop the dependency on MMU, as the code should work fine on 68020 and up
> without MMU (which are not yet supported by Linux, though).
> Add dependencies on M68K_CLASSIC (to rule out Coldfire) and FPU (to rule
> out 68xxx below 68020).

Depending on FPU looks strange, since that is supposed to be an FPU
emulation, for CPUs that _lack_ an FPU (ie. 680[23]0 without the
6888[12], or 68LC0[46]0).

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
