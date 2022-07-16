Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002B3577025
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 18:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiGPQff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 12:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiGPQfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 12:35:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684691EC7B
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 09:35:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F0837202E4;
        Sat, 16 Jul 2022 16:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657989330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ou8Rl3rKdNin3iFI14DAAcINBGak3oEAgpZ2DwPHU24=;
        b=h2RyGvFZRNu1j239mKDyQg+j7qJ/jd7VwXWZgEFZyK9SHH3Yg7cTBC0MhwLFrfkg0Bg/XK
        kOUrPpE5EcgMxvhAw9n5jZpoPuN2+Z0d28R0eyGtXst7y/YUwJNZgB59kz5W2MRSsGhzJW
        zdtef5jJRiqQ058zvI09cl6+/wJcl3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657989330;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ou8Rl3rKdNin3iFI14DAAcINBGak3oEAgpZ2DwPHU24=;
        b=h3HhjFZuj75cKW79F2SYwnpVgjphh1wfpkaUmhihoh9HRjQTIpvR2xUEozkj3RjoNPESIQ
        H1hifNVornz8VhDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94E591351D;
        Sat, 16 Jul 2022 16:35:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YKsHI9Lo0mIjBgAAMHmgww
        (envelope-from <nstange@suse.de>); Sat, 16 Jul 2022 16:35:30 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Build warnings in Xen 5.15.y and 5.10.y with retbleed backports
References: <Ys2jlGMqAe6+h1SX@kroah.com>
        <ddcdd531-fc33-39df-a69f-5352d7a1c8af@oracle.com>
        <Ys3MI7cv2yKj9RFc@kroah.com>
        <1b8fee7f-5af2-332e-d2c9-ceecd6ff487b@oracle.com>
