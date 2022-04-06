Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4724F66C2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbiDFRKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238649AbiDFRKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:10:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC6A3B38EA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 07:40:34 -0700 (PDT)
X-UUID: a5ba77229bc84a0aa701dca2a0208fca-20220406
X-UUID: a5ba77229bc84a0aa701dca2a0208fca-20220406
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <phil.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1370098395; Wed, 06 Apr 2022 22:40:29 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 6 Apr 2022 22:40:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 6 Apr 2022 22:40:28 +0800
From:   Phil Chang <phil.chang@mediatek.com>
To:     <jens.wiklander@linaro.org>
CC:     <sumit.garg@linaro.org>, <matthias.bgg@gmail.com>,
        <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: Re: [PATCH v4] tee: make tee_shm_register_kernel_buf vmalloc supported
Date:   Wed, 6 Apr 2022 22:40:28 +0800
Message-ID: <20220406144028.4203-1-phil.chang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAHUa44GDg7hAAFsmeOOkeqi8_1P1Q6jATRdnV9b6S-DhpEEQrA@mail.gmail.com>
References: <CAHUa44GDg7hAAFsmeOOkeqi8_1P1Q6jATRdnV9b6S-DhpEEQrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Feb 25, 2022 at 4:20 PM Phil Chang <phil.chang@mediatek.com>
> wrote:
>>
>> In some low-memory devices, it's hard to aquire large-orders pages,
>> this patch allowed user using scatter pages to register shm.
>>
>> Signed-off-by: Phil Chang <phil.chang@mediatek.com>
>> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>> ---
>>  drivers/tee/optee/call.c |  2 +-
>>  drivers/tee/tee_shm.c    | 35 +++++++++++++++++++++++++----------
>>  2 files changed, 26 insertions(+), 11 deletions(-)
>
> Looks good to me. Unfortunately this is too late for the coming merge
> window, so it's going to be the one after that. Meanwhile it will be
> in linux-next.
>
> Thanks,
> Jens

 Hi Jens
   thanks for your review, did I push again wile merge window open ?
   Or just wait ?

 Thanks

>>
>> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
>> index bd49ec934060..2082e632adff 100644
>> --- a/drivers/tee/optee/call.c
>> +++ b/drivers/tee/optee/call.c
>> @@ -362,7 +362,7 @@ int optee_check_mem_type(unsigned long start,
>> size_t num_pages)
>>          * Allow kernel address to register with OP-TEE as kernel
>>          * pages are configured as normal memory only.
>>          */
>> -       if (virt_addr_valid(start))
>> +       if (virt_addr_valid(start) || is_vmalloc_addr((void *)start))
>>                 return 0;
>>
>>         mmap_read_lock(mm);
>> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
>> index f31e29e8f1ca..836872467dc6 100644
>> --- a/drivers/tee/tee_shm.c
>> +++ b/drivers/tee/tee_shm.c
>> @@ -23,21 +23,36 @@ static void shm_put_kernel_pages(struct page
>> **pages, size_t page_count)
>>  static int shm_get_kernel_pages(unsigned long start, size_t
>>  page_count,
>>                                 struct page **pages)
>>  {
>> -       struct kvec *kiov;
>>         size_t n;
>>         int rc;
>>
>> -       kiov = kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
>> -       if (!kiov)
>> -               return -ENOMEM;
>> +       if (is_vmalloc_addr((void *)start)) {
>> +               struct page *page;
>>
>> -       for (n = 0; n < page_count; n++) {
>> -               kiov[n].iov_base = (void *)(start + n * PAGE_SIZE);
>> -               kiov[n].iov_len = PAGE_SIZE;
>> -       }
>> +               for (n = 0; n < page_count; n++) {
>> +                       page = vmalloc_to_page((void *)(start +
>> PAGE_SIZE * n));
>> +                       if (!page)
>> +                               return -ENOMEM;
>> +
>> +                       get_page(page);
>> +                       pages[n] = page;
>> +               }
>> +               rc = page_count;
>> +       } else {
>> +               struct kvec *kiov;
>> +
>> +               kiov = kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
>> +               if (!kiov)
>> +                       return -ENOMEM;
>>
>> -       rc = get_kernel_pages(kiov, page_count, 0, pages);
>> -       kfree(kiov);
>> +               for (n = 0; n < page_count; n++) {
>> +                       kiov[n].iov_base = (void *)(start + n *
>> PAGE_SIZE);
>> +                       kiov[n].iov_len = PAGE_SIZE;
>> +               }
>> +
>> +               rc = get_kernel_pages(kiov, page_count, 0, pages);
>> +               kfree(kiov);
>> +       }
>>
>>         return rc;
>>  }
>> --
>> 2.25.1
