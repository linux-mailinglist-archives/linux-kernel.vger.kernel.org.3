Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287815A5D17
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiH3HhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiH3HhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:37:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC71BCC1F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661845030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b3NkIhLQKy7eVJi/82pOIjWmNoom7j0EFy9fhBJw9/E=;
        b=Roya8zx70vPkBsb1Zvq+qSKlmhfqtZjIa6axvY596iluh8/pw5SHUSk8AywZ/tCyv+RJ4y
        dky+Ws/maRK071TBpbsM31qVFLaDEIa8c4hOwm+6Mu90uCVPCToZ9KX2/Pg9LFyLebYZAv
        46Y5t3QP+cxoDLLV6NcfMyNHRMMA438=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-204-cTciaf-dNbaNxSJAY5f-0Q-1; Tue, 30 Aug 2022 03:37:07 -0400
X-MC-Unique: cTciaf-dNbaNxSJAY5f-0Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 403DB1019C88;
        Tue, 30 Aug 2022 07:37:07 +0000 (UTC)
Received: from localhost (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8383A492C3B;
        Tue, 30 Aug 2022 07:37:06 +0000 (UTC)
Date:   Tue, 30 Aug 2022 15:37:03 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Yun Levi <ppbuk5246@gmail.com>
Cc:     will@kernel.org, chenzhou10@huawei.com, nramas@linux.microsoft.com,
        thunder.leizhen@huawei.com, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kexec@lists.infradead.org
Subject: Re: [PATCH-RESEND] arm64/kexec: Fix missing extra range for
 crashkres_low.
Message-ID: <Yw2+H9MNpf3Ve0eJ@MiWiFi-R3L-srv>
References: <20220803151217.75962-1-ppbuk5246@gmail.com>
 <CAM7-yPTdihLsPjDKM-0OEszxNd8n0bgeRseiEkCsSZW-uuaRvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM7-yPTdihLsPjDKM-0OEszxNd8n0bgeRseiEkCsSZW-uuaRvw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/22 at 01:28pm, Yun Levi wrote:
> Like crashk_res, Calling crash_exclude_mem_range function with
> crashk_low_res area would need extra crash_mem range too.
> Add one extra crash_mem range when crashk_low_res is used.
> 
> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> ---
>  arch/arm64/kernel/machine_kexec_file.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/kernel/machine_kexec_file.c
> b/arch/arm64/kernel/machine_kexec_file.c
> index 889951291cc0..378aee04e7d4 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -51,6 +51,9 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>         for_each_mem_range(i, &start, &end)
>                 nr_ranges++;
> 
> +       if (crashk_low_res.end)
> +               nr_ranges++; /**< for exclusion of
> crashkernel=size,low region */
> +

Right, excluding crashkernel region may cause memory region splitting,
so we need extra slot for that.

Meanwhile, can you fix above code comment mess? Otherwise, this looks
good to me. 

Or we can add extra 2 slots like we do in x86, it just add another 16
bytes temporarily.


>         cmem = kmalloc(struct_size(cmem, ranges, nr_ranges), GFP_KERNEL);
>         if (!cmem)
>                 return -ENOMEM;
> --
> 2.35.1
> 

