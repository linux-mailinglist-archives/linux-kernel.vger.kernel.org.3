Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC50C5462B9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347978AbiFJJsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347895AbiFJJsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:48:02 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D6266FBE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:47:58 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4LKGNS1WL2z1sCJ8;
        Fri, 10 Jun 2022 11:47:52 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4LKGNS0Y1xz1qqkC;
        Fri, 10 Jun 2022 11:47:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id ZVrNQR93sT2h; Fri, 10 Jun 2022 11:47:50 +0200 (CEST)
X-Auth-Info: 162ru3Q4VMnzLLQFOilR4v/i0ZvUQvOcexKpJLxzQGil3ncYElNin4Gd1Y9MaVVm
Received: from igel.home (ppp-46-244-161-94.dynamic.mnet-online.de [46.244.161.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 10 Jun 2022 11:47:50 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 411B52C3AC6; Fri, 10 Jun 2022 11:47:50 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     kernel test robot <lkp@intel.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: {standard input}:3978: Error: value 178 out of range
References: <202206100855.uY63FJUH-lkp@intel.com>
        <CAMuHMdVGdzkaT=SR2OWoN9S=Xr-2Ckki41P_p7t4WDgRLzfuGg@mail.gmail.com>
X-Yow:  NANCY!!  Why is everything RED?!
Date:   Fri, 10 Jun 2022 11:47:50 +0200
In-Reply-To: <CAMuHMdVGdzkaT=SR2OWoN9S=Xr-2Ckki41P_p7t4WDgRLzfuGg@mail.gmail.com>
        (Geert Uytterhoeven's message of "Fri, 10 Jun 2022 10:46:21 +0200")
Message-ID: <87wndoalyx.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 10 2022, Geert Uytterhoeven wrote:

> The offending instruction is:
>
>     | drivers/scsi/mpi3mr/mpi3mr_fw.c:299:  switch (host_tag) {
>             mvz.w %d2,%d0   | tmp160, host_tag
>             mov3q.l #5,%d1  |,
>             cmp.l %d0,%d1   | host_tag,
>             jcs .L154               |
>             tst.w %d6       | host_tag
>             jeq .L133               |
>             subq.l #2,%d2   |, tmp238
>             mvz.w %d2,%d2   | tmp238, tmp240
>             mov3q.l #3,%d0  |,
>             cmp.l %d2,%d0   | tmp240,
>             jcs .L140               |
>             add.l %d2,%d2   | tmp244
>>>>         move.w .L155(%pc,%d2.l),%d0     |, tmp245
>             jra .L186               |
>
> And the table L155 is just too far from the above instruction, so
> the displacement is too large, causing the failure.
>
> Looks like a compiler bug to me?

Yes, it's https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104028.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
