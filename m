Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E6A4C5DEF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 18:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiB0R5U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 27 Feb 2022 12:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiB0R5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 12:57:19 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7B44BFF3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 09:56:42 -0800 (PST)
Date:   Sun, 27 Feb 2022 17:56:31 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH -next] misc: rtsx: fix build for CONFIG_PM not set
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei WANG <wei_wang@realsil.com.cn>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <7U5Z7R.RNKITPUWCPX32@crapouillou.net>
In-Reply-To: <CAK8P3a3=5uud3jd7N3FEAnaLapX-0OYaiscBFNEQm2hzkTmj7g@mail.gmail.com>
References: <20220226222457.13668-1-rdunlap@infradead.org>
        <CAK8P3a07PoFGC8jyRG5_CjfVPCc2T79c7Fs_WmHZEkuqtG+oPg@mail.gmail.com>
        <449d6ceb-7308-9543-c23c-831bebffda21@infradead.org>
        <CAK8P3a30RbSk3Y5CyRrOjfTiq0c9XGxC3qjAD0154j3a7k+xQQ@mail.gmail.com>
        <0D5Z7R.NUOWBMRT4GQ2@crapouillou.net>
        <CAK8P3a3=5uud3jd7N3FEAnaLapX-0OYaiscBFNEQm2hzkTmj7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le dim., févr. 27 2022 at 18:51:38 +0100, Arnd Bergmann 
<arnd@arndb.de> a écrit :
> On Sun, Feb 27, 2022 at 6:46 PM Paul Cercueil <paul@crapouillou.net> 
> wrote:
>>  Le dim., févr. 27 2022 at 18:30:16 +0100, Arnd Bergmann
>> 
>>  There could be a DEFINE_DEV_PM_OPS(), but I don't think that's 
>> really
>>  needed - you can very well declare your struct dev_pm_ops without 
>> using
>>  one of these macros. Just make sure to use the SYSTEM_SLEEP_PM_OPS /
>>  RUNTIME_PM_OPS macros for the callbacks and pm_ptr() for the 
>> device.pm
>>  pointer.
> 
> Ah, of course, so it comes down to
> s/SET_SYSTEM_SLEEP_PM_OPS/SYSTEM_SLEEP_PM_OPS/ while
> removing all the #ifdef an __maybe_unused annotations. The pm_ptr()
> in driver.pm makes this slightly more optimized AFAICT, but has no
> effect on behavior, right?

The use of SYSTEM_SLEEP_PM_OPS makes sure that the callbacks are 
dropped if the dev_pm_ops is dead code, and the pm_ptr() must be used 
for the compiler to know that the dev_pm_ops is dead code.

-Paul


