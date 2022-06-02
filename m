Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C0A53B3C7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiFBGob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiFBGo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:44:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 538CB230990
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654152266;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VoyA/L0tlcMVaTBmlf7Z/ZHtCkE4mBDsIVQpvWHfbKo=;
        b=J5oC8Gq1h6AWsR7j0rKIRPqzx5wrJDquXVrpQtxZU+MD/4VJ5/0lutBL4hrR8C0fAtvxwB
        lbei2r9Fo3bEd7LyUxG4bQYW02LSQKnKnlulIkhjsSqL8PIjp2BCqQHHfgmDWwGI1GIjHy
        A2Lx54UX17I0uoaKXfIcx8rKY1sPu8k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-Gb2az9dsP8-kaBxZr050Yw-1; Thu, 02 Jun 2022 02:44:14 -0400
X-MC-Unique: Gb2az9dsP8-kaBxZr050Yw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76CE11C006B1;
        Thu,  2 Jun 2022 06:44:13 +0000 (UTC)
Received: from [10.72.12.91] (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C8DC87AD8;
        Thu,  2 Jun 2022 06:44:07 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 09/16] arch_topology: Drop LLC identifier stash from
 the CPU topology
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
References: <20220525081416.3306043-2-sudeep.holla@arm.com>
 <20220525081416.3306043-3-sudeep.holla@arm.com>
 <20220525081416.3306043-4-sudeep.holla@arm.com>
 <20220525081416.3306043-5-sudeep.holla@arm.com>
 <20220525081416.3306043-6-sudeep.holla@arm.com>
 <20220525081416.3306043-7-sudeep.holla@arm.com>
 <20220525081416.3306043-8-sudeep.holla@arm.com>
 <20220525081416.3306043-9-sudeep.holla@arm.com>
 <20220525081416.3306043-10-sudeep.holla@arm.com>
 <3860bfcc-a323-c031-0fdd-77001d338bec@redhat.com>
 <20220601120658.2x737nhyxmodoo7t@bogus>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <fab8ce3b-2c56-862e-afcd-9f05594c6044@redhat.com>
Date:   Thu, 2 Jun 2022 14:44:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20220601120658.2x737nhyxmodoo7t@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On 6/1/22 8:06 PM, Sudeep Holla wrote:
> On Wed, Jun 01, 2022 at 11:35:20AM +0800, Gavin Shan wrote:
>> On 5/25/22 4:14 PM, Sudeep Holla wrote:
>>> Since the cacheinfo LLC information is used directly in arch_topology,
>>> there is no need to parse and store the LLC ID information only for
>>> ACPI systems in the CPU topology.
>>>
>>> Remove the redundant LLC ID from the generic CPU arch_topology information.
>>>
>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>> ---
>>>    drivers/base/arch_topology.c  | 1 -
>>>    include/linux/arch_topology.h | 1 -
>>>    2 files changed, 2 deletions(-)
>>>
>>
>> How about merge the changes to PATCH[08/16]? I don't see why we need put
>> the changes into separate patches.
>>
> 
> It took a while to remember as I was with the same opinion as yours but
> decided to split them for one reason: to keep arch specific change in a
> separate patch(if that becomes a need due to some conflict or some other
> non-technical reason)
> 

Ok. Thanks for the explanation, which sounds reasonable to me.

Thanks,
Gavin

