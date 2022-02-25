Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB7C4C4247
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239505AbiBYK2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239373AbiBYK2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:28:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CEF6403C8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645784853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pcLo8HhUCSEqzQ84MhXy0mil81lymk7/0Pm/pFQBlcI=;
        b=Fgargy+4abgLRL7cgIsrhFft3hbVUmVVW0S2Dd8/MD7rmJmOoGN5oILsNCf5YUwHH/4c0/
        vBhvxOBDWq5DPiZ6notfO+ZVxJ/KO/xTnc7JZcvkfUcjHjA53vFimkQFdWSrE9r+24o+TM
        yx/oHUVlhslIGQvBmaLC1SThGrJAo6A=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-h2vWjvFXMqmHoKvuChewEQ-1; Fri, 25 Feb 2022 05:27:32 -0500
X-MC-Unique: h2vWjvFXMqmHoKvuChewEQ-1
Received: by mail-lf1-f72.google.com with SMTP id v24-20020a056512349800b0043f1c29459bso837982lfr.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:27:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pcLo8HhUCSEqzQ84MhXy0mil81lymk7/0Pm/pFQBlcI=;
        b=LupZ3Wudd6RrAJscZXoRGVYDlNzVQk3nroeZkbN7ibXdkNdlvNhOwjjs/l4+nBiEH7
         1YW8JV2QWoP7D5FqSvqbJTBmbbdV05zMH2+mZAv6jHpsUtOf7S5PZZOPa9q/cXyO90pE
         RwQr0Hq3vOKuUv169U2qdDGYa69vfmMcz9JLBqzYmQVQj+vfLaI8dMv8PLdA44Ah46gO
         aUIMN1KQZZ0cIpeucSWYAz/b5bLILDwpKtYr4BHOP2UKWXDfwwBRu4lIVvdUFkkq1KAo
         6IFd6kiSUts6HrlmOcW1Mz8dC2jpnO3JxyyoAtCfamRyUD5VXHeOezopy268uk7k1ngv
         8fLw==
X-Gm-Message-State: AOAM532UB00zT1OU4LqBg29Umwo7U3A3/PCcEbLck0V73kQuui7L3rwp
        JHJMlc2Mo+1YVd2FqhEIpsuiUyBdltNBv1ylQ3FjVcWzNGDyPElvuImuHttIg9z80/O3EPaEthl
        l5A/+uHngjUoWzQXso8v5Q04U5Pby0auNmArK0EI=
X-Received: by 2002:a05:6512:308b:b0:443:5f54:dcae with SMTP id z11-20020a056512308b00b004435f54dcaemr4846368lfd.79.1645784850337;
        Fri, 25 Feb 2022 02:27:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6MuhF+6LgSmAzEnwAwFmkG/DIt24tdoXVZYwMo+3YeU7eVOth2LXsJ+KD91+fuf1AW9YgqMKzzAi1acqvL5Q=
X-Received: by 2002:a05:6512:308b:b0:443:5f54:dcae with SMTP id
 z11-20020a056512308b00b004435f54dcaemr4846362lfd.79.1645784850156; Fri, 25
 Feb 2022 02:27:30 -0800 (PST)
MIME-Version: 1.0
References: <20220222141303.1392190-1-atomlin@redhat.com> <20220222141303.1392190-10-atomlin@redhat.com>
 <YhieKf9EcS3GQSXG@alley> <f9449aa6-be9d-9021-66e7-fb0272909ee7@csgroup.eu> <YhisWkgZCK8dz5fl@alley>
In-Reply-To: <YhisWkgZCK8dz5fl@alley>
From:   Aaron Tomlin <atomlin@redhat.com>
Date:   Fri, 25 Feb 2022 10:27:18 +0000
Message-ID: <CANfR36gsRw26C3M0hXGGK2w_05pC0rzkhg0-3Q+8tr_XxLiqiw@mail.gmail.com>
Subject: Re: [PATCH v8 09/13] module: Move kallsyms support into a separate file
To:     Petr Mladek <pmladek@suse.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
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

On Fri 2022-02-25 11:15 +0100, Petr Mladek wrote:
> rcu_dereference_sched() makes sparse happy. But lockdep complains
> because the _rcu pointer is not accessed under:
>
>     rcu_read_lock_sched();
>     rcu_read_unlock_sched();

Hi Petr,

>
> This is not the case here. Note that module_mutex does not
> disable preemtion.
>
> Now, the code is safe. The RCU access makes sure that "mod"
> can't be freed in the meantime:
>
>    + add_kallsyms() is called by the module loaded when the module
>      is being loaded. It could not get removed in parallel
>      by definition.
>
>    + module_kallsyms_on_each_symbol() takes module_mutex.
>      It means that the module could not get removed.

Indeed, which is why I did not use rcu_read_lock_sched() and
rcu_read_unlock_sched() with rcu_dereference_sched(). That being said, I
should have mentioned this in the commit message.

> IMHO, we have two possibilities here:
>
>    + Make sparse and lockdep happy by using rcu_dereference_sched()
>      and calling the code under rcu_read_lock_sched().
>
>    + Cast (struct mod_kallsyms *)mod->kallsyms when accessing
>      the value.

I prefer the first option.

> I do not have strong preference. I am fine with both.
>
> Anyway, such a fix should be done in a separate patch!

Agreed.


Kind regards,

-- 
Aaron Tomlin

