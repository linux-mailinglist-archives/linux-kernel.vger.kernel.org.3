Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A175A43B5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiH2HXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiH2HXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:23:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D5A4DF0C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 00:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661757818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hcPRhFm7mNV6NpDp2k0Lb7eWVPc8YWQH000p3YsLMTU=;
        b=Uxn4y1SXoRWugzFGvW6MhjriLT1hq+7zrd/y61PzVpmzJLjos0ZUvR1dmvlpfzZkYmiNoM
        bczeX8SBvHOAzBnutAhrSxdTvhvkrEcYu+YPyby3EhXSNIPXVTeI+8BGdD+HtWvQSStzGH
        G7avESVNpQlGhM45sLCQy9X6mUbRh18=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-32U3eHkIMCOWtsWdYN67hA-1; Mon, 29 Aug 2022 03:23:35 -0400
X-MC-Unique: 32U3eHkIMCOWtsWdYN67hA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 736BF811E81;
        Mon, 29 Aug 2022 07:23:34 +0000 (UTC)
Received: from [10.39.208.19] (unknown [10.39.208.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 40EA72166B26;
        Mon, 29 Aug 2022 07:23:32 +0000 (UTC)
Message-ID: <6f874c0b-cea2-e835-ad1c-8cd21fb1a82e@redhat.com>
Date:   Mon, 29 Aug 2022 09:23:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] vduse: prevent uninitialized memory accesses
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, elic@nvidia.com,
        guanjun@linux.alibaba.com, parav@nvidia.com,
        gautam.dawar@xilinx.com, xieyongji@bytedance.com,
        jasowang@redhat.com, mst@redhat.com
References: <20220826161605.559317-1-maxime.coquelin@redhat.com>
 <20220827065435.GL2030@kadam>
From:   Maxime Coquelin <maxime.coquelin@redhat.com>
In-Reply-To: <20220827065435.GL2030@kadam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/27/22 08:54, Dan Carpenter wrote:
> On Fri, Aug 26, 2022 at 06:16:05PM +0200, Maxime Coquelin wrote:
>> If the VDUSE application provides a smaller config space
>> than the driver expects, the driver may use uninitialized
>> memory from the stack.
>>
>> This patch prevents it by initializing the buffer passed by
>> the driver to store the config value.
>>
>> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> 
> This sounds like it needs a Fixes tag?

Yes, I actually did it, but somehow forgot to generate the patch bedore
posting.

I'll post a v2 soon.

Thanks,
Maxime

> regards,
> dan carpenter
> 

