Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06005616C7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbiF3Jsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbiF3Jsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:48:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52D5228718
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 02:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656582513;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=81XeNR30/gt+PowfKeOGNijQshuWEzmNgPk0a20HvN0=;
        b=jMfxaYvPWQp3RshSdzEGvBMgU8eZ+5g5zaOGDl4kEf7xvjJsS5pih9fMR/fyNIE0kXt5p3
        J1Zpfs/scSNUc6Res5jnY3XQ9WtoFJS4EdGs1M+S/TEey+wiirJ9JA3XjoU1Dc4Xbpj+Kl
        wu4hWSXCbhM70FEUvINDb/635ZA+vbw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-isF8oHKAOWuBrh-V19C9Cw-1; Thu, 30 Jun 2022 05:48:32 -0400
X-MC-Unique: isF8oHKAOWuBrh-V19C9Cw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1E5E80029D;
        Thu, 30 Jun 2022 09:48:31 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 732B7492C3B;
        Thu, 30 Jun 2022 09:48:30 +0000 (UTC)
Date:   Thu, 30 Jun 2022 10:48:27 +0100
From:   Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To:     Lei He <helei.sig11@bytedance.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        dhowells@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com
Subject: Re: [External] [PATCH v2 0/4] virtio-crypto: support ECDSA algorithm
Message-ID: <Yr1xa4twKn3qFAt9@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20220623070550.82053-1-helei.sig11@bytedance.com>
 <Yr1JvG1aJUp4I/fP@gondor.apana.org.au>
 <C7191BC8-5BE0-47CB-A302-735BBD1CBED0@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <C7191BC8-5BE0-47CB-A302-735BBD1CBED0@bytedance.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 03:23:39PM +0800, Lei He wrote:
> 
> > On Jun 30, 2022, at 2:59 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > 
> > On Thu, Jun 23, 2022 at 03:05:46PM +0800, Lei He wrote:
> >> From: lei he <helei.sig11@bytedance.com>
> >> 
> >> This patch supports the ECDSA algorithm for virtio-crypto.
> > 
> > Why is this necessary?
> > 
> 
> The main purpose of this patch is to offload ECDSA computations to virtio-crypto dev.
> We can modify the backend of virtio-crypto to allow hardware like Intel QAT cards to 
> perform the actual calculations, and user-space applications such as HTTPS server 
> can access those backend in a unified way(eg, keyctl_pk_xx syscall).
> 
> Related works are also described in following patch series:
> https://lwn.net/ml/linux-crypto/20220525090118.43403-1-helei.sig11@bytedance.com/

IIUC, this link refers to testing performance of the RSA impl of
virtio-crypto with a vhost-user backend, leveraging an Intel QAT
device on the host. What's the status of that depolyment setup ?
Is code for it published anywhere, and does it have dependancy on
any kernel patches that are not yet posted and/or merged ? Does it
cover both ECDSA and RSA yet, or still only RSA ?

The QEMU backend part of the virtio-crypto support for ECDSA looks fine
to merge, but obviously I'd like some positive sign that the kernel
maintainers are willing to accept the guest driver side.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

