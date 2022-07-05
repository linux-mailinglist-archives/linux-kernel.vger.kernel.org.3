Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1D15663CB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiGEHOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiGEHO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:14:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05A9525E1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657005266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4giCAN0BxKc778vWtSSTjZu8pniT4NMZr4y0gV4ab5g=;
        b=QbSXLA1nGNsfL4a6dcdZZDagb0berUXgxKOobbKyb0wcuhBiZOAemkVNDpJCTNaOWcfv87
        A1xf8+3sL099HAqbXw2yjdOnLOQ3k2h4uqax4yQmEor7fTEn4Qr4ElRCqlnYhmEyNYQXIh
        Lj/9xAlsTjw3ST+SiR5EUXVXRWG9LJk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-PssA0gOQPJirPu1LAw5aeg-1; Tue, 05 Jul 2022 03:14:25 -0400
X-MC-Unique: PssA0gOQPJirPu1LAw5aeg-1
Received: by mail-wr1-f71.google.com with SMTP id h29-20020adfaa9d000000b0021d67fc0b4aso908885wrc.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 00:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4giCAN0BxKc778vWtSSTjZu8pniT4NMZr4y0gV4ab5g=;
        b=3DD8WOweyV+Pjag5WS3vq91NbkIGfuCrMMmzPwaz+1TYWGVyt4wjyXlsYjx0NqUCgV
         UR6HD0otzTXkRbkn06Dalm+piM0fb9+vG9GAiLMOnzfSaoXvIFxqFfJfHOCbJ7i/KG5/
         3c1+l54xLEugFY/BR7WA/ldEREE0xFmvkM93ZRw9U+qZ3UHMutZBj7IzEVKe1d7HaEc1
         drfUNKrhc2V9ijTQfH4keWZby5B8uac2bUlJ0UHLfxJ2gixHrevxmVBYl0aglO2vZIHG
         jtDjlJ4PDa0XPLypwGOkexuSGj1VyZT8mfvTHxCG2pxsRnZqHFdZBOU3L7zSOo3fC1P1
         fwQw==
X-Gm-Message-State: AJIora/oVtFXDjt+KH+pzrWSl32B+t7TYE9zaiHHpF7Jn0DPrdj6ZE8L
        +BJd2sOkRrH7ZxZ1e6KC4odutgKWOQYxYuuN2qhRkX8pPlGZAnXKDCv44k3vsJGApuxZ3AuHNAE
        an3liNNdq05BhkhPF5d5ArMBU
X-Received: by 2002:a05:600c:219a:b0:3a1:816e:47da with SMTP id e26-20020a05600c219a00b003a1816e47damr28318206wme.36.1657005264248;
        Tue, 05 Jul 2022 00:14:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vcW9e9eTalezNtaWJSnF5gbHxxCeW7lqs+IDLr/j+gAKlupZwbA3tlhTxkIM9It+mdfQXIUg==
X-Received: by 2002:a05:600c:219a:b0:3a1:816e:47da with SMTP id e26-20020a05600c219a00b003a1816e47damr28318198wme.36.1657005264087;
        Tue, 05 Jul 2022 00:14:24 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-206.retail.telecomitalia.it. [79.46.200.206])
        by smtp.gmail.com with ESMTPSA id v13-20020a1cf70d000000b0039747cf8354sm21868103wmh.39.2022.07.05.00.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:14:23 -0700 (PDT)
Date:   Tue, 5 Jul 2022 09:14:20 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [RFC PATCH 1/6] tools/virtio: fix build
Message-ID: <20220705071420.24slcba3racqjmx6@sgarzare-redhat>
References: <20220704171701.127665-1-sgarzare@redhat.com>
 <20220704171701.127665-2-sgarzare@redhat.com>
 <20220704150706-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220704150706-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 03:07:15PM -0400, Michael S. Tsirkin wrote:
>On Mon, Jul 04, 2022 at 07:16:56PM +0200, Stefano Garzarella wrote:
>> Fix the build caused by the following changes:
>> - phys_addr_t is now defined in tools/include/linux/types.h
>> - dev_warn_once() is used in drivers/virtio/virtio_ring.c
>> - linux/uio.h included by vringh.h use INT_MAX defined in limits.h
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>Post this separately?

Yep, sure!

Stefano

