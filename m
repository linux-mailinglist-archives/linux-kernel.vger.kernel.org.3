Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B6956651F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiGEIfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 04:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGEIff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 04:35:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C50D92AD3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 01:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657010133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0z2UhLA9zTx8MYx+v6FOVFe00lHXS/rANJnQv0UrSL8=;
        b=DRsGiR4+af5mtrUuymruKTluxL+A+wl1VhKLQXwGk15NN4hbI8xHB3FER0efHroWBgatTt
        kNpupRgRtG/cJenvGwuFpKKuwxj7n3E8wIsTI/BMQCDBCAsoZCYlgpfu7zGg6y+8tVfjg5
        3mZuRIQFMpI5VAcQsF63ER1p+/jt8mg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-uU9BWdGCPfue2BuqLtC7dg-1; Tue, 05 Jul 2022 04:35:24 -0400
X-MC-Unique: uU9BWdGCPfue2BuqLtC7dg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C311C85A581;
        Tue,  5 Jul 2022 08:35:23 +0000 (UTC)
Received: from localhost (ovpn-13-74.pek2.redhat.com [10.72.13.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 393584010D28;
        Tue,  5 Jul 2022 08:35:22 +0000 (UTC)
Date:   Tue, 5 Jul 2022 16:35:18 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Will Deacon <will@kernel.org>, kexec@lists.infradead.org,
        "guanghui.fgh" <guanghuifeng@linux.alibaba.com>,
        baolin.wang@linux.alibaba.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org, david@redhat.com, jianyong.wu@arm.com,
        james.morse@arm.com, quic_qiancai@quicinc.com,
        christophe.leroy@csgroup.eu, jonathan@marek.ca,
        mark.rutland@arm.com, thunder.leizhen@huawei.com,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rppt@kernel.org,
        geert+renesas@glider.be, linux-mm@kvack.org,
        yaohongbo@linux.alibaba.com, alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v4] arm64: mm: fix linear mem mapping access performance
 degradation
Message-ID: <YsP3xnpyPON9KsMQ@MiWiFi-R3L-srv>
References: <20220704103523.GC31437@willie-the-truck>
 <73f0c53b-fd17-c5e9-3773-1d71e564eb50@linux.alibaba.com>
 <20220704111402.GA31553@willie-the-truck>
 <4accaeda-572f-f72d-5067-2d0999e4d00a@linux.alibaba.com>
 <20220704131516.GC31684@willie-the-truck>
 <2ae1cae0-ee26-aa59-7ed9-231d67194dce@linux.alibaba.com>
 <20220704142313.GE31684@willie-the-truck>
 <6977c692-78ca-5a67-773e-0389c85f2650@linux.alibaba.com>
 <20220704163815.GA32177@willie-the-truck>
 <CAMj1kXEvY5QXOUrXZ7rBp9As=65uTTFRSSq+FPt-n4M2P-_VtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXEvY5QXOUrXZ7rBp9As=65uTTFRSSq+FPt-n4M2P-_VtQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/22 at 07:09pm, Ard Biesheuvel wrote:
> On Mon, 4 Jul 2022 at 18:38, Will Deacon <will@kernel.org> wrote:
> >
> > On Mon, Jul 04, 2022 at 10:34:07PM +0800, guanghui.fgh wrote:
> > > Thanks.
> > >
> > > 在 2022/7/4 22:23, Will Deacon 写道:
> > > > On Mon, Jul 04, 2022 at 10:11:27PM +0800, guanghui.fgh wrote:
> ...
> > > > > Namely, it's need to use non block/section mapping for crashkernel mem
> > > > > before shringking.
> > > >
> > > > Well, yes, but we can change arch_kexec_[un]protect_crashkres() not to do
> > > > that if we're leaving the thing mapped, no?
> > > >
> > > I think we should use arch_kexec_[un]protect_crashkres for crashkernel mem.
> > >
> > > Because when invalid crashkernel mem pagetable, there is no chance to rd/wr
> > > the crashkernel mem by mistake.
> > >
> > > If we don't use arch_kexec_[un]protect_crashkres to invalid crashkernel mem
> > > pagetable, there maybe some write operations to these mem by mistake which
> > > may cause crashkernel boot error and vmcore saving error.
> >
> > I don't really buy this line of reasoning. The entire main kernel is
> > writable, so why do we care about protecting the crashkernel so much? The
> > _code_ to launch the crash kernel is writable! If you care about preventing
> > writes to memory which should not be writable, then you should use
> > rodata=full.
> >
> 
> This is not entirely true - the core kernel text and rodata are
> remapped r/o in the linear map, whereas all module code and rodata are
> left writable when rodata != full.
> 
> But the conclusion is the same, imo: if you can't be bothered to
> protect a good chunk of the code and rodata that the kernel relies on,
> why should the crashkernel be treated any differently?

Kernel text and rodata are remapped r/o in linear map, whereas
module code and rodata are left writable, it's different concept
than crashkernel region being mapped r/o.

If it's doable in technology to remap module code and rodata r/o, and
stamping into those regions will corrupt the entire system, we should do
it too. However, kdump is a system error diagonosing mechanism which is
very important and helpful on server, or some application scenarios, e.g
cloud. Stamping into crashkernel region will make it useless.

I am not against removing the arch_kexec_[un]protect_crashkres on arm64.
It is a balance:

Protecting the crashkernel region, causeing severe performance
degradation. This is always felt since we usually don't specify rodata
and enable kfence.

Taking off the protecting of crashkernel region, performance improved
very much, while wrong code may stamp into crashkernel region and fail
kdump. That could happen one in a million. Once happen, it's a nightmare
of kernel dev.

