Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A083748482D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbiADS6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbiADS6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:58:14 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F048C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 10:58:14 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 8so33011435pfo.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 10:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=axl0zitI3Sg0+7afMtdoHSwJ4SSyjtKwYA8uyUIl7eY=;
        b=Zzkz8OA6YPii0rzndeTnldcofz+TH8pyBChvpIG57PjzyCB5Yx8fGj7rgfXWl5RciV
         mbj258BttrVYhqiAnu5imaMhY5mpQZ8mHvgynMXp6zXy3krz8jtKfxAx9LVXCYNeakH0
         vA4lpuid2T/CY1JvBl+zm83uTEHEsG9rFnAtj3MxUjgm2GyzqQNqrYDYmwI/7s3RcMj9
         TsALeolijp/1qAdrya7SyZh2IHtC1TGpvnEewIztORyTK3Kh0teXGPgT4WkiWvsCJ3I9
         Mkkc1CM60dDl8XCkwjom1wV6Luz6J+16ZHlER87KoVJSDkYoCG9ZZqUVbxBJmhZ6nQoC
         R1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=axl0zitI3Sg0+7afMtdoHSwJ4SSyjtKwYA8uyUIl7eY=;
        b=GpeKVuoPFGFMDDagiIZ3cnvBYWzU958rzH0cg2gxlQ+TCO1JnByo/Qm2zoYMnAVg0R
         AnFIrkxbDAkyD19bob9LzO7+6952/EfYdD9yjA48ZiM6NjnspXGhnn6JoTJviUii27EL
         l7FAu6B96y9NEt7xopO2s2V044LuOt6WnEQSr16YFBBrKKRqc6P+1acp9bWSvluJQPDZ
         cSD7B3rbFltBvb4ASdHE6a3MFHU7kEfW416RU94uQku9OIxI7TrqKqSON1TrjBYg/87U
         2DDzoCf6cYZZ07jZ2+pAtPrrKr/S3MmH1o7vnF5pCOdqD6w4eg8p48LtW4kDONi1EmwG
         FU/A==
X-Gm-Message-State: AOAM532zdToAS8GQdiGrOOzjnWmcfEQM6jjLTToR6QAK6G1g4mzOsAmF
        mBAx+ZlK9Gz3WE79DC71NXltNVfimpQlvA==
X-Google-Smtp-Source: ABdhPJwvR+kVa4AEEEWFabGelN15sAtob49/MiZw8AlotNXTLtqzIVXazOlvxrUN547b0AWgTa7rFQ==
X-Received: by 2002:a62:6501:0:b0:4bc:9bc9:5231 with SMTP id z1-20020a626501000000b004bc9bc95231mr12720144pfb.0.1641322693454;
        Tue, 04 Jan 2022 10:58:13 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id t126sm35042663pgc.61.2022.01.04.10.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 10:58:12 -0800 (PST)
Date:   Tue, 4 Jan 2022 18:58:09 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jing Liu <jing2.liu@intel.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, corbet@lwn.net, shuah@kernel.org,
        jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, guang.zeng@intel.com,
        wei.w.wang@intel.com, yang.zhong@intel.com
Subject: Re: [PATCH v3 22/22] kvm: x86: Disable interception for IA32_XFD on
 demand
Message-ID: <YdSYwR5NDfJ6LIrU@google.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
 <20211222124052.644626-23-jing2.liu@intel.com>
 <Ycu0KVq9PfuygKKx@google.com>
 <ff29b36a-ffe4-8ba9-2856-cf96fcf33c0d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff29b36a-ffe4-8ba9-2856-cf96fcf33c0d@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022, Paolo Bonzini wrote:
> On 12/29/21 02:04, Sean Christopherson wrote:
> > 
> > Speaking of nested, interception of #NM in vmx_update_exception_bitmap() is wrong
> > with respect to nested guests.  Until XFD is supported for L2, which I didn't see
> > in this series, #NM should not be intercepted while L2 is running.
> 
> Why wouldn't L2 support XFD, since there are no new VMCS bits?  As long as
> L0 knows what to do with XFD and XFD_ERR, it will do the right thing no
> matter if L1 or L2 is running.

I incorrectly assumed there was something L0 needed to do in order to support
nested XFD.
