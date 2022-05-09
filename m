Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6AC52011F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbiEIP2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238213AbiEIP2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:28:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEA1B2180A
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652109893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8bfcIm7yDlfqmbUO81rwbADuEkLjKknQeGnF1p4aFcw=;
        b=KlFHZSgtXR/SRaybs713eNXOQFSQiPnzhM+/mQtFx11FGZbBtsrWYU/JsrtxDAx0I1QlHS
        TZ/UENUbqSxXsRqEf0DL7UqxnhNtKycEHw5CZaxFccRiZkcaEux5TGW7piZ75EEey7TETE
        E+mvivFDLVmYrsaRCJ0tYZu2A0OkEIc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-pxLQ7rAZNlO4dpEoB7X3Fg-1; Mon, 09 May 2022 11:24:48 -0400
X-MC-Unique: pxLQ7rAZNlO4dpEoB7X3Fg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9578D101AA44;
        Mon,  9 May 2022 15:24:47 +0000 (UTC)
Received: from localhost (unknown [10.39.193.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 49CD42166B2F;
        Mon,  9 May 2022 15:24:39 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jason Wang <jasowang@redhat.com>, jasowang@redhat.com,
        mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, paulmck@kernel.org,
        maz@kernel.org, pasic@linux.ibm.com, eperezma@redhat.com,
        lulu@redhat.com, sgarzare@redhat.com, xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH V4 3/9] virtio: introduce config op to synchronize vring
 callbacks
In-Reply-To: <20220507071954.14455-4-jasowang@redhat.com>
Organization: Red Hat GmbH
References: <20220507071954.14455-1-jasowang@redhat.com>
 <20220507071954.14455-4-jasowang@redhat.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Mon, 09 May 2022 17:24:37 +0200
Message-ID: <878rra4tl6.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07 2022, Jason Wang <jasowang@redhat.com> wrote:

> This patch introduces new virtio config op to vring
> callbacks. Transport specific method is required to make sure the
> write before this function is visible to the vring_interrupt() that is
> called after the return of this function. For the transport that
> doesn't provide synchronize_vqs(), use synchornize_rcu() which
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
>  include/linux/virtio_config.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