Date:   Sat, 16 Jul 2022 18:35:29 +0200
In-Reply-To: <1b8fee7f-5af2-332e-d2c9-ceecd6ff487b@oracle.com> (Boris
        Ostrovsky's message of "Tue, 12 Jul 2022 16:22:41 -0400")
Message-ID: <875yjxrp66.fsf@linux.fritz.box>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I see a patch for this has been queued up for 5.10 already ([1]), I'm
just sharing my findings in support of this patch here -- it doesn't
merely exchange one warning for another, but fixes a real issue and
should perhaps get applied to other stable branches as well.

TL;DR: for this particular warning, objtool would exit early and fail to
create any .orc_unwind* ELF sections for head_64.o, which are consumed
by the ORC unwinder at runtime.


Boris Ostrovsky <boris.ostrovsky@oracle.com> writes:

> On 7/12/22 3:31 PM, Greg KH wrote:
>> On Tue, Jul 12, 2022 at 03:19:39PM -0400, Boris Ostrovsky wrote:
>>>
>>> On 7/12/22 12:38 PM, Greg KH wrote:
>>>> Hi all,
>>>>
>>>> I'm seeing the following build warning:
>>>> 	arch/x86/kernel/head_64.o: warning: objtool: xen_hypercall_mmu_update=
(): can't find starting instruction
>>>> in the 5.15.y and 5.10.y retbleed backports.

The reason for this is that with RET being multibyte, it can cross those
"xen_hypecall_*" symbol boundaries, because ...

>>>>
>>>> I don't know why just this one hypercall is being called out by objtoo=
l,
>>>> and this warning isn't in 5.18 and Linus's tree due to I think commit
>>>> 5b2fc51576ef ("x86/ibt,xen: Sprinkle the ENDBR") being there.
>>>>
>>>> But, is this a ret call that we "forgot" here?  It's a "real" ret in
>>>> Linus's branch:
>>>>
>>>> .pushsection .noinstr.text, "ax"
>>>> 	.balign PAGE_SIZE
>>>> SYM_CODE_START(hypercall_page)
>>>> 	.rept (PAGE_SIZE / 32)
>>>> 		UNWIND_HINT_FUNC
>>>> 		ANNOTATE_NOENDBR
>>>> 		ANNOTATE_UNRET_SAFE
>>>> 		ret
>>>> 		/*
>>>> 		 * Xen will write the hypercall page, and sort out ENDBR.
>>>> 		 */
>>>> 		.skip 31, 0xcc
>>>> 	.endr
>>>>
>>>> while 5.15.y and older has:
>>>> .pushsection .text
>>>> 	.balign PAGE_SIZE
>>>> SYM_CODE_START(hypercall_page)
>>>> 	.rept (PAGE_SIZE / 32)
>>>> 		UNWIND_HINT_FUNC
>>>> 		.skip 31, 0x90

... the "31" is no longer correct, ...

>>>> 		ANNOTATE_UNRET_SAFE
>>>> 		RET

... as with RET occupying more than one byte, the resulting hypercall
entry's total size won't add up to 32 anymore.

Note that those xen_hypercall_* symbols' values are getting statically
calculated as 'hypercall page + n * 32' in the HYPERCALL() #define from
xen-head.S. So there's a mismatch and with RET =3D=3D 'ret; int3', the
resulting .text effectively becomes

    101e:       90                      nop
    101f:       c3                      ret=20=20=20=20

0000000000001020 <xen_hypercall_mmu_update>:
    1020:       cc                      int3=20=20=20
    1021:       90                      nop
    1022:       90                      nop


This is probably already not what has been intended, but because 'ret'
and 'int3' both are single-byte encoded, objtool would still be able to
find at least some "starting instruction" at this point.

But with RET =3D=3D 'jmp __x86_return_thunk', it becomes

    101e:       90                      nop
    101f:       e9                      .byte 0xe9

0000000000001020 <xen_hypercall_mmu_update>:
    1020:       00 00                   add    %al,(%rax)
    1022:       00 00                   add    %al,(%rax)
    1024:       90                      nop

Here the 'e9 00 00 00 00' jmp crosses the symbol boundary and objtool
errors out.

>>>> 	.endr
>>>>
>>>> So should the "ret" remain or be turned into "RET" in mainline right
>>>> now?
>>>
>>>
>>> It doesn't matter --- this is overwritten by the hypervisor during
>>> initialization when Xen fills in actual hypercall code.

It does makes a difference though: even though objtool reports only a
warning, it still exits early in this particular case and won't create
any of the .orc_unwind* or .return_sites sections for head_64.o as it's
supposed to.

The significance of not having .orc_unwind* for head_64.o is that the
reliable stacktracing implementation would mark the swapper tasks'
stacktraces as unreliable at runtime, because the ORC unwinder would
fail to recognize their final secondary_startup_64() from head_64.o as
being the end. Note that livepatching relies on reliable stacktraces
when transitioning tasks.


>>>
>>>
>>> So f4b4bc10b0b85ec66f1a9bf5dddf475e6695b6d2 added 'ret' to make objtool=
 happy and then 14b476e07fab6 replaced 'ret' with RET as part of SLS fixes.=
 The latter was not really necessary but harmless.
>>>
>>>
>>> So it can be 'ret', RET, or anything else that tools don't complain abo=
ut. It will not be executed.
>> Cool, thanks.
>> But what about the objtool warning that I now see?  Is that "real"?
>
>
>
> It's not real in the sense that the code there is not real, it will be ov=
erwritten. (Originally the whole page was 'nop's)
>
>
> I am getting a different error BTW:
>
> 	arch/x86/kernel/head_64.o: warning: objtool: .text+0x5: unreachable inst=
ruction
>

I think this one is (mostly?) harmless, at least as as far as the
.orc_unwind* generation is concerned. Josh would know more.


Thanks,

Nicolai

[1] https://lore.kernel.org/r/Ys+8ZYxkDmSCcDWv@kroah.com

>
>
>> I don't run any Xen systems, so I can't test any of this myself.
>
>
> You can't test any changes to that code --- it is rewritten when Xen gues=
t is running.
>
>
> We probably do want to shut up objtool. Josh, any suggestions?
>
>
> -boris
>

--=20
SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461 N=C3=BC=
rnberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
(HRB 36809, AG N=C3=BCrnberg)
