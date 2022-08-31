Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1A15A7678
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiHaGUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiHaGUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:20:06 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8227F1DA48
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:20:02 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id b128so10024418vsc.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5Uji14+TdZrnvcT0vtEfCUN+mbWQ8EBkoUebh8FZEU8=;
        b=Y2jD8zNY3VvF7yFZcZLYhg5Gfzu1o+2UpwAtIZ2QspR4u/sFWVRH4h00lTQdl/47MW
         U5odU8htYcZ2Axj1dl79B3wZsOZ6AaAPdjRQHp0WvPY18nb6X5oZ7E/qv2UrdCqSqcvZ
         fcm5ILO5TV8jpnS/soWNXWi/byQir7ZtOy2l6E/jPNrxOkqN9uQhq344Wv4lLGrr1sG3
         +X5uaZ6rKLsXBsGJpEd6Qw01wUEnqrQcnhJ7fvdlYWjpk58o8N+20uN7tysYr0ICkUCb
         aZdQZEo8jA8A1s3kXHfKh/Al/ymnrr3XYS0CpXGICVRZbwu2b/gMHYq+pxWvc293raeZ
         +sBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5Uji14+TdZrnvcT0vtEfCUN+mbWQ8EBkoUebh8FZEU8=;
        b=4ouK/vPlU6aTpyfqgGWRaL1vaipz6X4se65vE/l24gAoxJqHdGuK7VMkayuoP1ZMNu
         MTperFII+I6rQOuUgZwRzeFcT9K0Dovti9vZcCSPfkpLrm77DWMRd5n25ZjqBTb3JXeP
         mITvsyGJcv2La6sWpFaSkbUOxHEbekKmvdL60f3QfTcMKWphGsSnasSJASBNiqsAK1de
         kl/P/2ter/w7ZEcAQ2NuZSVlZs7kYgq+m6d4i9zZmc8QyBgTl4dgHLoDRVl/Go/hgNzl
         ghzloexylx4rNVNkKGROpRcrvC2bQEkN+Yz3Bf/nREMy8pkkSK3cVVWob/UhSrrs4UBI
         66aw==
X-Gm-Message-State: ACgBeo3AgZCjmvzgPpOd5EcaFTQUwHiqgbnxdIZ7AbMN+4fkFpziEoY8
        fkiZP2jauqpWIMQ48sFjnUVO1sxBe5HBm/P5hhNs6HgmA9U=
X-Google-Smtp-Source: AA6agR4394e/N2qvqEWV8UddKMjybUgjOSmpGyCbjDt0hIzivYq9pWESRkiTrl7QLWA8RmaV5T+80kojoXyYUB3pVqA=
X-Received: by 2002:a05:6102:e93:b0:390:d839:9aa2 with SMTP id
 l19-20020a0561020e9300b00390d8399aa2mr5535835vst.65.1661926801397; Tue, 30
 Aug 2022 23:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220829232934.3277747-1-yuzhao@google.com> <202208310701.LKr1WDCh-lkp@intel.com>
In-Reply-To: <202208310701.LKr1WDCh-lkp@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 31 Aug 2022 00:19:25 -0600
Message-ID: <CAOUHufbnaZpNZ-rarVzOE+S6Wya8OmJF5sbNF29S-Y_XLNRooQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "swiotlb: panic if nslabs is too small"
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        iommu@lists.linux.dev, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 12:01 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hi Yu,
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yu-Zhao/Revert-swiotlb-panic-if-nslabs-is-too-small/20220830-073123
> base:   c40e8341e3b3bb27e3a65b06b5b454626234c4f0
> config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220831/202208310701.LKr1WDCh-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> kernel/dma/swiotlb.c:334 swiotlb_init_remap() error: uninitialized symbol 'nslabs'.
>
> vim +/nslabs +334 kernel/dma/swiotlb.c
>
> 7374153d294eb5 kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-14  307  void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
> 7374153d294eb5 kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-14  308                int (*remap)(void *tlb, unsigned long nslabs))
>                                                                                                                               ^^^^^^
>
> abbceff7d7a884 lib/swiotlb.c           FUJITA Tomonori   2010-05-10  309  {
> 6424e31b1c050a kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-15  310        struct io_tlb_mem *mem = &io_tlb_default_mem;
> 20347fca71a387 kernel/dma/swiotlb.c    Tianyu Lan        2022-07-08  311        unsigned long nslabs;
>                                                                                               ^^^^^^
> Merge issue?  How does this compile?

Sorry, I deleted an extra line while resolving the conflict.

Resending the patch.
