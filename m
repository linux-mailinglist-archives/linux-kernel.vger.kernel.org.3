Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2CE53A943
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 16:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353341AbiFAOgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 10:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353323AbiFAOgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:36:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 174CB24F2D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 07:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654094180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ndVFt2OYBW8cSRXpIjiijVDbpZaQ/wTXyFWQt9Vv3wA=;
        b=NUs4K+sujqm0Hp5wL9cp92l9FzTX7FxnIZTwyoAhtaxDZFNodE6lNQYDQptucIfKqoOGgB
        d0TKwG5k53Xj9GCylOM4dcZqUy648OXGxeOVSUFO/EgG8Rwr9aM+FRCutSkl2BHKbjyGbW
        RDTUeK0LwpWQYOtQllJdolxQHb8FZ+k=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42--b8YmqQVPEGMZEsrePbtHw-1; Wed, 01 Jun 2022 10:36:19 -0400
X-MC-Unique: -b8YmqQVPEGMZEsrePbtHw-1
Received: by mail-ed1-f69.google.com with SMTP id y13-20020a056402358d00b0042dfb820070so1152931edc.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 07:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ndVFt2OYBW8cSRXpIjiijVDbpZaQ/wTXyFWQt9Vv3wA=;
        b=UCQP+f8n8G8UV81mnwC4NCYeHVDTv9pYanmvr8SStENJ8mp4rO0MqwXB2Ba7BgIByr
         uv4J1TYCt97zCF90Hvc8s1H/dw+Zk+teyuo2PzCisqsUZZ1rxO/NG+DDhVUly5WbqOlr
         4XCyx/BNH1CT6Otr3QSCN0fxY0VAjiiUW+lOsOmxUXJgypLXVTWmuMh8Il/39IFmg9Nn
         qgVOlCA9SHVdA0vrn2rmzMb1ebFTs9dKsNGmTrGCEQpGvoLszNyLoai60SWlPwj+8aoo
         76X87uMVd1YdWgMlJM7vTyCRvrIjakhCzPRzmcXhKLZj+/5oPaRgXDJXG6krqzx9rdqB
         1ZUA==
X-Gm-Message-State: AOAM530vCWohoDQga2f1woIS2j+tdCUBgk0izU3ZSSjCUaDH2bsngNvR
        7wLqYMFzEcAqNqzoMxB6LSihG1ibuMTMctXPhlmXfaQk5kB8L669TRDo0XBK23jwuHtvzSW/65P
        H2ak1Fki+xXXCpJdTO1SsW3F9MHyAdgyZyCxHGXsN
X-Received: by 2002:a05:6402:6cc:b0:42d:bd2d:9f82 with SMTP id n12-20020a05640206cc00b0042dbd2d9f82mr237692edy.59.1654094177794;
        Wed, 01 Jun 2022 07:36:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFh8H56y/l8Ke6nyDbJQA0j9RiyCmE3CPbXmuv5QhyDCmnY54KlRZlTjdvlq4rdEAuPxbDDSvggkS7C+zAZow=
X-Received: by 2002:a05:6402:6cc:b0:42d:bd2d:9f82 with SMTP id
 n12-20020a05640206cc00b0042dbd2d9f82mr237650edy.59.1654094177475; Wed, 01 Jun
 2022 07:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <388098b2c03fbf0a732834fc01b2d875c335bc49.1642170196.git.lucien.xin@gmail.com>
In-Reply-To: <388098b2c03fbf0a732834fc01b2d875c335bc49.1642170196.git.lucien.xin@gmail.com>
From:   Maurizio Lombardi <mlombard@redhat.com>
Date:   Wed, 1 Jun 2022 16:36:06 +0200
Message-ID: <CAFL455m6BZW-KVNOkJPo3BSeEK39Vq597F-b5XvQJmU3mrPmZA@mail.gmail.com>
Subject: Re: [PATCH] mm: slub: fix a deadlock warning in kmem_cache_destroy
To:     Xin Long <lucien.xin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Antoine Tenart <atenart@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

p=C3=A1 14. 1. 2022 v 15:23 odes=C3=ADlatel Xin Long <lucien.xin@gmail.com>=
 napsal:
>
> cpus_read_lock() is introduced into kmem_cache_destroy() by
> commit 5a836bf6b09f ("mm: slub: move flush_cpu_slab() invocations
> __free_slab() invocations out of IRQ context"), and it could cause
> a deadlock.

FYI,

I received a bug report from one of our customers, he complains that
his system (with nvmefc boot from SAN) hangs when rebooting.
He runs a RHEL-9 kernel based on version 5.14.0.

What is interesting is that, according to him, after reverting commit
5a836bf6b09f
("mm: slub: move flush_cpu_slab() invocations __free_slab()
invocations out of IRQ context")
the reboot operation doesn't hang anymore.

The call trace seems to point to a possible problem due to the fact that
nvme_delete_ctrl_work is allocated with the WQ_MEM_RECLAIM bit set.

[  453.012078] ------------[ cut here ]------------
[  453.016744] workqueue: WQ_MEM_RECLAIM
nvme-delete-wq:nvme_delete_ctrl_work [nvme_core] is flushing
!WQ_MEM_RECLAIM events:flush_cpu_slab
[  453.016789] WARNING: CPU: 37 PID: 410 at kernel/workqueue.c:2637
check_flush_dependency+0x10a/0x120
[...]
[  453.262125] Call Trace:
[  453.264582]  __flush_work.isra.0+0xbf/0x220
[  453.268775]  ? __queue_work+0x1dc/0x420
[  453.272623]  flush_all_cpus_locked+0xfb/0x120
[  453.276992]  __kmem_cache_shutdown+0x2b/0x320
[  453.281361]  kmem_cache_destroy+0x49/0x100
[  453.285465]  bioset_exit+0x143/0x190
[  453.289052]  blk_release_queue+0xb9/0x100
[  453.293075]  kobject_cleanup+0x37/0x130
[  453.296922]  nvme_fc_ctrl_free+0xc6/0x150 [nvme_fc]
[  453.302397]  nvme_free_ctrl+0x1ac/0x2b0 [nvme_core]
[  453.307818]  device_release+0x31/0x90
[  453.312005]  kobject_cleanup+0x37/0x130
[  453.316369]  process_one_work+0x1e5/0x3c0
[  453.320895]  worker_thread+0x50/0x3b0
[  453.325074]  ? rescuer_thread+0x370/0x370
[  453.329592]  kthread+0x146/0x170
[  453.333322]  ? set_kthread_struct+0x40/0x40
[  453.338027]  ret_from_fork+0x1f/0x30
[  453.342082] ---[ end trace 8c9cdd85adbbfc4f ]---

Maurizio Lombardi

