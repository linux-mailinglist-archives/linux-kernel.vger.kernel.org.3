Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB2D4F1DDC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387362AbiDDVnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380720AbiDDVMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 17:12:22 -0400
Received: from smtp.gentoo.org (dev.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171882F3B4;
        Mon,  4 Apr 2022 14:10:25 -0700 (PDT)
Subject: Re: [PATCH] MIPS: pgalloc: fix memory leak caused by pgd_free()
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Andrew Holmes <aholmes@omnom.net>
Cc:     yaliang.wang@windriver.com, rppt@kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        huangpei@loongson.cn, Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        anshuman.khandual@arm.com, penberg@kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
References: <20220310113116.2068859-1-yaliang.wang@windriver.com>
 <alpine.DEB.2.21.2204021446370.47162@angie.orcam.me.uk>
 <9cc88b1c-8a8c-95ea-2cf7-31be3b771495@omnom.net>
 <alpine.DEB.2.21.2204031122020.47162@angie.orcam.me.uk>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <4094bbe0-27b0-d83b-3b22-36d0d53769b5@gentoo.org>
Date:   Mon, 4 Apr 2022 17:10:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2204031122020.47162@angie.orcam.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/2022 06:37, Maciej W. Rozycki wrote:
> On Sun, 3 Apr 2022, Andrew Holmes wrote:
> 
>> MIPS64 has essentially been broken/unusable for 8 kernel releases,
>> including two LTS kernels, since the original commit landed. Should
>> there not have been CI/tests that caught this? It's pretty major!
> 
>  AFAIK the MIPS port is only maintained on the best effort basis nowadays 
> I'm afraid.  I.e. it's enthusiasts investing their free time for the joy 
> of fiddling with things.  So things are bound to break from time to time 
> and remain unnoticed for a while.  We're doing our best, but our resources 
> are limited.
> 
>  Taking these limitations into account I think Thomas has been doing a 
> tremendous job maintaining the MIPS port, but he hasn't been cc-ed on the 
> submission of the original change and it's very easy to miss stuff in the 
> flood that has only been posted to a mailing list.
> 
>   Maciej
> 

FWIW, hot off the presses is RFC9225:
https://datatracker.ietf.org/doc/html/rfc9225

4.  Best Current Practises

   1.  Authors MUST NOT implement bugs.

   2.  If bugs are introduced in code, they MUST be clearly documented.

   3.  When implementing specifications that are broken by design, it is
       RECOMMENDED to aggregate multiple smaller bugs into one larger
       bug.  This will be easier to document: rather than having a lot
       of hard-to-track inconsequential bugs, there will be only a few
       easy-to-recognise significant bugs.

   4.  The aphorism "It's not a bug, it's a feature" is considered rude.

   5.  Assume all external input is the result of (a series of) bugs.
       (Especially in machine-to-machine applications such as
       implementations of network protocols.)

   6.  In fact, assume all internal inputs also are the result of bugs.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
rsa6144/5C63F4E3F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
