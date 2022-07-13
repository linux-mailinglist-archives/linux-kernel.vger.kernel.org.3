Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA7C572DEA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbiGMGJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiGMGJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:09:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEA80C7482
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657692596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rycGqxN/Gg4LcgOpWK/Qy+DWH4iGydCM0L3/eUzUN/k=;
        b=PU5vk46Mh3Ne75EJXg4gH+flQ/JQ+Ha8bRQrIs+yKbgZJHExfdraGcij089pxLKEX8+rI0
        jbucv5V/U/AWK3v6ZSCfFDfI0NRLhDdnoMJHDb2I4KGGHYmYoZU0EkeJOAWsQOuWbeFB3H
        cPDnBZvrK2oHrTe0h6d4kqsv8NfeyLg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-vxM0isrQMDaYfDLiEpFEzQ-1; Wed, 13 Jul 2022 02:09:54 -0400
X-MC-Unique: vxM0isrQMDaYfDLiEpFEzQ-1
Received: by mail-ed1-f71.google.com with SMTP id n8-20020a05640205c800b00434fb0c150cso7593247edx.19
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rycGqxN/Gg4LcgOpWK/Qy+DWH4iGydCM0L3/eUzUN/k=;
        b=vA3gygk9XQWBjuycgQYFwZ10kYfMwPgxDXrSRIvQ9bl/JMfaityJWO/wxbaeSzJ54K
         BQLS1pXbVFIqIIDEoi+zkI5Lkk8oemEn1PwNX9liWqGbPTT1qoOmnqSJHYwxK2rUZLjg
         mpCjQ9pjklX4BivQi4J0TwaIhUHFHVOCJgATL1utcGJWigVDdR+gv11w+KNociDlHEmR
         w85k59vSUfNn4nC4n4A2uerWbk4muLzPNFgyt4y1LKYaTJCNjZ4HokPqEqLZCVPZTV5M
         w7jes9BeiCjFLPg9MllbH+RsFjWAdssNzGGf/orw5+0zQ/p7FCPe0aKEGgRmSifZJQSd
         RayA==
X-Gm-Message-State: AJIora/EvzwCOf+Axt0W3HF5EUOhxKt7bkIptgRUKlvoE6c+om4I6dfN
        XGFl1c59kzlwxI5Fsxx8s8jxU6oxzq5gdh0xQXFC6xjS6J8ekd7f/cx4xfcMw4fTEOxScANE1vL
        RNQko18+H/D8GpSt4ho1unFoz
X-Received: by 2002:a17:906:8475:b0:72b:12c7:effe with SMTP id hx21-20020a170906847500b0072b12c7effemr1745559ejc.337.1657692593451;
        Tue, 12 Jul 2022 23:09:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ul7GlkRy7udbTX/Vs/6L1EBonL23POvjBUN7N0DNV2mt6ZMpvJB3ZgWypD78EGz8spBLMv7w==
X-Received: by 2002:a17:906:8475:b0:72b:12c7:effe with SMTP id hx21-20020a170906847500b0072b12c7effemr1745544ejc.337.1657692593275;
        Tue, 12 Jul 2022 23:09:53 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id ky18-20020a170907779200b00715a02874acsm4516224ejc.35.2022.07.12.23.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 23:09:52 -0700 (PDT)
Message-ID: <c2a3fc9c-82e7-939c-b183-6dd57ccf9444@redhat.com>
Date:   Wed, 13 Jul 2022 08:09:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: linux-next: manual merge of the kvm tree with Linus' tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>, KVM <kvm@vger.kernel.org>
Cc:     Borislav Petkov <bp@suse.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Like Xu <likexu@tencent.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Luwei Kang <luwei.kang@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20220713160238.3bfcdb26@canb.auug.org.au>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220713160238.3bfcdb26@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/22 08:02, Stephen Rothwell wrote:
> I didn't know if the new includes needed to be prefixed with "../"
> as well ... I though it was better safe than sorry.

If it compiles, it's perfect. :)

Thanks, I'll check it out and report to Linus the reason for the conflict.

Paolo

> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

