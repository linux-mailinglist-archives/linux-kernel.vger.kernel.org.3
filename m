Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6414C007C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbiBVRwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbiBVRw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:52:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B558C6274;
        Tue, 22 Feb 2022 09:51:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0035BB81BE1;
        Tue, 22 Feb 2022 17:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D514C340E8;
        Tue, 22 Feb 2022 17:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645552313;
        bh=II7kjZuEny9420Pl6yfjZluXQCGAVRyjYESNN5jkbb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IRL57IP9eK9yShsv6AyNMwCgREFNgUH2nSqsjdlRyi3lf9Z0P+4qcthyPH8u8UtJD
         NEPE/K9jty2BBZOJgRFUsfhhlyI8JJC9r3MEx0Mx6wz3GPKqF5ReZiZ/ngV5SDtlbu
         909qA9zSclRpw83AUIdRr3LLoXMo+GiemiJzXf8SA8Vll9qYS6EpyYKuoyPzQxMcT8
         UT5VaoxIvvgM80akdzBqM14qloEzthkWoqalNxki1FD7IeU75ptoYEKb93A9HhKztj
         tLicti4h402VaoW/oAFRZqvDfafWgpJ5Tlc6KlDAsdF6QT3frO1F3L0ZuzHeM28TFc
         XRdj2VhN5C0pw==
Received: by pali.im (Postfix)
        id 989F2FDB; Tue, 22 Feb 2022 18:51:50 +0100 (CET)
Date:   Tue, 22 Feb 2022 18:51:50 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Armin Wolf <W_Armin@gmx.de>, jdelvare@suse.com,
        David.Laight@ACULAB.COM, linux-hwmon@vger.kernel.org,
        linux-assembly@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] hwmon: (dell-smm) Improve assembly code
Message-ID: <20220222175150.qs32v4outislnqj6@pali>
References: <20220220190851.17965-1-W_Armin@gmx.de>
 <20220222165432.GA255373@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222165432.GA255373@roeck-us.net>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 February 2022 08:54:32 Guenter Roeck wrote:
> On Sun, Feb 20, 2022 at 08:08:51PM +0100, Armin Wolf wrote:
> > The new assembly code works on both 32 bit and 64 bit
> > cpus and allows for more compiler optimisations.
> > Since clang runs out of registers on 32 bit x86 when
> > using CC_OUT, we need to execute "setc" ourself.
> > Also modify the debug message so we can still see
> > the result (eax) when the carry flag was set.
> > 
> > Tested with 32 bit and 64 bit kernels on a Dell Inspiron 3505.
> > 
> > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> 
> It would be great if I can get some Tested-by/Acked-by/Reviewed-by
> tags for this patch.

Well, I know about this driver asm code for a long time and it since
beginning it was suspicious for me, why there is such huge code with
stack and registers manipulation and why it cannot be implemented easily
via just two "out" instructions. This patch is exactly doing it.
But question reminds why it was written in this simple way since
beginning.

If this change is correct then I have no problem with it.

But I would rather see review of this asm change by skilled x86 asm
developer. We are dealing here with CPU 0, SMM x86 mode, I/O ports and
stack manipulation in inline gcc asm which sounds like a trap. And I'm
not feeling skilled for reviewing this change.

May I ask somebody to review this change? Is there some linux x86 ML?

