Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC09596B30
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbiHQIQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbiHQIPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:15:20 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3998A7674F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:14:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VMUoG2T_1660724092;
Received: from 30.97.48.48(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VMUoG2T_1660724092)
          by smtp.aliyun-inc.com;
          Wed, 17 Aug 2022 16:14:54 +0800
Message-ID: <e0be2d37-3649-22c8-e597-8d9ca3b7e6fb@linux.alibaba.com>
Date:   Wed, 17 Aug 2022 16:15:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 0/3] drivers/perf: add DDR Sub-System Driveway PMU
 driver for Yitian 710 SoC
To:     Shuai Xue <xueshuai@linux.alibaba.com>,
        Jonathan.Cameron@Huawei.com, rdunlap@infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, mark.rutland@arm.com
Cc:     yaohongbo@linux.alibaba.com, nengchen@linux.alibaba.com,
        zhuo.song@linux.alibaba.com
References: <20220617111825.92911-1-xueshuai@linux.alibaba.com>
 <20220720065815.60772-1-xueshuai@linux.alibaba.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220720065815.60772-1-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/2022 2:58 PM, Shuai Xue wrote:
> This patchset adds support for Yitian 710 DDR Sub-System Driveway PMU driver,
> which custom-built by Alibaba Group's chip development business, T-Head.
> 
> Changes since v2:
> - relaxe build constraints and add COMPILE_TEST
> - explicitly include dependent headers
> - add Reviewed-by, thanks Jonathan Cameron and Randy Dunlap for their valuable review and comments
> - Link: https://lore.kernel.org/linux-arm-kernel/20220715151310.90091-4-xueshuai@linux.alibaba.com/T/#m1116abc4b0bda1943ab436a45d95359f9bbe0858
> 
> Changes since v1:
> - add high level workflow about DDRC so that user cloud better understand the
>    PMU hardware mechanism
> - rewrite patch description and add interrupt sharing constraints
> - delete event perf prefix
> - add a condition to fix bug in ali_drw_pmu_isr
> - perfer CPU in the same Node when migrating irq
> - use FIELD_PREP and FIELD_GET to make code more readable
> - add T-Head HID and leave ARMHD700 as CID for compatibility
> - Link: https://lore.kernel.org/linux-arm-kernel/eb50310d-d4a0-c7ff-7f1c-b4ffd919b10c@linux.alibaba.com/T/
> 

As I've reviewed the patch set internally before, please feel free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> Shuai Xue (3):
>    docs: perf: Add description for Alibaba's T-Head PMU driver
>    drivers/perf: add DDR Sub-System Driveway PMU driver for Yitian 710
>      SoC
>    MAINTAINERS: add maintainers for Alibaba' T-Head PMU driver
> 
>   .../admin-guide/perf/alibaba_pmu.rst          | 100 +++
>   Documentation/admin-guide/perf/index.rst      |   1 +
>   MAINTAINERS                                   |   7 +
>   drivers/perf/Kconfig                          |   7 +
>   drivers/perf/Makefile                         |   1 +
>   drivers/perf/alibaba_uncore_drw_pmu.c         | 810 ++++++++++++++++++
>   6 files changed, 926 insertions(+)
>   create mode 100644 Documentation/admin-guide/perf/alibaba_pmu.rst
>   create mode 100644 drivers/perf/alibaba_uncore_drw_pmu.c
> 
