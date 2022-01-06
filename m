Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42AD4868DF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242012AbiAFRlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242165AbiAFRlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:41:44 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4456FC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 09:41:44 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id s15so3128890pfk.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 09:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6gPF6LIvuNsMGdMGQX3Xt0jGn5hRDQzTXJU/Apy4X9o=;
        b=ZXCj1o4HApJ/G+dSeBxr7o9+V1a1WB/D6yDpeMM1dZjJKJIsE7AUy+AGCgAKPNS3kt
         GSJ1bXgIehhEN49gNObI53pqK8MoVCeskaArovAEomnqYvaI88uGaPDfgYQ09Icf7QDU
         ZRBXxfoD5GNPVEtDjJigsKlI/90jIv0i2IkTNzfOIICO6JPavH+h6X8MZho0x5c1y3b3
         AtexljqK/mngSsltvRxemmDQ5nLfkhAT9cRnZlCMX/7uzUoWVuoT6NAaUwwxjdjOqJou
         5dAWCXU17wFbVbFiMMLX0eN9n4oQwCvxNKneGv/juASqztGmcExb/MBYJmOoToW5s7uD
         slKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6gPF6LIvuNsMGdMGQX3Xt0jGn5hRDQzTXJU/Apy4X9o=;
        b=I3N0FozFItFtoRMpIpknh2W9WOqLrGDSImOmc0ezTZckRFaeYEEirnhO5SXtsdzmv1
         74fRKUjB5SKuRjAZOZflBL8ZsWlt14gq3yjOTdfz6BuqFNqAuPYlQ7Rn8+Cy5e/55fu7
         dyg6SA03UuEUxLN80dpH4/HJJFwp+FSTiAktGwMO4PJ3bud5JuSNX3+1bBk+0VceHCNM
         fKIumsfkHaq1eOzyXfLm/kUKjYGFu+z46vgDRzmqeqgegP3F8axg/pujloxwqDQMQz7Z
         S2soEXmDzd17lzKdqfpwg+Yc0+RG2NEi7FUVAGchNnyKmynfhYC2gCLI0I0+k7oEcD0I
         lLYw==
X-Gm-Message-State: AOAM532xk6fOwDQKCUgHrJYe1ykLLIAL7mAEsk5+FXaQMvdPT9Wjfwad
        /m8VaMPVD7iRf/W9iEmv/CZAGw==
X-Google-Smtp-Source: ABdhPJxN8AU6A7B/z1GX0JgAJYOn+uaycfZURuK9IT+76YgEIPNdaUDq06/lOci9WrxYfwhbw+ByDA==
X-Received: by 2002:aa7:97a1:0:b0:4bc:f921:5ae4 with SMTP id d1-20020aa797a1000000b004bcf9215ae4mr2323740pfq.78.1641490903635;
        Thu, 06 Jan 2022 09:41:43 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id k6sm3412416pff.106.2022.01.06.09.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 09:41:43 -0800 (PST)
Date:   Thu, 6 Jan 2022 17:41:39 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2 5/5] KVM: SVM: allow AVIC to co-exist with a nested
 guest running
Message-ID: <Ydcp01dTJZKi0yuz@google.com>
References: <20211213104634.199141-1-mlevitsk@redhat.com>
 <20211213104634.199141-6-mlevitsk@redhat.com>
 <YdYUD22otUIF3fqR@google.com>
 <21d662162bfa7a5ba9ba2833cc607828b36480ca.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d662162bfa7a5ba9ba2833cc607828b36480ca.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022, Maxim Levitsky wrote:
> Also I recently found that we have KVM_X86_OP and KVM_X86_OP_NULL which are the
> same thing - another thing for refactoring, so I prefer to refactor this
> in one patch series.

I have a mostly-complete patch series that removes KVM_X86_OP_NULL, will get it
finished and posted after I get through my review backlog.
