Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A744EE9D7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 10:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244368AbiDAIkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 04:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiDAIkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 04:40:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E09F03153F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 01:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648802327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jJgRufLo0Q+2TohvSo0V+grK8YPgHhb39pNmOaDe4X4=;
        b=i1dUZuYYAqVSCyGEIlEn33F1du42TT2bGzKH2NGRzYwclcIFEsFMj6+/OA/RfSo3GacZbk
        Im/lbOygJA9YGMJkucVlIOJ7ZZMbmTKSg9/ME8lL+5DcmmatUDaHm+q724dVVKvN42Q/Bz
        ODM7agVwqiAfBpwzgCqXBWgP9r/UNOQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-bLyWL1dmM3iy4GRNK6i1pQ-1; Fri, 01 Apr 2022 04:38:46 -0400
X-MC-Unique: bLyWL1dmM3iy4GRNK6i1pQ-1
Received: by mail-wm1-f71.google.com with SMTP id t2-20020a7bc3c2000000b003528fe59cb9so887292wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 01:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jJgRufLo0Q+2TohvSo0V+grK8YPgHhb39pNmOaDe4X4=;
        b=jSfoKNb6oDlw+rAC3NwmntoJbnA+EILYvHaoMhEzJq1TMZR4VllO3tR6XrLbOa3Jm6
         9XUsGAzmDxQmufj5JzTEoAzgDQmB+IgIwOiB1SnfxVYL53ix5HoWby1cDfd6IW9PJjMd
         g0WGNjxmjKrK4nv3wb9xHsDo4AD7+qpxWumSPuJD/wB4Ifht746AjpPj3HNPWm2I16O7
         9mXsmFyNdRyu2ml86CUgnRtWwnd0c3692Re7Je1eIzVPVFzSYKRgEX/jp60ksGyHntJZ
         WrawQCYFFRop3JSwOKTpPr9KMcU+WUTEnY+/UmlP3s3d+OJ9PJgUgjuueb38wYzu+7Ny
         DtKg==
X-Gm-Message-State: AOAM5314hWurIFogwA4SXpwHdZzSamytngqHo9MwldlMdLLxmRiY7rPR
        TI9KL71AJfxDIdrlJKC8fLBzZbTUc02BK9ZhS4YNiXgw/2aCnk3HMfuYde1D5fOlir5Fchhezac
        bPnOLnK99utQz1oIBmbRVuzbx
X-Received: by 2002:a05:600c:20a:b0:38c:95bf:3289 with SMTP id 10-20020a05600c020a00b0038c95bf3289mr7846158wmi.134.1648802324816;
        Fri, 01 Apr 2022 01:38:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZv6I0FVV+CMTD5Ii7q1vvCTUGk/jp2epbACrhoZA7VwhBmVuCWWnjWAfbB1yDcm4RVzFGLA==
X-Received: by 2002:a05:600c:20a:b0:38c:95bf:3289 with SMTP id 10-20020a05600c020a00b0038c95bf3289mr7846142wmi.134.1648802324598;
        Fri, 01 Apr 2022 01:38:44 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l126-20020a1c2584000000b00387d4f35651sm9408352wml.10.2022.04.01.01.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 01:38:44 -0700 (PDT)
Message-ID: <19fa075a-cc5a-4127-389a-bab7812d7af3@redhat.com>
Date:   Fri, 1 Apr 2022 10:38:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] efi: Allow to enable EFI runtime services by default
 on RT
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Brian Masney <bmasney@redhat.com>, Al Stone <ahs3@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
References: <20220331151654.184433-1-javierm@redhat.com>
 <CAMj1kXHgyjB_BVzXx+CK0tBuJpZ3h=8XKus7nWiyovECjVQ0gw@mail.gmail.com>
 <YkYA/Wpqa/PMczkp@lx-t490>
 <CAFOAJEeKNy0HW82W6HV_49d5sc5L0m62QDfY9qA1906_ZzGRYg@mail.gmail.com>
 <Ykas9iX/D3WURx8T@linutronix.de>
 <78a0360d-1a27-5280-10bf-d27d1d306fa5@redhat.com>
 <CAMj1kXGEBtcdD+3MFK5gO6vCw8dg=ruTthdWGVUu1eJpgZXf8Q@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMj1kXGEBtcdD+3MFK5gO6vCw8dg=ruTthdWGVUu1eJpgZXf8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ard,

On 4/1/22 10:34, Ard Biesheuvel wrote:
> On Fri, 1 Apr 2022 at 10:33, Javier Martinez Canillas
> <javierm@redhat.com> wrote:

[snip]

>>
>>         if (!efi_enabled(EFI_RUNTIME_SERVICES))
>>                 efi.runtime_supported_mask = 0;
>> +       else if (IS_ENABLED(CONFIG_PREEMPT_RT))
>> +               pr_warn("EFI runtime services can lead to high latencies on Real-Time kernels\n");
>>
>>         if (!efi_enabled(EFI_BOOT))
>>                 return 0;
>>
> 
> 
> I don't think we need another warning.
> 
> The kernel log already tells you whether or not EFI runtime services
> are enabled.
> 

I'm fine with this too. As mentioned to Ahmed I was torn on this, since I
understand the ask for the warning but also don't want to pollute the log.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

