Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAF049530A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377290AbiATRRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243820AbiATRRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:17:53 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C28DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 09:17:53 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id f8so5848246pgf.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 09:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=itZYF4kduuCL3uDid4zM5TZEvDzEk2ZCskJ3bklCOp8=;
        b=LKQ1zDYPDSWBGKGDo5GbHqAT8/+6t5G4H9Hz1UVPjamPQwy02QR1wuW6kIfsDlwyCM
         v7mOFDIWlCYwZPOC1ZqNR0bWw8LodLvLtYvOYlf+6BoH8PhhphhBkEe3gWBLr/dEKCit
         V8WX+LyzL4QTyqRFung+MQyjN0pk3u5UDB6TOlRY5u5Qa3HRyFqxMt3tKrON4H89hdxa
         1acQHvFM9+x4pqH9Uhb0PElMOn9VIoviZ9/bjI83cm5vGoLiNGyTc/LtaZqh29O9w6P6
         l0C1OGAZo3KoGqAI7syomsn+3yYD1onNOI/5EZdT0r4x4Q6fxh1eJeBoGR1JhLpRd/4U
         dIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=itZYF4kduuCL3uDid4zM5TZEvDzEk2ZCskJ3bklCOp8=;
        b=sReT216nYQgVdutBAmMY9ry6ovTZxKWrX4ok7EScpovCuzc6Bt+KtzwLWhSZgcMlU8
         /51ES7v2Q6ynCBLeJvVDAN/31Xob599/E2+1qEWM0B4W6GZ7G1Ya4w++mhAgEZsqSQ7+
         H1O10UfzU+Byr7HXvqKEB8shrxZQnm2W2BvBH5bxlBfiSvzvT3ObrYtz/mlu7rQn48fo
         vLCjjCPs1aT6nQwPulhEayG8hizv7D4zhmeifh3xRDechwYQQq3lOUhuigVt0E/qfEjp
         O0tHyaTwzRZjc5UzsGk1M+pDuAFdvEYqGgTQ4pQSY0l5hGRLM5x43oTxDTUyWyr2Asep
         TYbQ==
X-Gm-Message-State: AOAM532t5JlYXzUH20yI5d//sWwI9xI4Upvz/8fCe4heHn+huPtDpsKQ
        1CL61MEPG5i2oFTd9Cgvvbf8OC9am4d1Cw==
X-Google-Smtp-Source: ABdhPJyj42mj4cAQLPULixNY2Rpdnr2GBGyvBaRnFhn8RqingV51wqdRPT0NoQgEp+c2iFX2SwKusg==
X-Received: by 2002:aa7:8642:0:b0:4be:9b5a:d4db with SMTP id a2-20020aa78642000000b004be9b5ad4dbmr36804055pfo.64.1642699072713;
        Thu, 20 Jan 2022 09:17:52 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id u20sm3967354pfi.96.2022.01.20.09.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 09:17:52 -0800 (PST)
Date:   Thu, 20 Jan 2022 17:17:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        aleksandar.qemu.devel@gmail.com, alexandru.elisei@arm.com,
        anup.patel@wdc.com, aou@eecs.berkeley.edu, atish.patra@wdc.com,
        borntraeger@linux.ibm.com, bp@alien8.de, catalin.marinas@arm.com,
        chenhuacai@kernel.org, dave.hansen@linux.intel.com,
        frankja@linux.ibm.com, frederic@kernel.org, gor@linux.ibm.com,
        hca@linux.ibm.com, james.morse@arm.com, jmattson@google.com,
        joro@8bytes.org, luto@kernel.org, maz@kernel.org, mingo@redhat.com,
        mpe@ellerman.id.au, nsaenzju@redhat.com, palmer@dabbelt.com,
        paulmck@kernel.org, paul.walmsley@sifive.com, peterz@infradead.org,
        suzuki.poulose@arm.com, svens@linux.ibm.com, tglx@linutronix.de,
        tsbogend@alpha.franken.de, vkuznets@redhat.com,
        wanpengli@tencent.com, will@kernel.org
Subject: Re: [PATCH v2 4/7] kvm/mips: rework guest entry logic
Message-ID: <YemZPAgGsbiUokZk@google.com>
References: <20220119105854.3160683-1-mark.rutland@arm.com>
 <20220119105854.3160683-5-mark.rutland@arm.com>
 <20220120164455.GA15464@C02TD0UTHF1T.local>
 <a2b628b4-907c-4e15-df91-18c0db099228@redhat.com>
 <20220120171551.GB15464@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120171551.GB15464@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022, Mark Rutland wrote:
> Longer-term MIPS should move to a loop like everyone else has:
> 
> 	for (;;) {
> 		status = kvm_mips_enter_exit_vcpu();
> 
> 		if (handle_exit(status))
> 			break;
> 		
> 		...
> 	}
> 
> ... which is far easier to manage.

I don't suppose we can just remove MIPS "support"?  And PPC while we're at it?  :-D
