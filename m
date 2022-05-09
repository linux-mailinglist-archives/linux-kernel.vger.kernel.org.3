Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA2652010D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238267AbiEIP14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238479AbiEIP0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:26:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8627A293B53
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652109758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n6h9yNfq72bzRls8HnUf0w0Kayfm+ufVKotdOqahwGY=;
        b=ejnBp1v099tNTA3G8COCxb1fNizbUXf9CWbs8dblcwdYv0+CCbFlzYzO3qV3hNGF511e3b
        zWhNDIYkhhIvUX0pwnhwKeYJ2ZOrYI9ZZnAmfKGg94jVaqWPcoughIsycIwdn7iQFWD8qQ
        vXtoJymxaAHtX49p0guMRTeaJQxu6Dc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-zWiH30deNgyu3D0kqi9u0A-1; Mon, 09 May 2022 11:22:37 -0400
X-MC-Unique: zWiH30deNgyu3D0kqi9u0A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8E5C8E6201;
        Mon,  9 May 2022 15:22:36 +0000 (UTC)
Received: from localhost (unknown [10.39.193.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 79D1C14C3022;
        Mon,  9 May 2022 15:22:36 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jason Wang <jasowang@redhat.com>, jasowang@redhat.com,
        mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, paulmck@kernel.org,
        maz@kernel.org, pasic@linux.ibm.com, eperezma@redhat.com,
        lulu@redhat.com, sgarzare@redhat.com, xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH V4 1/9] virtio: use virtio_device_ready() in
 virtio_device_restore()
In-Reply-To: <20220507071954.14455-2-jasowang@redhat.com>
Organization: Red Hat GmbH
References: <20220507071954.14455-1-jasowang@redhat.com>
 <20220507071954.14455-2-jasowang@redhat.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Mon, 09 May 2022 17:22:34 +0200
Message-ID: <87bkw64tol.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
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

> From: Stefano Garzarella <sgarzare@redhat.com>
>
> It will allow us to do extension on virtio_device_ready() without
> duplicating code.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

I think you forgot my R-b on this and the following patch...

