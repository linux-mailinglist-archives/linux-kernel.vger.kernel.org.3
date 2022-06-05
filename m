Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A313053DC6A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 17:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349051AbiFEPCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 11:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237838AbiFEPCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 11:02:08 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04706270D
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 08:02:07 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id u8so8827759qvj.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 08:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kcporvhqgValB24OgXM6V2a1HlQmkTeEazpU5LPxfg8=;
        b=YXw2x5GIeDonUvhgeSCC/3qbBKZTYOKxWtx6i/izuwzkQWdGc3w1xwBr4iCL8GYoiH
         6oJY6FPfRmD4p6N9VhfYopyuLFtfR5PQKQ2z5uciZ5ZTUOSsGyfomSv1DwaHyacUXcr0
         VskP2OtVN8nNi9APsTWp6TNvr6kdoJiQ3qMmr0JE8VoU7KSi8Vhv1I15pWthLvZK8XKY
         XoAeJ9OMYg2Ui7C3XRND5jSzanwxM91csirwHMLplV/fxDpxVTz7sUtUHwG778lUqDOw
         fbx0atX+lRL+ALNwI2GKni6MGB9ABSo9F2CehF1q5ulAiLqcPMO7b/WfnqFuE8s/u7mm
         xggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kcporvhqgValB24OgXM6V2a1HlQmkTeEazpU5LPxfg8=;
        b=avD8l4VFIMdT70vByputH2kjKkNxX+0BxoKLBKCN0UELTI3WeFswlFXzBsiG/nMhjo
         sXhUXjGbQLupeTGCdmZNIHO92ZvxEQ6LudDok4Ey9vkZHjIjeSLkKfFVpTT1xPNKoK8p
         tGdivIqOo9uD1d4PHcIpkQl4otWwYh2w8818COMD3KotJxyou+1zFJWv6PR5Gz4rj7x1
         GqyXq+brAwqNUXrLEsvTxSOygbOZc5Y01dg2AVlvILpf1o2LpLMwgL8JVOyLSIRj6GkA
         MiRaJ280BZfZDW3OA2jrEFq+Ju+zwyGBLFYc7I43tvMdZ+DdgUtMAlEXkL7DrmRg4PQ4
         w/Ww==
X-Gm-Message-State: AOAM531Mj/Y4cUKq4mxC5eO84TSZuhoSjCYHP02gZS4+7aLgdqQ83FfA
        gc9TD26/jkHvboZNdiY31Uw=
X-Google-Smtp-Source: ABdhPJx0iFE4AFFNRXtdR/CtcZ4neVA6woiJIV19pZMyklMpx95XtfuLRFBgWA04vjSIWY9TfQ56Qg==
X-Received: by 2002:a05:6214:194f:b0:461:b6e5:79b6 with SMTP id q15-20020a056214194f00b00461b6e579b6mr68968620qvk.60.1654441325930;
        Sun, 05 Jun 2022 08:02:05 -0700 (PDT)
