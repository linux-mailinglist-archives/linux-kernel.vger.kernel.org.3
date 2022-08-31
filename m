Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6D25A7343
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 03:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiHaBTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 21:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHaBTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 21:19:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B42CAC248
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661908743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c0FJw7LLBKzZ9BAQVj7sdve+f9M7Ki+7/qyGyj2VEc4=;
        b=B1AcHRz21mEItGmT/ipll9q5L95AZxB8dKQkMb0mWxiURk8fOINZJOLyEUm0IYoS4DCEOg
        4fxdd8PZ/k11bOCscdP4YwwBCjao/DPcgrpmt6j01DYYmTVa6QD6CQXuIK4Ntj/qTl/WrP
        kHzIcnWlfunVzlHxXuqs52pB1e+HJ1w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-djM3oyxSOLaVWSWEQ3DKwQ-1; Tue, 30 Aug 2022 21:19:00 -0400
X-MC-Unique: djM3oyxSOLaVWSWEQ3DKwQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8625F811E76;
        Wed, 31 Aug 2022 01:18:59 +0000 (UTC)
Received: from localhost (ovpn-13-50.pek2.redhat.com [10.72.13.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B73561121314;
        Wed, 31 Aug 2022 01:18:58 +0000 (UTC)
Date:   Wed, 31 Aug 2022 09:18:55 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Yun Levi <ppbuk5246@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        nramas@linux.microsoft.com, thunder.leizhen@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kexec@lists.infradead.org
Subject: Re: [PATCH v2] arm64/kexec: Fix missing extra range for
 crashkres_low.
Message-ID: <Yw62//C+LmH+BcEh@MiWiFi-R3L-srv>
References: <CAM7-yPTdihLsPjDKM-0OEszxNd8n0bgeRseiEkCsSZW-uuaRvw@mail.gmail.com>
 <20220830092839.3197-1-ppbuk5246@gmail.com>
 <Yw49m7Hpq+NIZYWw@arm.com>
 <CAM7-yPQjjwM_fCgojYHbrhE4GFCX22VLoCiTVkorNG6hQDj9EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM7-yPQjjwM_fCgojYHbrhE4GFCX22VLoCiTVkorNG6hQDj9EQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/22 at 09:38am, Yun Levi wrote:
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> >
> > Does this need a Fixes tag and cc stable?
> >
> > --
> > Catalin
> 
> IMHO, it seems good to add two tags like:
>    Fixes: 3751e728cef29 ("arm64: kexec_file: add crash dump support")
>    Cc: stable@vger.kernel.org

No, I don't think the Fixes commit is right. It should fix the commit
where crashkernel,low is introduced. Before that, no issue caused. 
So the tags should be:

Fixes: 944a45abfabc ("arm64: kdump: Reimplement crashkernel=X")
Cc: stable@vger.kernel.org

