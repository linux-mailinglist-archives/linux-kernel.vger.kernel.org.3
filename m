Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C415AFDD7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiIGHqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiIGHqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:46:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD7482D22
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 00:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662536771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q3eQegbyNUNUZfQN4Vuu2Y+4sgIIke5mBIO94daHPAk=;
        b=FH8JJ1jXsEyZ935BfXuOghYkFtoF/0Hm1Cn/TAae13pLxR4tRvEk9k+SIAkZTQf6wHPw33
        mSDWZdIoRkaxbwCbSLC4NqxBVlBoMdtgGfRNdj6qggeMfN9XJuCe5VQhZM6EBsl7RKXKQy
        vDy99W7oqeKE5g0rdntK8MDXyMBt5HY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-304-uPUkiUyQN0KpodrCABSWYA-1; Wed, 07 Sep 2022 03:46:10 -0400
X-MC-Unique: uPUkiUyQN0KpodrCABSWYA-1
Received: by mail-wr1-f72.google.com with SMTP id r17-20020adfbb11000000b00228663f217fso2651763wrg.20
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 00:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=q3eQegbyNUNUZfQN4Vuu2Y+4sgIIke5mBIO94daHPAk=;
        b=ePnBqM44NvBfwrhhuOQ8H++X2F8K6DM0AyJvWLY6GKRXIso7/xwAhG2vDTKoADjFM4
         EKgkLJWxB3b3T3whdc8IO67URLFU+pHudKTZj6B4/5jLhhhNWsQC0CqRrAuBrwaHPAc6
         lTyUySNKevJuG/ib5idupcJ4tHs5x+b8/cpnKkMi9fEQxtxNSMVUL2uN4vxGhmrUXrnd
         iLqxKk2nzY6Lm1Mi7QFATK9EP85end0ZZYfqqb3JJw1zf8FX18GZHe91B8tElfaUJ78l
         weUxjEQn3RDMduguEswG1inuUSUvlD7O2VlJIcaN40EuTI7+fB7Mh9gI2RbfejKVMfni
         nkyg==
X-Gm-Message-State: ACgBeo1rldNkODmRahrgmsNsJPIOjmBxArz8V8rZYRYAnVv8+zVaKDl8
        VON87D6lS4D/6e9A96CCzfm9z57KAmcLrkn8gpK0VR7OtmD17fF6SZqJWAu0F2mNHEBNT5wbywX
        YcjaEzErz77Sf4fujYVlwMLm6
X-Received: by 2002:adf:ed81:0:b0:226:a509:14b6 with SMTP id c1-20020adfed81000000b00226a50914b6mr1211069wro.150.1662536769192;
        Wed, 07 Sep 2022 00:46:09 -0700 (PDT)
X-Google-Smtp-Source: AA6agR44JqlJBu3NM8POTUmZPOMnuC7An3N2YQMeTdJEE/AQ3Rtm8kSGa0vZZHfwxjXMROy9TOM4iQ==
X-Received: by 2002:adf:ed81:0:b0:226:a509:14b6 with SMTP id c1-20020adfed81000000b00226a50914b6mr1211058wro.150.1662536768934;
        Wed, 07 Sep 2022 00:46:08 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-69.retail.telecomitalia.it. [87.11.6.69])
        by smtp.gmail.com with ESMTPSA id e3-20020a5d5303000000b0022584e771adsm16009397wrv.113.2022.09.07.00.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 00:46:08 -0700 (PDT)
Date:   Wed, 7 Sep 2022 09:45:58 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     vdasa@vmware.com
Cc:     vbhakta@vmware.com, namit@vmware.com, bryantan@vmware.com,
        zackr@vmware.com, linux-graphics-maintainer@vmware.com,
        doshir@vmware.com, gregkh@linuxfoundation.org, davem@davemloft.net,
        pv-drivers@vmware.com, joe@perches.com, netdev@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 3/3] MAINTAINERS: Add a new entry for VMWARE VSOCK VMCI
 TRANSPORT DRIVER
Message-ID: <20220907074558.75v3ucll6eo66zky@sgarzare-redhat>
References: <20220906172722.19862-1-vdasa@vmware.com>
 <20220906172722.19862-4-vdasa@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220906172722.19862-4-vdasa@vmware.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 10:27:22AM -0700, vdasa@vmware.com wrote:
>From: Vishnu Dasa <vdasa@vmware.com>
>
>Add a new entry for VMWARE VSOCK VMCI TRANSPORT DRIVER in the
>MAINTAINERS file.
>
>Signed-off-by: Vishnu Dasa <vdasa@vmware.com>
>---
> MAINTAINERS | 8 ++++++++
> 1 file changed, 8 insertions(+)

Thanks for adding this entry!
Will be very useful to review vsock patches for vmci transport.

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

