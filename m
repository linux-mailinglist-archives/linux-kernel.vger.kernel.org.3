Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F65A4DDBAA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbiCROaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237242AbiCROaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:30:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD11F4616F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:28:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647613738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/C+1JlCh6on/oEczFeM+hLgvy9mHBF6gV+x2tQ4Nn4Q=;
        b=0idis14fvUzl6CjTVUIlfluRCndc51gwpKKTjogPfKOGePjow9+f4lRqsQP6T9Zldv6tuQ
        PAc06Tvq6jJ5D1Ipb4LVHq4CqYeXDJqsHJqp5YuxlLLEyTPfvYuBrcvrMXeV3FaiUj7Va9
        DMsARrzf/Jf2H8Tb6ZQ+Gl9BzeSTTNvXGg5V7SL0Rb9oL+ZnyH7aGqkrtxRCv/yDEzDKby
        U2aDPaMVhBqqRcoa9r0kLGvERG4B7qlvv75NTRcUt6bSZVhdmewmxT45pbbTT49V/Rdd4k
        8Foszu8a58AcHZafoWpj55M6uxA3EkJ1+46zCIQwyH4xFoJxWT0pMeHNTZhiGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647613738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/C+1JlCh6on/oEczFeM+hLgvy9mHBF6gV+x2tQ4Nn4Q=;
        b=qB48XDs3iBbNIv7gVIAf8648rfP+w7V6FnktoJuiz4S2l3Tbb0NiLVgabx4+L36CIEdm7U
        8vyX3Sy8bfYE34Cg==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCHv6 16/30] x86/boot: Port I/O: add decompression-time
 support for TDX
In-Reply-To: <20220317201547.haoyqy2iaid7lku3@black.fi.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-17-kirill.shutemov@linux.intel.com>
 <87a6do22t6.ffs@tglx> <20220317201547.haoyqy2iaid7lku3@black.fi.intel.com>
Date:   Fri, 18 Mar 2022 15:28:57 +0100
Message-ID: <874k3vcp1y.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17 2022 at 23:15, Kirill A. Shutemov wrote:
> On Thu, Mar 17, 2022 at 01:15:01PM +0100, Thomas Gleixner wrote:
>> On Wed, Mar 16 2022 at 05:08, Kirill A. Shutemov wrote:
>> >  void early_tdx_detect(void)
>> >  {
>> >  	u32 eax, sig[3];
>> > @@ -23,4 +94,12 @@ void early_tdx_detect(void)
>> >  
>> >  	/* Cache TDX guest feature status */
>> >  	tdx_guest_detected = true;
>> > +
>> > +	/* Use hypercalls instead of I/O instructions */
>> > +	inb = tdx_inb;
>> 
>> Eeew. What's wrong with writing this out?
>> 
>>         pio_ops.inb = tdx_inb;
>> 
>> So it becomes obvious what this is about?
>
> This leads to preprocessor hell: "pio_ops.inb" is expanded to
> "pio_ops.pio_ops.inb" :/
>
> I can rename fields in struct port_io_ops to avoid conflicts, I donno.

Yes, please rename them.

Thanks,

        tglx
