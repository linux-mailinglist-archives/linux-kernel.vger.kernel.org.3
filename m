Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14D451C3B0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381215AbiEEPVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354664AbiEEPVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:21:03 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0747D47054;
        Thu,  5 May 2022 08:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651763844; x=1683299844;
  h=from:subject:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=rmjiVGuf+I9qAzRqL1/hFE3jsQzkeuoi7JMBhh6xEKA=;
  b=eTBUqKhRI3gZoiW2kvvgjM6ypRx2MfUxEuXwjTQDrDk24fbIzwmomwTx
   wh4IK445ejd4D94JwmY4sr8EB1JdgEQJpshskR1N4iLbd9Fx8RlOaQ4Sc
   7xxU0H4cec5i/II1IX3Bm3aRlmS1nC9gQYVbLE0C7KX8YqxhctHbCKYCs
   E=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 05 May 2022 08:17:23 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 08:17:21 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 08:17:20 -0700
Received: from [10.216.37.226] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 5 May 2022
 08:17:17 -0700
From:   Faiyaz Mohammed <quic_faiyazm@quicinc.com>
Subject: Re: [PATCH] mm: memblock: avoid to create memmap for memblock nomap
 regions
To:     Mike Rapoport <rppt@kernel.org>
CC:     <quic_vjitta@quicinc.com>, <karahmed@amazon.de>,
        <qperret@google.com>, <robh@kernel.org>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <devicetree@vger.kernel.org>
References: <1649704172-13181-1-git-send-email-quic_faiyazm@quicinc.com>
 <YlW2TO0O8qDHpkGW@kernel.org>
Message-ID: <7b18bea8-b996-601d-f490-cb8aadfffa1b@quicinc.com>
Date:   Thu, 5 May 2022 20:46:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YlW2TO0O8qDHpkGW@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/12/2022 10:56 PM, Mike Rapoport wrote:
> On Tue, Apr 12, 2022 at 12:39:32AM +0530, Faiyaz Mohammed wrote:
>> This 'commit 86588296acbf ("fdt: Properly handle "no-map" field in the
>> memory region")' is keeping the no-map regions in memblock.memory with
>> MEMBLOCK_NOMAP flag set to use no-map memory for EFI using memblock api's,
>> but during the initialization sparse_init mark all memblock.memory as
>> present using for_each_mem_pfn_range, which is creating the memmap for
>> no-map memblock regions. To avoid it skiping the memblock.memory regions
>> set with MEMBLOCK_NOMAP set and with this change we will be able to save
>> ~11MB memory for ~612MB carve out.
> The MEMBLOCK_NOMAP is very fragile and caused a lot of issues already. I
> really don't like the idea if adding more implicit assumptions about how
> NOMAP memory may or may not be used in a generic iterator function.

Sorry for delayed response.
Yes, it is possible that implicit assumption can create
misunderstanding. How about adding command line option and control the
no-map region in fdt.c driver, to decide whether to keep "no-map" region
with NOMAP flag or remove?. Something like below

--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1180,8 +1180,10 @@ int __init __weak
early_init_dt_reserve_memory_arch(phys_addr_t base,
                 */
                if (memblock_is_region_reserved(base, size))
                        return -EBUSY;
-
-               return memblock_mark_nomap(base, size);
+               if (remove_nomap_region)
+                       return memblock_remove(base, size);
+               else
+                       return memblock_mark_nomap(base, size);
Thanks and regards,
Mohammed Faiyaz

