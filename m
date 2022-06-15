Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53E454CB6E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344165AbiFOOeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242061AbiFOOen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:34:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD74238DBB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655303681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1qFcB0jtREv2LSbjUnEo7CUMp+7jcR89dNDcelz1/n8=;
        b=I90W4TWM4KSFRIY/R5uorjKQ4kGO4+A1fKPw7H/gzc8uUUy0+kHdPZM7w1ew/m8EC5vzw1
        QXATeuBBN9FoSTjZbNh/NQFkRqACKi69fbxJgEKFHS/KB04h+xKVTmJSK+wHPGvAqGIwyx
        DZHZ22dUAH18u6ltlbAwsKGcpdtNsMQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-213-9nbB7noOOLu1dnLNcAyZJg-1; Wed, 15 Jun 2022 10:34:39 -0400
X-MC-Unique: 9nbB7noOOLu1dnLNcAyZJg-1
Received: by mail-wm1-f71.google.com with SMTP id v125-20020a1cac83000000b0039c832fbd02so1346846wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1qFcB0jtREv2LSbjUnEo7CUMp+7jcR89dNDcelz1/n8=;
        b=zU8bu+4bTo9qdyvKvZugcaB/n5pGvf776+P36lRhYyHCo4JJ9ijm6/zNJ/eKx4p7Ye
         1ZK5LkVp8Bcw2PFn+6LGgaWvSUDN6Dp3H3NNH7WZrTS/PMtpbM8NFrMkznhTTZAArv5k
         5AwODOw2EiHk+8DrZ1yPIOTfIu2i0NY5b/HKR9IhoXmG9tgDWgCkihIdkuiz/QIIrNy5
         ZuuuShiZp03w8aY3B+P2K5ilnuWIVkVvnL3/LhPAL/JrdWk8WbXDtSBfDIDiMeSQrk+7
         od7HIIeJvi773EscEJj77dp1Mvt7HW9dxzDkLPmdkDgM5I3cIJyH8UPpF0d4PsIsistc
         rAkQ==
X-Gm-Message-State: AJIora8q72jAP2Mh03hdGKAEcjPsd9hSBPm2T38qL731FNhGd7wrDF96
        wmhOIPCaDKl38udiB3NeX4XU/Ukfyac9KHmFoYgInyiu6c5GgDKH5ZVd7WfVH3yyLa+u9YzDFr1
        OiHZkab+PIZUv3ElydN8w0H/X
X-Received: by 2002:adf:f20d:0:b0:214:c726:ce76 with SMTP id p13-20020adff20d000000b00214c726ce76mr79968wro.649.1655303678313;
        Wed, 15 Jun 2022 07:34:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tUMvForWLyCawk+9itwr+aDYGoB6Bp6vpvHSLSKcc3iHBmumDaBz8phScWGeKHLqmIpSYnvA==
X-Received: by 2002:adf:f20d:0:b0:214:c726:ce76 with SMTP id p13-20020adff20d000000b00214c726ce76mr79940wro.649.1655303677938;
        Wed, 15 Jun 2022 07:34:37 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id j11-20020a05600c190b00b0039c5328ad92sm3266197wmq.41.2022.06.15.07.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 07:34:37 -0700 (PDT)
Message-ID: <7355b23b-d1ca-0050-4acf-e4a9a15adffa@redhat.com>
Date:   Wed, 15 Jun 2022 16:34:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 5/8] KVM: x86/mmu: Use separate namespaces for guest
 PTEs and shadow PTEs
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
References: <20220614233328.3896033-1-seanjc@google.com>
 <20220614233328.3896033-6-seanjc@google.com>
 <090e701d-6893-ea25-1237-233ff3dd01ee@redhat.com>
 <YqnsAIKxQniAsb1d@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YqnsAIKxQniAsb1d@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 16:26, Sean Christopherson wrote:
>> +		 * For example, a 4-byte PDE consumes bits 31:22 and an 8-byte PDE
>> +		 * consumes bits 29:21.  Each guest PD must be expanded into four
>> +		 * shadow PDs, one for each value of bits 31:30, and the PDPEs
>> +		 * will use the four quadrants in round-robin fashion.
> It's not round-robin, that would imply KVM rotates through each quadrant on its
> own.  FWIW, I like David's comment from his patch that simplifies this mess in a
> similar way.
> 
> https://lore.kernel.org/all/20220516232138.1783324-5-dmatlack@google.com

Yeah, by round-robin I meant that the 512 entries will look like q=0 q=1 
q=2 q=3 q=0 q=1 etc.

I'll incorporate David's comment, minus the last paragraph.

Paolo

