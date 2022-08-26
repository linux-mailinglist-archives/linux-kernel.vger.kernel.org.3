Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51715A2589
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241505AbiHZKKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiHZKKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:10:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0C5A2DA8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661508649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DcTpl0Wy35V0dtimCv1uimSCVwCZkiyLvJPUjMOsYiE=;
        b=Okl574a8QLObi89QkGXck7uRXY8BZR+/W87duOXW8s/MPgW+YYoFZCaadB4Nyh2V9kteTp
        j4Fnkfht5qMnYmODRxO3BpCwNwFmuDPXSgGDKrgIt6U8xq2X4XBcMltageQyjohyg6P9xs
        yCqMzDxMyWUO7KWTAEY1u/HDYcxH+qY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-552-zS88279eP5m0IInJqloeCQ-1; Fri, 26 Aug 2022 06:10:48 -0400
X-MC-Unique: zS88279eP5m0IInJqloeCQ-1
Received: by mail-ej1-f69.google.com with SMTP id hb37-20020a170907162500b0073d7f7fbbbfso441617ejc.17
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=DcTpl0Wy35V0dtimCv1uimSCVwCZkiyLvJPUjMOsYiE=;
        b=QegTaiBmy6RuGIIjFQrbQ4RDskWb+TEYf9LVbAH6EiRU5AKTyHiR+uz+qO3SWacOHq
         56bPKOlB4qfaf5qaP3pZezHK+4vohmybd+x7JoQl0bsKgSy+48TId94H6SbsS0ISXWiA
         r4khawmGg1JV3I9X5IHNMw2IvWuroAOYG/HXaQrYePXUmVxdcEPcATdXZ9rX4NwDRDuC
         7QAQp82To7QLG0Se3/OBGMF0OXc0wSBfLA2NObnrtRnIhSyn4+F5A/d9SFRLbtv/c1kN
         /NVsNr+2iVQDV0GnEvkz5kpf5v+46BGcfx6MqBHEfdgNRkrAnJEYdiQMBY2rCxYS7Efb
         +dlg==
X-Gm-Message-State: ACgBeo3aL4/16y1rAmDCM37J3uYos4OXwP3+uDXnnbIXSwTQrXk7KI2k
        Hvzj1vgfbOnMFW5VLtQ+OycidxE2i0iK0qg1tTzkzGo3DOrww67ZcjeMcrL08MSEB3r5DI8pBRr
        r4P3WspbBnimnVkZMSOW7LEut
X-Received: by 2002:a05:6402:34d5:b0:446:cc39:2d38 with SMTP id w21-20020a05640234d500b00446cc392d38mr6209433edc.171.1661508647032;
        Fri, 26 Aug 2022 03:10:47 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7AwF3pGOxIX7OudqHD1JgPw34+XYwXsbIADeU85iqiVXbE8gx715QbeCQFyUk9JInkyzzBeA==
X-Received: by 2002:a05:6402:34d5:b0:446:cc39:2d38 with SMTP id w21-20020a05640234d500b00446cc392d38mr6209421edc.171.1661508646833;
        Fri, 26 Aug 2022 03:10:46 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id bq10-20020a170906d0ca00b00734b2169222sm687776ejb.186.2022.08.26.03.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 03:10:46 -0700 (PDT)
Message-ID: <b28c0e56-59b3-1152-56ef-490887cb0d87@redhat.com>
Date:   Fri, 26 Aug 2022 12:10:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] KVM: x86: Expose Predictive Store Forwarding Disable
Content-Language: en-US
To:     Jim Mattson <jmattson@google.com>
Cc:     Babu Moger <babu.moger@amd.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        seanjc@google.com, vkuznets@redhat.com, wanpengli@tencent.com,
        joro@8bytes.org, tony.luck@intel.com, peterz@infradead.org,
        kyung.min.park@intel.com, wei.huang2@amd.com, jgross@suse.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <163244601049.30292.5855870305350227855.stgit@bmoger-ubuntu>
 <CALMp9eSKcwChbc=cgYpdrTCtt49S1uuRdYoe83yph3tXGN6a2Q@mail.gmail.com>
 <e3718025-682d-469c-eac9-b4995e91dc11@redhat.com>
 <CALMp9eQCcy-MjB8Su+654XyL3zfR876tdh4QHUjvB7EiNjCU9A@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CALMp9eQCcy-MjB8Su+654XyL3zfR876tdh4QHUjvB7EiNjCU9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/22 19:16, Jim Mattson wrote:
>> Borislav asked to not show psfd in /proc/cpuinfo, because Linux had
>> decided not to control PSF separately; instead it just piggybacked
>> on SSBD which should disable PSF as well.  Honestly I disagree but
>> it's not my area of maintenance.
> 
> Do we expose PSFD in KVM for the use of another popular guest OS?

Yes, that was the purpose of this patch and we expose it via 
MSR_IA32_SPEC_CTRL (the only validation that KVM does is in 
kvm_spec_ctrl_test_value(), so it does not need to know more about the 
specific bits).

Paolo

