Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C24153E24F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbiFFHxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 03:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiFFHxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 03:53:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E8A912AB3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 00:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654502020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5tAtC8sWEQaHDrdHg4P+GFrcy06HggAEGufwFvj0o6E=;
        b=YhzPZ/yeC5BEPuhz0W18Gvm51PncqbTZQ/nYyP4uIPGBt/FCA5FphnLO8eIgY+olgOAYBx
        4Oi16q9lEjdZbGL8+YRMNsEpy2WCRTPwAaKhGYiZBeHDSygfhwyiOqhEJCqz86qC8Fwr/e
        YmAEuGrfYIwPaAuPwH+yh0q144YV5NQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-278-NoLWH7lPMFWie2M45C8Rog-1; Mon, 06 Jun 2022 03:53:38 -0400
X-MC-Unique: NoLWH7lPMFWie2M45C8Rog-1
Received: by mail-ej1-f72.google.com with SMTP id gh36-20020a1709073c2400b0070759e390fbso5660761ejc.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 00:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=5tAtC8sWEQaHDrdHg4P+GFrcy06HggAEGufwFvj0o6E=;
        b=GCpkrGKAKEpWD3HaH0QhoyI1KlicCAKBozc5hqxY9HGcEhyKnc7wloOm8Mn6Mqkgwu
         /M7qGaBRhJPsZXQ003Zs3d5KOM1tOe7zGPJsfduSN+BwxGddNuQQ3ymBfuk7KtiaJwv7
         LE9wQ5UEUCUSAH2I39Ma7L+Vw6yhrE0KDU/97ZU1T+Ir6Ry0v4PFRqaDJ0nUejyoMvVr
         PtReS2jMp8CUh8EuQouQwvJxXc00W4MtIFIG1ao16gdkOm+7vSvx96hy3QrLiPFZ3FFT
         KSB5fc1eRstCBpGkarCGixXMbu3Ac/1Eyo4y32eHACCPKKcEPq5iCwvNslXqHDqlPS7a
         ifyw==
X-Gm-Message-State: AOAM53271ui58Uhg0lRoZllzZJg03WWU7kqVbRJz40hVzP1ln7pIervN
        jWt0vtq0g1vnLlwJyh3tRq70MNaUJgynNissY73Zds95zJCTmRAgXue05yCtmg6Ww3XRwHcxE7H
        Pp2nXJKgBYdgDwMHGdoELl3DR
X-Received: by 2002:a17:906:d54e:b0:6f6:3ea:8e7b with SMTP id cr14-20020a170906d54e00b006f603ea8e7bmr20495920ejc.292.1654502017680;
        Mon, 06 Jun 2022 00:53:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuLlvNrnpO67bvA3yDD6EgX1SApqQwL5qjFJPSpxYtyIiXQNA1ZhGKHu0cFcsiEyjLisdIrg==
X-Received: by 2002:a17:906:d54e:b0:6f6:3ea:8e7b with SMTP id cr14-20020a170906d54e00b006f603ea8e7bmr20495905ejc.292.1654502017355;
        Mon, 06 Jun 2022 00:53:37 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id k16-20020a1709061c1000b00705cdfec71esm5882371ejg.7.2022.06.06.00.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 00:53:36 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4C41C4055A7; Mon,  6 Jun 2022 09:53:32 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ia64: fix sparse warnings with cmpxchg() & xchg()
In-Reply-To: <20220605160738.79736-1-luc.vanoostenryck@gmail.com>
References: <87h7547k8c.fsf@toke.dk>
 <20220605160738.79736-1-luc.vanoostenryck@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 06 Jun 2022 09:53:32 +0200
Message-ID: <871qw2xm6b.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luc Van Oostenryck <luc.vanoostenryck@gmail.com> writes:

> On IA64, new sparse's warnings where issued after fixing
> some __rcu annotations in kernel/bpf/.
>
> These new warnings are false positives and appear on IA64 because
> on this architecture, the macros for cmpxchg() and xchg() make
> casts that ignore sparse annotations.
>
> This patch contains the minimal patch to fix this issue:
> adding a missing cast and some missing '__force'.
>
> Link: https://lore.kernel.org/r/20220601120013.bq5a3ynbkc3hngm5@mail
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Ah, thank you for taking care of this! :)

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

