Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FBE59E763
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242123AbiHWQdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242776AbiHWQdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:33:11 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09617B78F;
        Tue, 23 Aug 2022 07:51:35 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id C95A061EA192D;
        Tue, 23 Aug 2022 16:51:33 +0200 (CEST)
Message-ID: <6d6b6bcf-cab8-695b-568a-c1372ac531ee@molgen.mpg.de>
Date:   Tue, 23 Aug 2022 16:51:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Content-Language: en-US
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To:     =?UTF-8?Q?Stephan_M=c3=bcller?= <smueller@chronox.de>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: kdf108_init() takes over 250 ms
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Stephan,


On the Dell XPS 13 9370 with Debian sid/unstable, I noticed with Linux 
5.18.16, that  `crypto_kdf108_init()` takes 263 ms to run even with 
disabled self-tests:

```
[    0.000000] Linux version 5.18.0-4-amd64 
(debian-kernel@lists.debian.org) (gcc-11 (Debian 11.3.0-5) 11.3.0, GNU 
ld (GNU Binutils for Debian) 2.38.90.20220713) #1 SMP PREEMPT_DYNAMIC 
Debian 5.18.16-1 (2022-08-10)
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.18.0-4-amd64 
root=UUID=56f398e0-1e25-4fda-aa9f-611dece4b333 ro quiet 
module_blacklist=psmouse initcall_debug log_buf_len=4M cryptomgr.notests
[…]
[    0.000000] DMI: Dell Inc. XPS 13 9370/0RMYH9, BIOS 1.21.0 07/06/2022
[…]
[    0.272123] calling  x509_key_init+0x0/0x11 @ 1
[    0.272125] Asymmetric key parser 'x509' registered
[    0.272126] initcall x509_key_init+0x0/0x11 returned 0 after 1 usecs
[    0.272127] calling  crypto_kdf108_init+0x0/0x149 @ 1
[    0.530787] Freeing initrd memory: 39332K
[    0.534667] alg: self-tests disabled
[    0.534701] alg: self-tests for CTR-KDF (hmac(sha256)) passed
[    0.534703] initcall crypto_kdf108_init+0x0/0x149 returned 0 after 
262573 usecs
[    0.534708] calling  blkdev_init+0x0/0x20 @ 1
[    0.534716] initcall blkdev_init+0x0/0x20 returned 0 after 5 usecs
[    0.534718] calling  proc_genhd_init+0x0/0x46 @ 1
[    0.534723] initcall proc_genhd_init+0x0/0x46 returned 0 after 3 usecs
```

With self-tests enabled it’s only less than a millisecond longer.

```
[    0.282389] calling  crypto_kdf108_init+0x0/0x149 @ 1
[    0.541096] Freeing initrd memory: 39332K
[    0.545674] alg: self-tests for CTR-KDF (hmac(sha256)) passed
[    0.545676] initcall crypto_kdf108_init+0x0/0x149 returned 0 after 
263284 usecs
```


Kind regards,

Paul
