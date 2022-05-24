Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98736532615
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbiEXJFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbiEXJFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:05:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5C9DD132
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653383133;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=991Yoy904FM5Pcpym2p+cdFnBELZSboveUf5hdm5xss=;
        b=HNSeOJfnPKoUhO/mHf5uW/RSrV5xiXL3OAZxN6YikpNNzUYt2na84rs1tEmQnXbchuE8Dk
        ffcnf5MTa1cpT6vLPzB/0mV5qiJNqqhx6ZEST5FuoqOOWKXPDIP/iiAkaRUeiwh/mQKEZ9
        yhjzdsAUM+UHYEkHwC6kZpFKKb3r/vY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-600-11oyp70QNwaABnW2F0PlDw-1; Tue, 24 May 2022 05:05:30 -0400
X-MC-Unique: 11oyp70QNwaABnW2F0PlDw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DEDC03C025BE;
        Tue, 24 May 2022 09:05:29 +0000 (UTC)
Received: from [10.72.12.91] (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 044692026D6A;
        Tue, 24 May 2022 09:05:25 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] arch_topology: Limit threads to one specific cluster
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rafael@kernel.org, Jonathan.Cameron@huawei.com, drjones@redhat.com,
        zhenyzha@redhat.com, shan.gavin@gmail.com
References: <20220524081212.1363105-1-gshan@redhat.com>
 <20220524085157.o3ie6hjy3tg5of5y@bogus>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <7cc4eef4-bdb6-bd53-450b-f2348f722cf5@redhat.com>
Date:   Tue, 24 May 2022 17:05:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20220524085157.o3ie6hjy3tg5of5y@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On 5/24/22 4:51 PM, Sudeep Holla wrote:
> On Tue, May 24, 2022 at 04:12:12PM +0800, Gavin Shan wrote:
>> The sibling information for one particular CPU is updated after ACPI
>> PPTT table is parsed. struct cpu_topology::thread_sibling tracks the
>> the CPUs in same core. However, cluster isn't considered when it's
>> populated. In this case, multiple threads belonging to different
>> clusters can be put together through the sibling information. It
>> eventually leads to unexpected warning from sched subsystem.
>>
>> For example, the following warning is observed in a VM where we have
>> 2 sockets, 4 clusters, 8 cores and 16 threads and the CPU topology
>> is populated as below.
>>
>>     CPU  Socket-ID  Cluster-ID  Core-ID  Thread-ID
>>     ----------------------------------------------
>>      0      0          0          0        0
>>      1      0          0          0        1
>>      2      0          0          1        0
>>      3      0          0          1        1
>>      4      0          1          0        0
>>      5      0          1          0        1
>>      6      0          1          1        0
>>      7      0          1          1        1
>>      8      1          0          0        0
>>      9      1          0          0        1
>>     10      1          0          1        0
>>     11      1          0          1        1
>>     12      1          1          0        0
>>     13      1          1          0        1
>>     14      1          1          1        0
>>     15      1          1          1        1
>>
>>    [    0.592181] CPU: All CPU(s) started at EL1
>>    [    0.593766] alternatives: patching kernel code
>>    [    0.595890] BUG: arch topology borken
>>    [    0.597210]      the SMT domain not a subset of the CLS domain
>>    [    0.599286]      child=0-1,4-5    sd=0-3
>>
>>    # cat /sys/devices/system/cpu/cpu0/topology/cluster_cpus_list
>>    0-3
>>    # cat /sys/devices/system/cpu/cpu0/topology/thread_siblings_list
>>    0-1,4-5
>>
>> This fixes the issue by limiting threads to one specific cluster.
>> With this applied, the unexpected warning disappears in the VM.
>>
> 
> I have similar fix but as part of bigger series[1] to get DT support in
> line with ACPI.
> 

Your patch resolves the issue I have. So please ignore mine. Sorry
for the noise.

https://lore.kernel.org/lkml/20220518093325.2070336-3-sudeep.holla@arm.com

# cat /sys/devices/system/cpu/cpu0/topology/cluster_cpus_list
0-3
# cat /sys/devices/system/cpu/cpu0/topology/thread_siblings_list
0-1

Thanks,
Gavin


