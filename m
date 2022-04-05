Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751B24F4C9E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579152AbiDEX0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386637AbiDEMzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:55:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24D2035269
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 04:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649159947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=caJ3Mn8x8sphClTxTGmFig0egR97QkRAGfFS5UfDfJg=;
        b=iMJFKuyd/NBBDuasFz+Q19WyHs8C7u61QUqviYeugCG9DDi3fB/04ubzBzwagCheInmqgz
        KC7volVEs2MjcggioH5JIo+jxd/6fC6eyjduVUE5JlPSJsHMmZNa55Icckq9Wsau+oMOzu
        eNwUgue0KuQf8euHSXsu3d+va/5refk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-C5yzQZkLNIu-BwW0aaP_fg-1; Tue, 05 Apr 2022 07:59:06 -0400
X-MC-Unique: C5yzQZkLNIu-BwW0aaP_fg-1
Received: by mail-wr1-f72.google.com with SMTP id j18-20020adfa552000000b002060a011303so1553466wrb.14
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 04:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=caJ3Mn8x8sphClTxTGmFig0egR97QkRAGfFS5UfDfJg=;
        b=PjBJCyRdByM26EfNLiTMQugjSpdTBAQBYBaPMwQ9urJ3b2OydWF14FMV6n6naGQSia
         5FOE9VFwhUKksKeB8oACI7cpgzEevl5FZyiQHzsyBKnueVOnVwkHcC//tqnxHTftR6YQ
         CbeH2LE6PGqUJ1Zm82mhIi3EXROwegWYOk6txkj/rlP3gjgXwZbCj9hJE50ORofeNp2+
         G5Rd/HmxLDQPhmWF2AJLHCcbQ/MKWQnO48aRgg4iB7Gbh8s5KBN03ojNhe+rss8o8L42
         /lC1RXx9stmNS6RNPY67Ao34KaDcageypnAIrgAghpBbW0gGgtaYvm9VAH/0PA/IoPiO
         6KeQ==
X-Gm-Message-State: AOAM533uZjaNKgQ81gu7I10VqaTSMqckTc8NAe6o03Hw4PE4KvmkA+vG
        SmX2VnO8wA6Lz1ir++QTrpvsrk1T4oYCoiYEt5ga00ATaZoJMWTodXy7kXSW/JwZuxtIpbYgjdc
        WcpxhVIxCPx0VyzGGls/H4p1p
X-Received: by 2002:a1c:f705:0:b0:37d:f2e5:d8ec with SMTP id v5-20020a1cf705000000b0037df2e5d8ecmr2850173wmh.21.1649159944331;
        Tue, 05 Apr 2022 04:59:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgAb5I4ZF3qI+9Z9tb/LO2zK3svds/SwszckCB8AT7KGF6vHKrXQi2sIZ1Gsir9F/APs8Zzw==
X-Received: by 2002:a1c:f705:0:b0:37d:f2e5:d8ec with SMTP id v5-20020a1cf705000000b0037df2e5d8ecmr2850160wmh.21.1649159944150;
        Tue, 05 Apr 2022 04:59:04 -0700 (PDT)
Received: from redhat.com ([2.52.17.211])
        by smtp.gmail.com with ESMTPSA id w7-20020a1cf607000000b00389a5390180sm1949693wmc.25.2022.04.05.04.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 04:59:03 -0700 (PDT)
Date:   Tue, 5 Apr 2022 07:59:00 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 8/8] virtio_ring.h: do not include <stdint.h> from
 exported header
Message-ID: <20220405075756-mutt-send-email-mst@kernel.org>
References: <20220404061948.2111820-1-masahiroy@kernel.org>
 <20220404061948.2111820-9-masahiroy@kernel.org>
 <Ykqh3mEy5uY8spe8@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ykqh3mEy5uY8spe8@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 12:44:30AM -0700, Christoph Hellwig wrote:
> On Mon, Apr 04, 2022 at 03:19:48PM +0900, Masahiro Yamada wrote:
> >  	vr->num = num;
> >  	vr->desc = p;
> >  	vr->avail = (struct vring_avail *)((char *)p + num * sizeof(struct vring_desc));
> > -	vr->used = (void *)(((uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
> > +	vr->used = (void *)(((__kernel_uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
> >  		+ align-1) & ~(align - 1));
> 
> This really does not look like it should be in a uapi header to start
> with.

It's a way to document a complex structure layout of virtio 0.9. It's
ugly but it's been like this for years. For virtio 1.0 we moved away
from this but a bunch of tools keep using legacy.

-- 
MST

