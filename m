Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BB952FDF6
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 17:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243526AbiEUPoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 11:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiEUPou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 11:44:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7533F5DBDF;
        Sat, 21 May 2022 08:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=N2cvmr5qgix9dsJyM3EfaeMcwlENDUG0UMFYTRsjfQ4=; b=CLKUW997PJmzXpkLm8NkNDEmp3
        finCe4jD1sKqY1neC9/6XkIiPNSsxDy0iBsVPQwzSWlltXaeh7nhLFxziihweE+QzM8wS9R2wLPKb
        /N/FNPVabP5+g0pY9VT4+6PRMxJOL66gkwobhTz0t1Cry2ccrs+sG143dimrT18QYfD1RFHquN3WH
        VsNhe9mmCxGCnWUERc7cLv6p4fhBPQ33RK+WoHVPmTpIzlQOlW5KiBHGO2YbRYFu9wUB3o29PESiu
        zns3936IaAkjg65aj0w440+XrUERAZ9AZJTPc2u46m7tFNRASa5vdeJJB2oEIyLU9YKeid1qAwFB0
        o2P1KDXQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsRHZ-00Ek1R-7r; Sat, 21 May 2022 15:44:45 +0000
Message-ID: <a728cf17-4866-1151-0740-56b06257c917@infradead.org>
Date:   Sat, 21 May 2022 08:44:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5] crc-itu-t: Fix typo in CRC ITU-T polynom comment
Content-Language: en-US
To:     Roger Knecht <roger@norberthealth.com>,
        linux-kernel@vger.kernel.org, Ivo van Doorn <IvDoorn@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org,
        Kristian Hoegsberg <krh@redhat.com>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>
References: <20220521124745.8747-1-roger@norberthealth.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220521124745.8747-1-roger@norberthealth.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

On 5/21/22 05:47, Roger Knecht wrote:
> The code comment says that the polynom is x^16 + x^12 + x^15 + 1, but the
> correct polynom is x^16 + x^12 + x^5 + 1.
> 
> Quote from page 2 in the ITU-T V.41 specification:
>   "2 Encoding and checking process
> 
>   The service bits and information bits, taken in conjunction, correspond
>   to the coefficients of a message polynomial having terms from x^(n-1)
>   (n = total number of bits in a block or sequence) down to x^16. This
>   polynomial is divided, modulo 2, by the generating polynomial
>   x^16 + x^12 + x^5 + 1. [...]"
> 
> Source: https://www.itu.int/rec/T-REC-V.41-198811-I/en)
> The hex polynom 0x1021 and CRC code implementation are correct.
> 
> Signed-off-by: Roger Knecht <roger@norberthealth.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

I don't know which maintainer will merge this since no one is Cc:ed on it.
You will probably need to choose some maintainer to send the patch to.

But let's add the people who merged the header file in the first place
for their comments/review. (done)

> ---
> Changes:
> v5: Clean up patch description and added acked-by
> v4: Changed comment from /** to /* (the comment is not a kernel doc comment)
> v3: Moved "changes and thanks" out of the commit message.
> v2: Extended patch description
> 
>  include/linux/crc-itu-t.h | 2 +-
>  lib/crc-itu-t.c           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/crc-itu-t.h b/include/linux/crc-itu-t.h
> index a4367051e192..2f991a427ade 100644
> --- a/include/linux/crc-itu-t.h
> +++ b/include/linux/crc-itu-t.h
> @@ -4,7 +4,7 @@
>   *
>   * Implements the standard CRC ITU-T V.41:
>   *   Width 16
> - *   Poly  0x1021 (x^16 + x^12 + x^15 + 1)
> + *   Poly  0x1021 (x^16 + x^12 + x^5 + 1)
>   *   Init  0
>   */
>  
> diff --git a/lib/crc-itu-t.c b/lib/crc-itu-t.c
> index 1974b355c148..1d26a1647da5 100644
> --- a/lib/crc-itu-t.c
> +++ b/lib/crc-itu-t.c
> @@ -7,7 +7,7 @@
>  #include <linux/module.h>
>  #include <linux/crc-itu-t.h>
>  
> -/** CRC table for the CRC ITU-T V.41 0x1021 (x^16 + x^12 + x^15 + 1) */
> +/* CRC table for the CRC ITU-T V.41 0x1021 (x^16 + x^12 + x^5 + 1) */
>  const u16 crc_itu_t_table[256] = {
>  	0x0000, 0x1021, 0x2042, 0x3063, 0x4084, 0x50a5, 0x60c6, 0x70e7,
>  	0x8108, 0x9129, 0xa14a, 0xb16b, 0xc18c, 0xd1ad, 0xe1ce, 0xf1ef,

-- 
~Randy
