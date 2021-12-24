Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C4747EDA7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 10:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352179AbhLXJQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 04:16:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54572 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352165AbhLXJQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 04:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640337382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AqoPJrJcAr/gH8piYBPPRkJ8mfLyPeVx2tGfF9+DYtA=;
        b=Q1B0+dphEaeqEszLbkjy8nR2Fu/BuVoiZv5ZU4rarIi5c9gyqrsBUW5z5YMmstJVputggE
        rn+F8y+s3JonjZVkp22kGiLkjv02/gSxugZXJzXJv9UyCeWseZ8lTIo+3FIXujQXCaBOqm
        z1tDZl+WP2+OMTLyNR/ldcC6z9wfcWs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-EaZLgSAQP1GFp2Xi15RhzQ-1; Fri, 24 Dec 2021 04:16:21 -0500
X-MC-Unique: EaZLgSAQP1GFp2Xi15RhzQ-1
Received: by mail-wm1-f69.google.com with SMTP id b75-20020a1c804e000000b0034569bde713so5977122wmd.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 01:16:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AqoPJrJcAr/gH8piYBPPRkJ8mfLyPeVx2tGfF9+DYtA=;
        b=wXyPbT3x9he13fdDOQj9afFvUPe/FsW5srfUxR4sWj/dxv1EzhFSrw+8sEJ6lEfHq9
         mpW0lixPyDMG9IK3SS+cUz/fuWzc0yDBhfuCw9obPTe2gNl9Q3Xn+UFIUjqL2U0L0yLM
         4HBRoRSwvpxlMdwbJ0cTYhGhImBIum5zRCYFPTNzp0nRSeSL2SGUaQr5cGNenyfNhV3A
         PjwpGnMTDBzWSB6JCrQVqxjhC53SouaU/ZsXCYqPYZDbY+XNMbeROXCVw0xT0ncxIk/k
         i4kI1U3EQ/98qg2i7l4Rsl7fWzDV6VZamM/pVzQkz/szBlDCwed8gaq5E8As/9fnm94J
         ZF8A==
X-Gm-Message-State: AOAM532hZ9jwbGcothSSkAPTZTyQ03fAiSbe669LA7KdknaLRVyiwbs7
        rN0wDrRX5g4CZoBZbZycL1Gier/rJ5N3GmUS/7SvDRiywuuW++5uakmyvSIZe8Q+Sfnwz0JyQQF
        S3YJmDNoRABTezIy9+Jb1dLF4
X-Received: by 2002:a5d:4312:: with SMTP id h18mr4122365wrq.626.1640337379855;
        Fri, 24 Dec 2021 01:16:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRoAQGEeiBeeCNngWlB4kcFaHHyvricxK6b5MMG92tq+6uRW+fs97P40kTSRC723dEiJ2Hgw==
X-Received: by 2002:a5d:4312:: with SMTP id h18mr4122345wrq.626.1640337379694;
        Fri, 24 Dec 2021 01:16:19 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id p5sm7110486wrd.13.2021.12.24.01.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Dec 2021 01:16:19 -0800 (PST)
Message-ID: <f67229d5-c92e-5953-5f77-1dee2c7643b3@redhat.com>
Date:   Fri, 24 Dec 2021 10:16:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 03/26] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        sdeep@vmware.com, seanjc@google.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-4-kirill.shutemov@linux.intel.com>
 <YcIm8fngUsVulUoI@zn.tnic>
 <20211223165548.xr57h25g4diixivp@black.fi.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211223165548.xr57h25g4diixivp@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/21 17:55, Kirill A. Shutemov wrote:
> 	In a TDX based VM, since the VMM is an untrusted entity, an intermediary
> 	layer -- TDX module -- facilitates secure communication between the host
> 	and the guest. TDX module is loaded like a firmware into a special CPU
> 	mode called SEAM. TDX guests communicate with the TDX module using the
> 	TDCALL instruction.
> 
> Does it look fine?

Looks good but I wouldn't say "like a firmware".  The TDX module is the 
"real" hypervisor, it's not firmware.

Paolo

