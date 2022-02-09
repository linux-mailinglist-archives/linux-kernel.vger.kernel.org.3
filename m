Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697BB4AEEB7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbiBIJ4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbiBIJz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:55:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4C75E046F1F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 01:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644400266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bOGT40PA5LmAnBRQIBrjCAxhYJpsutSMC+lcUcCHisA=;
        b=WaD9JxkXykV92Ys4a5XHnxtSNcNkiP8bh6uq5uGgHl2gd4tZ8J02Mi6rNpYW3bNXWCQgd5
        5oH4XdQDAUjSWhTemPStqNtaRAe5BLXAqJND5+INxip5smLOkcsCSalhGJhGc5qRA/diOt
        bmjO+p8CqT0B4cvIBmNEIt7y9s64PJg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-zLksJTvLPNmflJynIoqBdg-1; Wed, 09 Feb 2022 04:45:02 -0500
X-MC-Unique: zLksJTvLPNmflJynIoqBdg-1
Received: by mail-wr1-f71.google.com with SMTP id d13-20020adfa34d000000b001e33a1c56f3so868794wrb.20
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 01:45:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=bOGT40PA5LmAnBRQIBrjCAxhYJpsutSMC+lcUcCHisA=;
        b=a6N1eSsiko2OGxhVCM2ROPoZDraj/9Mt9UyjZ25jYnUvGvOdQVweetT4KFHPHi1C9+
         P1UQ8mf0yQI6l4KEpd04orDriZF/y/TdnFD7b3UTDFd7tmTONgNvsa2AUMAHMGoxQ81b
         lY7PDj6W0+4Z4xrcI31vlFN5pXMnntGp/5UJPoEa8rsfslO/0CLpykGa/1TNH/28YjqK
         MX1h0jplRL8kx+Ct7or44YB4LLj8EKB26dwJZEjS5/bYGjAYZqOOvi5nLYIuj2dV4d+y
         6DMsD8lxBqPiuINcRquR18BS7Vp4tjKpoIA+YzljB2kh6e31OdJQctfpw9lmFWxUm12E
         W36w==
X-Gm-Message-State: AOAM531zY67yr7rNtJmPC1tYSiZgiXPeaOo+XT/TTrIHxahXtHxCHDiQ
        au2qg5pB5t7r60cBZTktI/w57VogDGwGX9TrOKFxFeVVcd3Td5DqFGYQXlCVxrBgWnhpOCxPjFf
        dA57JVMjVk3vkkX5D+ICwfeAN
X-Received: by 2002:a1c:7418:: with SMTP id p24mr1246561wmc.21.1644399901426;
        Wed, 09 Feb 2022 01:45:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvFdeFjkesIm97KwdAHOETISeFDFk5mT6+L7zC0mhqZYGBbdP+JGwExuY5pOJJ7UuI+EuXSg==
X-Received: by 2002:a1c:7418:: with SMTP id p24mr1246546wmc.21.1644399901192;
        Wed, 09 Feb 2022 01:45:01 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:1204:1500:37e7:8150:d9df:36f? ([2a0c:5a80:1204:1500:37e7:8150:d9df:36f])
        by smtp.gmail.com with ESMTPSA id h6sm4428856wmq.26.2022.02.09.01.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 01:45:00 -0800 (PST)
Message-ID: <b5363ced8e17d07d41554da8fde06c410e6688e0.camel@redhat.com>
Subject: Re: [PATCH 0/2] mm/page_alloc: Remote per-cpu lists drain support
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        frederic@kernel.org, tglx@linutronix.de, mtosatti@redhat.com,
        mgorman@suse.de, linux-rt-users@vger.kernel.org, vbabka@suse.cz,
        cl@linux.com, paulmck@kernel.org, willy@infradead.org
Date:   Wed, 09 Feb 2022 10:45:00 +0100
In-Reply-To: <7c87f388-cc50-e9a1-17a7-802bb42656e4@huawei.com>
References: <20220208100750.1189808-1-nsaenzju@redhat.com>
         <7c87f388-cc50-e9a1-17a7-802bb42656e4@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiongfeng, thanks for taking the time to look at this.

On Wed, 2022-02-09 at 16:55 +0800, Xiongfeng Wang wrote:
> Hi Nicolas，
> 
> When I applied the patchset on the following commit and tested on QEMU, I came
> accross the following CallTrace.
>   commit dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
> 
> I wrote a userspace application to consume the memory. When the memory is used
> out, the OOM killer is triggered and the following Calltrace is printed. I am
> not sure if it is related to this patchset. But when I reverted this patchset,
> the 'NULL pointer' Calltrace didn't show.

It's a silly mistake on my part, while cleaning up the code I messed up one of
the 'struct per_cpu_pages' accessors. This should fix it:

------------------------->8-------------------------
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0caa7155ca34..e65b991c3dc8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3279,7 +3279,7 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
                                has_pcps = true;
                } else {
                        for_each_populated_zone(z) {
-                               pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
+                               pcp = per_cpu_ptr(z->per_cpu_pageset, cpu);
                                lp = rcu_dereference_protected(pcp->lp,
                                                mutex_is_locked(&pcpu_drain_mutex));
                                if (lp->count) {
------------------------->8-------------------------

Thanks!

-- 
Nicolás Sáenz

