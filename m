Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E5A52D9BE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 18:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241674AbiESQEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 12:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbiESQEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:04:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6CE255374
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652976283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cn9DGsidYHLKIgSfwQZyuGk5MNvO4cusQzW9CGpB6cM=;
        b=WocO52Ghr7Meae0rRiCZOweWkyW1UqhWssMa62dq1rxLeyRzDVB3YQ42v7Tk4bg3cqxETm
        06i1Z3YTVp09TKqZZ30ZlsBejbWmcLjB6yfFmQHooVHjSwPpsuML96CH5wME/R6fTd5sK8
        sKjU99DzqvbamVF7NlgaWess/07y6rM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-IcWT5TfLN_awcsp9JUxh5Q-1; Thu, 19 May 2022 12:04:42 -0400
X-MC-Unique: IcWT5TfLN_awcsp9JUxh5Q-1
Received: by mail-qt1-f198.google.com with SMTP id m3-20020ac807c3000000b002f910a674a7so2030614qth.18
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cn9DGsidYHLKIgSfwQZyuGk5MNvO4cusQzW9CGpB6cM=;
        b=krTQepcGnjP0R5IyO3coCOhlUZ6iyFqlDkTKuVN+zTawnrwl8iDhE9sRJerF5zq/AR
         tMoJKQcmMCj/mCQ0oNJtYPeKgIaliVeftliz4N/RG2qm0ROk9JEQTwS1OaXY77DKQ+X6
         sWoYerziBgUbosoD2c7Bg2Vmi4fhi3IeCfzhqni9G0JeHrPrGku7oRaZxT11k+YUjEUd
         wnU6YqUH+3QsJWE5Cxmt00RYdpcEAqWhGoZae3Z1JZU1goIARSDpVHoYsC5wPgq28Qkx
         KgRjiJhxZW+xauhG2yAiws2VjeGhwNb1R97NjVm5W8f1sQiJFiItoe1IeCS3Llt1wMOl
         0EwA==
X-Gm-Message-State: AOAM533RC03PB26NeA80A3T/ThIynhO0TouR/STaXmJ9+26zvBKVXhaV
        LF9v6bKMIJDHsjslvY09ZQKnDYs8e8oXr61+PPQ3Alf0JxcWHqSYJh7gzgaXjxVM1V9CDurVNjy
        9yZ5EgN6NnkjfEEtga2U3OZMa
X-Received: by 2002:a05:620a:29c2:b0:6a0:5fac:2f45 with SMTP id s2-20020a05620a29c200b006a05fac2f45mr3340501qkp.529.1652976282232;
        Thu, 19 May 2022 09:04:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2Oj1i3ECAaRC8bD7Zm1tmm+5AblYIrHtBAeojqUV3W8R84H9LagTNe0ivlgrCeQ6ZxU1Wmw==
X-Received: by 2002:a05:620a:29c2:b0:6a0:5fac:2f45 with SMTP id s2-20020a05620a29c200b006a05fac2f45mr3340446qkp.529.1652976281677;
        Thu, 19 May 2022 09:04:41 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it. [87.12.25.16])
        by smtp.gmail.com with ESMTPSA id z10-20020ac87f8a000000b002f39b99f6a3sm1590625qtj.61.2022.05.19.09.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 09:04:41 -0700 (PDT)
Date:   Thu, 19 May 2022 18:04:34 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Cc:     mst@redhat.com, jasowang@redhat.com, lvivier@redhat.com,
        netdev@vger.kernel.org, lulu@redhat.com, eli@mellanox.com,
        parav@nvidia.com, virtualization@lists.linux-foundation.org,
        kvm@vger.kernel.org, lingshan.zhu@intel.com,
        linux-kernel@vger.kernel.org, gdawar@xilinx.com
Subject: Re: [PATCH v2] vdpasim: allow to enable a vq repeatedly
Message-ID: <20220519160434.5s5jzwdmajewpqvg@sgarzare-redhat>
References: <20220519145919.772896-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220519145919.772896-1-eperezma@redhat.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 04:59:19PM +0200, Eugenio Pérez wrote:
>Code must be resilient to enable a queue many times.
>
>At the moment the queue is resetting so it's definitely not the expected
>behavior.
>
>v2: set vq->ready = 0 at disable.
>
>Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
>Cc: stable@vger.kernel.org
>Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

