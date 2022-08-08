Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9B458C671
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 12:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242620AbiHHKbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 06:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242409AbiHHKbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 06:31:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9C72F5
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 03:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659954669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XvPrsjTvSRvoKVmqojs3rSzxL2OS329sfzMWHSZ4M50=;
        b=GFAql5z2TIeA62I7XleLC58YPAvWmz/Ry9NkxxGtsUryxC9et8iswVJzPzmzxm2CdKXZpk
        BtMt7FF0zNBJy2SEhm3aYzssAdWhUnvzuaT0g/ZNbnlmCDBLyJuzsTZIVSra8JJ0SUuA9b
        +OHcdyYhf/EyVFDg9Widi9ZMuEuZC5g=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-jemyhmxeND-yTDDtS_0Aog-1; Mon, 08 Aug 2022 06:31:08 -0400
X-MC-Unique: jemyhmxeND-yTDDtS_0Aog-1
Received: by mail-qt1-f198.google.com with SMTP id h13-20020ac87d4d000000b00342f6c363afso2439048qtb.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 03:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=XvPrsjTvSRvoKVmqojs3rSzxL2OS329sfzMWHSZ4M50=;
        b=tQ56R3qnEsKyDYP1+qPJRO1iwEQqQo22FC9yFj/aSaHmGtbLo1UdRtnEbOWM7YcnFh
         dVlxjkkQ0bf8UoN+L+dvGYtv0Fw2mb3mraHFVTqN6LHOtFKJVoQRyNtZIChH/MTXnyh+
         oCzZHPjYpiMUA97bVZoQ9SNN40yfjsbUzhhzVcC4bIiZx00ddXRKSXoqFAy7Z3kLrTfS
         fVx6eHvltpP/RJ+vr/blnU7XON4mmkyA/Wr1PHFnj/FQ0/V3/uCH4Fbix0f1B/kVicpc
         obRWbE/8REhu5eYt+ZrP6mqIRv0C1OwM0HkxHuTJRKhP2eAl3tipRFkgJoW1B2dTrAh8
         kttA==
X-Gm-Message-State: ACgBeo0dwscSLY86BEeriuQ6yTdM3Ngr0Da7UCQBW534YG380JvuAxOz
        Wo4gdQ1czFkNbotL+G3HJExcZ8/3NGRF0PFwmfZoADRH9WKhujsMXQRdQJp6sZZ4iPqqVzWc1nV
        3VQD+CmpEzL0R+Qvb6WFLJiul
X-Received: by 2002:a37:8a44:0:b0:6b5:f371:a183 with SMTP id m65-20020a378a44000000b006b5f371a183mr13302346qkd.492.1659954668397;
        Mon, 08 Aug 2022 03:31:08 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6/yFs0KjeGd8bKDfXwYhjua9yB0wwXzaxZKsQn6plBoppBAz4IclCsn96TyP1BAgwx2AsEgg==
X-Received: by 2002:a37:8a44:0:b0:6b5:f371:a183 with SMTP id m65-20020a378a44000000b006b5f371a183mr13302320qkd.492.1659954668196;
        Mon, 08 Aug 2022 03:31:08 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it. [79.46.200.178])
        by smtp.gmail.com with ESMTPSA id u12-20020a05620a454c00b006b928ba8989sm844240qkp.23.2022.08.08.03.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 03:31:07 -0700 (PDT)
Date:   Mon, 8 Aug 2022 12:31:01 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [RFC PATCH v3 2/9] hv_sock: disable SO_RCVLOWAT support
Message-ID: <20220808103101.iknoveb7vgsrkxp6@sgarzare-redhat>
References: <2ac35e2c-26a8-6f6d-2236-c4692600db9e@sberdevices.ru>
 <58f53bef-62f4-fd63-472c-dcd158439b09@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <58f53bef-62f4-fd63-472c-dcd158439b09@sberdevices.ru>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 01:53:23PM +0000, Arseniy Krasnov wrote:
>For Hyper-V it is quiet difficult to support this socket option,due to
>transport internals, so disable it.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>Reviewed-by: Dexuan Cui <decui@microsoft.com>
>---
> net/vmw_vsock/hyperv_transport.c | 7 +++++++
> 1 file changed, 7 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

