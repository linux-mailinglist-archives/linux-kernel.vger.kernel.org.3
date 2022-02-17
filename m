Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A184BA45D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242495AbiBQP3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:29:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242461AbiBQP3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:29:19 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CAA2B103D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:29:05 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id c4so5234032pfl.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v3PZTYCZtAw5vPUwO4Uq8xdQCoMiI5xDnErBT8ttkLk=;
        b=TQ/dBtFIbcKmtvuPVxScTZxmhDqYbufa0jGlagp21kUsyB694jxg6WQagCAVZI2TGA
         zYGAIOV6IMgCd7GpMgwmdJsNLdAdXnrqQ504wI5Xee6OQEXgWHSPw27oPTetGLUufW5u
         vA2H7uVuXzXa73Z/0Nu4L3t0WiwWK83IhTIlEYTr0fEMD1QcAI/ZrhboHIPgFu4Z7l3E
         mMG1dp6dmGSIpVmVblZ04mY03B3jVmxL2t3cHDftbPce7XqBNVGDlYSoN3S+GY3i3iFw
         u//+gKc1/PM/sw1darf0UguaEhe38/P/NEGw1EzPUiTOLSW532B32OOjDjDmv7cODxPl
         A7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v3PZTYCZtAw5vPUwO4Uq8xdQCoMiI5xDnErBT8ttkLk=;
        b=S3jqZ0ORB5lmcecUKMFpCRdUVbjcuoDtO+WheTLM48vSVejFCkcqllFComnn8R7K36
         Aj3iuS4Y83GThMTdykBqSgVefnRuH2JXbqVZpdT/rkHBGAt+1bymzTtrAfkI1HKRj8Dd
         7sZd5iMo4EezwX2JgcHpdsjpqu0jplhh+X14DmXh3RNHDlJ5mgBAzypGZzCbguYubKms
         Db3jw8BeplxGcrCCMqQSpLfHWYoG1PSS2z0HCAcgxc8agzzGCwGfTKJ3Wknw73fBR2HG
         keFI9jGs+0dzQ+TKVta3EUMiETOXyK6rPaLT6q79mJy2SNG2MgMjnIfo0nDa8smW2vdq
         GHrg==
X-Gm-Message-State: AOAM533C9Crf1eWsujuCoCyYsi+T6WByyVTTLlWkKp7kauFqXokY8l4s
        9usNoEqZKUSRSmYlA5zUZC2cvA==
X-Google-Smtp-Source: ABdhPJzG+UEGctEp/dAIN2I+Mwgu+h36V/CqR71UBm6VYavQqzvx+n2gMw4CaFEs2mvncaNmZJnJlg==
X-Received: by 2002:a63:6441:0:b0:372:c9d1:ea90 with SMTP id y62-20020a636441000000b00372c9d1ea90mr2850128pgb.249.1645111744467;
        Thu, 17 Feb 2022 07:29:04 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id q94sm2070913pja.27.2022.02.17.07.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 07:29:03 -0800 (PST)
Date:   Thu, 17 Feb 2022 15:29:00 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@intel.com, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, pbonzini@redhat.com, sdeep@vmware.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCHv2 00/29] TDX Guest: TDX core support
Message-ID: <Yg5pvO1nXo6qQP9C@google.com>
References: <20220210003033.e57c2925b69bab5cfabf7292@intel.com>
 <YgOoId+vyd1VhIqQ@zn.tnic>
 <20220210004831.03dea501738bee060003d040@intel.com>
 <YgOr6tZjsooJgAi9@zn.tnic>
 <YgPwwI2+16/7jQC4@google.com>
 <YgQR/S67Fqz9PanR@zn.tnic>
 <YgQfGKXOemtXnFau@google.com>
 <YgQl6Uk9rONgv9+F@zn.tnic>
 <20220216154809.w27bt6oi3ql4ssip@black.fi.intel.com>
 <Yg5nh1RknPRwIrb8@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yg5nh1RknPRwIrb8@zn.tnic>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022, Borislav Petkov wrote:
> On Wed, Feb 16, 2022 at 06:48:09PM +0300, Kirill A. Shutemov wrote:
> > So, any conclusion?
> 
> Lemme type the whole thing here again so that we have it all summed up
> in one place - I think we all agree by now:
> 
> - confidential computing guest stuff: arch/x86/coco/{sev,tdx}
> - generic host virtualization stuff: arch/x86/virt/
> - coco host stuff: arch/x86/virt/vmx/{tdx,vmx}.c and arch/x86/virt/svm/sev*.c

LGTM

> New stuff goes to the new paths - i.e., TDX guest, host, etc - old stuff
> - AMD SEV/SNP will get moved gradually so that development doesn't get
> disrupted. Or we can do a flag day, right before -rc1 or so, and move it
> all so in one go. We'll see.

FWIW, I don't think there's much existing SEV host virtualization stuff that can
be moved without first extracting and decoupling it from KVM, which will be
non-trivial.  I do want to do that some day, but it definitely shouldn't hold up
merging SNP.
