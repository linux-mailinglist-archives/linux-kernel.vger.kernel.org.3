Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B214BE091
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbiBURCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 12:02:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiBURCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 12:02:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94D80AE74
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 09:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645462944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a8jYdftJnmb0zvI4rCaqGXuSppwKQhG6hl6AuRmMuaU=;
        b=M0dA2xZlg+1N8TEEWEv67o8cfmK0GAnQOiKTvMwDCIKuehfg8TXCmsYstoxYHZnqmo6IDi
        MdkPBfXxI2+Hv0Qqk8fw+59NjMBcgDAnSNWxmtmfLZ+FcRC+3BUwt1lDEZTbVIJ7hj1FqH
        pnv0LKCZ/+LFfkhqaa1vaLibkGTN368=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-W_Z1KJqfMR6eTbJgKQ17EQ-1; Mon, 21 Feb 2022 12:02:23 -0500
X-MC-Unique: W_Z1KJqfMR6eTbJgKQ17EQ-1
Received: by mail-qk1-f199.google.com with SMTP id w4-20020a05620a094400b0060dd52a1445so12806937qkw.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 09:02:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a8jYdftJnmb0zvI4rCaqGXuSppwKQhG6hl6AuRmMuaU=;
        b=W5Yhwppahj2O4Lpb4rkn2SCQjyJvQsJC86G00Mrku9PCEzjTSfGPAQnD5yq9lXEW7H
         o0bP0STJVlJ/ILzFekYRkYrxVNMvQmCIeY6TrZA5H282Tps+XmKjYXEjv3hzUFlBDscv
         Xv/N39PCcAsuDd/jGThFTuqD8sS8vDLkuaTizqOtpb6x4QPB3k5yEnBOPGPb4APFfGuy
         03Cd8FTTO8NinZcWRN9WjqmrT0GFrWX/kIq07KfpyBXJtvshxAPTGg5Vm1QTL2N3FQ3w
         kSSXM+jZEVoUNO17ByVKRbBp1TbNt+T5cYOYnGNla4szIT84dw10/bdHH9vQz/Frr9CZ
         Tieg==
X-Gm-Message-State: AOAM531ss3W7z+02I6YT9c6cXDdupvEDgHDUfUzyg3Tfi423kyrIFN7g
        DiAoKCnTLngAyQNJX2vW7qwxQZ9W2adH00TOd6YAc7gdv6U6Q8MDFMpGd04hnmCC3Sg7rDqq826
        mF+7359X8B+npD+ED2m4i14uT
X-Received: by 2002:ac8:5950:0:b0:2dc:a139:4f36 with SMTP id 16-20020ac85950000000b002dca1394f36mr19235715qtz.646.1645462942693;
        Mon, 21 Feb 2022 09:02:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz4IW2ywlrbCp6vvy6jwSlIcSAdtGODJ9+dki3CIZxUMw8weOa4wJ8ZcCtuLx9JhEkSLSVVWA==
X-Received: by 2002:ac8:5950:0:b0:2dc:a139:4f36 with SMTP id 16-20020ac85950000000b002dca1394f36mr19235682qtz.646.1645462942435;
        Mon, 21 Feb 2022 09:02:22 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it. [95.248.229.156])
        by smtp.gmail.com with ESMTPSA id bk19sm26406528qkb.125.2022.02.21.09.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 09:02:21 -0800 (PST)
Date:   Mon, 21 Feb 2022 18:02:17 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools/virtio: Test virtual address range detection
Message-ID: <20220221170217.5bq7nhr3pvchku5x@sgarzare-redhat>
References: <c1895bcc240d413ff067f982b6e653996ace9887.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c1895bcc240d413ff067f982b6e653996ace9887.camel@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 04:15:22PM +0000, David Woodhouse wrote:
>As things stand, an application which wants to use vhost with a trivial
>1:1 mapping of its virtual address space is forced to jump through hoops
>to detect what the address range might be. The VHOST_SET_MEM_TABLE ioctl
>helpfully doesn't fail immediately; you only get a failure *later* when
>you attempt to set the backend, if the table *could* map to an address
>which is out of range, even if no out-of-range address is actually
>being referenced.
>
>Since userspace is growing workarounds for this lovely kernel API, let's
>ensure that we have a regression test that does things basically the same
>way as https://gitlab.com/openconnect/openconnect/-/commit/443edd9d8826
>does.
>
>This is untested as I can't actually get virtio_test to work at all; it
>just seems to deadlock on a spinlock. But it's getting the right answer
>for the virtio range on x86_64 at least.

I had a similar issue with virtio_test and this simple patch [1] should 
fix the deadlock.

[1] 
https://lore.kernel.org/lkml/20220118150631.167015-1-sgarzare@redhat.com/

Stefano

