Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F644E3FED
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbiCVN6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbiCVN6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:58:19 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB838300E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:56:52 -0700 (PDT)
Received: from [192.168.12.80] (unknown [182.2.69.158])
        by gnuweeb.org (Postfix) with ESMTPSA id 22E547E2DF;
        Tue, 22 Mar 2022 13:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647957411;
        bh=PjMcysHt2dknFDp2J9SgqL6N1EYY0N4Y0Qnc7+5AWNU=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=rXc5Yqn0rJPnMDmwFzT311hNYadKNDbfYhAXlKq1HdV4nFdHuj4d07ws2l6NaEKPu
         yjxuOTNcFslyG1L5AgvuqxyEMfDa8YGIZ3vSXSCoMdCcU629fqWOmQNHoq9gSf+KFS
         nb0YUhj7LC2xiNE0+zGXuTwBWAwd+ygrOQiEyKQnjZnCO63MwIFQHH9R4WvUkxrhSX
         qcZ+zi5Lu8FhxEfc0iyIFb87KMgI0M3sk1OIj82XNInUR2CaUCO3hKVoqqtjrr+ROI
         bnCvuabDEuA7dLmYawUJ/SOjEi1Jnd2uSr+6w5+7kfL0orpqEPglbfbckgQvusnH7c
         JnkAxD+Yv2+bw==
Message-ID: <8f11bc01-4b63-eaf7-6da3-77556cfb0118@gnuweeb.org>
Date:   Tue, 22 Mar 2022 20:56:44 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v2 3/8] tools/nolibc: i386: Implement syscall with 6
 arguments
Content-Language: en-US
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>, David Laight <David.Laight@aculab.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
 <20220322102115.186179-4-ammarfaizi2@gnuweeb.org>
 <8653f6784a9b4272a59a75a530663567@AcuMS.aculab.com>
 <a8eeec1d-656d-15a3-dde5-0f8cc8c5956b@gnuweeb.org>
 <20220322121338.GD10306@1wt.eu>
 <81569a1c-a6d3-ceb2-a1f1-f229a024d684@gnuweeb.org>
 <20220322133413.GG10306@1wt.eu>
 <58cb5455-d065-b508-b328-20b57c3a67a7@gnuweeb.org>
 <3b8984ecfbcd4c93aeb468d01728cd74@AcuMS.aculab.com>
 <20220322134100.GH10306@1wt.eu>
 <9cfcb296-9dfe-aef1-4209-20a3a95c50ba@gnuweeb.org>
 <98304cd4-a443-5e5e-9764-654ecd1d458b@gnuweeb.org>
In-Reply-To: <98304cd4-a443-5e5e-9764-654ecd1d458b@gnuweeb.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/22 8:54 PM, Ammar Faizi wrote:
> 
> Willy, something goes wrong here...
> 
> ammarfaizi2@integral2:~/work/linux.work/tools/include/nolibc$ taskset -c 0 gcc -ffreestanding -nostdlib -nostartfiles test.c -o test -lgcc
> /usr/bin/ld: /tmp/ccHiYiks.o: warning: relocation against `environ' in read-only section `.text'
> /usr/bin/ld: /tmp/ccHiYiks.o: in function `getenv':
> test.c:(.text+0x1f76): undefined reference to `environ'
> /usr/bin/ld: test.c:(.text+0x1fc3): undefined reference to `environ'
> /usr/bin/ld: test.c:(.text+0x1ffc): undefined reference to `environ'
> /usr/bin/ld: test.c:(.text+0x2021): undefined reference to `environ'
> /usr/bin/ld: test.c:(.text+0x2049): undefined reference to `environ'
> /usr/bin/ld: warning: creating DT_TEXTREL in a PIE
> collect2: error: ld returned 1 exit status
> ammarfaizi2@integral2:~/work/linux.work/tools/include/nolibc$
> 
> 
> I suspect it's caused by commit:
> 
> commit c970abe796019b3d576fd154a54b94efb35c02b1
> Author: Willy Tarreau <w@1wt.eu>
> Date:   Mon Mar 21 18:33:08 2022 +0100
> 
>      tools/nolibc/stdlib: add a simple getenv() implementation
>      This implementation relies on an extern definition of the environ
>      variable, that the caller must declare and initialize from envp.
>      Signed-off-by: Willy Tarreau <w@1wt.eu>
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> I will take a look deeper on this...

This bug only exists when compiling without optimization.

-- 
Ammar Faizi
