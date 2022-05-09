Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165FE52011E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238391AbiEIPaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238319AbiEIPaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:30:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28E3119322F
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652109974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6XSEmEQ9egD5A/DUmCwpbnEx9ZXtReSemsPxNZfoukQ=;
        b=Bj/zxrdswiNAHxPheaqtdCWbY3ywBEpKxJht/hru29at+iwmXef4M+3yEQ1bLVomIieMGk
        fLDpNqIToO1LbJ9in2kD3JSQGgP/Yhq8/p++EhauCk690z8ndaBUuVIGvrzug2qHXTBHUt
        tEebbuYOOvnbUZ3l45b8BeuZa1kCw5A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-CxEtbfy5M5OjvMGRW-5W2g-1; Mon, 09 May 2022 11:26:10 -0400
X-MC-Unique: CxEtbfy5M5OjvMGRW-5W2g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0D0C80B716;
        Mon,  9 May 2022 15:26:09 +0000 (UTC)
Received: from localhost (unknown [10.39.193.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D6A81121315;
        Mon,  9 May 2022 15:26:06 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jason Wang <jasowang@redhat.com>, jasowang@redhat.com,
        mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, paulmck@kernel.org,
        maz@kernel.org, pasic@linux.ibm.com, eperezma@redhat.com,
        lulu@redhat.com, sgarzare@redhat.com, xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH V4 4/9] virtio-pci: implement synchronize_cbs()
In-Reply-To: <20220507071954.14455-5-jasowang@redhat.com>
Organization: Red Hat GmbH
References: <20220507071954.14455-1-jasowang@redhat.com>
 <20220507071954.14455-5-jasowang@redhat.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Mon, 09 May 2022 17:26:04 +0200
Message-ID: <875yme4tir.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
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

> We can simply reuse vp_synchronize_vectors() for .synchronize_cbs().
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_pci_legacy.c | 1 +
>  drivers/virtio/virtio_pci_modern.c | 2 ++
>  2 files changed, 3 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

