Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43ED57407F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 02:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiGNAYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 20:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbiGNAXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 20:23:52 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842A418368
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 17:23:14 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y4so427151edc.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 17:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aozmkmuwUJAK9N7zPpsvHom1BPqHAVFCekZgk5g49Hw=;
        b=Vt8l5nhRlgTF0drHWIPgfqLB2BVwcyrUlRWEZXgTS4Rz4km/e9v8o8ltubGyf5XRUM
         rCRyvsXNBZ4bxzmf5PUIkVQIxCoHGXYj8VZY5Nd9Txtv9nkXlcDs9gRw99giP+9onZQ2
         95SoV0vhEaykcWhYiX2/u0mBf1BGNi5Ony50mq6b9YGVV9tfxdQfUnUbTTyO2bskYyae
         LEuzky3XRreqW83V4gOuB2/SjCyhPZabCR/lWt7hr7gOjoW1WdnbrjH+uDa6VYG3Dr28
         Aqf2Y0mCcqU7KVDr2O2/pDZkEMpwdbJoGTd/osFzJ3yhTRkhnVnaqCZPsERMxQXE7mgB
         Q0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aozmkmuwUJAK9N7zPpsvHom1BPqHAVFCekZgk5g49Hw=;
        b=FSw0TmtPf12QH77nQx4vSUK0F+HnJ8xVrEGsLXtVw8d9sQO5wjjpMV+EaEoEZwRlgS
         y8nhBwF9u5PiWCpKg8t2Hv2mTi/1EJBvk9dH9Y6QijrzTs4V68bj9on4kXdEjd2a3p3D
         Xh9QbI6vbT5KGgwAwCI8YNawRmFz8bzwyAxg/o/7+0TJs7fK45/rcOVNUvQJdsyuXPAj
         AdUO7jGxIOmE5eIGQjaRFuqIA8eYnBzfXbftz7T7mLNabX431O8UON5jPYayadZ54B97
         FMziD+mLjUNDjakeM+NrQnobKPd+G84WQdIbRdUNakuyoRqSIgJt3qPpSkGAKanS0Cu7
         Wplw==
X-Gm-Message-State: AJIora+m9+EK1ta+T0zvOm8pMXXyrPLRf21Q1WNV7gOSCVHimxfqgruI
        JmbbiIYEgJchqrG2ibKo0KPmT1BqCHdrY2sLl58=
X-Google-Smtp-Source: AGRyM1vPbnqckBEA3D1MUCGqWV8o3YAdFF7nrjfZdrU3PHX75RECDNzdctvfnSiLxHtNBnw4qMvbgA81wALUCyuNBH0=
X-Received: by 2002:aa7:db9a:0:b0:43a:76bf:5401 with SMTP id
 u26-20020aa7db9a000000b0043a76bf5401mr8449634edt.244.1657758192985; Wed, 13
 Jul 2022 17:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220713183855.2188201-1-pauld@redhat.com>
In-Reply-To: <20220713183855.2188201-1-pauld@redhat.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 14 Jul 2022 12:23:01 +1200
Message-ID: <CAGsJ_4yb5Z3msMgXRZpSXLFiysQdJq-n_p9B6d-p2t_-_UHhVQ@mail.gmail.com>
Subject: Re: [PATCH v3] drivers/base/node.c: fix userspace break from using
 bin_attributes for cpumap and cpulist
