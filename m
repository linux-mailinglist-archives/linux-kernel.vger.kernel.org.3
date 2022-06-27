Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A85555B566
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 04:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiF0Cwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 22:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiF0Cwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 22:52:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 247593894
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 19:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656298357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JakvLevS0YnBGyhibLY4QkJ72ieVyrb1/yRcRNc1BYw=;
        b=W8ML5LPRh1Dp19WIipWlhBzHAMl6U9R34xgQRkHshJRBzphD5jF9eewHINnC5IFZLUcIoj
        zewTjSvAUlzMQEfXS0n1sqln+EWezQ5MZPthIFTCN/Rqif7QmA6OSjxk6WNYA9QwNhbanv
        TdqBcOKuPM0HJy8io1UwvkuNw9iqp7M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-3tZgnw0DPyKkAw1P9ym7bg-1; Sun, 26 Jun 2022 22:52:32 -0400
X-MC-Unique: 3tZgnw0DPyKkAw1P9ym7bg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B95D811E75;
        Mon, 27 Jun 2022 02:52:31 +0000 (UTC)
Received: from localhost (ovpn-13-65.pek2.redhat.com [10.72.13.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B0D6F40CFD05;
        Mon, 27 Jun 2022 02:52:29 +0000 (UTC)
Date:   Mon, 27 Jun 2022 10:52:26 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        liushixin <liushixin2@huawei.com>
Subject: Re: [PATCH 5/5] arm64: kdump: Don't defer the reservation of crash
 high memory
Message-ID: <Yrkbak66vYT55H4x@MiWiFi-R3L-srv>
References: <20220613080932.663-1-thunder.leizhen@huawei.com>
 <20220613080932.663-6-thunder.leizhen@huawei.com>
 <YrFYHYgX3mC//t2l@MiWiFi-R3L-srv>
 <3f66323d-f371-b931-65fb-edfae0f01c88@huawei.com>
 <YrIIJkhKWSuAqkCx@arm.com>
 <YrLUREAoBMSZo7RR@MiWiFi-R3L-srv>
 <YrRzvO5F0dumsbAU@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrRzvO5F0dumsbAU@arm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/23/22 at 03:07pm, Catalin Marinas wrote:
> On Wed, Jun 22, 2022 at 04:35:16PM +0800, Baoquan He wrote:
> > On 06/21/22 at 07:04pm, Catalin Marinas wrote:
> > > The problem with splitting is that you can end up with two entries in
> > > the TLB for the same VA->PA mapping (e.g. one for a 4KB page and another
> > > for a 2MB block). In the lucky case, the CPU will trigger a TLB conflict
> > > abort (but can be worse like loss of coherency).
> > 
> > Thanks for this explanation. Is this a drawback of arm64 design? X86
> > code do the same thing w/o issue, is there way to overcome this on
> > arm64 from hardware or software side?
> 
> It is a drawback of the arm64 implementations. Having multiple TLB
> entries for the same VA would need additional logic in hardware to
> detect, so the microarchitects have pushed back. In ARMv8.4, some
> balanced was reached with FEAT_BBM so that the only visible side-effect
> is a potential TLB conflict abort that could be resolved by software.

I see, thx.

> 
> > I ever got a arm64 server with huge memory, w or w/o crashkernel setting 
> > have different bootup time. And the more often TLB miss and flush will
> > cause performance cost. It is really a pity if we have very powerful
> > arm64 cpu and system capacity, but bottlenecked by this drawback.
> 
> Is it only the boot time affected or the runtime performance as well?

Sorry for late reply. What I observerd is the boot time serious latecy
with huge memory. Since the timestamp is not available at that time,
we can't tell the number. I didn't notice the runtime performance.

