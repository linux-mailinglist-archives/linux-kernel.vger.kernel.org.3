Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1944C519DDA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 13:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348692AbiEDLXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 07:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbiEDLXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 07:23:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B5662A270
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 04:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651663194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lXMVJx+7jkqkO46ktvyPIT140OLmxQYNMIQN5pPJqZw=;
        b=SCYjalymi6XRXSaP1h/RlDovvtF9qAjCF0lzM0b5t9JasFluZbrZw9oO+oaKU2UHSbvPv2
        LwDSf6GNhO8CXK9Joynrr5M17UPtkXWLzP+OU/yc1WDnvj8Uw0Xg2p1sIQ3pWCmtSMNqtq
        0zhL7LZsKPdm5X1N2kzQbKD5q1RgqpQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-EFN7_W9jPNGba6QV2r9uAw-1; Wed, 04 May 2022 07:19:53 -0400
X-MC-Unique: EFN7_W9jPNGba6QV2r9uAw-1
Received: by mail-ej1-f71.google.com with SMTP id dt6-20020a170907728600b006f40b4ea280so647384ejc.21
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 04:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=lXMVJx+7jkqkO46ktvyPIT140OLmxQYNMIQN5pPJqZw=;
        b=cy8O5FeCkgJ1bCmwsj7sk4pqbtb3OPYhd17BJBvWfzNIQxDxN2HF+Bfa0si/cYNEuq
         KzW5jLInCGLmK40Kv2pkZjiTimRbFPAS0hjka/+ndEbRRTRhv4oQKv4aiUHQ2F46GOLO
         uWn+d+R1yKEsyEI5/qq6izZ1tVOBVtpvKTN34ONuThvDJ4j1oZUk693DgKw4UyTm1T/q
         gu0pMZxp+KnOrz0Or1HxDhL4Q2rf9wYWbqg+SXPEMgVnfstjlGJJS8OMz5oNIQ8ZzXGa
         McTWUUrsBSTEBLOfZGurWTog2WJLZroT9sehspdKFxy9NLhz8BpEqGWRW4cRmHxPs2/c
         NtcQ==
X-Gm-Message-State: AOAM5312lGHOFreOxFnCEIO8CNru4v1HT08GW9YJ37xxeqeeDJWO1ipI
        o7GA0dXxl2h1BEKFAuzCNLObAbHfz8u7FvkESwPDduHt977hEcZVs9zSnj+oAzzlgixtGrsO7xY
        FRejz88mKdYrqEqgZoArTy5Mh
X-Received: by 2002:a17:907:a41f:b0:6f3:e75c:5a77 with SMTP id sg31-20020a170907a41f00b006f3e75c5a77mr18660112ejc.70.1651663192531;
        Wed, 04 May 2022 04:19:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzceBB2USpyoo+pVY8+rlawNZ6Is0gHrKs+ouHJgFVE+uPIf9IviOi2f9nkD4t0M0FD3BfvVg==
X-Received: by 2002:a17:907:a41f:b0:6f3:e75c:5a77 with SMTP id sg31-20020a170907a41f00b006f3e75c5a77mr18660073ejc.70.1651663192175;
        Wed, 04 May 2022 04:19:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id l24-20020a056402029800b0042617ba63a7sm9104938edv.49.2022.05.04.04.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 04:19:50 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 08C323464C2; Wed,  4 May 2022 13:19:50 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, kpsingh@kernel.org,
        bigeasy@linutronix.de, imagedong@tencent.com, petrm@nvidia.com,
        memxor@gmail.com, arnd@arndb.de, weiyongjun1@huawei.com,
        shaozhengchao@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH bpf-next] bpf/xdp: Can't detach BPF XDP prog if not exist
In-Reply-To: <20220504035207.98221-1-shaozhengchao@huawei.com>
References: <20220504035207.98221-1-shaozhengchao@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 04 May 2022 13:19:49 +0200
Message-ID: <875ymlwnmy.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhengchao Shao <shaozhengchao@huawei.com> writes:

> if user sets nonexistent xdp_flags to detach xdp prog, kernel should
> return err and tell user that detach failed with detail info.
>
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

I kinda see your point, but this will change user-visible behaviour that
applications might be relying on, so I don't think we can make this
change at this stage. Why can't your application just query the link for
whether a program is attached?

-Toke

