Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C264F204E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 01:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiDDXgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 19:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiDDXgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:36:24 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F81C3F8B7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 16:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649115267; x=1680651267;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+5MMmPyU6ZJJ0lTiy81U+nJ/FsY36S456cHlcxHKPSc=;
  b=GZ3sQW0Dt2G/vJUHhRBpCfLQQqZdIinr4M4odtJPhbp7NxZOQB+BmwoD
   9+05I9fZJeciULNJntaHLxZU+bCJJDilDRaC6HcyGm+xKwUOWcAdhtnIC
   enAilUlJtrLpQ/0ibjja74atkfZ4EMlmrezX3AgqcxJF0niS5pDBpSW5p
   2SteKK/yAkiRZnnL1bjoTMg+cm9WpWgfXX/4MNKXnZ/0te7DASvlN4I4O
   q1EQL/p87bnPm8VK5qQVc61DhI3vt2k9bN/LOIove1rfL5+odBp3Ps3ey
   sP4XnWdDYObxiqb2qyS7cEdmMUPkYbxUiESBGb2Pjh9WvUrw78BgyOQCm
   w==;
X-IronPort-AV: E=Sophos;i="5.90,235,1643644800"; 
   d="scan'208";a="301247868"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Apr 2022 07:34:25 +0800
IronPort-SDR: 51iFTQh1un3CsfZQU4YxnYa1yfwYJTy5LGbNtjFdhCIERZmuayl3fde0bNOJN5AjNX7WZZCE20
 JSgLot+QXXnY7s3vl8Ki5tqeEJV7EoVY0RYdfhc/UG2wh96tORloFMhkvILNgRi/pasGWdodc9
 VWUddfz576LH1YEUwZVfeIs3bosZKs7ZYuoD1QaxXkpQTTTwmQAutMgwVpTQd5kVeS9lq8QfF+
 G/J/WHIN5FefsfGb/tSYXUooYzDeqJc0kv+Z3QkOTL1A+5phY9IpRHFpI2TF6G9PvrtW5GWbaG
 cLatrkuC/4MC6fJigCGUrD/d
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Apr 2022 16:05:59 -0700
IronPort-SDR: uUWoZEJP+1U0+y99uJdI1vUAgFQMY3XelGqU5otXUNvR7xGheSbTL8wNr9a6kcj4bnW8y+rtkm
 SzeXsg4uPxA4bJaKP2wRiPujaxF62YiPGTPx8SzZqfni6u8JNYVXL3QYNabhL0X6avTTAYph2q
 0OEMLZi2Txiw7LUkYjREmE3EtdUg4sFVv/hS7C8U+2uMxe1SUlzdtLtk92u0FAtcslhhZSSYdD
 DvFqLVyefz/hYOR0Co0r2nEMzhfM8NQrP8rc0wlfizatbd8y4MN6XXvNDIznhT9OyWCFK5U9hz
 4Oc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Apr 2022 16:34:26 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KXRv54DnKz1SVp1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 16:34:25 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649115264; x=1651707265; bh=+5MMmPyU6ZJJ0lTiy81U+nJ/FsY36S456cH
        lcxHKPSc=; b=NmXGSpihtKJypsJDwlOSBugs5bzoYpMuuBDgh/oBqIn+/Eb8mMq
        lI6D/MptbIBjXUVDl/UMgUaRdw4yZZvwum/7IJjbVyOrmgTT+k/7Pf/TIW2Szu6k
        gc7mfbb8PoLSzmV7Wh2r1w3TskdGFURxSc8XADmTZENiyab6u+3Ep2eTIOdqdSF6
        NWkS2OD25F1vSAjy1UWzi5Cy3L1OuNi1q6ge7xGAumKL2x02HwBUCiLi9eXMfRNm
        SiZfFUOR8TizSU1svfJKmtFfvy1CHmvgomNA5aLGazPZojpQLhdHYFwFf34/zQHz
        XYUG2Wmpho9kURuveUVhewHi9fGM2cECXOw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4P81XT2p8JJk for <linux-kernel@vger.kernel.org>;
        Mon,  4 Apr 2022 16:34:24 -0700 (PDT)
Received: from [10.225.163.2] (unknown [10.225.163.2])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KXRv20dN1z1Rvlx;
        Mon,  4 Apr 2022 16:34:21 -0700 (PDT)
Message-ID: <5245096f-6003-39a9-6e5e-db2fc4f567fd@opensource.wdc.com>
Date:   Tue, 5 Apr 2022 08:34:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PULL] remove arch/h8300
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Max Filippov <jcmvbkbc@gmail.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Rich Felker <dalias@libc.org>
References: <Yib9F5SqKda/nH9c@infradead.org>
 <CAK8P3a1dUVsZzhAe81usLSkvH29zHgiV9fhEkWdq7_W+nQBWbg@mail.gmail.com>
 <YkmWh2tss8nXKqc5@infradead.org>
 <CAK8P3a0QdFOJbM72geYTWOKumeKPSCVD8Nje5pBpZWazX0GEnQ@mail.gmail.com>
 <CAMuHMdWcg+171ggdVC4gwbQ=RUf+cYrX3o9uSpDxo-XXEJ5Qgw@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAMuHMdWcg+171ggdVC4gwbQ=RUf+cYrX3o9uSpDxo-XXEJ5Qgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/22 22:22, Geert Uytterhoeven wrote:
> Hi Arnd,
> 
> On Mon, Apr 4, 2022 at 3:09 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> On Sun, Apr 3, 2022 at 2:43 PM Christoph Hellwig <hch@infradead.org> wrote:
>>> On Tue, Mar 08, 2022 at 09:19:16AM +0100, Arnd Bergmann wrote:
>>>> If there are no other objections, I'll just queue this up for 5.18 in
>>>> the asm-generic
>>>> tree along with the nds32 removal.
>>>
>>> So it is the last day of te merge window and arch/h8300 is till there.
>>> And checking nw the removal has also not made it to linux-next.  Looks
>>> like it is so stale that even the removal gets ignored :(
>>
>> I was really hoping that someone else would at least comment.
> 
> Doh, I hadn't seen this patch before ;-)
> Nevertheless, I do not have access to H8/300 hardware.
> 
>> 3. arch/sh j2 support was added in 2016 and doesn't see a lot of
>> changes, but I think
>>     Rich still cares about it and wants to add J32 support (with MMU)
>> in the future
> 
> Yep, when the SH4 patents will have expired.
> I believe that's planned for 2016 (Islamic calendar? ;-)
> 
> BTW, the unresponsiveness of the SH maintainers is also annoying.
> Patches are sent to the list (sometimes multiple people are solving
> the same recurring issue), but ignored.
> 
> Anyway, I do regular boot tests on SH4.
> 
>> 5. K210 was added in 2020. I assume you still want to keep it.
> 
> FTR, I do regular boot tests on K210.

FYI, we identified the problem that makes userspace execution unreliable.
Working on a fix.


-- 
Damien Le Moal
Western Digital Research
