Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBCC5773EE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 05:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiGQD5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 23:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGQD5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 23:57:37 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7A1A475
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 20:57:35 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id f14so6544017qkm.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 20:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O1xMeMkMSgVby2HoU7+PD7j4cl3UxZ4VZxvd2iWyXrM=;
        b=US3+KEaRM84ACWseUiYGB8Q6Sl+/u3a9Aw2rYPPeLyuSfRj3PUF9MmBHHjg5zYI+Yz
         MQUQ8z2nD34DpvB+MsWSCSzj8iUVyLIDRAM8JoSVCkC+KmmLB/RIatzmJc5i8rJo5/jS
         CTSOc/qCaYbZk3fJ+RhqxPnahcbItnPqnsHXUB60bN7F/29K3YthTCodzZt7fhXpX7hG
         bWWNGk15gBz1bSgqK8MIKkAW24CtwDVwQGC99pkAj5okJy5PnAt2nNYaIfUbuq5h9zr6
         hbFj5HYrFdSkakoZfydE/i9FTB+CR62cG0srmbS7U0W0NUspakWXW8Xz9vgH3C/f79mF
         skVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O1xMeMkMSgVby2HoU7+PD7j4cl3UxZ4VZxvd2iWyXrM=;
        b=w9srk63DZw4TH/S78WOVHrtX/DqjC/KzPoLXnRC9AYfCQoRzT4Fzxp/WA2uVkUrxCk
         sYLU/7k7cXN3XVaw6H4FEoeE3GNB8QzGX78lRchfU3o2gQt1lzxIniHN1LONro8VBJm9
         LoeHMIFbg1uyPTOZZJTu8jlPa1tTuRbQruANfQISEv6snMcvd1ypeHMj6zcTYL2fSL2L
         UwGznDoHkRrUD+sX3TU29CwK4OQIMwA6/0MPGmr44Nur9vYB4x6ouiMproTt+XCCC/9m
         l/A13qtGc4yBNUKrS/sRSzx2rCqTMWbhN3w4B9UTVgU6CY7y1wdMfje0x30WxXVMb2pb
         RGRA==
X-Gm-Message-State: AJIora+NOCzGSls4+Yg3/iGQZuM0xj80rEAymYh/Hu/rESmG4xIv/eBi
        nJ8PycIoPhnSYELbZfo7vzm2x6NUnIE=
X-Google-Smtp-Source: AGRyM1v37y/oaETAcHJYGhD90nOh2suIWyVjGPbhOR2OsEKjHHkoCttlEYaRZOaj+bK5MwocKuj7vw==
X-Received: by 2002:a05:620a:4514:b0:6b5:e33d:32b6 with SMTP id t20-20020a05620a451400b006b5e33d32b6mr1050911qkp.66.1658030254367;
        Sat, 16 Jul 2022 20:57:34 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:8d1c:55ec:9e5b:c86b])
        by smtp.gmail.com with ESMTPSA id x6-20020a05620a258600b006a65c58db99sm8530229qko.64.2022.07.16.20.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 20:57:33 -0700 (PDT)
Date:   Sat, 16 Jul 2022 20:57:32 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] lib/bitmap: Make count and length parameters unsigned
Message-ID: <YtOIrI9WqZYN5a5k@yury-laptop>
References: <20220714164207.52410-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714164207.52410-1-pmenzel@molgen.mpg.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 06:42:07PM +0200, Paul Menzel wrote:
> Counts and the length are non-negative, so make them unsigned, and adapt the
> while condition in `__bitmap_set()` and `__bitmap_clear()` accordingly.

Hi Paul, 

I applied your patch on top of bitmap-for-next, and kernel failed
to boot with it on a very early stage without any logs. I attached
the target with GDB, but there's no any meaningful backtrace.
0xffffc0f6aa39541c in ?? ()
(gdb) i threads
  Id   Target Id                    Frame
