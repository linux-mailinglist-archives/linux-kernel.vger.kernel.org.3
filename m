Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11D5565DEF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 21:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiGDTXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 15:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiGDTXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 15:23:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44F82B4A6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 12:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656962587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cqt8xqRDDqH9AAgLPBiNMPVtge5N9qex3Wlgb+K/pvE=;
        b=SXZsu9v9ek+NqhWxji//ha9GSQ0n1GU0gHqpRV5b8nQBMD0K0RDgyP26gMD26ZM8XkUeMp
        EZhmX3MFOKReHl5Op20IYIQOxycyJIgbJrigyj+jj3w06IwCOEy2ByKOq1dq/W1Y8u3FlV
        QGUh/qTMzbBQh/sdSr2ovX2/NMFHnEI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-_XU9VqVYN26RoJfFXdVTig-1; Mon, 04 Jul 2022 15:23:05 -0400
X-MC-Unique: _XU9VqVYN26RoJfFXdVTig-1
Received: by mail-ed1-f72.google.com with SMTP id w5-20020a056402268500b0043980311a5fso7242182edd.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 12:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cqt8xqRDDqH9AAgLPBiNMPVtge5N9qex3Wlgb+K/pvE=;
        b=lMftUCLJjfUoC9N/fehyAAHeqjnbQryYGSRH5yYwaZQU82lvkMHHB8GzDE1QK0/k5A
         08TpYiChwaKZCAV4AeE7I7XIHbPDvceRUm/le3UBJLwDWZk43jUZLoioIz6ERLCtr2RN
         lpfG03yUqdo9y78pXesA5fW+fIP4H2DjLdPmqMSr4pAwmDgmEWO/UlDaeqtqJ+EimzBw
         O3NtoljIlkduAtotDttraVgi91jGe1/5VmHZEYZcwkNqCLkjzE17DCtlG0PgFLGH8fFt
         EuDPDcRlNHd9kgQqIZ152rV624hQU+v6DbhqWbgIjNJGRp+15jDIyo2AuqXE1+7VcJYY
         t0yw==
X-Gm-Message-State: AJIora8ODrsRB+/MY38MkUNrBPQ6I+poWaY/RrGa0vGH7gcsqBMO4giB
        ks84KahPhPo/x5seZFIR85KAJMQwsFNjYth3QtkAn2vranIe0obVhTEpCFqZGawGjiRx+QmukMB
        TZdCwAHBxtFBP4oImY9MC1XFJUBQD+o36Zrztv5QZ
X-Received: by 2002:a05:6402:354d:b0:435:93f9:fc0b with SMTP id f13-20020a056402354d00b0043593f9fc0bmr40109232edd.288.1656962584591;
        Mon, 04 Jul 2022 12:23:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t1lgOTxdP24YLEIW+QyT4SwgvOfV8yy7PPWjjB5xHbJy3DsvqX9vaqp/QQ3825q3Y1A+fHDQXT1WSRkOklODI=
X-Received: by 2002:a05:6402:354d:b0:435:93f9:fc0b with SMTP id
 f13-20020a056402354d00b0043593f9fc0bmr40109220edd.288.1656962584421; Mon, 04
 Jul 2022 12:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <202207030630.6SZVkrWf-lkp@intel.com> <CAMusb+SaQOEw_deYyT-nB43Jvmy8W1Bd5gJrpcgvtMOTiEaoNg@mail.gmail.com>
 <CAMusb+QDk4CutzAGg-ZVmndnDh9N9q=HK1-Se=r6ebxPpdLp2g@mail.gmail.com>
 <CAMusb+QJ3yvEF8rUQ7=4Xf4dGG3Bs_ZOb2muJPKQ9ftXO+mX5g@mail.gmail.com> <CAMusb+Rr9_TBLad1UQN52nWBN48j8V1c8GmMPNz=ezsEZfGKOg@mail.gmail.com>
In-Reply-To: <CAMusb+Rr9_TBLad1UQN52nWBN48j8V1c8GmMPNz=ezsEZfGKOg@mail.gmail.com>
From:   Vlad Dronov <vdronov@redhat.com>
Date:   Mon, 4 Jul 2022 21:22:53 +0200
Message-ID: <CAMusb+QqSU0ak2Dd2pqWcS82u9z5iTyqHp7CQZNuDCm5Juhrxw@mail.gmail.com>
Subject: Re: include/crypto/chacha.h:100: undefined reference to `chacha_crypt_arch'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Harald Freudenberger <freude@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 4, 2022 at 5:42 PM Vlad Dronov <vdronov@redhat.com> wrote:
> ...skip...
>
> JFYI: fed with a config in question, "make menuconfig" just silently changes
> CONFIG_CRYPTO_CHACHA_S390=m to =y
> and, accordingly,
> CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m to =y
> thus allowing a correct build.
>
> Still not sure how to proceed from here with this clarification above.

Ok, I'm sorry for the traffic. The fix was posted:

https://lore.kernel.org/netdev/20220704191535.76006-1-vdronov@redhat.com/T/#u

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer

