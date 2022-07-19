Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A967D57A04E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbiGSOE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbiGSOEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:04:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AFFE5A8B4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658236562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJf6KlVfeRVngbSTejTWUt+U80/qXtsQhw+SCo2l0vo=;
        b=FVs/q7ym6ClhgvwRvSh13lunuWbzVtfnvw0dJp8YCMOqJ0NE58dE0ox0alg1GlYlZcPoAw
        pZRTcH6hT59qw719czJFkryJzM0H87kPY9A0e9OgSzIfm/5Kt/v+VbR5x/u3JvQiuRDo92
        lEHNkFA3uhbYpO8wmFJgfm3K4M4Mldc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-6_e_19uKNfSmxQSKwPm6Ww-1; Tue, 19 Jul 2022 09:16:00 -0400
X-MC-Unique: 6_e_19uKNfSmxQSKwPm6Ww-1
Received: by mail-ej1-f71.google.com with SMTP id gb37-20020a170907962500b0072b820af09dso3090623ejc.20
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rJf6KlVfeRVngbSTejTWUt+U80/qXtsQhw+SCo2l0vo=;
        b=nkNXjlCziKJ5d5Zf82SH1Dn8a13TL5ZEzcZx6Ms6KpOMWLTmthZuGrS0emsXo/gRnp
         a4DElAVuKKaL1HrOV4TI/r02GpPW96DcLVNVwb/Wtu6Mnt975oYFCZdwwm8tda2qIZ0h
         AdrHuK1MCFtHxpow5nBYFKN7OLAcqGTq5cLcb1CODLpz0pqlItGx2kGFVa+6BA7NfSlF
         C5MNiA3+dlXPETUdf1s7gBepxW3OfLppqiXWiHSCEA4RzDavxjVGmAfN/os7s/rob0Yv
         +xFEHcq7+t5BIISiBEzmQJDy9vEWwQCWc35T/HNq/Wsf+xuw7YFCGKPqxuhh5NeAl9Tv
         Nz8A==
X-Gm-Message-State: AJIora+6/ozOf/mz5vAQOf5WsHyGVtZ+jWNysTwfy01UnIa7ZPIvdlYN
        NQRYCUnAndLGXLoweu2tyavuZDz9HWprQTkhsrxLUd00/sIgT+FOWf4KbYR+Qt6EJsy/loIxt/C
        Zvt8yzNm2lF565/7b5Ij2J4WS
X-Received: by 2002:a05:6402:270d:b0:43a:d1e8:460b with SMTP id y13-20020a056402270d00b0043ad1e8460bmr43187820edd.40.1658236559724;
        Tue, 19 Jul 2022 06:15:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uGqPI+l9SH5XhS0ZFNjLCgvpzsHv09ItYHQ1n2uS/3Rd5Po974l+ACfKMCt+snKacpJNYSfQ==
X-Received: by 2002:a05:6402:270d:b0:43a:d1e8:460b with SMTP id y13-20020a056402270d00b0043ad1e8460bmr43187799edd.40.1658236559548;
        Tue, 19 Jul 2022 06:15:59 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id j9-20020a17090623e900b0072f5fa11d19sm235975ejg.202.2022.07.19.06.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 06:15:59 -0700 (PDT)
Message-ID: <28992751-7de9-7900-ae78-be1a5d30c3c0@redhat.com>
Date:   Tue, 19 Jul 2022 15:15:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/1] tools headers UAPI: Sync linux/kvm.h with the kernel
 sources
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <YtQLDvQrBhJNl3n5@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YtQLDvQrBhJNl3n5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/22 15:13, Arnaldo Carvalho de Melo wrote:
> tldr; Just FYI, I'm carrying this on the perf tools tree.

Thanks, I'll add a sync patch myself to the KVM tree.  Do you have a 
script to do that?

Paolo