Received: from localhost (c-69-254-185-160.hsd1.ar.comcast.net. [69.254.185.160])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a15d500b0069fc13ce216sm9084996qkm.71.2022.06.05.08.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 08:02:05 -0700 (PDT)
Date:   Sun, 5 Jun 2022 08:01:59 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: mainline build failure due to 0a97953fd221 ("lib: add
 bitmap_{from,to}_arr64")
Message-ID: <YpzFZ/hUqg3VmLmw@yury-laptop>
References: <YpyJ9qTNHJzz0FHY@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpyJ9qTNHJzz0FHY@debian>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2022 at 11:48:22AM +0100, Sudip Mukherjee wrote:
> Hi All,
> 
> The latest mainline kernel branch fails to build for "arm allmodconfig"
> and "csky allmodconfig".
> 
> "arm allmodconfig" fails with the error:
> 
> In file included from ./include/linux/string.h:253,
>                  from ./include/linux/bitmap.h:11,
>                  from ./include/linux/cpumask.h:12,
>                  from ./include/linux/smp.h:13,
>                  from ./include/linux/lockdep.h:14,
>                  from ./include/linux/mutex.h:17,
>                  from ./include/linux/rfkill.h:35,
>                  from net/bluetooth/hci_core.c:29:
> In function 'fortify_memcpy_chk',
>     inlined from 'bitmap_copy' at ./include/linux/bitmap.h:254:2,
>     inlined from 'bitmap_copy_clear_tail' at ./include/linux/bitmap.h:263:2,
>     inlined from 'bitmap_from_u64' at ./include/linux/bitmap.h:540:2,
>     inlined from 'hci_bdaddr_list_add_with_flags' at net/bluetooth/hci_core.c:2156:2:
> ./include/linux/fortify-string.h:344:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>   344 |                         __write_overflow_field(p_size_field, size);
> 
> 
> And, "csky allmodconfig" fails with the error:
> 
> In file included from ./include/linux/cpumask.h:12,
>                  from ./include/linux/mm_types_task.h:14,
>                  from ./include/linux/mm_types.h:5,
>                  from ./include/linux/buildid.h:5,
>                  from ./include/linux/module.h:14,
>                  from net/bluetooth/mgmt.c:27:
> In function 'bitmap_copy',
>     inlined from 'bitmap_copy_clear_tail' at ./include/linux/bitmap.h:263:2,
>     inlined from 'bitmap_from_u64' at ./include/linux/bitmap.h:540:2,
>     inlined from 'set_device_flags' at net/bluetooth/mgmt.c:4534:4:
> ./include/linux/bitmap.h:254:9: error: 'memcpy' forming offset [4, 7] is out of the bounds [0, 4] of object 'flags' with type 'long unsigned int[1]' [-Werror=array-bounds]
>   254 |         memcpy(dst, src, len);
>       |         ^~~~~~~~~~~~~~~~~~~~~
> In file included from ./include/linux/kasan-checks.h:5,
>                  from ./include/asm-generic/rwonce.h:26,
>                  from ./arch/csky/include/generated/asm/rwonce.h:1,
>                  from ./include/linux/compiler.h:248,
>                  from ./include/linux/build_bug.h:5,
>                  from ./include/linux/container_of.h:5,
>                  from ./include/linux/list.h:5,
>                  from ./include/linux/module.h:12,
>                  from net/bluetooth/mgmt.c:27:
> net/bluetooth/mgmt.c: In function 'set_device_flags':
> net/bluetooth/mgmt.c:4532:40: note: 'flags' declared here
>  4532 |                         DECLARE_BITMAP(flags, __HCI_CONN_NUM_FLAGS);
>       |                                        ^~~~~
> ./include/linux/types.h:11:23: note: in definition of macro 'DECLARE_BITMAP'
>    11 |         unsigned long name[BITS_TO_LONGS(bits)]
> 
> 
> For both the failures, git bisect points to:
> 0a97953fd221 ("lib: add bitmap_{from,to}_arr64")
> 
> 
> And, reverting it on top of mainline branch has fixed both the build failures.

Hi Sudip,

Thanks for pointing at this.

In the patch you mentioned, silent typecasting from to u64 has been
replaced with explicit memory dereference, and it spotted -Warray-bounds:

 static inline void bitmap_from_u64(unsigned long *dst, u64 mask)
 {
-       dst[0] = mask & ULONG_MAX;
-
-       if (sizeof(mask) > sizeof(unsigned long))
-               dst[1] = mask >> 32;
+       bitmap_from_arr64(dst, &mask, 64);
 }

The problem is that bluetooth code declares current_flags as u32, and 
later applies 64-bit function to convert it to bitmap.

In the bluetooth code, using bitmap_from_u64 is incorrect because of
that, and because the length of bitmap in that case is __HCI_CONN_NUM_FLAGS,
which is 2, not 64. The simplest fix is to switch to bitmap_from_arr32.

I'll send a fix shortly.

Thanks,
Yury
