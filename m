Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C614513006
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345599AbiD1JRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345558AbiD1JQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:16:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50F7B5DE40
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651137214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L4zZpdNOPi0WVFim58wTW/tRyBHrzLYktI6b26zWCEE=;
        b=iYujGgrlfgV+SjTTWu75JM5OJT5t0UfwGb5GqZcCDaWC9D8yJunY8piqsUZtLlQmLmJ85m
        AEQ9yj9Yla/l3DmJMleqLhMltRgqTTuOIg2/THuLZjl5nKMEY+3Q+5lWXsQTacEZwel4FZ
        BcBnBpWWSeyil3WeY05eK8+SccbH0bk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-Hrmmk8wyPFmtCbZ-Px_e2A-1; Thu, 28 Apr 2022 05:13:26 -0400
X-MC-Unique: Hrmmk8wyPFmtCbZ-Px_e2A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D9FF811E75;
        Thu, 28 Apr 2022 09:13:26 +0000 (UTC)
Received: from localhost (unknown [10.39.193.199])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD34940869CB;
        Thu, 28 Apr 2022 09:13:25 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jason Wang <jasowang@redhat.com>, jasowang@redhat.com,
        mst@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     sgarzare@redhat.com, eperezma@redhat.com, lulu@redhat.com,
        tglx@linutronix.de, peterz@infradead.org, paulmck@kernel.org,
        maz@kernel.org, pasic@linux.ibm.com
Subject: Re: [PATCH V3 3/9] virtio: introduce config op to synchronize vring
 callbacks
In-Reply-To: <20220425024418.8415-4-jasowang@redhat.com>
Organization: Red Hat GmbH
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-4-jasowang@redhat.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Thu, 28 Apr 2022 11:13:22 +0200
Message-ID: <87r15hlgel.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25 2022, Jason Wang <jasowang@redhat.com> wrote:

> This patch introduces new virtio config op to vring
> callbacks. Transport specific method is required to make sure the
> write before this function is visible to the vring_interrupt() that is

Which kind of writes? I.e., what is the scope?

> called after the return of this function. For the transport that
> doesn't provide synchronize_vqs(), use synchornize_rcu() which

Typo: synchronize_rcu()

> synchronize with IRQ implicitly as a fallback.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  include/linux/virtio_config.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index b341dd62aa4d..14fe89ff99c7 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -57,6 +57,10 @@ struct virtio_shm_region {
>   *		include a NULL entry for vqs unused by driver
>   *	Returns 0 on success or error status
>   * @del_vqs: free virtqueues found by find_vqs().
> + * @synchronize_cbs: synchronize with the virtqueue callbacks (optional)
> + *      Make sure the writes commited before this method is visible to
> + *      vring_interrupt() which is called after this method.

Same here, I think the description needs to be a bit more explicit about
which writes we care about here.

> + *      vdev: the virtio_device
>   * @get_features: get the array of feature bits for this device.
>   *	vdev: the virtio_device
>   *	Returns the first 64 feature bits (all we currently need).
> @@ -89,6 +93,7 @@ struct virtio_config_ops {
>  			const char * const names[], const bool *ctx,
>  			struct irq_affinity *desc);
>  	void (*del_vqs)(struct virtio_device *);
> +	void (*synchronize_cbs)(struct virtio_device *);
>  	u64 (*get_features)(struct virtio_device *vdev);
>  	int (*finalize_features)(struct virtio_device *vdev);
>  	const char *(*bus_name)(struct virtio_device *vdev);

