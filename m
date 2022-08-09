Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E4758D90C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 14:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243357AbiHIM7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 08:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241979AbiHIM7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 08:59:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08FD915A14
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 05:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660049957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KBecFOB/Bo1T/mXz5cBJlBh2olRYpsGjGSOjfij+x2Q=;
        b=ThQcu0VZyiCzKArVlUkNAUlUPwnoQoCPOUJUkwVAem9NewjJ7erAhdz9MPZEsbxQC6QRmn
        f/dxFEZCEeepvs+mSL6MgVcDwZ6wV8bF3MxqT+YDwrkCKNapAoFnZfmZkSZsD0reN82JZs
        SziPbNyVpIf0I8soEgjZqP3SxtutTDA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-zTNIa3aANCq0yYzfrRbAvQ-1; Tue, 09 Aug 2022 08:59:16 -0400
X-MC-Unique: zTNIa3aANCq0yYzfrRbAvQ-1
Received: by mail-ed1-f69.google.com with SMTP id q18-20020a056402519200b0043dd2ff50feso7176733edd.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 05:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=KBecFOB/Bo1T/mXz5cBJlBh2olRYpsGjGSOjfij+x2Q=;
        b=tf8bqsLIDVf2rQ4Dwrf1pg3Yptdr0BxeQLifKc/m74ujD1wFRRhuOCBRf0n255xUz4
         VAjNg2xlcpu/nO/v7vVg+C5zrXyYH35E+/bhNThWnV6XtuzaAEta6zk7sHs7mY72ttda
         tam3aJZtv8YxFbjZnSce8RnwUMUt3QAUrHNaT2lDtQOuB1axorxZbP89Rqvr74gsF34h
         qD2p9IMTP7k2/hK2rVk+XV7Y2AQNpIVFhuVr6oFLOUSJVZLD8g5kXEynurQoMpWGV55z
         1b5W+v6d2D8Fu27PNN4FePXkwOC6KO4kdjAlvIcNdqS24gxVYRNd7PPFpK88C5ontq8B
         jEJg==
X-Gm-Message-State: ACgBeo3d3D3vWBUTlD3/elK/4hUuaua6kSbGD9xOVyTRdTCnB/L4Kldm
        YNenRJJWx1qrBMPOQV55LRq45b7d1B34L1mgMiek+64Pf1ob+lwUPSCaBzsrKxZMxcNKG5mhUZE
        kcnYb3vn+8SbYKyyd8oQwEDJ6
X-Received: by 2002:a05:6402:1907:b0:43d:e91d:e544 with SMTP id e7-20020a056402190700b0043de91de544mr22039364edz.107.1660049954832;
        Tue, 09 Aug 2022 05:59:14 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4wUw7Vpw3aM/6l7uafzRR30NIAU8ZjnuvsDJ5chqhOQYeDofcjkztMJTSa6IdTzmsVZH8dFg==
X-Received: by 2002:a05:6402:1907:b0:43d:e91d:e544 with SMTP id e7-20020a056402190700b0043de91de544mr22039348edz.107.1660049954607;
        Tue, 09 Aug 2022 05:59:14 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id b2-20020a1709063ca200b0073095b4b758sm1090273ejh.218.2022.08.09.05.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 05:59:13 -0700 (PDT)
Message-ID: <43e258cc-71ac-bde4-d1f8-9eb9519928d3@redhat.com>
Date:   Tue, 9 Aug 2022 14:59:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 2/2] KVM: x86/xen: Stop Xen timer before changing IRQ
Content-Language: en-US
To:     David Woodhouse <dwmw2@infradead.org>,
        Coleman Dietsch <dietschc@csp.edu>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Pavel Skripkin <paskripkin@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        stable@vger.kernel.org,
        syzbot+e54f930ed78eb0f85281@syzkaller.appspotmail.com
References: <20220808190607.323899-2-dietschc@csp.edu>
 <20220808190607.323899-3-dietschc@csp.edu>
 <c648744c096588d30771a22efa6d65c31fffd06c.camel@infradead.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <c648744c096588d30771a22efa6d65c31fffd06c.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/22 11:22, David Woodhouse wrote:
> On Mon, 2022-08-08 at 14:06 -0500, Coleman Dietsch wrote:
>> Stop Xen timer (if it's running) prior to changing the IRQ vector and
>> potentially (re)starting the timer. Changing the IRQ vector while the
>> timer is still running can result in KVM injecting a garbage event, e.g.
>> vm_xen_inject_timer_irqs() could see a non-zero xen.timer_pending from
>> a previous timer but inject the new xen.timer_virq.
> 
> Hm, wasn't that already addressed in the first patch I saw, which just
> called kvm_xen_stop_timer() unconditionally before (possibly) setting
> it up again?

Which patch is that?

Paolo

