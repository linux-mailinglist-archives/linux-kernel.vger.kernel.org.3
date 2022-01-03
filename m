Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A52483407
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 16:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbiACPPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 10:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiACPPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 10:15:01 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E1BC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 07:15:01 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id h15so42852570ljh.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 07:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vxve14nl+oiAzGV/G3PcxuvZbVcx2XFd4xcjhqQP5m4=;
        b=kUcokzzQVOQqV/w+VY8TrmrW6e7FJ0JFAswvzA0BFIkp+29qqTsbY1hVMhIuHmqlCv
         w1u/injXfJMakQBVVwPe6PUoOfMy7WrU1vK9J5vPybKyv3JV7R8iSQwmEc6lr0RuR2f+
         xuBXJi/R9oKg9O06WJy5GAGjc7TvDL1ejLTN4JWxccYmZefJOLM/Mm3NKHAPcPAQXDUP
         FB/qwZVsOGAR0DM7bY8JOGJs+DNVrZiqFHToJsTunMIDHmAStlYnujPDPdnIgNFY79Vm
         KR72A1BSOTJZdfJsXO+rGhtsqy/vW23kDRWHx9e9upv1M04SiOvDyWyfnGIfkyedh5xG
         NMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vxve14nl+oiAzGV/G3PcxuvZbVcx2XFd4xcjhqQP5m4=;
        b=Sup8nYRx3lYSe8L8pr+/FY7A35Tv7FOBNuWT4rqqwsskELuyzrXTwG8IKNKBVWHipl
         HiqvB/+9YEcYdK/KGwn0l4a7v4xQgZZDBEk/L+9aq0ZxHtDJ291j+VwBjXalL6PH78cF
         23nir8WXi8K7i662z8BGKEFciInh/in2ien/b4OR2GAfKjDD1MAnVdoxT/UXa2DbY5BU
         pWSU1BN0ZAGE1H+O/C1N/BQg4i94NLkmEfRTdILcV56kuncVwXga2c4kSikJJ8L8B2xK
         TvhCO65mNiZAb5MXTMdaVyuiSopV+QB8q37aH6trjUtZJ3ACj4jSD0w5scagg0yhJzpt
         HqkQ==
X-Gm-Message-State: AOAM530PfZR8cKdSFfrbMjyy9PmnZnPD1Clj2afOwIdCi14HG2oOQCeM
        B6s6AEVC92Pd6xsbrZK+Z/qNXA==
X-Google-Smtp-Source: ABdhPJwasg+6i24oU6Iw1yonk4tW5Y99zX650ujWtOlbqt0d+7pEiwDNqi7WAl+/HFFVf1yqxZdhmA==
X-Received: by 2002:a05:651c:891:: with SMTP id d17mr26163121ljq.502.1641222898910;
        Mon, 03 Jan 2022 07:14:58 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y1sm3654246lfd.278.2022.01.03.07.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 07:14:58 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 795DE103686; Mon,  3 Jan 2022 18:15:16 +0300 (+03)
Date:   Mon, 3 Jan 2022 18:15:16 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/26] x86/tdx: Make pages shared in ioremap()
Message-ID: <20220103151516.pfcz2pap5l7r2rzv@box.shutemov.name>
References: <87c288d6-9bf8-5a94-a628-1e0aaa7de690@amd.com>
 <20211223171530.v73posbqizb5l3md@black.fi.intel.com>
 <f61b591b-a06c-bc29-4b9b-a5d46111fe4e@intel.com>
 <YcTTt4LXKfDO+9u3@zn.tnic>
 <20211223205604.g44kez5d7iedatfo@box.shutemov.name>
 <YcTlhp1PUfrMOelI@zn.tnic>
 <20211224110300.7zj3nc5nbbv7jobp@black.fi.intel.com>
 <33914dc1-37e8-f0bb-6468-71c3b5f4169d@amd.com>
 <20220103141705.6hqflhwykqmtfim6@black.fi.intel.com>
 <YdMIWAT42el4D6wJ@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdMIWAT42el4D6wJ@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 03:29:44PM +0100, Borislav Petkov wrote:
> On Mon, Jan 03, 2022 at 05:17:05PM +0300, Kirill A. Shutemov wrote:
> > I'm not sure how to unwind this dependency hell. Any clues?
> 
> Forward-declaration maybe?
> 
> I.e., something like
> 
> struct task_struct;
> 
> at the top of arch/x86/include/asm/switch_to.h, for example...

Forward-declaration only works if you refer the struct/union by pointer,
not value.

And pgprot_t is not always a struct and when it is a struct it is
anonymous.

See "git grep 'typedef.*pgprot_t;'".

-- 
 Kirill A. Shutemov
