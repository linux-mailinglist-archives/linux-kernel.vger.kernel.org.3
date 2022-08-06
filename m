Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD9F58B51D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 12:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiHFKxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 06:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiHFKxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 06:53:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD1BDE0D5
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 03:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659783191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HoXZYNXSL5fLTvts22bXZSeKXcAG3hKrGWdYE5IH2uY=;
        b=MfWu+P+aYmMnXfVmBgGlx+EXxTGZ3KRznvVnh8sBLUbNlEM8a7vF4FQLDuQje3EjRCjPF5
        sXaJRHTpCSFiSi56qKDE6JBE3ez7swWkZDOg7shpbJTgBx+kOgLtCpNj5HU4yhc5aMugMD
        uOtlkTCNW15X7icE7cCVLjFppM1D8WM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-z7zON1pWMsK7tLMIdw_LJA-1; Sat, 06 Aug 2022 06:53:08 -0400
X-MC-Unique: z7zON1pWMsK7tLMIdw_LJA-1
Received: by mail-lj1-f200.google.com with SMTP id j15-20020a2e850f000000b0025e6da69e18so1444677lji.18
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 03:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=HoXZYNXSL5fLTvts22bXZSeKXcAG3hKrGWdYE5IH2uY=;
        b=O8ew+Y/tKLHBMBTSC9IBDAjPKIZF1ZpMgBTHqpnwDIwZYa1hxkToHXF5mF2/ZycHGC
         dYojHada2vdZG81XhQCZSa5RzuIqD3YNuyDO5dU1iI+AxsgmNbK5H6dwSgOlMcphKu8U
         ShDVEiYVJ6WGlAztq97v+/6Qasx2HwjRsvtv8g1/6qUa2V0PtN0T7TSWhaPI3OVvCQh8
         Id3hO9yX1ZZeo2XAPLjbSJYYHdORFsTFVLXszn2hySwRg/JB9eKYvy1fpePggaTSjQaD
         RK6/2/pZzeVAC8Mi27XOIURSfSfBB1/8UAwpw4n7wczyLfyKFPSMj9orFgrSdn9tZveE
         Ftnw==
X-Gm-Message-State: ACgBeo30Wb3VvKitVuZhvimH+MtMWeLIrZkK4ZvAG0g8vjzxQIbBJyY2
        cRL72u7NZrtBMXBT8IotoTCsYSsyMmLh9rXDjGYAPz132VbX5RLmZRVYroegGwHsLeCCy/D+6oi
        UP/bsJiZqknXuqbAs8rY1QcWIz2Koo2NdPPg+RfZq
X-Received: by 2002:a19:ab02:0:b0:48b:3f9:add1 with SMTP id u2-20020a19ab02000000b0048b03f9add1mr3725676lfe.329.1659783186705;
        Sat, 06 Aug 2022 03:53:06 -0700 (PDT)
X-Google-Smtp-Source: AA6agR68ndpqPOOxRv2oo+THbpQNjgqPKLoS/uiP2MJpF6wKiapM7segimQKmjhNFxOTs1KVU4EO6HP0z4kLPfWE/JQ=
X-Received: by 2002:a19:ab02:0:b0:48b:3f9:add1 with SMTP id
 u2-20020a19ab02000000b0048b03f9add1mr3725668lfe.329.1659783186556; Sat, 06
 Aug 2022 03:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220805181105.GA29848@willie-the-truck> <20220806074828.zwzgn5gj47gjx5og@sgarzare-redhat>
 <20220806094239.GA30268@willie-the-truck> <CAD60JZMbbkwFHqCm_iCrOrKgRLBUMkDQfuJ=Q1T-sZt59eTBrw@mail.gmail.com>
In-Reply-To: <CAD60JZMbbkwFHqCm_iCrOrKgRLBUMkDQfuJ=Q1T-sZt59eTBrw@mail.gmail.com>
From:   Stefan Hajnoczi <shajnocz@redhat.com>
Date:   Sat, 6 Aug 2022 06:52:55 -0400
Message-ID: <CAD60JZN2rTWAXoSVtpOVGABw+rLGuQn=DLTEsN+UnHOMEEiLQA@mail.gmail.com>
Subject: Re: IOTLB support for vhost/vsock breaks crosvm on Android
To:     Will Deacon <will@kernel.org>
Cc:     Stefano Garzarella <sgarzare@redhat.com>, mst@redhat.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        torvalds@linux-foundation.org, ascull@google.com, maz@kernel.org,
        keirf@google.com, jiyong@google.com, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/vhost devices are full VIRTIO devices/vhost devices are not full
VIRTIO devices/

