Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560A84C19E5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 18:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243399AbiBWR1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239033AbiBWR1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:27:30 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B451E6;
        Wed, 23 Feb 2022 09:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645637214;
        bh=LPsjSmV0AW6oNRFK93v2KYQmZ22UPSkf9MaEPo7lXQU=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=E3Jk6KIMAqNpbIIBIcjuP0ahrnYMQNE97EUmmDfaUS6iLo8KQO7BBETbeYN5aSZhc
         ZtHzCZOhBk+BMkVC4l6aL+JsRxkTTbn9KW0Nnt+0SbIddByvSUC39QqIIA28WKzHk6
         jAyl5uBmGTNH3A52Tmi+y5ipRuyqUS7ARyiH5LgA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.191.154]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMGRK-1ncnZT3pIs-00JL2y; Wed, 23
 Feb 2022 18:26:53 +0100
Date:   Wed, 23 Feb 2022 18:26:51 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
Subject: [GIT PULL] parisc unaligned handler fixes for v5.17-rc6
Message-ID: <YhZuW0o9A4qhfdZ5@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:OKAG+fF1F81XlSTqFe02e38imDLCbDPCIbNqJSCCHmlK6pkJDk6
 YvfmCCJyFLM++lsSmxhdwhodHm6xCDK0yTZp/BmZI76GRV2ySbxI0rnFCnlZz/ZDag/XDd7
 WrpyziN7e8eL5JZEX8CSLw3zcDTkFkDKcsBzNj8NraRosRY2HqVFULMns8+/hsGpvwI+R8y
 6iNIG05MLvjjX03B5B49w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YZesXhFq358=:EWA2cRoXmJPRn89Z3HeAkr
 UDA/t2BE83CTFqbrvyvRCpJso+jg48E2OxHGoY2ifSPtBLfWYUg2xzkDRgNU7qvP7Vj2CSAMK
 A2TvdAHpdpV5km4MNY6TLrLK8v0Hs0N9iwu76fSK5A0XJL5qD47ZhPCkemy0lIhCqtsD6Icwi
 lJCJ6rRt0m+jXqfxQcLpcTAMacg6lKA7+OFIr8vB8irVgEoNsfo+IO4dQ3W5q/afktqAS5Itn
 MYFdIvjYftnO3DhrktlTpvbWP/2khwHScNALkWIUzRAh5Y2Pa15JYi01NxIbAEK7YDDDbfKm5
 KTDNEDH83/lCeZXqvHwz4CkfD7BgoaM8hfRhw4s9g86IQ/Pbzl0cRZqR0Z9u3vQa4Yg3L8mKi
 v3gANIhDfHeKHJopdNEMZQ+l+Q4wg8SUQ8VXf/QYPHSeH00EiXIutct1Ubo361Wqcoc0uj0sx
 p2bBgy/o5uek2mWldg4+d1xvESKvHAwrVN65GEaQ/dN5Kk9kV9NM5YnARIAuGiNmyxrAnuBDo
 wt1W4XlVm00Nn3nnTFUjmN/QAPs32it7t+Qdyxk8XSS7e5jQpIQc3gPfN3vearHAXOvuuvwFS
 wY54mfUiERULM+2ASY+aU+ohlDB81SPOwIn6LQWddG42Bw7/6LdFL/C2rmw5eAwE+QqrDQESa
 RoROBqWbhhGYd9cuMKdvXJph3HugzGa8tXH8B164QA/1wtlRU8ra3qUrGCMcTlyS3W8SgtwpW
 nU8FL1TXGaKP3KmgvXvzg60MTpCAFk5MIAVnuHwo02YXObEgCD7JdRD8fnfQCp4irqTBQ2uaw
 sDjW+lZCU3ID+hlsVlVKwlxd/TjggOF8j4AIxk0Jykpv+dF4us860pP3Q2SK1pgj+Nxw40vfj
 2ASkcMRoTT42zRf179e4R4iRnjDOxKUnIqsEm4wujTtFc+/qGrj/VagE9q3FMCQ3FevG+S2jO
 PapSb5/IoHW1fRFu18yo0/k6LwwNYicGFy1/ZDYNtypO71Pli0IFnPDVCxXuBZ1g6KpR+pX6H
 zFyggi74dC4U/J43sICnuOe66AiChp5eQksddcYl61vySojpgwNgmZ7wZIVbxhZpLNPzua2AJ
 QLTr1jXSsUN2uk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8b97cae315cafd7debf3601f88621e2aa8956ef3:

  Merge tag 'net-5.17-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2022-02-17 11:33:59 -0800)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.17/parisc-4

for you to fetch changes up to a97279836867b1cb50a3d4f0b1bf60e0abe6d46c:

  parisc/unaligned: Fix ldw() and stw() unalignment handlers (2022-02-23 18:01:06 +0100)

----------------------------------------------------------------
parisc unaligned handler fixes

Two patches which fix a few bugs in the unalignment handlers.  The fldd
and fstd instructions weren't handled at all on 32-bit kernels, the stw
instruction didn't checked for fault errors and the fldw_l and ldw_m
were handled wrongly as integer vs. floating point instructions.
Both patches are tagged for stable series.

----------------------------------------------------------------
Helge Deller (2):
      parisc/unaligned: Fix fldd and fstd unaligned handlers on 32-bit kernel
      parisc/unaligned: Fix ldw() and stw() unalignment handlers

 arch/parisc/kernel/unaligned.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)
