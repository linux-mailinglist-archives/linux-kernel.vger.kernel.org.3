Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3930C52482A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351560AbiELInF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351692AbiELIm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:42:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5AAF41320
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652344970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TL296SryyvFIzUKAgvAx0DbiXeRdrRfvIeuhT1ztCEc=;
        b=Y7/X+9KxonqUFDVXCsVfPVDsjyFP4vl6drQ1eXYnLdiGSS+/s5x8g1SARf/BW4iALTuLJS
        +I4NiP6A3D58cye1KRj4tSvV6SUh3rVFLOlNKxYUX8+vFCOmUPOwYgI2onGSPJVNa5KBT2
        PdwA3Vkl9FJ29+fvQ7z4pWa6SHk1fP8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-Of_QDZGKM3ih64jI1pM8kQ-1; Thu, 12 May 2022 04:42:49 -0400
X-MC-Unique: Of_QDZGKM3ih64jI1pM8kQ-1
Received: by mail-wr1-f71.google.com with SMTP id o11-20020adfca0b000000b0020adc114131so1795002wrh.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=TL296SryyvFIzUKAgvAx0DbiXeRdrRfvIeuhT1ztCEc=;
        b=OTtr3h2xz20LW8Pkuzd0FO5TauwLXlWF1dxpaADep1K6yCq3WnKy1eMnd64UVt/gMY
         /uX7ECM9gauImvySPr/jcrEUNvMNwCL6A/4379K/lCeAnEWTShsHuN2oA/DUlzQphEaB
         R4BJEOroao1yU58vfSkiLz3zmH/H405QH0eyqE7LzI0lP7WUol+aGEqK/YU0l2McVOnX
         mOgT8gYS5bQkBfXziJvx12IwySKr9u0KM4SqIONfFU58S0OOElSOGVWHhTVQHpFyizoV
         JWXM9gMyMZfp5MOuEMnlHByRzzp+9OFG7DWRKlo8HUvt6k2f7HYK+2Jk4n8ckm6yn1YO
         G1xQ==
X-Gm-Message-State: AOAM533AMO22U3yXiLmpTqcre1CXDkXaTIrqmMTcYP2bl63r6pVSWmxF
        /grJmp7lCld2F9vCth0Ko4PlvWKrxtw/pwe5nB8f7KFaW2WfSAyinjoz26bnXzfE/fXyGRNTYHy
        8RkkqT9+9Mze3+nTYpINjxUtc
X-Received: by 2002:a1c:2b86:0:b0:392:ae97:2fec with SMTP id r128-20020a1c2b86000000b00392ae972fecmr8712603wmr.165.1652344968570;
        Thu, 12 May 2022 01:42:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbQjWVKCg/mTM5M+UooSQiAqm2pFe5GDlwzn/9BE6+Xp7XBA0IvVggvyUtSDCdR3aT9tTh/g==
X-Received: by 2002:a1c:2b86:0:b0:392:ae97:2fec with SMTP id r128-20020a1c2b86000000b00392ae972fecmr8712585wmr.165.1652344968305;
        Thu, 12 May 2022 01:42:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id z1-20020a5d6541000000b0020ac8c19ecfsm3647938wrv.3.2022.05.12.01.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 01:42:47 -0700 (PDT)
Message-ID: <c26a28cc-9955-9724-3271-602c9bddf8a2@redhat.com>
Date:   Thu, 12 May 2022 10:42:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v8 2/7] crash: prototype change for
 crash_prepare_elf64_headers
Content-Language: en-US
To:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-3-eric.devolder@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220505184603.1548-3-eric.devolder@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.05.22 20:45, Eric DeVolder wrote:
> From within crash_prepare_elf64_headers() there is a need to
> reference the struct kimage hotplug members. As such, this
> change passes the struct kimage as a parameter to the
> crash_prepare_elf64_headers().

You should make it clearer that the hotplug members will be added by
successive patches.

> 
> This is preparation for later patch, no functionality change.
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> Acked-by: Baoquan He <bhe@redhat.com>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

