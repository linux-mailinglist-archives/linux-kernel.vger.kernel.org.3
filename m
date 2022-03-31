Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EBE4ED889
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 13:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbiCaLeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbiCaLeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:34:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EC2D2028A0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 04:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648726345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SAu/4xzDajMNjep6aDEEiUFGX6R0FRcoSt433wu4cDw=;
        b=bHkkY+2EEsJQt1mXnZeVJtEo+sRboiwfzOKZJIuzrBVJg/UTAZbT8Ri7zadv6mFVE/BUcc
        Uyl9V0xk8V7503KLUvrHSXzHh2GtQWvlhB1YO9Wm4jcQAWSRJZx5NPVQeH4CPYid818kNq
        AMhKmjJf71JeOlvCr7GtlfihWOJ8bKU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-tOc7I50TPx-Lde9yQz4wNg-1; Thu, 31 Mar 2022 07:32:21 -0400
X-MC-Unique: tOc7I50TPx-Lde9yQz4wNg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80F54188B2BE;
        Thu, 31 Mar 2022 11:32:21 +0000 (UTC)
Received: from localhost (ovpn-13-26.pek2.redhat.com [10.72.13.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C50C3C15D42;
        Thu, 31 Mar 2022 11:32:20 +0000 (UTC)
Date:   Thu, 31 Mar 2022 19:32:17 +0800
From:   Baoquan He <bhe@redhat.com>
To:     akpm@linux-foundation.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        dyoung@redhat.com, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/2] x86/kexec: fix memory leak of elf header buffer
Message-ID: <YkWRQdp7TxV22ygO@MiWiFi-R3L-srv>
References: <20220223113225.63106-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223113225.63106-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 02/23/22 at 07:32pm, Baoquan He wrote:
> The memory leak is reported by kmemleak detector, has been existing
> for very long time. It casue much memory loss on large machine
> with huge memory hotplug which will trigger kdump kernel reloading
> many times, with kexec_file_load interface.

Could you merge these two patches? Or should I ping x86 maintainers to
take them? 

Thanks
Baoquan

> 
> And in patch 2, clean up is done to remove unneeded
> arch_kexec_kernel_image_load() and rename functions.
> 
> V1 post can be found here:
> https://lore.kernel.org/all/20211029072424.9109-1-bhe@redhat.com/T/#u
> 
> v1->v2:
>  No code change. The v1 post has been acked by Dave Young but not
> merged. In v2, just merging the old patch 1 and 2 as per Dave's concern
> in v1 post.
> 
> Baoquan He (2):
>   x86/kexec: fix memory leak of elf header buffer
>   kexec_file: clean up arch_kexec_kernel_image_load
> 
>  arch/x86/kernel/machine_kexec_64.c | 23 +++++++++--------------
>  include/linux/kexec.h              |  1 -
>  kernel/kexec_file.c                |  9 ++-------
>  3 files changed, 11 insertions(+), 22 deletions(-)
> 
> -- 
> 2.31.1
> 

