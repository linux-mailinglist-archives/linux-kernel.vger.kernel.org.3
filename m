Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9935AA66E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 05:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbiIBDbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 23:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbiIBDbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 23:31:02 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FE9AB063
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 20:31:01 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id m2so661839pls.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 20:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=shz1MJujjzqiNwugBIDcBsPwYPc3SVzREMOMkqsy7Mk=;
        b=w8zTqe7jLtPspiEBjz+Fy4fnP6CRLP/1zB1TYddtfRvPRf6HmPkOhDjjui66WN2vsl
         5IjdUYxKnnoMusvxY/mOH9TD6PkP0ZcdcNPwGreeU6bbLuIBySqYMjVzFdaEv0V86kHy
         pRzBdIR3YkpGmIYlHpQDxZhmRZ72RRgFTm51BCNCOvy5ir+Mv2OIiiNBEEtYNav77mUF
         mbHV4wPilqz1NqoKMoWYS9n2nLpkfXWHCOkA/MkS5si5zhMesHK7y5M6S0/swB5oGNJp
         Vho54MFRdGsDtTej4LYmrHru82H6nWe9gB2JJQhofQYoZ/Tj2mO1Q5xsj0DzIRYpaQd7
         /r3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=shz1MJujjzqiNwugBIDcBsPwYPc3SVzREMOMkqsy7Mk=;
        b=Ew65zJ/dL3/eNBnoDiToBJ5+YWvQCYxNOh843AhS0iC+X+zGZ5Cgsc7rXqcOdNl020
         jAi9TJjkQKO1nSygeqDghRE8AdYlwMOAf51CigTXrcQTDVK5JJAStxnmLKk/1yvQ48/f
         u6t9rO/9NYlHF/WPZRcszzZhtbkeaIe6kODMxsfsxtn+2CQ7OS/vmqPffCHV/11spUl1
         CqYKwcOfYfGT1n0FM92b2kafTWTeZ49CbD7JDUDrmiY31pACDhRM1Qz6FpInYq2INIDo
         SlUgRlxbfrtD907iiJZHiOs9tt/zDM7PTnm1rbtPR5eC+pbwj6Ohiiudc5XqERX5GjOs
         lhuw==
X-Gm-Message-State: ACgBeo2Ngfy4uduc/Z7NESLCXdPJrCB6prGdzeu1+0D8gOA8MYRx5drC
        E5aazMl8DwexT9iVynpsLa+E0dXmDaswIA==
X-Google-Smtp-Source: AA6agR5WowK59aA98UXhJCFNoaxgGwDjHSg3E1dHsTvjRo7r8QRvQblDqSuZDdJ0+myL45NwJuKEsQ==
X-Received: by 2002:a17:90a:4d8d:b0:1fa:9cc6:3408 with SMTP id m13-20020a17090a4d8d00b001fa9cc63408mr2434860pjh.245.1662089460803;
        Thu, 01 Sep 2022 20:31:00 -0700 (PDT)
Received: from [10.255.237.132] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id x13-20020a17090a1f8d00b001f510175984sm4090447pja.41.2022.09.01.20.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 20:31:00 -0700 (PDT)
Message-ID: <4a62a93c-683a-0515-2033-26c59b3b6f20@bytedance.com>
Date:   Fri, 2 Sep 2022 11:30:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.0
Subject: Re: [PATCH v2] iommu/iova: Optimize alloc_iova with rbtree_augmented
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, xieyongji@bytedance.com,
        Ethan Zhao <haifeng.zhao@linux.intel.com>
References: <20220824095139.66477-1-zhangpeng.00@bytedance.com>
 <06c215c6-cbae-d6b9-312c-6535e51a3128@linux.intel.com>
 <486fcde8-e9f5-e40c-db5d-fd3ade59b267@bytedance.com>
 <a2479500-479a-22ef-3bd2-90606a26a35e@linux.intel.com>
 <4527c925-076b-a477-4ff8-697d75f16761@bytedance.com>
 <1351998d-4fd7-dffb-c1fa-a0b1ca759123@huawei.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <1351998d-4fd7-dffb-c1fa-a0b1ca759123@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> If you really have a performance issue with alloc_iova_fast() -> 
> alloc_iova() then I suggest that you consider trying to use 
> dma_opt_mapping_size() to teach the DMA engine driver to not create 
> requests whose overall size exceeds to the rcache limit.

Yes. But I don't think it essentially solves the problem.
A library for users should run stably ant it shouldn't hold
the spinlock for a long time in some cases. It can even be
said to be a bug.

Like this:
[Wed May 25 05:27:59 2022] watchdog: BUG: soft lockup - CPU#58
stuck for 23s!
[Wed May 25 05:27:59 2022] Call Trace:
[Wed May 25 05:27:59 2022]  alloc_iova+0xf2/0x140
[Wed May 25 05:27:59 2022]  alloc_iova_fast+0x56/0x251

Now we avoid this problem with iommu=pt, but it didn't solve the problem.

Thanks,
Peng
