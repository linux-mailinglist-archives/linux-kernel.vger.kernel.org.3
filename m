Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4426C58663F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiHAIUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiHAIUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:20:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92C08193CF
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 01:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659342035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pJH07x8QvE4r/0Wcvdf2EaLzPedOQZnkWNurVPoZ0fI=;
        b=LdlnI3b8f5bBfuAEYQ4tWKoljG+xFkR/ldTBe+Yu40sxWNZAaIVFpF/S3YhUFchxIxXDmF
        XQDLcRDqhHiGIKcqyHETnlW4tU2iqzPs1FvbwqQlSjapLF0yZIhYFzyc/hb7niA/4iRdz4
        ziwfyB3WwOf4MYPnCqDU8/ozrBHVWKo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-wsEDCQC2NEKteI_g3du0kQ-1; Mon, 01 Aug 2022 04:20:32 -0400
X-MC-Unique: wsEDCQC2NEKteI_g3du0kQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9434B1C14488;
        Mon,  1 Aug 2022 08:20:31 +0000 (UTC)
Received: from localhost (ovpn-12-103.pek2.redhat.com [10.72.12.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 10BDE492C3B;
        Mon,  1 Aug 2022 08:20:29 +0000 (UTC)
Date:   Mon, 1 Aug 2022 16:20:25 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH v3 0/2] arm64: kdump: Function supplement and performance
 optimization
Message-ID: <YueMyUqannVg7l9v@MiWiFi-R3L-srv>
References: <20220711090319.1604-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711090319.1604-1-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 07/11/22 at 05:03pm, Zhen Lei wrote:
> v2 --> v3:
> 1. Discard patch 3 in v2, a cleanup patch.
> 
> v1 --> v2:
> 1. Update the commit message of Patch 1, explicitly indicates that "crashkernel=X,high"
>    is specified but "crashkernel=Y,low" is not specified.
> 2. Drop Patch 4-5. Currently, focus on function integrity, performance optimization
>    will be considered in later versions.
> 3. Patch 3 is not mandatory, it's just a cleanup now, although it is a must for patch 4-5.
>    But to avoid subsequent duplication of effort, I'm glad it was accepted.
> 
> 
> v1:
> After the basic functions of "support reserving crashkernel above 4G on arm64
> kdump"(see https://lkml.org/lkml/2022/5/6/428) are implemented, we still have
> three features to be improved.
> 1. When crashkernel=X,high is specified but crashkernel=Y,low is not specified,
>    the default crash low memory size is provided.
> 2. For crashkernel=X without '@offset', if the low memory fails to be allocated,
>    fall back to reserve region from high memory(above DMA zones).
> 3. If crashkernel=X,high is used, page mapping is performed only for the crash
>    high memory, and block mapping is still used for other linear address spaces.
>    Compared to the previous version:
>    (1) For crashkernel=X[@offset], the memory above 4G is not changed to block
>        mapping, leave it to the next time.
>    (2) The implementation method is modified. Now the implementation is simpler
>        and clearer.

Do you have plan to pick this series so that it can be taken into 5.20
rc-1~3?

We have back ported the basic crashkernel=high, low, support into our
distros and have taken wide testing on arm64 servers, need this patchset
to back port for more testing. 

Thanks
Baoquan

> 
> Zhen Lei (2):
>   arm64: kdump: Provide default size when crashkernel=Y,low is not
>     specified
>   arm64: kdump: Support crashkernel=X fall back to reserve region above
>     DMA zones
> 
>  .../admin-guide/kernel-parameters.txt         | 10 ++-----
>  arch/arm64/mm/init.c                          | 28 +++++++++++++++++--
>  2 files changed, 28 insertions(+), 10 deletions(-)
> 
> -- 
> 2.25.1
> 

