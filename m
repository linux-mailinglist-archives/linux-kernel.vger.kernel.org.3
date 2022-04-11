Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C7B4FB216
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 04:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244255AbiDKC7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 22:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243836AbiDKC7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 22:59:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE31F1839C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 19:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649645813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T/TxVJ8j7MEenFEqiqkbwv+oE0JIQvDaicMqp8AOqcI=;
        b=jMyliiD3jEhh3sJJbptWNZ9WVvNMhxElHX2nw6dXkekOWUvDVkQcw44tq8+KVGQFVbP5bP
        4/dKG1UwUAip0eLgRqlCEVQuU5AL+GGLTb6Z5nAt0sNiZrdPUw7Cno2DBm00VWjyvjFydw
        Fno9aOULY/vuEKAMiMh+WmYw5k8k5b4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-361-H7MUrN6SN8WG-5xHhgUh7Q-1; Sun, 10 Apr 2022 22:56:47 -0400
X-MC-Unique: H7MUrN6SN8WG-5xHhgUh7Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FBE4811E75;
        Mon, 11 Apr 2022 02:56:46 +0000 (UTC)
Received: from localhost (ovpn-12-19.pek2.redhat.com [10.72.12.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C3E3401E99;
        Mon, 11 Apr 2022 02:56:45 +0000 (UTC)
Date:   Mon, 11 Apr 2022 10:56:42 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH v21 0/5] support reserving crashkernel above 4G on arm64
 kdump
Message-ID: <YlOY6jGpl2EBs6zE@MiWiFi-R3L-srv>
References: <20220227030717.1464-1-thunder.leizhen@huawei.com>
 <YlABRPBEaTldZwuL@MiWiFi-R3L-srv>
 <3a0bb9a9-c2a1-2e3a-8f23-16109ae1e525@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a0bb9a9-c2a1-2e3a-8f23-16109ae1e525@huawei.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/22 at 05:47pm, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/4/8 17:32, Baoquan He wrote:
> > Hi, Lei
> > 
> > On 02/27/22 at 11:07am, Zhen Lei wrote:
> >> Changes since [v20]:
> >> 1. Check whether crashkernel=Y,low is incorrectly configured or not configured. Do different processing.
> >> 2. Share the existing description of x86. The configuration of arm64 is the same as that of x86.
> >> 3. Define the value of macro CRASH_ADDR_HIGH_MAX as memblock.current_limit, instead of MEMBLOCK_ALLOC_ACCESSIBLE.
> >> 4. To improve readability, some lightweight code adjustments have been made to reserve_craskernel(), including comments.
> >> 5. The defined value of DEFAULT_CRASH_KERNEL_LOW_SIZE reconsiders swiotlb, just like x86, to share documents.
> > 
> > 5.18 rc1 is already done, do you have plan to post a new version for
> > reviewing?
> 
> Yes, v5.18-rc1 has added a new patch
> commit  031495635b46 ("arm64: Do not defer reserve_crashkernel() for platforms with no DMA memory zones")
> to allow block mapping again, so my patches need to be modified. It should be post next week.

Sounds great, thanks. Just a reminder, please take your time.

