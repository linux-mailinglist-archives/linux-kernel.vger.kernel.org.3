Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A9D571B67
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbiGLNfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiGLNfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:35:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6886BB6545
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657632914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AYDTpVfeHq/kcDxEOQn4ahOzHHQ5F5sUW+bY6Ncfdw0=;
        b=cCl/b4Q/lHd9IMWyq9GbZwgFAAJiqBLryDX1W0kaLowHYHS8PEFBcvJJNEfzdQ1xrlXQ8q
        U9JROZaLsg9e8tLj8ORA+m1K5GxBD0it3nydMmht5PXj0+OADW91eo1I3/q5J3o94WtHk3
        33uul3zxlVm/DhYgNg9geRlH/lR9h3I=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-404-3_mvxN-POHahcA5xFuyfOQ-1; Tue, 12 Jul 2022 09:35:13 -0400
X-MC-Unique: 3_mvxN-POHahcA5xFuyfOQ-1
Received: by mail-qk1-f198.google.com with SMTP id t203-20020a3746d4000000b006af1d3e8068so7802458qka.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=AYDTpVfeHq/kcDxEOQn4ahOzHHQ5F5sUW+bY6Ncfdw0=;
        b=PotXTkTsRbfiHLyQ4vgRRw45eCrO52njV1E8mx3gouXEnEPeAqn6D9mrJINHrGWi4u
         6/Hzi85mbwd57n82FiwtJKyUnk+5f984wfYigwKMkk4o5vosEG9IfOyzO9JLPRJigHBE
         izXU3PCLrBtetwmco2k4lX4o9AoRdUFCc9XL7lZYcs3F6+MYcHZB8NU4vqTc+i+E2ikf
         EIe8RfqdCqCLOuZD4KI46BNQX//nW8M5OmzH7P6vF3uw+i4Nr8x22w4cQbtcU+QZ4Ip+
         lQPGMKkfmkfK1HHY+okaQfQnxkqTK1pcji08Es2OE77rq64jG1HUpPiX2yyHlDC6qx9I
         qAPw==
X-Gm-Message-State: AJIora98J03Vx+W01O4iQy9a2D7YYHVR/tWFKhupy9RKLR1uXe/W4Wzp
        SUVakUS/A8fO4vdJoAzs6mmWI1IWqKZMWc//3z363JTt+kG+SiYm8XZq2RygngWCUmbJndw1S5n
        EJn4aG9oPjzNmgqzWSWCugwmL
X-Received: by 2002:a05:620a:294d:b0:6b3:bb34:ecf2 with SMTP id n13-20020a05620a294d00b006b3bb34ecf2mr14838033qkp.181.1657632912658;
        Tue, 12 Jul 2022 06:35:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vtMFCzLrA3SwwmG1gbgi57BoQRxTT2NzAoIxVA3+ubZEEcf4EGzm6Q/kg/e6cmwGmzZS8wvQ==
X-Received: by 2002:a05:620a:294d:b0:6b3:bb34:ecf2 with SMTP id n13-20020a05620a294d00b006b3bb34ecf2mr14838011qkp.181.1657632912295;
        Tue, 12 Jul 2022 06:35:12 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id x9-20020a05620a448900b006a79479657fsm9407335qkp.108.2022.07.12.06.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:35:11 -0700 (PDT)
Message-ID: <8307c007823eac899d3a017d1616e0d08a653185.camel@redhat.com>
Subject: Re: [PATCH 1/3] KVM: x86: Mark TSS busy during LTR emulation
 _after_ all fault checks
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+760a73552f47a8cd0fd9@syzkaller.appspotmail.com,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Hou Wenlong <houwenlong.hwl@antgroup.com>
Date:   Tue, 12 Jul 2022 16:35:08 +0300
In-Reply-To: <20220711232750.1092012-2-seanjc@google.com>
References: <20220711232750.1092012-1-seanjc@google.com>
         <20220711232750.1092012-2-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-11 at 23:27 +0000, Sean Christopherson wrote:
> Wait to mark the TSS as busy during LTR emulation until after all fault
> checks for the LTR have passed.  Specifically, don't mark the TSS busy if
> the new TSS base is non-canonical.


Took me a while to notice it but I see the canonical check now, so the patch
makes sense, and so:

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Unrelated, but I do wonder why we use cmpxchg_emulated for setting the busy bit, while we use
write_segment_descriptor to set the accessed bit.


Best regards,
	Maxim Levitsky

> 
> Opportunistically drop the one-off !seg_desc.PRESENT check for TR as the
> only reason for the early check was to avoid marking a !PRESENT TSS as
> busy, i.e. the common !PRESENT is now done before setting the busy bit.
> 
> Fixes: e37a75a13cda ("KVM: x86: Emulator ignores LDTR/TR extended base on LLDT/LTR")
> Reported-by: syzbot+760a73552f47a8cd0fd9@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org
> Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Cc: Hou Wenlong <houwenlong.hwl@antgroup.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/emulate.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 39ea9138224c..09e4b67b881f 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -1699,16 +1699,6 @@ static int __load_segment_descriptor(struct x86_emulate_ctxt *ctxt,
>         case VCPU_SREG_TR:
>                 if (seg_desc.s || (seg_desc.type != 1 && seg_desc.type != 9))
>                         goto exception;
> -               if (!seg_desc.p) {
> -                       err_vec = NP_VECTOR;
> -                       goto exception;
> -               }
> -               old_desc = seg_desc;
> -               seg_desc.type |= 2; /* busy */
> -               ret = ctxt->ops->cmpxchg_emulated(ctxt, desc_addr, &old_desc, &seg_desc,
> -                                                 sizeof(seg_desc), &ctxt->exception);
> -               if (ret != X86EMUL_CONTINUE)
> -                       return ret;
>                 break;
>         case VCPU_SREG_LDTR:
>                 if (seg_desc.s || seg_desc.type != 2)
> @@ -1749,6 +1739,15 @@ static int __load_segment_descriptor(struct x86_emulate_ctxt *ctxt,
>                                 ((u64)base3 << 32), ctxt))
>                         return emulate_gp(ctxt, 0);
>         }
> +
> +       if (seg == VCPU_SREG_TR) {
> +               old_desc = seg_desc;
> +               seg_desc.type |= 2; /* busy */
> +               ret = ctxt->ops->cmpxchg_emulated(ctxt, desc_addr, &old_desc, &seg_desc,
> +                                                 sizeof(seg_desc), &ctxt->exception);
> +               if (ret != X86EMUL_CONTINUE)
> +                       return ret;
> +       }
>  load:
>         ctxt->ops->set_segment(ctxt, selector, &seg_desc, base3, seg);
>         if (desc)


