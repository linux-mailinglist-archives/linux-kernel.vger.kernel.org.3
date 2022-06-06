Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D206253E745
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbiFFLv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 07:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbiFFLvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 07:51:19 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CA527D0C2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 04:51:17 -0700 (PDT)
Received: from [192.168.88.254] (unknown [36.73.79.120])
        by gnuweeb.org (Postfix) with ESMTPSA id DEFBE7F7F3;
        Mon,  6 Jun 2022 11:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1654516277;
        bh=xS066RNFYXBkTn5epxLFYxfXH9r2y85e17PJRqJHmdc=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=olPq1n0+74Urgx+BMlpgHn5uyWzfInE13COp2RmOJ/9QiqmUZHzcnNqkFEQjlPTrv
         t0NyjIjpR5BiW7H2EHmC22hk6nY3ST9FqJ89s+2VkN1OHlx9SFJMY7+MnJy+kmzO4K
         RJsNc5gb2PPc6MqujDdUeTaJvmw+IvJ4VzCyxgw8n+etN243nv7oAsrk5voTUnmVqb
         Toz9A1xa5E/RSNThoLJPHGaPI7aKi8n12HrQ+5dewnJ9z4VGrdL7fdso+ZKh0sKR4D
         MQB11V5PjlDOjoLPCChsrrJy9EOGPBOccSBdDbni55qTnZ/nFuC2V365KeC4JndiU/
         ywrEpclsPyEGQ==
Message-ID: <ff7406ea-1fc5-515e-2e14-f1ce2587cd69@gnuweeb.org>
Date:   Mon, 6 Jun 2022 18:51:02 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Linux 5.19-rc1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wgZt-YDSKfdyES2p6A_KJoG8DwQ0mb9CeS8jZYp+0Y2Rw@mail.gmail.com>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <CAHk-=wgZt-YDSKfdyES2p6A_KJoG8DwQ0mb9CeS8jZYp+0Y2Rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/22 7:42 AM, Linus Torvalds wrote:
> So hey, let's start calming things down and testing this all.

Doesn't compile with clang 15, the fix is there:

https://lore.kernel.org/lkml/20220523150521.2947108-1-nathan@kernel.org/

Error:
```
ammarfaizi2@integral2:~/work/linux.work$ git log -n 1

commit f2906aa863381afb0015a9eb7fefad885d4e5a56 (HEAD -> master, tag: v5.19-rc1, @torvalds/linux/master)
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Jun 5 17:18:54 2022 -0700

     Linux 5.19-rc1
ammarfaizi2@integral2:~/work/linux.work$
ammarfaizi2@integral2:~/work/linux.work$ taskset -c 0-7 make -j8 && taskset -c 0-7 make modules -j8
   DESCEND objtool
   CALL    scripts/atomic/check-atomics.sh
   CALL    scripts/checksyscalls.sh
   CHK     include/generated/compile.h
   CC [M]  drivers/misc/cardreader/rts5261.o
   CC [M]  drivers/misc/altera-stapl/altera-lpt.o
   CC [M]  drivers/misc/altera-stapl/altera-jtag.o
   CC [M]  drivers/misc/altera-stapl/altera-comp.o
drivers/misc/cardreader/rts5261.c:406:13: error: variable 'setting_reg2' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
         } else if (efuse_valid == 0) {
                    ^~~~~~~~~~~~~~~~
drivers/misc/cardreader/rts5261.c:412:30: note: uninitialized use occurs here
         pci_read_config_dword(pdev, setting_reg2, &lval2);
                                     ^~~~~~~~~~~~
drivers/misc/cardreader/rts5261.c:406:9: note: remove the 'if' if its condition is always true
         } else if (efuse_valid == 0) {
                ^~~~~~~~~~~~~~~~~~~~~~
drivers/misc/cardreader/rts5261.c:364:32: note: initialize the variable 'setting_reg2' to silence this warning
         u16 setting_reg1, setting_reg2;
                                       ^
                                        = 0
1 error generated.
make[3]: *** [scripts/Makefile.build:249: drivers/misc/cardreader/rts5261.o] Error 1
make[2]: *** [scripts/Makefile.build:466: drivers/misc/cardreader] Error 2
make[2]: *** Waiting for unfinished jobs....

```

-- 
Ammar Faizi