* 1    Thread 1.1 (CPU#0 [running]) 0xffffc0f6aa39541c in ?? ()
  2    Thread 1.2 (CPU#1 [halted ]) 0x0000000000000000 in ?? ()
  3    Thread 1.3 (CPU#2 [halted ]) 0x0000000000000000 in ?? ()
  4    Thread 1.4 (CPU#3 [halted ]) 0x0000000000000000 in ?? ()
(gdb) bt
#0  0xffffc0f6aa39541c in ?? ()
Backtrace stopped: previous frame identical to this frame (corrupt stack?)

Reproduced on qemu/arm64 and x86_64 with the same results. Can you
try your patch on top of bitmap-for-next and/or next-20220715?

You can find bitmap-for-next here:
https://github.com/norov/linux/

Thanks,
Yury

> For `__bitmap_set()` six less intstructions are used as a result:
> 
> ```
> __bitmap_set: __bitmap_set:
>         movl    %esi, %eax movl    %esi, %eax
>         movq    %rdi, %r8                                     <
>         movl    %esi, %ecx movl    %esi, %ecx
>         movl    %edx, %edi                                    | movl    %esi, %r8d
>                                                               > movl    $64, %esi
>                                                               > andl    $63, %ecx
>         shrl    $6, %eax shrl    $6, %eax
>         andl    $63, %esi                                     | movl    %edx, %r9d
>         movq    $-1, %rdx                                     | leaq    (%rdi,%rax,8), %rax
>         leaq    (%r8,%rax,8), %rax                            | subl    %ecx, %esi
>         leal    -64(%rsi,%rdi), %r8d                          | movq    $-1, %rdi
>         salq    %cl, %rdx                                     | salq    %cl, %rdi
>         testl   %r8d, %r8d                                    | cmpl    %edx, %esi
>         js      .L88                                          | ja      .L85
>         movl    %r8d, %r9d                                    <
>         shrl    $6, %r9d                                      <
>         leal    1(%r9), %esi                                  <
>         leaq    (%rax,%rsi,8), %rsi                           <
> .L86:                                                           .L86:
>         orq     %rdx, (%rax)                                  | subl    %esi, %edx
>                                                               > orq     %rdi, (%rax)
>                                                               > movl    $64, %esi
>         addq    $8, %rax addq    $8, %rax
>         movq    $-1, %rdx                                     | movq    $-1, %rdi
>         cmpq    %rsi, %rax                                    | cmpl    $63, %edx
>         jne     .L86                                          | ja      .L86
>         sall    $6, %r9d                                      <
>         subl    %r9d, %r8d                                    <
> .L85:                                                           .L85:
>         testl   %r8d, %r8d                                    | testl   %edx, %edx
>         je      .L84 je      .L84
>         addl    %edi, %ecx                                    | leal    (%r8,%r9), %ecx
>         movq    $-1, %rax                                     | movq    $-1, %rdx
>         negl    %ecx negl    %ecx
>         shrq    %cl, %rax                                     | shrq    %cl, %rdx
>         andq    %rax, %rdx                                    | andq    %rdx, %rdi
>         orq     %rdx, (%rsi)                                  | orq     %rdi, (%rax)
> .L84:                                                           .L84:
>         ret                                                             ret
> .L88:                                                         <
>         movq    %rax, %rsi                                    <
>         movl    %edi, %r8d                                    <
>         jmp     .L85                                          <
>         .size   __bitmap_set, .-__bitmap_set .size   __bitmap_set, .-__bitmap_set
>         .p2align 4 .p2align 4
>         .globl  __bitmap_clear .globl  __bitmap_clear
>         .type   __bitmap_clear, @function .type   __bitmap_clear, @function
> ```
> 
>     $ diff lib/bitmap.1.S lib/bitmap.2.S | diffstat
>      unknown |   55 ++++++++++++++++++++++++-------------------------------
>      1 file changed, 24 insertions(+), 31 deletions(-)
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> v2: Update signature in header file
> v3: Adapt more functions to use unsigned int
> 
>  include/linux/bitmap.h | 20 ++++++++++----------
>  lib/bitmap.c           | 26 +++++++++++++-------------
>  2 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 2e6cd5681040..9f1a097cd5d4 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -164,8 +164,8 @@ bool __bitmap_intersects(const unsigned long *bitmap1,
>  bool __bitmap_subset(const unsigned long *bitmap1,
>  		     const unsigned long *bitmap2, unsigned int nbits);
>  int __bitmap_weight(const unsigned long *bitmap, unsigned int nbits);
> -void __bitmap_set(unsigned long *map, unsigned int start, int len);
> -void __bitmap_clear(unsigned long *map, unsigned int start, int len);
> +void __bitmap_set(unsigned long *map, unsigned int start, unsigned int len);
> +void __bitmap_clear(unsigned long *map, unsigned int start, unsigned int len);
>  
>  unsigned long bitmap_find_next_zero_area_off(unsigned long *map,
>  					     unsigned long size,
> @@ -198,17 +198,17 @@ bitmap_find_next_zero_area(unsigned long *map,
>  }
>  
>  int bitmap_parse(const char *buf, unsigned int buflen,
> -			unsigned long *dst, int nbits);
> +			unsigned long *dst, unsigned int nbits);
>  int bitmap_parse_user(const char __user *ubuf, unsigned int ulen,
> -			unsigned long *dst, int nbits);
> +			unsigned long *dst, unsigned int nbits);
>  int bitmap_parselist(const char *buf, unsigned long *maskp,
> -			int nmaskbits);
> +			unsigned int nmaskbits);
>  int bitmap_parselist_user(const char __user *ubuf, unsigned int ulen,
> -			unsigned long *dst, int nbits);
> +			unsigned long *dst, unsigned int nbits);
>  void bitmap_remap(unsigned long *dst, const unsigned long *src,
>  		const unsigned long *old, const unsigned long *new, unsigned int nbits);
>  int bitmap_bitremap(int oldbit,
> -		const unsigned long *old, const unsigned long *new, int bits);
> +		const unsigned long *old, const unsigned long *new, unsigned int bits);
>  void bitmap_onto(unsigned long *dst, const unsigned long *orig,
>  		const unsigned long *relmap, unsigned int bits);
>  void bitmap_fold(unsigned long *dst, const unsigned long *orig,
> @@ -224,13 +224,13 @@ void bitmap_copy_le(unsigned long *dst, const unsigned long *src, unsigned int n
>  #endif
>  unsigned int bitmap_ord_to_pos(const unsigned long *bitmap, unsigned int ord, unsigned int nbits);
>  int bitmap_print_to_pagebuf(bool list, char *buf,
> -				   const unsigned long *maskp, int nmaskbits);
> +				   const unsigned long *maskp, unsigned int nmaskbits);
>  
>  extern int bitmap_print_bitmask_to_buf(char *buf, const unsigned long *maskp,
> -				      int nmaskbits, loff_t off, size_t count);
> +				      unsigned int nmaskbits, loff_t off, size_t count);
>  
>  extern int bitmap_print_list_to_buf(char *buf, const unsigned long *maskp,
> -				      int nmaskbits, loff_t off, size_t count);
> +				      unsigned int nmaskbits, loff_t off, size_t count);
>  
>  #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
>  #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index b18e31ea6e66..d529f7dffc48 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -348,14 +348,14 @@ int __bitmap_weight(const unsigned long *bitmap, unsigned int bits)
>  }
>  EXPORT_SYMBOL(__bitmap_weight);
>  
> -void __bitmap_set(unsigned long *map, unsigned int start, int len)
> +void __bitmap_set(unsigned long *map, unsigned int start, unsigned int len)
>  {
>  	unsigned long *p = map + BIT_WORD(start);
>  	const unsigned int size = start + len;
>  	int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
>  	unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
>  
> -	while (len - bits_to_set >= 0) {
> +	while (len >= bits_to_set) {
>  		*p |= mask_to_set;
>  		len -= bits_to_set;
>  		bits_to_set = BITS_PER_LONG;
> @@ -369,7 +369,7 @@ void __bitmap_set(unsigned long *map, unsigned int start, int len)
>  }
>  EXPORT_SYMBOL(__bitmap_set);
>  
> -void __bitmap_clear(unsigned long *map, unsigned int start, int len)
> +void __bitmap_clear(unsigned long *map, unsigned int start, unsigned int len)
>  {
>  	unsigned long *p = map + BIT_WORD(start);
>  	const unsigned int size = start + len;
> @@ -445,7 +445,7 @@ EXPORT_SYMBOL(bitmap_find_next_zero_area_off);
>   */
>  int bitmap_parse_user(const char __user *ubuf,
>  			unsigned int ulen, unsigned long *maskp,
> -			int nmaskbits)
> +			unsigned int nmaskbits)
>  {
>  	char *buf;
>  	int ret;
> @@ -478,7 +478,7 @@ EXPORT_SYMBOL(bitmap_parse_user);
>   * actually printed to @buf, excluding terminating '\0'.
>   */
>  int bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
> -			    int nmaskbits)
> +			    unsigned int nmaskbits)
>  {
>  	ptrdiff_t len = PAGE_SIZE - offset_in_page(buf);
>  
> @@ -499,7 +499,7 @@ EXPORT_SYMBOL(bitmap_print_to_pagebuf);
>   * @count: the maximum number of bytes to print
>   */
>  static int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
> -		int nmaskbits, loff_t off, size_t count)
> +		unsigned int nmaskbits, loff_t off, size_t count)
>  {
>  	const char *fmt = list ? "%*pbl\n" : "%*pb\n";
>  	ssize_t size;
> @@ -542,7 +542,7 @@ static int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
>   * normal attribute with buf parameter and without offset, count::
>   *
>   *   bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
> - * 			   int nmaskbits)
> + * 			   unsigned int nmaskbits)
>   *   {
>   *   }
>   *
> @@ -600,7 +600,7 @@ static int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
>   * Returns the number of characters actually printed to @buf
>   */
>  int bitmap_print_bitmask_to_buf(char *buf, const unsigned long *maskp,
> -				int nmaskbits, loff_t off, size_t count)
> +				unsigned int nmaskbits, loff_t off, size_t count)
>  {
>  	return bitmap_print_to_buf(false, buf, maskp, nmaskbits, off, count);
>  }
> @@ -618,7 +618,7 @@ EXPORT_SYMBOL(bitmap_print_bitmask_to_buf);
>   * the print format.
>   */
>  int bitmap_print_list_to_buf(char *buf, const unsigned long *maskp,
> -			     int nmaskbits, loff_t off, size_t count)
> +			     unsigned int nmaskbits, loff_t off, size_t count)
>  {
>  	return bitmap_print_to_buf(true, buf, maskp, nmaskbits, off, count);
>  }
> @@ -793,7 +793,7 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
>   *   - ``-ERANGE``: bit number specified too large for mask
>   *   - ``-EOVERFLOW``: integer overflow in the input parameters
>   */
> -int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
> +int bitmap_parselist(const char *buf, unsigned long *maskp, unsigned int nmaskbits)
>  {
>  	struct region r;
>  	long ret;
> @@ -836,7 +836,7 @@ EXPORT_SYMBOL(bitmap_parselist);
>   */
>  int bitmap_parselist_user(const char __user *ubuf,
>  			unsigned int ulen, unsigned long *maskp,
> -			int nmaskbits)
> +			unsigned int nmaskbits)
>  {
>  	char *buf;
>  	int ret;
> @@ -893,7 +893,7 @@ static const char *bitmap_get_x32_reverse(const char *start,
>   * Leading, embedded and trailing whitespace accepted.
>   */
>  int bitmap_parse(const char *start, unsigned int buflen,
> -		unsigned long *maskp, int nmaskbits)
> +		unsigned long *maskp, unsigned int nmaskbits)
>  {
>  	const char *end = strnchrnul(start, buflen, '\n') - 1;
>  	int chunks = BITS_TO_U32(nmaskbits);
> @@ -1068,7 +1068,7 @@ EXPORT_SYMBOL(bitmap_remap);
>   * returns 13.
>   */
>  int bitmap_bitremap(int oldbit, const unsigned long *old,
> -				const unsigned long *new, int bits)
> +				const unsigned long *new, unsigned int bits)
>  {
>  	int w = bitmap_weight(new, bits);
>  	int n = bitmap_pos_to_ord(old, oldbit, bits);
> -- 
> 2.36.1
