Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D60153AFF7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiFAV50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiFAV5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:57:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EAD62707
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 14:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654120639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pfsPPlObmxBUf8zfBnAcZpTwKCgsSglvrSC1O4IlG2A=;
        b=SYQWeG3+GQNmdEjUWh6Zj0nDQMOBNnLucm/atv64xohIbysu1NgZ85LMc4lUGmFyhXgDAj
        L37MgDd5f182REjJnGvg7edlsw7Zaa8cTPKzL9l8X9wxoOVAxDaJFbZ2Zl/pqMC60R7mzW
        3d2TPnnRuvMwNxXZofaM3wX3EHLOFQg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-QHq_p8luN1C5CkREb0KuJQ-1; Wed, 01 Jun 2022 17:57:18 -0400
X-MC-Unique: QHq_p8luN1C5CkREb0KuJQ-1
Received: by mail-wm1-f71.google.com with SMTP id j14-20020a05600c1c0e00b003973bf0d146so1777661wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 14:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pfsPPlObmxBUf8zfBnAcZpTwKCgsSglvrSC1O4IlG2A=;
        b=XciGTnMDwcZCCwhLdlgeUcflqhlcsdRmFtBMVtsLE1Go4zfgfUXiYeR/n2SPZ+0GWL
         JUUx3thwzpCo+6NPe0pmMPlrjGV7zcK9jANd2wINUv7b5Q5P9fYko9t9iIdgxsB0DX+Q
         C5peHCzvkgvA5ZeqkAZb7dEvJqQ7ZKqKrDo//sXlvdCrEudWQKAUvmwVSgyBGmmo0dgz
         3wtMEK+8AXVvR3kj4Gk1n7EMvYtYJbUoB1Ze50Fvrzf6wONI03eywjSm+/Prt9Q8czOW
         kQvlr5vcULY08E+gipt9kWmXRbPjgx935cshcbC2yrJd1Qdm3cdai7goi9FxJhVev1fx
         IgsA==
X-Gm-Message-State: AOAM531mgRQDHyxhsHLs4GEJaLgGj+gvYpmOFd8PAGDqzfytGQS3cUto
        YexcPHMElYlcdcKv4uyDAYe/oKK9Ft72dEMPFIo9jkHvjJb7fNpr9H+f5ZGFga3SHLq6fEO8eHd
        SHu4lwEFgkVM/5fk4EuQxF1Qz
X-Received: by 2002:adf:d1c4:0:b0:210:1935:3dd8 with SMTP id b4-20020adfd1c4000000b0021019353dd8mr1140102wrd.229.1654120636667;
        Wed, 01 Jun 2022 14:57:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyT3n1+KA+gV0gXkaj3TTcR2XZ+MnWa9sLLa5MfPFZ5jWN3hEtO0yBntP8BfueuRIZdsK9GVA==
X-Received: by 2002:adf:d1c4:0:b0:210:1935:3dd8 with SMTP id b4-20020adfd1c4000000b0021019353dd8mr1140093wrd.229.1654120636417;
        Wed, 01 Jun 2022 14:57:16 -0700 (PDT)
Received: from redhat.com ([2.52.157.68])
        by smtp.gmail.com with ESMTPSA id a5-20020adffac5000000b0021023877ac5sm2432596wrs.107.2022.06.01.14.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 14:57:15 -0700 (PDT)
Date:   Wed, 1 Jun 2022 17:57:12 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bo Liu <liubo03@inspur.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vhost tree
Message-ID: <20220601060641-mutt-send-email-mst@kernel.org>
References: <20220601114240.1dafefc6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601114240.1dafefc6@canb.auug.org.au>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 11:42:40AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the vhost tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> drivers/virtio/virtio_ring.c: In function 'virtqueue_add':
> drivers/virtio/virtio_ring.c:1783:16: error: 'vq' undeclared (first use in this function); did you mean '_vq'?
>  1783 |         return vq->packed_ring ? virtqueue_add_packed(_vq, sgs, total_sg,
>       |                ^~
>       |                _vq
> drivers/virtio/virtio_ring.c:1783:16: note: each undeclared identifier is reported only once for each function it appears in
> drivers/virtio/virtio_ring.c:1787:1: error: control reaches end of non-void function [-Werror=return-type]
>  1787 | }
>       | ^
> 
> Caused by commit
> 
>   a50f09346a34 ("virtio_ring: remove unused variable in virtqueue_add()")
> 
> I am sorry, but I expect better review and build testing than this :-(
> 
> I have used the vhost tree from next-20220531 for today.

Indeed, pushed a wrong tree :( 
I hope I pushed the correct one now, pls let me know whether this is now fixed.
Thanks!

-- 
MST

