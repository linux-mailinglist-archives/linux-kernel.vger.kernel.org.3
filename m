Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E982C5729CC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 01:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbiGLXTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 19:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbiGLXTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 19:19:12 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19AFACF74
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 16:19:11 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id t1so1223528ejd.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 16:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bezpQ51vOd+O4bzkMY2t3j2Rv2TPtQX5p0hq3zFqsUM=;
        b=cTZwLp2+j6r2TZspzI55cCZMgP/2Dn3ankHT4oU4p4uf4a48bva4ZPD/ewzJ15dL/c
         rOA8n6e77oyNXz8Lpd3R550AXLrBeM0nhGXa7uc1DJjECWzOhHCKo4mPPxindjPxQ2PF
         r36qMHxws+wCOFKie4yLLVKFrNU0fCEhndnGfELF/EpQ5M5ifhKSN/11J5M6FIg6Sz8N
         3oyEI9Zl9KdT1vKrvZivegp/G6PdTnUodRBAK0EuZaJUmTC7CsHThHxt/ZlCWx4JV3v7
         qPT/jamS55NlMBNFqf8Jn/mQ/HAM7r78SLnuzLTK6XuZ8b2e19ZUGpw/Mb30EzX6NF4f
         ebGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bezpQ51vOd+O4bzkMY2t3j2Rv2TPtQX5p0hq3zFqsUM=;
        b=LkG7RsBJIam2OARIUTkN98p/QwCOqCeApPoPcekdifYfILbg7wPR3neQjcyluB4PNv
         1XKWN4aHMjefXRP2KoJQ62W54iuAUrc5/7/ppqauA+zFL8GpCJ4b2CHrr/nZW4EObQi1
         Q6RW57Fmd5gYD0fI4/VZgjrrLRanDeocYbTfqhjnk60RQ6kTLIShsphdLOQxpX3qnB+N
         vbLnv9NLtpuf2sWaoOzIBo9VpfzZXytvrSV0Eh6sw1Zhfm12Ecm7P5sUJ3L7fjK1rsve
         TlPbqZQA6oPuQli9p6TWxVMz7eyqaeup3A2SQSzlDx2NytcEjq92b+muYVCYsjJRRFed
         NPCg==
X-Gm-Message-State: AJIora+Sa+Utf1aTdm64MyMJxNvFUtgWMVe7Pr3RE+8kQhDuTpvTmKmB
        Dql6icmfWktixwRZBF/ZrvTSa9CH+/EmqUmsGj4=
X-Google-Smtp-Source: AGRyM1uYbQeFwBsfeH9KFr8QzdvFZLkdNk38Lsf6onm0pL3CC+fjdfv62VB4tA/6ScEZSiR3BZKKkkIhHcc3t50xkWM=
X-Received: by 2002:a17:907:9810:b0:722:f204:b409 with SMTP id
 ji16-20020a170907981000b00722f204b409mr472431ejc.457.1657667950265; Tue, 12
 Jul 2022 16:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220712214301.809967-1-pauld@redhat.com>
In-Reply-To: <20220712214301.809967-1-pauld@redhat.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 13 Jul 2022 11:18:59 +1200
Message-ID: <CAGsJ_4xG0az1-g8DWL-mEv_cF3ZBMe6j87m_cxeL9abvxGNW=g@mail.gmail.com>
Subject: Re: [PATCH] drivers/base/node.c: fix userspace break from using
 bin_attributes for cpumap and cpulist
To:     Phil Auld <pauld@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki : --cc=" <rafael@kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        Barry Song <song.bao.hua@hisilicon.com>
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

On Wed, Jul 13, 2022 at 9:58 AM Phil Auld <pauld@redhat.com> wrote:
>
> Using bin_attributes with a 0 size causes fstat and friends to return that 0 size.
> This breaks userspace code that retrieves the size before reading the file. Rather
> than reverting 75bd50fa841 ("drivers/base/node.c: use bin_attribute to break the size
> limitation of cpumap ABI") let's put in a size value at compile time. Use direct
> comparison and a worst-case maximum to ensure compile time constants. For cpulist the
> max is on the order of NR_CPUS * (ceil(log10(NR_CPUS)) + 1) which for 8192 is 40960.
> In order to get near that you'd need a system with every other CPU on one node or
> something similar. e.g. (0,2,4,... 1024,1026...). We set it to a min of PAGE_SIZE
> to retain the older behavior. For cpumap, PAGE_SIZE is plenty big.
>
> On an 80 cpu 4-node system (NR_CPUS == 8192)
>
> before:
>
> -r--r--r--. 1 root root 0 Jul 12 14:08 /sys/devices/system/node/node0/cpulist
> -r--r--r--. 1 root root 0 Jul 11 17:25 /sys/devices/system/node/node0/cpumap

it is a fundamental problem of bin_attr, isn't it? when we don't know the
exact size of an attribute, and this size might become more than one
PAGE_SIZE, we use bin_attr to break the limitation. but the fact is that
we really don't know or it is really hard to know the actual size of the
attribute.

>
> after:
>
> -r--r--r--. 1 root root 40960 Jul 12 16:48 /sys/devices/system/node/node0/cpulist
> -r--r--r--. 1 root root  4096 Jul 12 15:50 /sys/devices/system/node/node0/cpumap

if we finally set a size which might be improper, it seems we defeat the
purpose we start to move to bin_attr?

>
> Fixes: 75bd50fa841 ("drivers/base/node.c: use bin_attribute to break the size limitation of cpumap ABI")
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Phil Auld <pauld@redhat.com>
> ---
>  drivers/base/node.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 0ac6376ef7a1..291c69671f23 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -45,7 +45,7 @@ static inline ssize_t cpumap_read(struct file *file, struct kobject *kobj,
>         return n;
>  }
>
> -static BIN_ATTR_RO(cpumap, 0);
> +static BIN_ATTR_RO(cpumap, PAGE_SIZE);

PAGE_SIZE is probably big enough, will we still calculate to get it rather than
hard coding?

>
>  static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
>                                    struct bin_attribute *attr, char *buf,
> @@ -66,7 +66,7 @@ static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
>         return n;
>  }
>
> -static BIN_ATTR_RO(cpulist, 0);
> +static BIN_ATTR_RO(cpulist, (((NR_CPUS * 5) > PAGE_SIZE) ? NR_CPUS *5 : PAGE_SIZE));

I am still not sure why it is NR_CPUS * 5. Is 5 bytes big enough to
describe the number
of cpu id? technically it seems not,  for example,  for cpuid=100000,
we need at least 6
bytes.

BTW, my silly question is that what if we set the size to MAXIMUM int?
Will it fix
the userspace fsstat?

>
>  /**
>   * struct node_access_nodes - Access class device to hold user visible
> --
> 2.31.1
>

Thanks
Barry