To:     Phil Auld <pauld@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 6:38 AM Phil Auld <pauld@redhat.com> wrote:
>
> Using bin_attributes with a 0 size causes fstat and friends to return that 0 size.
> This breaks userspace code that retrieves the size before reading the file. Rather
> than reverting 75bd50fa841 ("drivers/base/node.c: use bin_attribute to break the size
> limitation of cpumap ABI") let's put in a size value at compile time. Use direct
> comparison and a worst-case maximum to ensure compile time constants. For cpulist the
> max is on the order of NR_CPUS * (ceil(log10(NR_CPUS)) + 1) which for 8192 is 40960
> (8192 * 5). In order to get near that you'd need a system with every other CPU on one
> node or something similar. e.g. (0,2,4,... 1024,1026...). To simplify the math and
> support larger NR_CPUS we are using NR_CPUS * 7 to support a future with much larger NR_CPUS.
> We also set it to a min of PAGE_SIZE to retain the older behavior for smaller NR_CPUS.
> The cpumap file wants to be something like NR_CPUS/4 + NR_CPUS/32, for the ","s so for
> simplicity we are using NR_CPUS/2.
>
> On an 80 cpu 4-node sytem (NR_CPUS == 8192)
>
> before:
>
> -r--r--r--. 1 root root 0 Jul 12 14:08 /sys/devices/system/node/node0/cpulist
> -r--r--r--. 1 root root 0 Jul 11 17:25 /sys/devices/system/node/node0/cpumap
>
> after:
>
> -r--r--r--. 1 root root 57344 Jul 13 11:32 /sys/devices/system/node/node0/cpulist
> -r--r--r--. 1 root root  4096 Jul 13 11:31 /sys/devices/system/node/node0/cpumap
>
> NR_CPUS = 16384
> -r--r--r--. 1 root root 114688 Jul 13 14:03 /sys/devices/system/node/node0/cpulist
> -r--r--r--. 1 root root   8192 Jul 13 14:02 /sys/devices/system/node/node0/cpumap
>
> Fixes: 75bd50fa841 ("drivers/base/node.c: use bin_attribute to break the size limitation of cpumap ABI")
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Phil Auld <pauld@redhat.com>
> ---
>  drivers/base/node.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 0ac6376ef7a1..89c932a1d8ca 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -45,7 +45,11 @@ static inline ssize_t cpumap_read(struct file *file, struct kobject *kobj,
>         return n;
>  }
>
> -static BIN_ATTR_RO(cpumap, 0);
> +/* Report a valid max size for this file to avoid breaking userspace. We use NR_CPUS/2 as
> + * a simplification of NR_CPUS/8 + NR_CPUS/32.  Use PAGE_SIZE as a minimum for smaller
> + * configurations.
> + */
> +static BIN_ATTR_RO(cpumap, (((NR_CPUS >> 1) > PAGE_SIZE) ? NR_CPUS >> 1 : PAGE_SIZE));

the code should be fine. but the comment seems to be wrong?

/$ cat /sys/devices/system/node/node0/cpumap
00000000,00000000,00000000,000000ff

4 cpus need one byte in hex, 32 cpus need a comma.
for 32cpus, we totally need 9 bytes.

Based on your comment, you get 32/8+32/32=5.
should be NR_CPUS/4 ?

>
>  static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
>                                    struct bin_attribute *attr, char *buf,
> @@ -66,7 +70,15 @@ static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
>         return n;
>  }
>
> -static BIN_ATTR_RO(cpulist, 0);
> +/* Report a valid maximum size for this file since 0 breaks userspace, which
> + * may use the size from fstat to allocate a read buffer.
> + * The value 7 is a hardcoded version of ceil(log10(NR_CPUS)) + 1 for future values
> + * of NR_CPUS that may be upto 2 orders of magnitude larger than 8192.
> + * In a worst case system every other cpu is on one of two nodes. This leads to
> + * a file like "0,2,4,6,8...1024,...8190,...". Use PAGE_SIZE as a minimum for smaller
> + * NR_CPUS.
> +*/
> +static BIN_ATTR_RO(cpulist, (((NR_CPUS * 7) > PAGE_SIZE) ? NR_CPUS * 7 : PAGE_SIZE));
>

It seems to be very sufficient. At least, my poor math tells me 7
bytes can describe cpu id like
"100000," and up to "999999,"
but it is still hard for me to understand the comments :-)

btw, we have a lot of other places which might need this, such as
drivers/base/topology.c

so perhaps we can move them to some common place,

#define cpu_bitmap_bytes  (((NR_CPUS >> 1) > PAGE_SIZE) ? NR_CPUS >> 1
: PAGE_SIZE)
#define cpu_list_bytes  (((NR_CPUS * 7) > PAGE_SIZE) ? NR_CPUS * 7 : PAGE_SIZE)

is include/linux/cpumask.h a good place for it?

>  /**
>   * struct node_access_nodes - Access class device to hold user visible
> --
> 2.31.1
>

Thanks
Barry
