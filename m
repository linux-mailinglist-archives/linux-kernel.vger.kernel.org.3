Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8FA596D50
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239052AbiHQLGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 07:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbiHQLGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 07:06:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E547FFBA
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660734391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=koEJ17EkMuiifFe0GL3YnkhTBSC0XSjMKGEWlVUiBCE=;
        b=YE6emKxCZyUeKUKQ7jnEcMlpDXqRASLlY1QLWlCaJrkPrwRbPGZ1xSyKQz1FWGQ1NOmP6C
        lfEM1OAN6Z+ofUVaqAKs0LDDV/5Y1VZaCvtyVTcAygqLYHDleufZhND/Y+fEmndX9JsYjH
        bUFxIx8/uJbF1C7ievBwHYoS1AbTMSE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-232-_6YLZkRhMHOMK6G_f_vLKg-1; Wed, 17 Aug 2022 07:05:32 -0400
X-MC-Unique: _6YLZkRhMHOMK6G_f_vLKg-1
Received: by mail-ed1-f69.google.com with SMTP id s21-20020a056402521500b00440e91f30easo8462290edd.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=koEJ17EkMuiifFe0GL3YnkhTBSC0XSjMKGEWlVUiBCE=;
        b=aJ3AXalMbUBYYJ3jHh/2taVH0aEnM7mHWloO5nLlmNo9mDUe9gdQwvkB4EF0f2jjW3
         dILhgFyFvvfKUdekS9Z6dwDBozCMmAoTRR/pLSZwU527FhQF0j8sORYQdRzHyCvXE0+0
         WthHJilfGk2WlunSlrLEP387TzPSCd/RVDvBURjWIA/Wge7sTr3QkNTxy+bX+tNdCg/B
         A5NHl3MXnoDTYuWcmBrE5YfuNGn2I6Rqb2Dh3IO9R5vxMDnRw7u6iL1DXsMlmyticCim
         Se821h2o5oItrAaS0L/AopTWYZBm8tiL0yijj397G6fgb6kaNBa92qtpdOVaE2ZI54Tv
         zfwg==
X-Gm-Message-State: ACgBeo2YzKVFcsdkXJzml6twKP22d/tchv+2vDkbf8VCwbLgmFGjOpH0
        2nYVOuOYh2G5YlycR00VJm+Anl/SkC9rfuqtJu5mr54/LLfOfzkKDISwVJoJRDzZTxyKR91DKp1
        jUkkMYUZO9Sm5DPSCPzkVc2eM
X-Received: by 2002:a17:907:628c:b0:6ee:70cf:d59 with SMTP id nd12-20020a170907628c00b006ee70cf0d59mr16435802ejc.402.1660734331597;
        Wed, 17 Aug 2022 04:05:31 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5c8IFWZuGKlWCZOMVH9BjRaCUp6BdLO0jPPTy5lPcG61T3LTdm8B7qsGHnDEfueWrBGv3r8Q==
X-Received: by 2002:a17:907:628c:b0:6ee:70cf:d59 with SMTP id nd12-20020a170907628c00b006ee70cf0d59mr16435788ejc.402.1660734331415;
        Wed, 17 Aug 2022 04:05:31 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id ky5-20020a170907778500b00738467f743dsm4322541ejc.5.2022.08.17.04.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 04:05:30 -0700 (PDT)
Message-ID: <8e675228-b140-08c8-e8d4-2bd0d1121911@redhat.com>
Date:   Wed, 17 Aug 2022 13:05:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] KVM: Rename KVM_PRIVATE_MEM_SLOTS to
 KVM_INTERNAL_MEM_SLOTS
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220816125322.1110439-1-chao.p.peng@linux.intel.com>
 <20220816125322.1110439-2-chao.p.peng@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220816125322.1110439-2-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/22 14:53, Chao Peng wrote:
>   
>   #define KVM_MAX_VCPUS		16
>   /* memory slots that does not exposed to userspace */
> -#define KVM_PRIVATE_MEM_SLOTS	0
> +#define KVM_INTERNAL_MEM_SLOTS	0
>   

This line can be removed altogether.

Paolo

