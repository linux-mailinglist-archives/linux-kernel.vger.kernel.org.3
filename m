Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804524D680D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 18:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350291AbiCKRv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346660AbiCKRv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:51:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B10DA1D3DA9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647021051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bJ1LnGLCik9cz8Oj4VtAQ6a1oLh3vtDtBJWR6jjMB14=;
        b=gUMtaek7cKV88crwNgmUVdWo3ZiFoK2rXsn9HoVOe1BJtB5AbwcALT8ypEt3S5Zv6kNpWT
        Pisdk+rB5fQ7arkXxQoq2BqQa/uh6XLQ62uioAKTnzBLj2D5NvEPHrTCxgBQQ8twxZ5d92
        L2fcS0zNOfAcSwCqV6zGDyquN145PSQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-xiKu-LALPt6ibAPJpAsnjw-1; Fri, 11 Mar 2022 12:50:50 -0500
X-MC-Unique: xiKu-LALPt6ibAPJpAsnjw-1
Received: by mail-wm1-f69.google.com with SMTP id 3-20020a05600c230300b00384e15ceae4so5779204wmo.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:50:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bJ1LnGLCik9cz8Oj4VtAQ6a1oLh3vtDtBJWR6jjMB14=;
        b=rYBdfgpHPT5zK2r10711U0QHJs87yo1CmxPzmqUrecQft6ozEUTEdpv46IoJ1KrODh
         QGKNjXrddbQavlXRmuryRx7qu7Ir6hn1dSlR7i8ZwL7WiOI8elew9feMxDf38AJIlCaa
         3Q10PS5ZDhD2RRI2i9yWSxULBYOdBNgD6gUNaK2vz0AN5g8R/xXPf13O3hqqGA5l5TQp
         WoUJYvvxtELDwWV0Ekgpvd/YgelA/P7L9nR9MLkxz3eJyOMZZ8a2JmdeUbZ1r5geeCOw
         dSkZ1c9jURfOFAdnd0kmvCxqalw5UxXmx+oT9MhJQLdjifBgDlxVzp4jAK5n/9GTPjQQ
         mYWQ==
X-Gm-Message-State: AOAM53226BVJcD9tjgDeJcCtG7sh2sN2ygftyIq7FZE940rdPQC3VtAf
        fr0PKZ3nFvWZcMDXuMTH+ekRGFzO4AkUb974iDaBI3WVD5qroxwxGRsTCWgdwlkhCuV3Mk6gny8
        GxWSrNo+bIT6bg3Pik2ijUYMF
X-Received: by 2002:a7b:cb84:0:b0:382:a9b9:2339 with SMTP id m4-20020a7bcb84000000b00382a9b92339mr16518527wmi.91.1647021049556;
        Fri, 11 Mar 2022 09:50:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwV5rxQ6cU+cq4n86NWbEwiPpgQ80vOui2/XR7C8tqHuAzrSRz6o/8F0wDPUSmKCBUPsc5QIQ==
X-Received: by 2002:a7b:cb84:0:b0:382:a9b9:2339 with SMTP id m4-20020a7bcb84000000b00382a9b92339mr16518514wmi.91.1647021049333;
        Fri, 11 Mar 2022 09:50:49 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id t184-20020a1c46c1000000b003814de297fcsm10868608wma.16.2022.03.11.09.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 09:50:48 -0800 (PST)
Message-ID: <ace6ecbf-9723-ac04-0c07-5e1c83f14afb@redhat.com>
Date:   Fri, 11 Mar 2022 18:50:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 21/30] KVM: x86/mmu: Zap invalidated roots via
 asynchronous worker
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Hildenbrand <david@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Mingwei Zhang <mizhang@google.com>
References: <20220303193842.370645-1-pbonzini@redhat.com>
 <20220303193842.370645-22-pbonzini@redhat.com> <YiExLB3O2byI4Xdu@google.com>
 <YiEz3D18wEn8lcEq@google.com>
 <eeac12f0-0a18-8c63-1987-494a2032fa9d@redhat.com>
 <YiI4AmYkm2oiuiio@google.com>
 <8b8c28cf-cf54-f889-be7d-afc9f5430ecd@redhat.com>
 <YiKwFznqqiB9VRyn@google.com>
 <20497464-0606-7ea5-89b8-8f5cd56a1a68@redhat.com>
 <YifKoCZAmymIxDTQ@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YifKoCZAmymIxDTQ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/22 22:29, Sean Christopherson wrote:
>>>> Good, for the record these are the commit messages I have:
>> I'm seeing some hangs in ~50% of installation jobs, both Windows and Linux.
>> I have not yet tried to reproduce outside the automated tests, or to bisect,
>> but I'll try to push at least the first part of the series for 5.18.
> Out of curiosity, what was the bug?  I see this got pushed to kvm/next.
> 

Of course it was in another, "harmless" patch that was in front of it. :)

Paolo

