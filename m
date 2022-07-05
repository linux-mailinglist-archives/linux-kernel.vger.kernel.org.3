Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126BB566C70
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 14:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbiGEMPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 08:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbiGEMIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:08:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 008AD186EC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 05:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657022874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rtU/kjgULaXwcfy8e9s7Yd/T+aye61K0bMduomyl2x8=;
        b=ET8aILWa/kDf21auaaZsqvrfavaQc+pcj4IOjSzXbtR5VtSQS4O2Dphs5zfApiwu5f6un7
        GylpZWdDNnUQJ9jdE03EnjhQ+gprUo2F8LXR7Gk1Ohz4DSm9oZCpummFGgI6N2U0pshxrA
        cmjTpZ5dP8nzvRlqbfqrnUT7kqseHcE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-5GbvSFoFO-KWzGGYvGs_Qg-1; Tue, 05 Jul 2022 08:07:52 -0400
X-MC-Unique: 5GbvSFoFO-KWzGGYvGs_Qg-1
Received: by mail-ed1-f71.google.com with SMTP id y6-20020a056402270600b00433940d207eso5734646edd.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 05:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rtU/kjgULaXwcfy8e9s7Yd/T+aye61K0bMduomyl2x8=;
        b=FAfk5SsjJwetQfXq3VMal78cU0f3O1Amc5LtHOkeJs1SzF13Rdgqk0OjfTrstiLhfP
         EmgK4ay7PSwFhPm41VU9t8evtaWh9YLO9dZ+58dYQVev1MRVYjHqFYc68yFEJa/NfZgj
         gjr9rywnmEqpINr8Kryq3dI1k6Bj6117qrsivKGWgQD1PT789W2eR9+uYscKMJ9kcrOQ
         ab0SeMXdkzVW7dmm6ueADvSYNRmxW0gJjUuGRz/x6eP8zZhcvQmCC/fkWFJk9JjpzBDL
         662+ITYIRePNrxyzhjHAtfgTsERUgy5dSoYKY2VmBmi0Sl0PAMOJy5X8+P/YiwlxCY1G
         R+ig==
X-Gm-Message-State: AJIora/Z5LCSCVRL1HzkpsIP1Ifz/kfdNAGj4YmbhSc0WTmWEqJjfl58
        azeh00c8mqRNGuuQnyn3PimVvkl2SYrt8aX6tBiN+F8/2J5vFvAUn6UIZpcbijKKM3KJH528iNw
        LVcgeTlYtLcyaoWT8sqxXhTuRq9KW+eRT21O3WDrz
X-Received: by 2002:a17:907:60cb:b0:726:a69a:c7a with SMTP id hv11-20020a17090760cb00b00726a69a0c7amr34652269ejc.156.1657022871632;
        Tue, 05 Jul 2022 05:07:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uhvLESVkJqLMUVkS1+sqRcYMDYYv/DpSqkaUqCJgY9nCI7teVnX7sRGbX5NjXfak1s0+Cw2DXmD+gxM4e1w/E=
X-Received: by 2002:a17:907:60cb:b0:726:a69a:c7a with SMTP id
 hv11-20020a17090760cb00b00726a69a0c7amr34652242ejc.156.1657022871395; Tue, 05
 Jul 2022 05:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220704191535.76006-1-vdronov@redhat.com> <YsOKj/GE2Mb2UsYa@zx2c4.com>
 <YsOY/eWq7gRjXJK1@zx2c4.com>
In-Reply-To: <YsOY/eWq7gRjXJK1@zx2c4.com>
From:   Vlad Dronov <vdronov@redhat.com>
Date:   Tue, 5 Jul 2022 14:07:40 +0200
Message-ID: <CAMusb+RLB6-oz10yp9Cdigt0TeJ_85M30bH8snZaeM2CyvUiYA@mail.gmail.com>
Subject: Re: [PATCH] wireguard: Kconfig: select CRYPTO_CHACHA_S390
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
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

On Tue, Jul 5, 2022 at 3:51 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Tue, Jul 05, 2022 at 02:49:19AM +0200, Jason A. Donenfeld wrote:
> > Hi Vladis,
> >
> > On Mon, Jul 04, 2022 at 09:15:35PM +0200, Vladis Dronov wrote:
> > > Select the new implementation of CHACHA20 for S390 when available,
> > > it is faster than the generic software implementation.
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Link: https://lore.kernel.org/linux-kernel/202207030630.6SZVkrWf-lkp@intel.com/
> > > Signed-off-by: Vladis Dronov <vdronov@redhat.com>
> > > ... skip ...
> >
> > Thanks for the patch. Queued up as:
> > https://git.zx2c4.com/wireguard-linux/commit/?id=1b4ab028730cd00c144eaa51160865504b780961
> >
> > I'll include this in my series to net.git soon.

Thanks a ton, Jason!
Most appreciated.

> This actually leads to a minor problem:
>
>   WARNING: unmet direct dependencies detected for CRYPTO_CHACHA_S390
>     Depends on [n]: CRYPTO [=y] && CRYPTO_HW [=n] && S390 [=y]
>
> This is of course harmless, since this doesn't *actually* depend on
> CRYPTO_HW. In fact, the dependency on CRYPTO_HW is entirely a mistake
> here that was repeated a few times. I cleaned this up and fixed it in
> this patch:
>
>     https://lore.kernel.org/linux-crypto/20220705014653.111335-1-Jason@zx2c4.com/
>
> So hopefully Herbert will take that for 5.19 and then we'll be all set
> here.
>
> Jason

Whoa, that's... funny. Honestly, I was always wondering why CRYPTO_CHACHA_S390
and friends live in drivers/crypto/Kconfig. Now I know why. The patch
looks great, thank you.

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer

