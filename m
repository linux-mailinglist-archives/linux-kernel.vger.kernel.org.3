Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C810E5234C0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239953AbiEKNyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244216AbiEKNyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:54:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FED434B95
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652277245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yiBquU9ycutIGVQ+Lafkd382/sLMfLYmiUneQuM6tdo=;
        b=d1KUMZBHHjdjA3axPTvahqtKQA6qxLvSs9pCFpW16TNcqrgTTTlguClzu1Lv3DhUEcIOPZ
        nvUajJGjD350Bo2irqRvr8eGHo6IoOS2c9zbKld2ConKKUHdnB3+6BPYn1UOgfASmEDqG9
        bqyTztglUdaY362MMzu4q3znBR4+Ib4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-d3z9dT_rMFCYASVnl7vJag-1; Wed, 11 May 2022 09:54:04 -0400
X-MC-Unique: d3z9dT_rMFCYASVnl7vJag-1
Received: by mail-ej1-f71.google.com with SMTP id nb10-20020a1709071c8a00b006e8f89863ceso1187588ejc.18
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yiBquU9ycutIGVQ+Lafkd382/sLMfLYmiUneQuM6tdo=;
        b=SRWYqN6L0kKKhRXktBKIDRGWNDzh/lAQYphr4nxXQLhpyAK0RM0SkZAiLZci8oEAxF
         tUKR0zouJa/ZH4Fn7R4zVPyhFX0xZCnmbkWcxrM5tYIm7OSplNxoTtQPd7ExGx/G41Tk
         eiuJ39KQhsq1Po1/n5uGNqyTLSjgIecBjkUoOkoYL6C92REB7kJSkuXYEzrLD0T2+5/y
         WI76cd3nTPExfcmK2x8ZK6Q4m/Ssa3wIG2yw7WXG0wZIBTR807BXN5cyH8rn2EDbbw3g
         n+n2LPreTNhX++kGumGwDlVwfMrGJP/FZxQsvJGBfuW3RJ6NjFEqvZmTQlaHtSW+tNoQ
         CMFQ==
X-Gm-Message-State: AOAM533gx1JTq3NZ8nCK/vqqKM0pGALW1fJgqWHpI2tQj1jLgSGlg38m
        OlBg5bbKy4kWfXl/QT3bIF7Yp6my2/7vJvy3EWGYDJrRzDZ6tlP12PpSzgvw2uwFNouyiBMhxE+
        jepY8+whOMzHQzKKJrtueK6xA
X-Received: by 2002:a05:6402:2078:b0:428:1071:d9b2 with SMTP id bd24-20020a056402207800b004281071d9b2mr29798745edb.302.1652277242271;
        Wed, 11 May 2022 06:54:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFNGrXEYB8j4ZnML/DgDYxNGSibD3TzmU9JnkCNgK/+z8cTd0gXxgIxWKyb7My6aTgwuk7Gw==
X-Received: by 2002:a05:6402:2078:b0:428:1071:d9b2 with SMTP id bd24-20020a056402207800b004281071d9b2mr29798734edb.302.1652277242095;
        Wed, 11 May 2022 06:54:02 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id b22-20020a170906491600b006f3ef214e2esm1034769ejq.148.2022.05.11.06.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 06:54:01 -0700 (PDT)
Message-ID: <7d9d5f72-21ed-070e-c063-1cd7ae6671ec@redhat.com>
Date:   Wed, 11 May 2022 15:53:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 1/2] KVM: LAPIC: Disarm LAPIC timer includes pending
 timer around TSC deadline switch
Content-Language: en-US
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1652236710-36524-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <1652236710-36524-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/22 04:38, Wanpeng Li wrote:
> 
> Fixes: 4427593258 (KVM: x86: thoroughly disarm LAPIC timer around TSC deadline switch)
> Signed-off-by: Wanpeng Li<wanpengli@tencent.com>
> ---

Please write a testcase for this.

Paolo

