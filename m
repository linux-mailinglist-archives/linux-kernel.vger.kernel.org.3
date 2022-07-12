Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67BC5714FC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiGLIqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiGLIqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:46:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C886AA6F10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657615559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/5viHAMgMI6jui+cYPhD/VCPPSMBqFNLNZorgYl625U=;
        b=P49X28+lyBjfeOtbPFyF1yoFhJIuUuJGWndqLdjGpOQ193rTGHIKse0MKW/E2Iw52Gc9TR
        oniJLIvL7wRMWxtxctpOmPYp4sYxVHQ1GtC5yVUmwmGEQHkcm+NzcfNs0lc4Dpn0XIHdXN
        n61GfxXezQf+9fl7KwQx0CDfXm9mKBQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-1ISBy8_BPIGZTRthPiWAPA-1; Tue, 12 Jul 2022 04:45:58 -0400
X-MC-Unique: 1ISBy8_BPIGZTRthPiWAPA-1
Received: by mail-qv1-f70.google.com with SMTP id q16-20020a0ce210000000b00472f361d6b1so1457362qvl.21
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/5viHAMgMI6jui+cYPhD/VCPPSMBqFNLNZorgYl625U=;
        b=Zqvv0v8cEI4WAIPPlsd7bGvJXhIrnoZSPLQcrpiYsm5iLDj1BMb2LSHf7GuxaCFQlB
         YnglJuRU5Nfng4s/ctAhYGNRVCtYa2+3o52RV5KPNchwTXMDAeT0BT5xAU1wqkBQWlhp
         /GKz+wnc7C5p2+mKWIZVSBE5hOvdx5Za/wwepg5cCkLK8Oc8i1ccFjgw+seNAYFVm31m
         kAoiRVwNL7a6n8OGjSUXvXbnZVDs4kqkyM5ILhGyTSszgy5C/vz+SWE8tgol4X8zgs29
         j3JwuFlZMHweSDL2ngdWnC3vvUfToKUpmNwZp0l+U2/GZM60IvL64l1Gz+Hc0oV2YSUC
         +sxA==
X-Gm-Message-State: AJIora9iGoCKvkW0WZ+QXrbpK/YisOMd1lY7tXpQFBFjjh4szFvR/yJL
        NEjppIKzOWD6Sm0BDd89/5ldLVgbarZCQ93wWjb6ls7SynB1BNj3R+ncGEcgJtTK8qO5YHcrgai
        7JMLHzx7FIaUQQGnncjFfEd26
X-Received: by 2002:a05:6214:2465:b0:472:fcc9:1dcd with SMTP id im5-20020a056214246500b00472fcc91dcdmr16963095qvb.78.1657615557881;
        Tue, 12 Jul 2022 01:45:57 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tUTQ99MFxlI2VwBl7zvyJVXCGsmZNH1yRbY+f7aA3VJw4iVjvfnEC2GZTTk2GKSBne6wfjlQ==
X-Received: by 2002:a05:6214:2465:b0:472:fcc9:1dcd with SMTP id im5-20020a056214246500b00472fcc91dcdmr16963088qvb.78.1657615557707;
        Tue, 12 Jul 2022 01:45:57 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-206.retail.telecomitalia.it. [79.46.200.206])
        by smtp.gmail.com with ESMTPSA id bl29-20020a05620a1a9d00b006af45243e15sm8774185qkb.114.2022.07.12.01.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 01:45:53 -0700 (PDT)
Date:   Tue, 12 Jul 2022 10:45:44 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [RFC PATCH 0/6] virtio_test: add support for vhost-vdpa
Message-ID: <20220712084544.lgtggj44ihlkfsb3@sgarzare-redhat>
References: <20220704171701.127665-1-sgarzare@redhat.com>
 <a94ec2f5-8728-d62a-072e-407fbe59eb61@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a94ec2f5-8728-d62a-072e-407fbe59eb61@redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 04:34:11PM +0800, Jason Wang wrote:
>
>在 2022/7/5 01:16, Stefano Garzarella 写道:
>>The first 3 patches fix various problems I have encountered with
>>virtio_test (they may go without this series, but I included to allow you
>>to test the series).
>>
>>Patch 4 is in preparation of patch 5, moving the feature negotiation when
>>we initialize the device.
>>
>>Patch 5 add the support of vhost-vdpa in virtio_test
>>
>>Patch 6 add vdpa_test.ko based on vdpa_sim_test.c, so we can reuse most of
>>the code coming from the vdpa_sim framework.
>>
>>I tested in this way:
>>
>>   $ modprobe vdpa_sim
>>   $ modprobe vhost-vdpa
>>
>>   # load the vdpasim_test device
>>   $ insmod vdpa_test.ko
>>
>>   # create a new vdpasim_test device
>>   $ vdpa dev add mgmtdev vdpasim_test name dev0
>
>
>I wonder what's the benefit of using a dedicated test device other 
>than networking? (already a loopback device anyhow).
>

The main advantage I was thinking is that we can extend it at will to 
try to cover as much as possible all the paths that maybe with net we 
can't (indirect, reset, etc.).

Plus it should be easier to test vhost-vdpa this way without using QEMU.

Do you think this is redundant?

Thanks,
Stefano

