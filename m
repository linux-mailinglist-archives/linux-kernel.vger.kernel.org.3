Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD89578DAC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbiGRWmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235764AbiGRWlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:41:53 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7172F645
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:41:52 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id mi10so9928507qvb.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YjeR/BKl7tGBTzlht0Fuz8ACOgbjgQ373S98IaM7eJ8=;
        b=c7f9jrMy6ThlGBqy5kiu0yLs3gEapU5CwyJuvNtp4N4hSW1O7SklQJkSYB85k7p52V
         MtnIChWHHsjaRXWgBToyn/uUp0c6LRqL+C+JBtfDIUOk5rTxAtidNoO7OXp95sjQ51ay
         vXkm3AC64oelslKJlZXjuJqg9m9049YZ4yX6ebZwzgCepvqLZna4+boi5/u15qo1P98p
         GB5ikXiUCialeUVQP+I7X8dcy0QzsDNxqpkpqota82H5up6ZW/+bXiLTrSwu/54bAofO
         YgoWEU6jzT29Bl+MzpnBFovU2DOgvzWsHQgnv7h9D8s8fX18XxTwieBXOr1WqwgSVJrI
         yVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YjeR/BKl7tGBTzlht0Fuz8ACOgbjgQ373S98IaM7eJ8=;
        b=ontKf4/b7zkn5nqhSNET9ZIjq1/6x49O67p98j5q/SDyQw9tWfRsHicvsitmddEtF5
         eYdeBVG31RsLo+idv3huaO2HDJ6pIA94lDqQKN/Rkcf15A4teJ/cAMOn7zHJSG5tK2VA
         EjcB0z8UWehNhjaf+9xXFEDaM1v4KWeaO4XNqT/xlGEayNggPMnfgDU0CZyn9EyOAu6W
         3IybBUlDpI6stRM/masfGnuJXZ/XI893s8vdf/RX4k6Il09ZzTSJ9xt3neTVE7TU1McP
         /RYdUxJybNnMJl/H2hnpDdNhDTiOWinGIpq0940A0h2puCyTRQPGbugm/UvbgQJCDWJ3
         8stQ==
X-Gm-Message-State: AJIora/F4CBFwwLrrF9Hdz50wfs8W7hxjeVLpBf9BAMIFTP0ZBMlEFq7
        UVQrVK7sxbXfJV1FBNHhlVV8xzFwqXHKr5dosZo=
X-Google-Smtp-Source: AGRyM1tor71WFv2HR9ksCyOtz7JK9zZW9G2eGf1Wrr7Max8Xf4sYaO8ifu8yUfbkmFYtCv8QmrWRsNeVWdiOSKPSqTg=
X-Received: by 2002:a05:6214:226c:b0:473:25b7:fce1 with SMTP id
 gs12-20020a056214226c00b0047325b7fce1mr22964567qvb.56.1658184111244; Mon, 18
 Jul 2022 15:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <5ea6f55fb645405bb52cb15b8d30544ba3f189b0.1655150842.git.andreyknvl@google.com>
 <202206152134.sadCRvGk-lkp@intel.com>
In-Reply-To: <202206152134.sadCRvGk-lkp@intel.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 19 Jul 2022 00:41:40 +0200
Message-ID: <CA+fCnZfs+CiBVBf0BYD2sp9KgO2+_QJOH=XaNVt7-kk4tdLy-A@mail.gmail.com>
Subject: Re: [PATCH 24/32] kasan: move kasan_addr_to_slab to common.c
To:     kernel test robot <lkp@intel.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        kbuild-all@lists.01.org, Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 3:28 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on akpm-mm/mm-everything]
> [also build test WARNING on linus/master v5.19-rc2 next-20220615]
> [cannot apply to vbabka-slab/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/andrey-konovalov-linux-dev/kasan-switch-tag-based-modes-to-stack-ring-from-per-object-metadata/20220614-042239
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20220615/202206152134.sadCRvGk-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/b0b10a57b2d9a5e5ae5d7ca62046b9774df1a88f
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review andrey-konovalov-linux-dev/kasan-switch-tag-based-modes-to-stack-ring-from-per-object-metadata/20220614-042239
>         git checkout b0b10a57b2d9a5e5ae5d7ca62046b9774df1a88f
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash mm/kasan/
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    mm/kasan/common.c: In function 'kasan_addr_to_slab':
> >> mm/kasan/common.c:35:19: warning: ordered comparison of pointer with null pointer [-Wextra]
>       35 |         if ((addr >= (void *)PAGE_OFFSET) && (addr < high_memory))
>          |                   ^~
>    mm/kasan/common.c: In function '____kasan_slab_free':
>    mm/kasan/common.c:202:12: warning: variable 'tag' set but not used [-Wunused-but-set-variable]
>      202 |         u8 tag;
>          |            ^~~

Will fix both in v2. Thanks!
