Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C395D4AB6FB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241091AbiBGIxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349261AbiBGIqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:46:36 -0500
X-Greylist: delayed 503 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 00:46:33 PST
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9651C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 00:46:33 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Jsffm0nXYz1rB81;
        Mon,  7 Feb 2022 09:38:08 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4Jsffm00XGz1qqkP;
        Mon,  7 Feb 2022 09:38:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 7iAGubkoVI4f; Mon,  7 Feb 2022 09:38:07 +0100 (CET)
X-Auth-Info: 3fmUPnVS0Kvboy0oxbh9eBJwvyO+NTPtLCgh38lLIqw+6NL2h6OEzMlpGRGwyssh
Received: from igel.home (ppp-46-244-191-16.dynamic.mnet-online.de [46.244.191.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  7 Feb 2022 09:38:07 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 9D7122C36AF; Mon,  7 Feb 2022 09:38:06 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] riscv: reduce THREAD_SIZE from 16KB to 8KB for RV64
References: <20220206174359.2986-1-jszhang@kernel.org>
        <CAEn-LTrZwq1-6F8PWScGPp1TRk1eaB-7qOrvPjyLhK=OzDTQBQ@mail.gmail.com>
X-Yow:  ..  One FISHWICH coming up!!
Date:   Mon, 07 Feb 2022 09:38:06 +0100
In-Reply-To: <CAEn-LTrZwq1-6F8PWScGPp1TRk1eaB-7qOrvPjyLhK=OzDTQBQ@mail.gmail.com>
        (David Abdurachmanov's message of "Mon, 7 Feb 2022 10:05:14 +0200")
Message-ID: <87bkzjvzpt.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 07 2022, David Abdurachmanov wrote:

> On Sun, Feb 6, 2022 at 7:53 PM Jisheng Zhang <jszhang@kernel.org> wrote:
>>
>> After irq stack is supported, it's possible to use small THREAD_SIZE.
>> In fact, I tested this patch on a Lichee RV board, looks good so far.
>
> We went from 8K to 16K somewhere in mid-2020 on riscv64 because we
> were seeing some random crashes in various distributions (Debian,
> Fedora, OpenSUSE). Thus we matched what other popular arches do, i.e.
> 16K.

I think NFS is one of the worst offenders.  I'm running an Unleashed
with NFS root, which probably amplifies this.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
