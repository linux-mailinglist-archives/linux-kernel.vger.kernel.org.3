Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AA852288F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 02:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238627AbiEKAlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 20:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238599AbiEKAky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 20:40:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22E3A50004
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 17:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652229651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=75c2pwoMl9AH7S04XkzjExQuuOAifRI3PqS3C+YfgtY=;
        b=DbDDI7NcnZPq5Fw+RkvjJe4XvIWWR3b0m6UE/mq29Dk4+bgQkzcUuZr98kswJhi3+/DZY+
        amykOV0Z3C9NZAuE7wUU5MfRvELl052Xg7PJJgAbj1GI0CrDT1UWHI+YBGqIl2D9+c/ap8
        8mwizIp89f+J3t/4EFjLTqxZwrLgEB4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-05bw7PcqMy2Rw_ZT_2iREA-1; Tue, 10 May 2022 20:40:50 -0400
X-MC-Unique: 05bw7PcqMy2Rw_ZT_2iREA-1
Received: by mail-qv1-f69.google.com with SMTP id n5-20020a0cbe85000000b0045aff56564bso715078qvi.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 17:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=75c2pwoMl9AH7S04XkzjExQuuOAifRI3PqS3C+YfgtY=;
        b=thze3JCfuGVEpLbPoFZFiT9KGWt4NR15DLjNYRxUaF5ma08gFuN4AvT8G2+ftcELFP
         /wWurSuRDMf1FYy566rhUtayRdvu6mgeYDM+TMxbxCDG6jutmBKhe5Id71a1XfXqlS0n
         vOZIXeGEsdes2LGkn2/LJKUJU1I8iLZBwoWhAmCw/8IZWn9RgmNEfm5tq+QR+PyDjjd3
         fhTYk0qcYqHv72oHKwAeE7kIbq46hLGSZ6O9xplR9vpd2OLMj0CqdaQWhbwDAbjMlNxd
         nr8J9xi3Bjz6OzK1x1FzfG8EKaQ5ohWdp7VGnKXiNuqLNLEtsnVDosaRLTt0YPZ2KgFS
         Gfqg==
X-Gm-Message-State: AOAM532rR5wVGLkd1GvzbBT1wpLJ4eJAf/PxHfwMzSYHYiZGRIp429yu
        QoIz2tBO4C/mKPaj8qmEwOgCHrTmNd5sqcS/ovz6m2L+3Xdc0/y1PH3DV9Z0lkfYZsACfL9l+vI
        ws9AJ7e3Kv/dac4cHiM1eKCOt
X-Received: by 2002:a37:9d4b:0:b0:69f:b567:efec with SMTP id g72-20020a379d4b000000b0069fb567efecmr17402301qke.592.1652229650230;
        Tue, 10 May 2022 17:40:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEL8ckarl5PqTLa58S+ksf2hfiaXZWb4frzEks4mCUNysmcB31Tm/yfkyt10KIrdo3U+6IBQ==
X-Received: by 2002:a37:9d4b:0:b0:69f:b567:efec with SMTP id g72-20020a379d4b000000b0069fb567efecmr17402288qke.592.1652229649978;
        Tue, 10 May 2022 17:40:49 -0700 (PDT)
Received: from m8.users.ipa.redhat.com (cpe-158-222-141-151.nyc.res.rr.com. [158.222.141.151])
        by smtp.gmail.com with ESMTPSA id c4-20020ac87dc4000000b002f39b99f68esm326680qte.40.2022.05.10.17.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 17:40:49 -0700 (PDT)
Message-ID: <8f305036248cae1d158c4e567191a957a1965ad1.camel@redhat.com>
Subject: Re: [PATCH 2/2] random: add fork_event sysctl for polling VM forks
From:   Simo Sorce <simo@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Graf <graf@amazon.com>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Torben Hansen <htorben@amazon.co.uk>,
        Jann Horn <jannh@google.com>
Date:   Tue, 10 May 2022 20:40:48 -0400
In-Reply-To: <20220502140602.130373-2-Jason@zx2c4.com>
References: <20220502140602.130373-1-Jason@zx2c4.com>
         <20220502140602.130373-2-Jason@zx2c4.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-05-02 at 16:06 +0200, Jason A. Donenfeld wrote:
> In order to inform userspace of virtual machine forks, this commit adds
> a "fork_event" sysctl, which does not return any data, but allows
> userspace processes to poll() on it for notification of VM forks.
> 
> It avoids exposing the actual vmgenid from the hypervisor to userspace,
> in case there is any randomness value in keeping it secret. Rather,
> userspace is expected to simply use getrandom() if it wants a fresh
> value.
> 
> For example, the following snippet can be used to print a message every
> time a VM forks, after the RNG has been reseeded:
> 
>   struct pollfd fd = { .fd = open("/proc/sys/kernel/random/fork_event", O_RDONLY)  };
>   assert(fd.fd >= 0);
>   for (;;) {
>     read(fd.fd, NULL, 0);
>     assert(poll(&fd, 1, -1) > 0);
>     puts("vm fork detected");
>   }
> 
> Various programs and libraries that utilize cryptographic operations
> depending on fresh randomness can invalidate old keys or take other
> appropriate actions when receiving that event. While this is racier than
> allowing userspace to mmap/vDSO the vmgenid itself, it's an incremental
> step forward that's not as heavyweight.

At your request teleporting here the answer I gave on a different
thread, reinforced by some thinking.

As a user space crypto library person I think the only reasonable
interface is something like a vDSO.

Poll() interfaces are nice and all for system programs that have full
control of their event loop and do not have to react immediately to
this event, however crypto libraries do not have the luxury of
controlling the main loop of the application.

Additionally crypto libraries really need to ensure the value they
return from their PRNG is fine, which means they do not return a value
if the vmgenid has changed before they can reseed, or there could be
catastrophic duplication of "random" values used in IVs or ECDSA
Signatures or ids/cookies or whatever.

For crypto libraries it is much simpler to poll for this information 
than using notifications of any kind given libraries are
generally not in full control of what the process does.

This needs to be polled fast as well, because the whole point of
initializing a PRNG in the library is that asking /dev/urandom all the
time is too slow (due to context switches and syscall overhead), so
anything that would require a context switch in order to pull data from
the PRNG would not really fly.

A vDSO or similar would allow to pull the vmgenid or whatever epoch
value in before generating the random numbers and then barrier-style
check that the value is still unchanged before returning the random
data to the caller. This will reduce the race condition (which simply
cannot be completely avoided) to a very unlikely event.

HTH,
Simo.

-- 
Simo Sorce
RHEL Crypto Team
Red Hat, Inc



