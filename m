Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691D4538579
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240589AbiE3Pw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241929AbiE3PvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:51:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12E3D61629
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 08:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653923898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TKjMVcygi9lawNhz7dJlRnUYRfj2p0j+s5D17eX1aSE=;
        b=RWehqmo3+RD2eYYBeExhXeozWXqmpT3xIVmxnCysXyqNmLnzKj0O2DHeZ1D9eHr7cWJnku
        vaj0dUdeK+ZNKO9tyqgOE1RVvH+dtMzQ9Z0Kyl5UM8w0yk0tBmMIIzUtNo8cfXiRTpCxoe
        7sywsbrpOyDePUnsBxlFtYKmQbiZ4wY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-YH1uR05dMY-PCeIcztxrpg-1; Mon, 30 May 2022 11:18:11 -0400
X-MC-Unique: YH1uR05dMY-PCeIcztxrpg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 89E3E858F00;
        Mon, 30 May 2022 15:18:10 +0000 (UTC)
Received: from localhost (unknown [10.39.194.233])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 372D31410F36;
        Mon, 30 May 2022 15:18:10 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jason Wang <jasowang@redhat.com>, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, paulmck@kernel.org,
        maz@kernel.org, pasic@linux.ibm.com, eperezma@redhat.com,
        lulu@redhat.com, sgarzare@redhat.com, xuanzhuo@linux.alibaba.com,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH V6 8/9] virtio: harden vring IRQ
In-Reply-To: <20220527060120.20964-9-jasowang@redhat.com>
Organization: Red Hat GmbH
References: <20220527060120.20964-1-jasowang@redhat.com>
 <20220527060120.20964-9-jasowang@redhat.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Mon, 30 May 2022 17:18:08 +0200
Message-ID: <87sfort5fz.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27 2022, Jason Wang <jasowang@redhat.com> wrote:

> This is a rework on the previous IRQ hardening that is done for
> virtio-pci where several drawbacks were found and were reverted:
>
> 1) try to use IRQF_NO_AUTOEN which is not friendly to affinity managed IRQ
>    that is used by some device such as virtio-blk
> 2) done only for PCI transport
>
> The vq->broken is re-used in this patch for implementing the IRQ
> hardening. The vq->broken is set to true during both initialization
> and reset. And the vq->broken is set to false in
> virtio_device_ready(). Then vring_interrupt() can check and return
> when vq->broken is true. And in this case, switch to return IRQ_NONE
> to let the interrupt core aware of such invalid interrupt to prevent
> IRQ storm.
>
> The reason of using a per queue variable instead of a per device one
> is that we may need it for per queue reset hardening in the future.
>
> Note that the hardening is only done for vring interrupt since the
> config interrupt hardening is already done in commit 22b7050a024d7
> ("virtio: defer config changed notifications"). But the method that is
> used by config interrupt can't be reused by the vring interrupt
> handler because it uses spinlock to do the synchronization which is
> expensive.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c       |  4 ++++
>  drivers/virtio/virtio.c                | 15 ++++++++++++---
>  drivers/virtio/virtio_mmio.c           |  5 +++++
>  drivers/virtio/virtio_pci_modern_dev.c |  5 +++++
>  drivers/virtio/virtio_ring.c           | 11 +++++++----
>  include/linux/virtio_config.h          | 20 ++++++++++++++++++++
>  6 files changed, 53 insertions(+), 7 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

