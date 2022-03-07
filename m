Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF504CF436
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbiCGJGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbiCGJGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:06:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F29BA44747
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 01:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646643944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KquYHpLzP9rbFE8aNYKIXPzbeoLEFNa1Q6VUPR36ZHo=;
        b=QKAA8K9GzG5DSO+zSVPqcYfOYJqCeKIopvbsQklRK7SheihdevM6C8tNzvunjZ0y04plrt
        Axtpv1oEUCArbtO/NryJJbxABQysNKg0yESUUCLsuRbEpOk3RriXUty1Oe5wrBxYAgujq0
        47pULlU3o/ht2Wru2dqhvmKFwz4zFHk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-i5l1ODFFON2m2W0KO4A93w-1; Mon, 07 Mar 2022 04:05:42 -0500
X-MC-Unique: i5l1ODFFON2m2W0KO4A93w-1
Received: by mail-ed1-f72.google.com with SMTP id i5-20020a056402054500b00415ce7443f4so7301071edx.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 01:05:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KquYHpLzP9rbFE8aNYKIXPzbeoLEFNa1Q6VUPR36ZHo=;
        b=V3h424F+s+s/E/IO9p2CDad2DFruqZiFFyXp/8L21b9kaz7cITce8hdpzpv9R4b764
         v+0awpI6ENQ9NHdzoeY7w0/OfHw4VrYM/8rgan9VDu5wsHp8DD9rZZbzQaqTIuNrfBEm
         LJpf8lndbCwx0NUbmOtzPBODB6LHq6o48EMzyoCfdGlOLNIJpyxh/njsh4CgDfzHW3yt
         GfBUFrBRDO70m6VAZorVaMInj3o2wl6IC7GyygKunDYgkG+wuIZMK6vbnvWZU7Mi7GvO
         Q/opl1DXot0H3KiUSYtOsQYcKUIzangwG/Xbn6s2PqdBP8ZKTLhFULsfMHWfXaefySBt
         X95A==
X-Gm-Message-State: AOAM531/kDsXjgEHFY1jRPbRphHJz4qy0gHwUksrGNjAJYQaGPoBhBs3
        WzDMb/4ErNr1sUM4fgAqr3NwFJL4CimMGxhmo/FWjF1ftSEpolte5crNllcBZ0T0FXTebGr8JZC
        TtH/qXzzBlrDV0+O/bBDW25pm
X-Received: by 2002:a50:fb93:0:b0:416:c4f:bd24 with SMTP id e19-20020a50fb93000000b004160c4fbd24mr10142949edq.225.1646643941331;
        Mon, 07 Mar 2022 01:05:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyWeD5sAgrgZ1GTJMg5/qZSM+l+wtaHwT/4dN4mntileJu6VvueA9/As61UwE+i+QOYycmFEg==
X-Received: by 2002:a50:fb93:0:b0:416:c4f:bd24 with SMTP id e19-20020a50fb93000000b004160c4fbd24mr10142922edq.225.1646643941088;
        Mon, 07 Mar 2022 01:05:41 -0800 (PST)
Received: from redhat.com ([2.55.138.228])
        by smtp.gmail.com with ESMTPSA id a25-20020a50ff19000000b0040f84cd806csm5875397edu.59.2022.03.07.01.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 01:05:40 -0800 (PST)
Date:   Mon, 7 Mar 2022 04:05:37 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     arei.gonglei@huawei.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        herbert@gondor.apana.org.au, helei.sig11@bytedance.com,
        cohuck@redhat.com
Subject: Re: [PATCH v3 0/4] Introduce akcipher service for virtio-crypto
Message-ID: <20220307040431-mutt-send-email-mst@kernel.org>
References: <20220302033917.1295334-1-pizhenwei@bytedance.com>
 <a9d1dfc1-080e-fba2-8fbb-28718b067e0d@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9d1dfc1-080e-fba2-8fbb-28718b067e0d@bytedance.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 10:42:30AM +0800, zhenwei pi wrote:
> Hi, Michael & Lei
> 
> The full patchset has been reviewed by Gonglei, thanks to Gonglei.
> Should I modify the virtio crypto specification(use "__le32 akcipher_algo;"
> instead of "__le32 reserve;" only, see v1->v2 change), and start a new issue
> for a revoting procedure?

You can but not it probably will be deferred to 1.3. OK with you?

> Also cc Cornelia Huck.
> 
> On 3/2/22 11:39 AM, zhenwei pi wrote:
> > v2 -> v3:
> >    Rename virtio_crypto_algs.c to virtio_crypto_skcipher_algs.c, and
> >      minor changes of function name.
> >    Minor changes in virtio_crypto_akcipher_algs.c: no need to copy from
> >      buffer if opcode is verify.
> > 
> > v1 -> v2:
> >    Fix 1 compiling warning reported by kernel test robot <lkp@intel.com>
> >    Put "__le32 akcipher_algo;" instead of "__le32 reserve;" field of
> >      struct virtio_crypto_config directly without size change.
> >    Add padding in struct virtio_crypto_ecdsa_session_para to keep
> >      64-bit alignment.
> >    Remove irrelevant change by code format alignment.
> > 
> >    Also CC crypto gurus Herbert and linux-crypto@vger.kernel.org.
> > 
> >    Test with QEMU(patched by the v2 version), works fine.
> > 
> > v1:
> >    Introduce akcipher service, implement RSA algorithm, and a minor fix.
> > 
> > zhenwei pi (4):
> >    virtio_crypto: Introduce VIRTIO_CRYPTO_NOSPC
> >    virtio-crypto: introduce akcipher service
> >    virtio-crypto: implement RSA algorithm
> >    virtio-crypto: rename skcipher algs
> > 
> >   drivers/crypto/virtio/Makefile                |   3 +-
> >   .../virtio/virtio_crypto_akcipher_algs.c      | 585 ++++++++++++++++++
> >   drivers/crypto/virtio/virtio_crypto_common.h  |   7 +-
> >   drivers/crypto/virtio/virtio_crypto_core.c    |   6 +-
> >   drivers/crypto/virtio/virtio_crypto_mgr.c     |  15 +-
> >   ...o_algs.c => virtio_crypto_skcipher_algs.c} |   4 +-
> >   include/uapi/linux/virtio_crypto.h            |  82 ++-
> >   7 files changed, 693 insertions(+), 9 deletions(-)
> >   create mode 100644 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> >   rename drivers/crypto/virtio/{virtio_crypto_algs.c => virtio_crypto_skcipher_algs.c} (99%)
> > 
> 
> -- 
> zhenwei pi

