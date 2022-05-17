Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940AF52AE52
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiEQWxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiEQWwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:52:55 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7A14F459
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:52:53 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id a19so513058pgw.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OWhG3qNg/5eexE1crBNvOipFCjBLP3/z9bYPvdK0Xxw=;
        b=fnN/DvFGJ4S3ggNNyN5o3rd3y77Dx9DNm4bOF+yHVmOoZS7i6nfjMCUF4X9DBpZxYd
         XuHPR9H3pIcmzmNbjAw3ppEGPbJMMD1c9GlGZAlOJOYNk5d769FXmJa3KunEriq2eXIW
         gssuRXaEqst3+WXdz5NiMVzWLvlHNCenbHb8S9DHg/nzHXKYFY7NlriVliFbsTZQG2oA
         xqJg+S06MJKmKptc/ITVIQW6pv/Aiz0bfAjP8S0wZ/mCzEVmobXNHGxkHnn5hyyNoHjo
         CEbdyk2Z0TyLR5nAiXf4wvk6D4nCOoCGityKQJcte7YfRTC6DkG6G/t1vcYenxABzFRA
         9PrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OWhG3qNg/5eexE1crBNvOipFCjBLP3/z9bYPvdK0Xxw=;
        b=FD9NSnUvLM8DMbTRUjhgSyKXqJhNZ7ALBmSdO/CKD0xpPYonxZ/Ea5u2UzHVvrBmCL
         ja08IT7dPH/4/8rhIo+5UpBis8cUY9qIuVetBa4DH3729L+BN+HkL406EV5j0r43CCGk
         Qi1IvReuW12hgMwEQ2iAFylCMSxhECA1R2VdZpefEanINWQ0OHImgQF/VFbRDtOFcm0/
         oNKbAZOvjWdWbJaM1MeXgnAII5p5nTn4DGwNPkqH9RmH6yXhEvCtwS1Mf8jXWFAICfkg
         l3weWaRFkTT4kKrYubeBQ4H/nm7SzTc0GaUV67NsSFucibq8BD8s3i0mlGNyxa5Ncwtj
         rbZg==
X-Gm-Message-State: AOAM533814kiUbG40ccG1btswRPa4HwpByhNLe7rPSo+qyjW3e9McOaf
        ZHEtf7TXeqrjreDglAthoyl5Cw==
X-Google-Smtp-Source: ABdhPJyizKDn01Z3nK2KyOrPiO1lbsfF2tvuKrM/43JMbGs3xC827t0VguJyVrqoCONQApzSp0k/Qg==
X-Received: by 2002:a63:5a13:0:b0:3c6:3d28:87e5 with SMTP id o19-20020a635a13000000b003c63d2887e5mr21807441pgb.452.1652827972596;
        Tue, 17 May 2022 15:52:52 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id w137-20020a627b8f000000b0050dc76281bbsm249334pfc.149.2022.05.17.15.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 15:52:52 -0700 (PDT)
Date:   Tue, 17 May 2022 22:52:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/tdx: Handle load_unaligned_zeropad() page-cross to a
 shared page
Message-ID: <YoQnQIfX8GuOgKqH@google.com>
References: <20220517153021.11116-1-kirill.shutemov@linux.intel.com>
 <e73cb19e-7dab-2fc1-b947-fac70fd607d2@intel.com>
 <20220517174042.v6s7wm3u5j2ebaoq@black.fi.intel.com>
 <c761e774-8014-6fa9-cf21-e7cd8f7aca54@intel.com>
 <20220517201710.ixbpsaga5jzvokvy@black.fi.intel.com>
 <083519ab-752f-9815-7741-22b3fcc03322@intel.com>
 <YoQkTtrMiU2bff9i@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoQkTtrMiU2bff9i@google.com>
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

On Tue, May 17, 2022, Sean Christopherson wrote:
> On Tue, May 17, 2022, Dave Hansen wrote:
> > On 5/17/22 13:17, Kirill A. Shutemov wrote:
> > >>> Given that we had to adjust IP in handle_mmio() anyway, do you still think
> > >>> "ve->instr_len = 0;" is wrong? I dislike ip_adjusted more.
> > >> Something is wrong about it.
> > >>
> > >> You could call it 've->instr_bytes_to_handle' or something. Then it
> > >> makes actual logical sense when you handle it to zero it out.  I just
> > >> want it to be more explicit when the upper levels need to do something.
> > >>
> > >> Does ve->instr_len==0 both when the TDX module isn't providing
> > >> instruction sizes *and* when no handling is necessary?  That seems like
> > >> an unfortunate logical multiplexing of 0.
> > > For EPT violation, ve->instr_len has *something* (not zero) that doesn't
> > > match the actual instruction size. I dig out that it is filled with data
> > > from VMREAD(0x440C), but I don't know where is the ultimate origin of the
> > > data.
> > 
> > The SDM has a breakdown:
> > 
> > 	27.2.5 Information for VM Exits Due to Instruction Execution
> > 
> > I didn't realize it came from VMREAD.  I guess I assumed it came from
> > some TDX module magic.  Silly me.
> > 
> > The SDM makes it sound like we should be more judicious about using
> > 've->instr_len' though.  "All VM exits other than those listed in the
> > above items leave this field undefined."  Looking over
> > virt_exception_kernel(), we've got five cases from CPU instructions that
> > cause unconditional VMEXITs:

Ideally, what the SDM says wouldn't matter at all.  The TDX module spec really
should be the authorative source in this case, but it just punts to the SDM:

  The 32-bit value that would have been saved into the VMCS as VM-exit instruction
  length if a legacy VM exit had occurred instead of the virtualization exception.

Even if the TDX spec wants to punt to the SDM, it would save a lot of headache and
SDM reading if it also said something to the effect of:

  The INSTRUCTION_LENGTH and INSTRUCTION_INFORMATION fields are valid for all
  #VEs injected by the Intel TDX Module.  The fields are undefined for #VEs
  injected by the CPU due to EPT Violations.
