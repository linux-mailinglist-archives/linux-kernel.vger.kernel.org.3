Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7ECF5163A0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 12:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245077AbiEAKWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 06:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243051AbiEAKWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 06:22:40 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D8F6EC65;
        Sun,  1 May 2022 03:19:13 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1nl6fU-000xac-Gm; Sun, 01 May 2022 12:19:08 +0200
Received: from dynamic-077-013-254-075.77.13.pool.telefonica.de ([77.13.254.75] helo=[192.168.1.9])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1nl6fU-000dgz-5Q; Sun, 01 May 2022 12:19:08 +0200
Message-ID: <a31ad123-5a37-63ea-e8b6-d573bb6c0bee@physik.fu-berlin.de>
Date:   Sun, 1 May 2022 12:19:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3] sh: avoid using IRQ0 on SH3/4
Content-Language: en-US
To:     Rob Landley <rob@landley.net>, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <2584ba18-9653-9310-efc1-8b3b3e221eea@omp.ru>
 <11021433-66c0-3c56-42bd-207a5ae8d267@physik.fu-berlin.de>
 <2ebef1ac-e5c5-980c-9413-22a6cccdfa1d@landley.net>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <2ebef1ac-e5c5-980c-9413-22a6cccdfa1d@landley.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 77.13.254.75
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob!

On 4/30/22 12:30, Rob Landley wrote:
>> Maybe try getting it landed through Andrew Morton's tree?
> 
> As I told him in IRC, the problem is still that sh4 never gives me a shell
> prompt with this patch applied. I just reconfirmed it against current git:
> 
> Freeing unused kernel image (initmem) memory: 124K
> This architecture does not have kernel memory protection.
> Run /init as init process
> mountpoint: dev/pts: No such file or directory
> 8139cp 0000:00:02.0 eth0: link up, 100Mbps, full-duplex, lpa 0x05E1
> 
> It makes it partway through the init script, but it hangs with qemu-system-sh4
> stuck in a CPU-eating loop before finishing. Without the patch, I get a shell
> prompt.

Oh, I wasn't aware of that. I did not experience the issue on my SH7785LCR but I can
retest against current git with the patch applied on top.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

