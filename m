Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC34E58F66C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 05:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbiHKDhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 23:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiHKDhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 23:37:47 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139106CF73;
        Wed, 10 Aug 2022 20:37:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0VLxQ5Q3_1660189052;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VLxQ5Q3_1660189052)
          by smtp.aliyun-inc.com;
          Thu, 11 Aug 2022 11:37:34 +0800
Subject: Re: [PATCH V5 5/6] riscv: crash_core: Export kernel vm layout,
 phys_ram_base
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        crash-utility@redhat.com, huanyi.xj@alibaba-inc.com,
        heinrich.schuchardt@canonical.com, k-hagio-ab@nec.com,
        hschauhan@nulltrace.org, yixun.lan@gmail.com
References: <20220802121818.2201268-1-xianting.tian@linux.alibaba.com>
 <20220802121818.2201268-6-xianting.tian@linux.alibaba.com>
 <YvRyT5f5uH7LBs4H@debian.me>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <81bf1acd-307c-b093-44c2-280c70f44e08@linux.alibaba.com>
Date:   Thu, 11 Aug 2022 11:37:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YvRyT5f5uH7LBs4H@debian.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/8/11 上午11:06, Bagas Sanjaya 写道:
> On Tue, Aug 02, 2022 at 08:18:17PM +0800, Xianting Tian wrote:
>> These infos are needed by the kdump crash tool. Since these values change
>> from time to time, it is preferable to export them via vmcoreinfo than to
>> change the crash's code frequently.
>>
> I have to agree with Conor.Dooley, that this patch is misleading (I see
> documentation instead of real export). So IMO, the patch subject should
> be "Documentation: kdump: describe VMCOREINFO export for RISCV64".
>
> For MODULES_VADDR and friends, the doc can be improved, like:
>
> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> index 6b76284a503ca5..6694acc32c3588 100644
> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> @@ -615,14 +615,13 @@ phys_ram_base
>   
>   Indicates the start physical RAM address.
>   
> -MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMAP_END
> ------------------------------------------------------------------------------
> -KASAN_SHADOW_START|KASAN_SHADOW_END|KERNEL_LINK_ADDR|ADDRESS_SPACE_END
> -----------------------------------------------------------------------
> +MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMAP_END|KASAN_SHADOW_START|KASAN_SHADOW_END|KERNEL_LINK_ADDR|ADDRESS_SPACE_END
> +----------------------------------------------------------------------------------------------------------------------------------------------------
>   
>   Used to get the correct ranges:
> -	MODULES_VADDR ~ MODULES_END : Kernel module space.
> -	VMALLOC_START ~ VMALLOC_END : vmalloc() / ioremap() space.
> -	VMEMMAP_START ~ VMEMMAP_END : vmemmap region, used for struct page array.
> -	KASAN_SHADOW_START ~ KASAN_SHADOW_END : kasan shadow space.
> -	KERNEL_LINK_ADDR ~ ADDRESS_SPACE_END : Kernel link and BPF space.
> +
> +  * MODULES_VADDR ~ MODULES_END : Kernel module space.
> +  * VMALLOC_START ~ VMALLOC_END : vmalloc() / ioremap() space.
> +  * VMEMMAP_START ~ VMEMMAP_END : vmemmap region, used for struct page array.
> +  * KASAN_SHADOW_START ~ KASAN_SHADOW_END : kasan shadow space.
> +  * KERNEL_LINK_ADDR ~ ADDRESS_SPACE_END : Kernel link and BPF space.
Thanks for the comment, I will fix it in V6
>
> Thanks.
>