> Thanks,
> Guenter
> 
> > ---
> > Changes in v4:
> > - reword commit message
> > 
> > Changes in v3:
> > - make carry an unsigned char
> > - use "+a", ... for output registers
> > - drop "cc" from clobbered list
> > 
> > Changes in v2:
> > - fix clang running out of registers on 32 bit x86
> > - modify debug message
> > ---
> >  drivers/hwmon/dell-smm-hwmon.c | 78 ++++++++--------------------------
> >  1 file changed, 18 insertions(+), 60 deletions(-)
> > 
> > --
> > 2.30.2
> > 
> > diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> > index c5939e68586d..38d23a8e83f2 100644
> > --- a/drivers/hwmon/dell-smm-hwmon.c
> > +++ b/drivers/hwmon/dell-smm-hwmon.c
> > @@ -119,7 +119,7 @@ struct smm_regs {
> >  	unsigned int edx;
> >  	unsigned int esi;
> >  	unsigned int edi;
> > -} __packed;
> > +};
> > 
> >  static const char * const temp_labels[] = {
> >  	"CPU",
> > @@ -164,74 +164,32 @@ static int i8k_smm_func(void *par)
> >  	struct smm_regs *regs = par;
> >  	int eax = regs->eax;
> >  	int ebx = regs->ebx;
> > +	unsigned char carry;
> >  	long long duration;
> > -	int rc;
> > 
> >  	/* SMM requires CPU 0 */
> >  	if (smp_processor_id() != 0)
> >  		return -EBUSY;
> > 
> > -#if defined(CONFIG_X86_64)
> > -	asm volatile("pushq %%rax\n\t"
> > -		"movl 0(%%rax),%%edx\n\t"
> > -		"pushq %%rdx\n\t"
> > -		"movl 4(%%rax),%%ebx\n\t"
> > -		"movl 8(%%rax),%%ecx\n\t"
> > -		"movl 12(%%rax),%%edx\n\t"
> > -		"movl 16(%%rax),%%esi\n\t"
> > -		"movl 20(%%rax),%%edi\n\t"
> > -		"popq %%rax\n\t"
> > -		"out %%al,$0xb2\n\t"
> > -		"out %%al,$0x84\n\t"
> > -		"xchgq %%rax,(%%rsp)\n\t"
> > -		"movl %%ebx,4(%%rax)\n\t"
> > -		"movl %%ecx,8(%%rax)\n\t"
> > -		"movl %%edx,12(%%rax)\n\t"
> > -		"movl %%esi,16(%%rax)\n\t"
> > -		"movl %%edi,20(%%rax)\n\t"
> > -		"popq %%rdx\n\t"
> > -		"movl %%edx,0(%%rax)\n\t"
> > -		"pushfq\n\t"
> > -		"popq %%rax\n\t"
> > -		"andl $1,%%eax\n"
> > -		: "=a"(rc)
> > -		:    "a"(regs)
> > -		:    "%ebx", "%ecx", "%edx", "%esi", "%edi", "memory");
> > -#else
> > -	asm volatile("pushl %%eax\n\t"
> > -	    "movl 0(%%eax),%%edx\n\t"
> > -	    "push %%edx\n\t"
> > -	    "movl 4(%%eax),%%ebx\n\t"
> > -	    "movl 8(%%eax),%%ecx\n\t"
> > -	    "movl 12(%%eax),%%edx\n\t"
> > -	    "movl 16(%%eax),%%esi\n\t"
> > -	    "movl 20(%%eax),%%edi\n\t"
> > -	    "popl %%eax\n\t"
> > -	    "out %%al,$0xb2\n\t"
> > -	    "out %%al,$0x84\n\t"
> > -	    "xchgl %%eax,(%%esp)\n\t"
> > -	    "movl %%ebx,4(%%eax)\n\t"
> > -	    "movl %%ecx,8(%%eax)\n\t"
> > -	    "movl %%edx,12(%%eax)\n\t"
> > -	    "movl %%esi,16(%%eax)\n\t"
> > -	    "movl %%edi,20(%%eax)\n\t"
> > -	    "popl %%edx\n\t"
> > -	    "movl %%edx,0(%%eax)\n\t"
> > -	    "lahf\n\t"
> > -	    "shrl $8,%%eax\n\t"
> > -	    "andl $1,%%eax\n"
> > -	    : "=a"(rc)
> > -	    :    "a"(regs)
> > -	    :    "%ebx", "%ecx", "%edx", "%esi", "%edi", "memory");
> > -#endif
> > -	if (rc != 0 || (regs->eax & 0xffff) == 0xffff || regs->eax == eax)
> > -		rc = -EINVAL;
> > +	asm volatile("out %%al,$0xb2\n\t"
> > +		     "out %%al,$0x84\n\t"
> > +		     "setc %0\n"
> > +		     : "=mr" (carry),
> > +		       "+a" (regs->eax),
> > +		       "+b" (regs->ebx),
> > +		       "+c" (regs->ecx),
> > +		       "+d" (regs->edx),
> > +		       "+S" (regs->esi),
> > +		       "+D" (regs->edi));
> > 
> >  	duration = ktime_us_delta(ktime_get(), calltime);
> > -	pr_debug("smm(0x%.4x 0x%.4x) = 0x%.4x  (took %7lld usecs)\n", eax, ebx,
> > -		 (rc ? 0xffff : regs->eax & 0xffff), duration);
> > +	pr_debug("smm(0x%.4x 0x%.4x) = 0x%.4x carry: %d (took %7lld usecs)\n",
> > +		 eax, ebx, regs->eax & 0xffff, carry, duration);
> > 
> > -	return rc;
> > +	if (carry || (regs->eax & 0xffff) == 0xffff || regs->eax == eax)
> > +		return -EINVAL;
> > +
> > +	return 0;
> >  }
> > 
> >  /*
