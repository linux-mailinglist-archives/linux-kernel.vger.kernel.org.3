Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985DF57D5A0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbiGUVPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiGUVPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:15:02 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CB852E74
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:15:01 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id v28so2300368qkg.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=huM2v4ySs7XPnjZqKJ4bFPZo6KHWBhqcbxJbAZarKKw=;
        b=HY7CiNGVhsDsOSKPTHt7KqhJPq+aaQsuIV2PkASeSaiCHEdcjtMLfkdpRQZjn1kujB
         eS0LC0pxymlIwzW+RVCTxKXk9q8S2Xki6rMsFuCIwXH9G0JbkqthRoebeb6OlpgQFrKP
         XvQgHsHYO5ytz2RmpPEPKgKeKrBkG0hU4MhqrAWkWPFG3m9gDtuFzf8VE5gbvPEZZFSW
         o5pXTe6FVoRKWhBDTMpEDtjbkKlGCx0Heh1IXYgeDeh2DefUKAQX4QP3q1q1gd18CmGj
         3NTCtrAjY7ADFlkTo1MSKmmWYTJV+eFq2jsvSsmCiBfGn8E6J7JmJyPiJgCUlRvbWcZk
         wY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=huM2v4ySs7XPnjZqKJ4bFPZo6KHWBhqcbxJbAZarKKw=;
        b=odPrPB/XCduRmEbt8jnnXNIB0A74ArKi/daTLplEmDm8gHNFo+TFLS+GPY0RB6NHDi
         wGoFavUgSkET/i7a0CS7934pZVD1ZEV5w56Pnr/x2xDMEbaNzJBU+eV3fpFtz4NXX/MV
         rtQHjOXbCfrzbc1nect19hBqG8QEidg0tmb05zz61Gh088ANx6hrPxDML3lmbR2cvca/
         Js8Xzihpc+TjbRTxBZnl1EcPOQKH/JmFKL9ZMGJzvRKgT2g6G22RUpdBx1k3yTz2NCUA
         MZQjvzgGOPFRy3uSW7QWtfW0U+Ul5ku9bH/qBzqePNg/7o5nXf6bCeE/XvzCnisEE5Pm
         QJig==
X-Gm-Message-State: AJIora9D6JniVxQ7CAka4vzn4uL6+zUzP/oOIUU26UL2qXwfb1azzPF+
        1MR3db/PWvb31MREI+XRyTZrMdVnp0o=
X-Google-Smtp-Source: AGRyM1s5O0XXTuFtd5DYh7k95K31tjJuJeRjo5YqmSli8ZK09qVlbk2EIb/BkuUZbyNMSb+gvgehug==
X-Received: by 2002:a37:c407:0:b0:6b5:f51f:e0b3 with SMTP id d7-20020a37c407000000b006b5f51fe0b3mr291612qki.619.1658438100448;
        Thu, 21 Jul 2022 14:15:00 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:b961:5175:2ed5:9f33])
        by smtp.gmail.com with ESMTPSA id ez5-20020a05622a4c8500b0031e99798d70sm1953417qtb.29.2022.07.21.14.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 14:14:59 -0700 (PDT)
Date:   Thu, 21 Jul 2022 14:14:58 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH v2 0/5] lib/find: add find_nth_bit()
Message-ID: <YtnB0p8ebbI3jBEn@yury-laptop>
References: <20220711044711.466822-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711044711.466822-1-yury.norov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If no other comments, except that fns() name, moving it in -next.

On Sun, Jul 10, 2022 at 09:47:06PM -0700, Yury Norov wrote:
> Kernel lacks for a function that searches for Nth bit in a bitmap.
> Usually people do it like this:
>         for_each_set_bit(bit, mask, size)
>                 if (--n == 0)
>                         return bit;
> 
> Which is not so elegant, and very slow.
> 
> This series adds fast routines for this task, and applies them where
> appropriate.
> 
> While here, move thin wrappers around find_bit() in nodemask.c to a
> corresponding header, and because nodemask.c is empty after that,
> remove it.
> 
> v1: https://lore.kernel.org/lkml/20220706182300.70862-4-yury.norov@gmail.com/T/
> v2: - count Nth bit from 0 (was 1);
>     - use 'invert' trick in _find_nth_bit(), as in _find_next_bit();
>     - cleanup comments;
>     - fns() is kept inline - looking at __ffs() generic implementation,
>       I decided to keep it untouched.
> 
> Yury Norov (5):
>   lib: add find_nth(,and,andnot)_bit()
>   lib/bitmap: add tests for find_nth_bit()
>   lib/bitmap: remove bitmap_ord_to_pos
>   cpumask: add cpumask_nth_{,and,andnot}
>   lib/nodemask: inline next_node_in() and node_random()
> 
>  MAINTAINERS              |  1 -
>  include/linux/bitmap.h   |  1 -
>  include/linux/bitops.h   | 19 +++++++++
>  include/linux/cpumask.h  | 44 +++++++++++++++++++++
>  include/linux/find.h     | 83 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/nodemask.h | 27 ++++++++++---
>  lib/Makefile             |  2 +-
>  lib/bitmap.c             | 36 ++---------------
>  lib/cpumask.c            | 26 ++++++-------
>  lib/find_bit.c           | 20 ++++++++++
>  lib/find_bit_benchmark.c | 17 ++++++++
>  lib/nodemask.c           | 31 ---------------
>  lib/test_bitmap.c        | 36 ++++++++++++++++-
>  13 files changed, 254 insertions(+), 89 deletions(-)
>  delete mode 100644 lib/nodemask.c
> 
> -- 
> 2.34.1
