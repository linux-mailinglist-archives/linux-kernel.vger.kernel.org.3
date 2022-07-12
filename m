Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA565721CC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 19:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiGLRcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 13:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiGLRcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 13:32:03 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A073C5941
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 10:32:03 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id e16so8048415pfm.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 10:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Tipq/nj9MEYhYyki32K3Sq5jHiPmAdYbo2QRD/1w12M=;
        b=KoV5zunRtnk7CrQ7p+03Pg1oFW3K0LFhtQ3HRAOGrXlAYUZOFseawOuZHnYbBdi0EP
         fRpBjw9UY8QC2Cir7Gsda8qMW4+hChJ97iCbTx2uU81FZueVXbIMuu16ReXUk2MYfl94
         FZbCKvJ4hVz+XnB+tvRNK7timMvxth+QZvQWRo+iIVbn93JAhRjggDB8IFGAEj2bErdw
         gMjfOhruf8xl/QQsXqbQ6SgGl0nbuuD2WFT9QIRwIL4OH38XXQ3xjmCmFMej9oYgCRdy
         OLBgClaF4QyOPd4XZruhunjItb2HjOukPqtDXXuz3XMmjXRSqrQ0/swiI4iCIQAsemw+
         9/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Tipq/nj9MEYhYyki32K3Sq5jHiPmAdYbo2QRD/1w12M=;
        b=Vy+XoLGMmFZIGG8eTqy0zcw7oO+skw/ZTcKMlIMnXr4sb3MABTgz9m5AfnnHASFYQ8
         JNbPs8i46L63P5+DY68aZV6pl54dRL3kL4mCfTsLuXi00EHSqo3sQyIL6xItz9jxKv13
         HCsUI36rpRqz5fhdREZai4g7E5+udwCFEYGgRtj0ZPDBmE6aQCmfXhWJpeznC/x4M/QV
         tDgQgesqz54DEoiMisz9tYUwl3wG+8BxStWCkCjJpjVqfzeb5mHif6fXm9SowZXeCr9y
         G1gUv68NzPOhgzmykvqvpf4DM0jaN2DnFwW5nQjAfDAVGvoBt5KXExK3TaN4Ykz8AxKm
         97OQ==
X-Gm-Message-State: AJIora89U600IFPAOJvn8EjMKl1IC1OPoFa6Wvv8rfIfV7Rpbq9NmjZt
        XnApESxjOzNfw4hj6Px2sxnfburVMvjGWA==
X-Google-Smtp-Source: AGRyM1sgerqeP+C4e3KoL3HAmG0KhyUEjxGMZ62YS5EyGwS7Heq4P2g6z3G6uWCmPSzpZaZckIWf5w==
X-Received: by 2002:a65:4c0b:0:b0:415:d3a4:44d1 with SMTP id u11-20020a654c0b000000b00415d3a444d1mr16619195pgq.191.1657647122462;
        Tue, 12 Jul 2022 10:32:02 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090a664a00b001ec85441515sm7087423pjm.24.2022.07.12.10.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 10:32:02 -0700 (PDT)
Date:   Tue, 12 Jul 2022 17:31:58 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+760a73552f47a8cd0fd9@syzkaller.appspotmail.com,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Hou Wenlong <houwenlong.hwl@antgroup.com>
Subject: Re: [PATCH 2/3] KVM: x86: Set error code to segment selector on
 LLDT/LTR non-canonical #GP
Message-ID: <Ys2wDjRAIVhXZjOh@google.com>
References: <20220711232750.1092012-1-seanjc@google.com>
 <20220711232750.1092012-3-seanjc@google.com>
 <4017447bfd4636f4075d29d8f3c57c4c32fd67d2.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4017447bfd4636f4075d29d8f3c57c4c32fd67d2.camel@redhat.com>
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

On Tue, Jul 12, 2022, Maxim Levitsky wrote:
> On Mon, 2022-07-11 at 23:27 +0000, Sean Christopherson wrote:
> > When injecting a #GP on LLDT/LTR due to a non-canonical LDT/TSS base, set
> > the error code to the selector.  Intel SDM's says nothing about the #GP,
> > but AMD's APM explicitly states that both LLDT and LTR set the error code
> > to the selector, not zero.
> > 
> > Note, a non-canonical memory operand on LLDT/LTR does generate a #GP(0),
> > but the KVM code in question is specific to the base from the descriptor.
> > 
> > Fixes: e37a75a13cda ("KVM: x86: Emulator ignores LDTR/TR extended base on LLDT/LTR")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/emulate.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> > index 09e4b67b881f..bd9e9c5627d0 100644
> > --- a/arch/x86/kvm/emulate.c
> > +++ b/arch/x86/kvm/emulate.c
> > @@ -1736,8 +1736,8 @@ static int __load_segment_descriptor(struct x86_emulate_ctxt *ctxt,
> >                 if (ret != X86EMUL_CONTINUE)
> >                         return ret;
> >                 if (emul_is_noncanonical_address(get_desc_base(&seg_desc) |
> > -                               ((u64)base3 << 32), ctxt))
> > -                       return emulate_gp(ctxt, 0);
> > +                                                ((u64)base3 << 32), ctxt))
> > +                       return emulate_gp(ctxt, err_code);
> >         }
> >  
> >         if (seg == VCPU_SREG_TR) {
> 
> I guess this is the quote from AMD's manual (might we worth to add to the source?)

Eh, probably not worth it.  Anyone working on segmentation emulation is already
up to their eyeballs in the SDM/APM.
