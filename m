Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBBD506C39
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352225AbiDSMYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbiDSMYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:24:32 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F99C2CC90;
        Tue, 19 Apr 2022 05:21:50 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ngmrU-000RXz-5F; Tue, 19 Apr 2022 14:21:40 +0200
Received: from p57bd9f4f.dip0.t-ipconnect.de ([87.189.159.79] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ngmrT-003azM-Uv; Tue, 19 Apr 2022 14:21:40 +0200
Message-ID: <d9ef4940-9aca-1932-c04d-e554cecfbe31@physik.fu-berlin.de>
Date:   Tue, 19 Apr 2022 14:21:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] sh: make !MMU iounmap an inline function
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>, kernel@axis.com,
        Christoph Hellwig <hch@lst.de>,
        kernel test robot <lkp@intel.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Landley <rob@landley.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20220414081257.1487499-1-vincent.whitchurch@axis.com>
 <76a7b33d-6f8b-e660-c64d-027b1bc8e308@landley.net>
 <CAMuHMdW-8HaQip+DT5W2Owq8M8kbYwHsf8_Zd-5rRfSjSjK0=g@mail.gmail.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <CAMuHMdW-8HaQip+DT5W2Owq8M8kbYwHsf8_Zd-5rRfSjSjK0=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.159.79
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert!

On 4/19/22 11:42, Geert Uytterhoeven wrote:
> Hi Rich, Sato-san,
> 
> On Sat, Apr 16, 2022 at 12:01 AM Rob Landley <rob@landley.net> wrote:
>> On 4/14/22 03:12, Vincent Whitchurch wrote:
>>> The current definition of sh's !MMU iounmap makes it unusable in certain
>>> kinds of code, such as this instance caught by 0day on a patch posted to
>>> the mailing lists:
>>>
>>>  In file included from include/linux/io.h:13,
>>>                   from drivers/mtd/devices/phram.c:21:
>>>  drivers/mtd/devices/phram.c: In function 'register_device':
>>>  arch/sh/include/asm/io.h:274:33: error: expected expression before 'do'
>>>    274 | #define iounmap(addr)           do { } while (0)
>>>        |                                 ^~
>>>  drivers/mtd/devices/phram.c:150:44: note: in expansion of macro 'iounmap'
>>>    150 |         cached ? memunmap(new->mtd.priv) : iounmap(new->mtd.priv);
>>>        |                                            ^~~~~~~
>>>
>>> Make it an inline function as it was earlier.
>>>
>>> Link: https://lore.kernel.org/lkml/202204131446.omJ5mC54-lkp@intel.com/
>>> Fixes: 13f1fc870dd747131 ("sh: move the ioremap implementation out of line")
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
>>
>> Tested-by: Rob Landley <rob@landley.net>
>>
>> Worked For Me.
> 
> Can we please get any of [1], [2], [3], or [4] applied and sent
> upstream, so people can stop wasting time on recreating and
> resubmitting similar patches all the time?

I agree. Those patches shouldn't be sent in vain. I very much appreciate everyone
sending in patches to improve Linux support for SH which is why I find it saddening
that the maintainers don't find enough time to review the patches.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

