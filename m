Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9709758BB0E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 15:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbiHGNfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 09:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbiHGNfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 09:35:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 796DB10C1
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 06:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659879317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kUQoZ+Z3T3noJLGRnWhyvuGBcgQof1Le7Re/cjImcLw=;
        b=IHLvnNpzfybRtxs38FQa5zvubeXzFo0iBriuSw9yVSRCcTm6LdI25vBjDvAJpxsfirYNYN
        gm75Pg0AulwGKyAvisdV1OwA3NG+ePzELQJkWGIlCB1poEhufUkw503Ke3UQUPLGcjH1K7
        z4ghHdAT2no8Ue24/v0ds6eh02wvCx0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-UWd_EXkUMrWZzOaSPf1Cuw-1; Sun, 07 Aug 2022 09:35:14 -0400
X-MC-Unique: UWd_EXkUMrWZzOaSPf1Cuw-1
Received: by mail-wm1-f71.google.com with SMTP id j36-20020a05600c1c2400b003a540d88677so10820wms.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 06:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=kUQoZ+Z3T3noJLGRnWhyvuGBcgQof1Le7Re/cjImcLw=;
        b=H34+gZ8+vJ2GeB8XC3NCPMyD82/FrP2jWMkY7A7U6mnI5zNCQYZbMnCy6CC10WIowm
         Opbq9CIawHvIneSqgvZ8wOPXeGzHUMrMQHcG9c+xZSdVUYpL1bsimdIeThBtq7n0hyJT
         /5FCHpUf3Rs4gVJ8bWDsMLczeNEAbv/mFf/VZJ+5RAjURWKT3Mc8Bo1kfNEGPtrTxMuf
         y2l/y6AIVBF8mBZK89P+mQrRw4QmdKHPVDw0xAJXL0LEDI/DPQmwERLZ+0VKVjPfjfFn
         HdOaTqhLv3NVMJgEPQjYQYK2g5N5/BozQhsKtNyvfQS8IZ6bgCFeLAdnJjDdOpr3+Oci
         7K8A==
X-Gm-Message-State: ACgBeo02rvoH7jc1UrLF/jacsrBxLz8QNN9si1dWXPyIyZDrsqc2vHRl
        dQa7X0q+9NYJ//WlHs6+EZmZ36CvrjNNF7+xjl6gQXbQmF/xRXdy1QaYr/sx6xeHrX5s4T0yeo+
        pC2FoFie7qCJJprnyV1RRjBzr
X-Received: by 2002:a05:600c:35c7:b0:3a3:2612:f823 with SMTP id r7-20020a05600c35c700b003a32612f823mr9706769wmq.33.1659879313163;
        Sun, 07 Aug 2022 06:35:13 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6b3gJMHnoTNtj37IngASsHIWEjuA+66KHlhEYj9gzwpL5gbhYjiJ9U3VuycAq+eyh6uwiMbA==
X-Received: by 2002:a05:600c:35c7:b0:3a3:2612:f823 with SMTP id r7-20020a05600c35c700b003a32612f823mr9706761wmq.33.1659879312980;
        Sun, 07 Aug 2022 06:35:12 -0700 (PDT)
Received: from redhat.com ([2.52.21.123])
        by smtp.gmail.com with ESMTPSA id y12-20020adfdf0c000000b0021f138e07acsm8993628wrl.35.2022.08.07.06.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 06:35:12 -0700 (PDT)
Date:   Sun, 7 Aug 2022 09:35:07 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, stefanha@redhat.com,
        jasowang@redhat.com, ascull@google.com, maz@kernel.org,
        keirf@google.com, jiyong@google.com, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: IOTLB support for vhost/vsock breaks crosvm on Android
Message-ID: <20220807092733-mutt-send-email-mst@kernel.org>
References: <20220805181105.GA29848@willie-the-truck>
 <CAHk-=wip-Lju3ZdNwknS6ouyw+nKXeRSnhqVyNo8WSEdk-BfGw@mail.gmail.com>
 <Yu9hHef3VawCbJT9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yu9hHef3VawCbJT9@infradead.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2022 at 11:52:13PM -0700, Christoph Hellwig wrote:
> It really is vhost that seems to abuse it so that if the guest
> claims it can handle VIRTIO_F_ACCESS_PLATFORM (which every modern
> guest should) it enables magic behavior, which I don't think is what
> the virtio spec intended.

Well the magic behavour happens to be used by QEMU to
implement a virtual IOMMU. And when you have a virtual
IOMMU you generally want VIRTIO_F_ACCESS_PLATFORM.
This is how it came to be reused for that.

And since QEMU never passed guest features to vhost
unfiltered we never saw the issue even with old QEMU
versions on new kernels.

It seems natural to pass features unfiltered and we never even said
userspace should not do it, so it's quite understandable that this is
what corsvm did.

-- 
MST

