Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD7C4E689C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 19:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352621AbiCXSZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 14:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiCXSZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 14:25:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DAF4A7764
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648146248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BJQ4AT1Ezm+OM7uYaunbGJGeDkJH79IfuLeFbVntUZE=;
        b=hVXDoHuciM9hXwo098qRONk02GsADAE8x6Tc1IuhiEYm8btWjINZZ7RXYnq5M498grgvd8
        WI8j/tiSx51rtfGNRRi82klZ82zW0uIqrVKFEBgFL4KkOfXPCKaw0SSXqgfYNJ1bSqbID2
        c+vhlKdkZSu88lznh8DJGW8C+1bU5t0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-422-zf1b6xATMfmmrEwuC2HooQ-1; Thu, 24 Mar 2022 14:24:06 -0400
X-MC-Unique: zf1b6xATMfmmrEwuC2HooQ-1
Received: by mail-wr1-f69.google.com with SMTP id z1-20020adfec81000000b001f1f7e7ec99so1958165wrn.17
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BJQ4AT1Ezm+OM7uYaunbGJGeDkJH79IfuLeFbVntUZE=;
        b=6s5OMRIk8htVu2K5T4qAd+8KW4U0v3medn5knYw8c2h8wuCcZOAZDmks3eegk7cTb3
         gaP69I9+C34IRkppZZmLFmNPLzqDha1Mr2ZNYnJBtCMqwlawpKpdW7hW4P05ifVxh39q
         xbvu5HjCWX90GMYzrjVPWgGOye0/sYiFLvJjCeSar4Mghcq58QZw6je17yOzy3gz1BUa
         qe4vjgO4Jt+GBzz4GFmHKGkCBlF+Q1/+Iu4H9kNNs5dC/gxgM6xC+/BxlOaP/2MtFLEs
         uVSFTSc81ucm3DmaTAFo4pusdUqB7gaLpertDucl8IWV4vj4felvIy7s1x78gzmsag/J
         dZcA==
X-Gm-Message-State: AOAM5327X3POGy40MA1Y+/LzsKjtYGiGeHmYLce8mWd7szI7i4+luvYv
        iS1pzOHLlfSvHFylnMOEdoshghKIieoxGHzNdBoNuEY3JLzp45u5wzFuEbOibfu3AgCzh8ZnRH/
        mtOUD0txzEZrr0OwD431Ez3Dl
X-Received: by 2002:a5d:4a0f:0:b0:1ed:d377:288a with SMTP id m15-20020a5d4a0f000000b001edd377288amr5542426wrq.3.1648146244540;
        Thu, 24 Mar 2022 11:24:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCPjRof9hOHTEcZ0tmLN1KWm/QUI1HGnj1f9hRLaiYWf0GX/hWiVdh77H1Ueh5vTfpR0fp+g==
X-Received: by 2002:a5d:4a0f:0:b0:1ed:d377:288a with SMTP id m15-20020a5d4a0f000000b001edd377288amr5542414wrq.3.1648146244333;
        Thu, 24 Mar 2022 11:24:04 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id z12-20020a5d4d0c000000b002057d6f7053sm3210955wrt.47.2022.03.24.11.24.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 11:24:03 -0700 (PDT)
Message-ID: <848bba1a-66f2-a3eb-510e-9322b729c8ec@redhat.com>
Date:   Thu, 24 Mar 2022 19:24:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 3/6] KVM: x86: nSVM: support PAUSE filtering when L0
 doesn't intercept PAUSE
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jim Mattson <jmattson@google.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wanpeng Li <wanpengli@tencent.com>
References: <20220322174050.241850-1-mlevitsk@redhat.com>
 <20220322174050.241850-4-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220322174050.241850-4-mlevitsk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/22 18:40, Maxim Levitsky wrote:
> Allow L1 to use PAUSE filtering if L0 doesn't use it.
> 
> Signed-off-by: Maxim Levitsky<mlevitsk@redhat.com>

Can you enlarge the commit message to explain the logic in 
nested_vmcb02_prepare_control?

Thanks,

Paolo

