Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540AC5A63CD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiH3MrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiH3MrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:47:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E372BDF64B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661863620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3UT54XJrekXL8c4mrX4vwvSpge6ZFyCM6o46RKlXL6s=;
        b=Ajqx4avAiZmTAcamC/n2FDw+4UbT0zITiRMj5EUFQKuRpG0JzX8pKkFAX3yZ4LlwAPgZPB
        dXuj523t739Qcz0q8Y0vqhfJ1DHF/nZyFFQG9UiLaa/BCLeDGoCZqAsV8R+O7fNrPAMxAD
        gkdsSS+3drYkyEj8FghfVFZp15vw7XU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-XHXWHpWOP---uR8szXvu5Q-1; Tue, 30 Aug 2022 08:46:58 -0400
X-MC-Unique: XHXWHpWOP---uR8szXvu5Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EFE3185A7BA;
        Tue, 30 Aug 2022 12:46:57 +0000 (UTC)
Received: from localhost (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 431FB492C3B;
        Tue, 30 Aug 2022 12:46:55 +0000 (UTC)
Date:   Tue, 30 Aug 2022 20:46:52 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Levi Yun <ppbuk5246@gmail.com>
Cc:     will@kernel.org, catalin.marinas@arm.com,
        nramas@linux.microsoft.com, thunder.leizhen@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH v2] arm64/kexec: Fix missing extra range for
 crashkres_low.
Message-ID: <Yw4GvOh3UnnfTbbE@MiWiFi-R3L-srv>
References: <CAM7-yPTdihLsPjDKM-0OEszxNd8n0bgeRseiEkCsSZW-uuaRvw@mail.gmail.com>
 <20220830092839.3197-1-ppbuk5246@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830092839.3197-1-ppbuk5246@gmail.com>
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

On 08/30/22 at 06:28pm, Levi Yun wrote:
> Like crashk_res, Calling crash_exclude_mem_range function with
> crashk_low_res area would need extra crash_mem range too.
> 
> Add one more extra cmem range slot in case of crashk_low_res is used.
                                             ~~^ should be removed.

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> ---
>  arch/arm64/kernel/machine_kexec_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index 889951291cc0..a11a6e14ba89 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -47,7 +47,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>  	u64 i;
>  	phys_addr_t start, end;
>  
> -	nr_ranges = 1; /* for exclusion of crashkernel region */
> +	nr_ranges = 2; /* for exclusion of crashkernel region */
>  	for_each_mem_range(i, &start, &end)
>  		nr_ranges++;
>  
> -- 
> 2.35.1
> 

