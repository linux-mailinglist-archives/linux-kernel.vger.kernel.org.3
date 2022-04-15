Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFC4502C1E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 16:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354667AbiDOOsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 10:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbiDOOsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 10:48:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7CC73041
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 07:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=QWxdhbL8bXm/fNhn6GXmwt668iO5RiNBagKq9feE/Fo=; b=W72ZZbjGfB/fnnZ02Pihi6NHkn
        lrIO5UceziNVJjvzdRS0PYq8kLQoAK4Nu7zkrC94GwEA6j6J8UkSOIrhn4/+Ov76aGj3L+uOBmGor
        33xN1DmIGjgc1QrGRRBImTYhAr5iz8osT03d8vhGH339njujF5sp2EqEh2GSCAh9r4dy1MFeqYnvn
        1ciFtQbbdtTMBgrPFtAAGfJInAY0CXnWy7lm6NwpBKX88N6w/q1rrB6BkD5R6cJYvq3M6m0QgWfMy
        k4IqwvWONH8AsfDUiSd4ly6HumNXofrhxV4XYxnWDlmgOfxmKjX7fx3tR+lLFsbRuHidSALWfyYZw
        mM/BlECQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfNCg-005Ppn-1C; Fri, 15 Apr 2022 14:45:42 +0000
Message-ID: <34f3fe4a-7d75-d007-2b22-54d44f49a435@infradead.org>
Date:   Fri, 15 Apr 2022 07:45:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3] sound/oss/dmasound: fix build when drivers are mixed
 =y/=m
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20220405234118.24830-1-rdunlap@infradead.org>
 <20220415134852.GA2271702@roeck-us.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220415134852.GA2271702@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/15/22 06:48, Guenter Roeck wrote:
> On Tue, Apr 05, 2022 at 04:41:18PM -0700, Randy Dunlap wrote:
>> When CONFIG_DMASOUND_ATARI=m and CONFIG_DMASOUND_Q40=y (or vice versa),
>> dmasound_core.o can be built without dmasound_deinit() being defined,
>> causing a build error:
>>
>> ERROR: modpost: "dmasound_deinit" [sound/oss/dmasound/dmasound_atari.ko] undefined!
>>
>> Modify dmasound_core.c and dmasound.h so that dmasound_deinit() is
>> always available.
>>
>> The mixed modes (=y/=m) also mean that several variables and structs
>> have to be declared in all cases.
>>
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Link: lore.kernel.org/r/202204032138.EFT9qGEd-lkp@intel.com
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Jaroslav Kysela <perex@perex.cz>
>> Cc: Takashi Iwai <tiwai@suse.com>
>> Cc: alsa-devel@alsa-project.org
>> ---
> 
> m68k:allmodconfig fails to build with this patch in the tree.
> 
> Error log:
> sound/oss/dmasound/dmasound_core.c:1431:12: error: 'dmasound_setup' defined but not used
> 
> ... because __setup() is empty if MODULE is defined.
> 
> Guenter

Takashi has already merged a patch for this from Miles Chen.

thanks.

-- 
~Randy
