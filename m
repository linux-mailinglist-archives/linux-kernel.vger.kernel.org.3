Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C6F4DDF8F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 18:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239488AbiCRREk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 13:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiCRREi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 13:04:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89F44FD36
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 10:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647622998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VLZ3JS2/DyhoFGvu41Lcz0nqjayRDaII6Z+BmBWn99k=;
        b=M28XVPMsjadVrjpL2QgmAq7JCutLMFdS1i8da0dBoycTGLtbvlEDg2WfC0JFz0vyVIU+3u
        oR2JfvkET+RGUX6G+DbADZUWW2yR33T4UB8TpT6sTHB3YDWWdX17+z2QW2x6qUzSwPZIHe
        Ps20Th65SLJG7jBY2POALaHpLJW15IA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-C9sI6OL6OV-sQ_nnNYigpw-1; Fri, 18 Mar 2022 13:03:17 -0400
X-MC-Unique: C9sI6OL6OV-sQ_nnNYigpw-1
Received: by mail-qk1-f200.google.com with SMTP id y140-20020a376492000000b0067b14129a63so5700682qkb.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 10:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VLZ3JS2/DyhoFGvu41Lcz0nqjayRDaII6Z+BmBWn99k=;
        b=Ql226D0GSQ8f9gv80pR/cryy8ee0aC2PJZM5XD7KBBzaJPSoiDrf55k1TsAEpFNPsl
         j79ll1aS8aQSn0qeenUvwvb+MZMarnULETvyp1dX+tYW2D80QqxHnD2/MoYbY7y4z1Aa
         E89DJQsM8vS2M+Xakwd+ZA+637jS1dPaTFjnN+5th4rwFX1VASV/jAZDtAU/6oOT5P94
         sTQCiUuZU/C5yBurMz4O8yiIZB8+3glMhOkPtp7kTBa2dyebkXwywOi7AjGpXnwruOoT
         lDN5desv78IcKQe0gU58zGmVLEtWnwxQHAkP4s4ORZWeNaH51t6M4cXISL2Xl+QGcZFd
         mhqg==
X-Gm-Message-State: AOAM530Iyp27cG1cI1cbpn5zsBcW1AFvchXrP2WPJfZno168podLOAod
        yN1np8tW/5Ws6hi27ufgYxFgXB2X7gs34ND8d1mQiVS69WoBDZTT7Sh2yHGStcdwLwwODrAcQrb
        EPydZM/F7oligFuvRz1xjXsre
X-Received: by 2002:a05:620a:e89:b0:49b:6677:8f8f with SMTP id w9-20020a05620a0e8900b0049b66778f8fmr6329422qkm.269.1647622996810;
        Fri, 18 Mar 2022 10:03:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx23mxkbxLHxoLzswedr88Hz+bjJqaM2yOtqnFZyKdBO2BdHXW0k4mNF0tkPLUTeX7vf3lWPg==
X-Received: by 2002:a05:620a:e89:b0:49b:6677:8f8f with SMTP id w9-20020a05620a0e8900b0049b66778f8fmr6329403qkm.269.1647622996525;
        Fri, 18 Mar 2022 10:03:16 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id d12-20020a05620a158c00b00648ec3fcbdfsm3840968qkk.72.2022.03.18.10.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 10:03:16 -0700 (PDT)
Date:   Fri, 18 Mar 2022 10:03:12 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/sev: Add ENCODE_FRAME_POINTER after stack changed
 for #VC
Message-ID: <20220318170312.rc2zgtubddg4dpya@treble>
References: <20220316041612.71357-1-jiangshanlai@gmail.com>
 <20220317221943.6vhoqx3fdv7py6hi@treble>
 <CAJhGHyC1qPee2QOpgR8B+2Sd+XzfoJD3NL9biFZ5gKE-B9r_rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJhGHyC1qPee2QOpgR8B+2Sd+XzfoJD3NL9biFZ5gKE-B9r_rQ@mail.gmail.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 09:14:09AM +0800, Lai Jiangshan wrote:
> On Fri, Mar 18, 2022 at 6:19 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Wed, Mar 16, 2022 at 12:16:12PM +0800, Lai Jiangshan wrote:
> > > From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> > >
> > > In idtentry_vc(), the real frame is changed after it switches to new
> > > stack, ENCODE_FRAME_POINTER should be called in case for unwinder.
> > >
> > > Cc: Joerg Roedel <jroedel@suse.de>
> > > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > > Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> > > ---
> > >  arch/x86/entry/entry_64.S | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> > > index e20eabaa56b8..f99f2881ed83 100644
> > > --- a/arch/x86/entry/entry_64.S
> > > +++ b/arch/x86/entry/entry_64.S
> > > @@ -540,6 +540,7 @@ SYM_CODE_START(\asmsym)
> > >       call    vc_switch_off_ist
> > >       movq    %rax, %rsp              /* Switch to new stack */
> > >
> > > +     ENCODE_FRAME_POINTER
> > >       UNWIND_HINT_REGS
> > >
> > >       /* Update pt_regs */
> >
> > Looks right to me.  Any chance you have the ability to test this
> > scenario by unwinding from #VC with CONFIG_FRAME_POINTER?
> >
> 
> I don't have the hardware to test it.  Actually, it was you to
> inspire me to find this in the conversation of my patchset when
> I tried to search all the code of switching of %rsp to see how
> ENCODE_FRAME_POINTER and UNWIND_HINT_REGS are used once more.

Ok, maybe Joerg can test it.  It looks obviously right to me though.
Since it fixes a real frame pointer unwinding bug, it probably needs:

  Fixes: a13644f3a53d ("x86/entry/64: Add entry code for #VC handler")

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

