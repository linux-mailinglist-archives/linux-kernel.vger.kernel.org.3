Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0D855C532
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbiF0KRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 06:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbiF0KRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:17:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 738536442
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656325036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=29XAW3SdVV053hARy2DHbS6TO7CBuYcWdq0hwUUUOu8=;
        b=i02/zf9jeGNZ63POGBjKzIzknhWwA0Rptr8MX0ZqVp0Y857DyCi4KiPZAaOCClZ78BZd6m
        yvi3IpMAaJCtKdRY7kPPaZvTaf1XFjO6HszsqiRJUEgOpKUarZvkbpGB4JCV6BRbsJ901R
        XcYIEeIT3QogvF0Wv+gJJBQj20IwBeI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-_16kP6lEP1-vh2RorxSJ6Q-1; Mon, 27 Jun 2022 06:17:13 -0400
X-MC-Unique: _16kP6lEP1-vh2RorxSJ6Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 474EC83395C;
        Mon, 27 Jun 2022 10:17:12 +0000 (UTC)
Received: from localhost (ovpn-13-65.pek2.redhat.com [10.72.13.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CDC4A404E4DD;
        Mon, 27 Jun 2022 10:17:10 +0000 (UTC)
Date:   Mon, 27 Jun 2022 18:17:07 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
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
Message-ID: <YrmDo7Sx1jNQ4WFd@MiWiFi-R3L-srv>
References: <20220613080932.663-1-thunder.leizhen@huawei.com>
 <20220613080932.663-6-thunder.leizhen@huawei.com>
 <YrFYHYgX3mC//t2l@MiWiFi-R3L-srv>
 <3f66323d-f371-b931-65fb-edfae0f01c88@huawei.com>
 <YrIIJkhKWSuAqkCx@arm.com>
 <YrLUREAoBMSZo7RR@MiWiFi-R3L-srv>
 <YrRzvO5F0dumsbAU@arm.com>
 <Yrkbak66vYT55H4x@MiWiFi-R3L-srv>
 <e3318551-4134-245a-c060-86ab81eb3e68@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3318551-4134-245a-c060-86ab81eb3e68@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/27/22 at 05:17pm, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/6/27 10:52, Baoquan He wrote:
> > On 06/23/22 at 03:07pm, Catalin Marinas wrote:
> >> On Wed, Jun 22, 2022 at 04:35:16PM +0800, Baoquan He wrote:
> >>> On 06/21/22 at 07:04pm, Catalin Marinas wrote:
> >>>> The problem with splitting is that you can end up with two entries in
> >>>> the TLB for the same VA->PA mapping (e.g. one for a 4KB page and another
> >>>> for a 2MB block). In the lucky case, the CPU will trigger a TLB conflict
> >>>> abort (but can be worse like loss of coherency).
> >>>
> >>> Thanks for this explanation. Is this a drawback of arm64 design? X86
> >>> code do the same thing w/o issue, is there way to overcome this on
> >>> arm64 from hardware or software side?
> >>
> >> It is a drawback of the arm64 implementations. Having multiple TLB
> >> entries for the same VA would need additional logic in hardware to
> >> detect, so the microarchitects have pushed back. In ARMv8.4, some
> >> balanced was reached with FEAT_BBM so that the only visible side-effect
> >> is a potential TLB conflict abort that could be resolved by software.
> > 
> > I see, thx.
> > 
> >>
> >>> I ever got a arm64 server with huge memory, w or w/o crashkernel setting 
> >>> have different bootup time. And the more often TLB miss and flush will
> >>> cause performance cost. It is really a pity if we have very powerful
> >>> arm64 cpu and system capacity, but bottlenecked by this drawback.
> >>
> >> Is it only the boot time affected or the runtime performance as well?
> > 
> > Sorry for late reply. What I observerd is the boot time serious latecy
> > with huge memory. Since the timestamp is not available at that time,
> > we can't tell the number. I didn't notice the runtime performance.
> 
> There's some data here, and I see you're not on the cc list.
> 
> https://lore.kernel.org/linux-mm/1656241815-28494-1-git-send-email-guanghuifeng@linux.alibaba.com/T/

Thanks, Zhen Lei. I also saw the patch. That seems to be a good way,
since there's only one process running at that time. Not sure if there's
still risk of multiple TLB entries for the same VA existing.

