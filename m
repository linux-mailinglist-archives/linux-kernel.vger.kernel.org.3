Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDF14DDB8F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbiCROXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237215AbiCROWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:22:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F751BA692
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:20:33 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647613231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZNMXP6J9xWB0d8DtI6D+7sf/8u+0IpppoujJx7MrKmI=;
        b=wk28hfwfAHtEmopuVMi4KZzVCZbYWy1+8VDduqmt8pdTcz7WklVl8OI0Pno30ndyZmWUug
        yh4p0H0ujWaQ1961MV7VeDa3akFjup8zoFeVqEpR8sE0VcvVTlzEws9Yl/5L6IHRmnMDF9
        Z54IWPfwd+pESUF3dQsIzXzWlNnPSWPXqTFMFYYRcYbBSW6ym9oE7T3cE1jYv5CZinCBvG
        lOoyR7m2IfIO8BuMVjuWbHTMSBJzt4MQn7HczxKYo7ktnxURBRxUQOVw/NHhCO/bw+QEQY
        MCrNuF0neFc9ae+o5k6i4t8ZvP/9EFe0fWtumfVmOv+AP5Oxvt4I180yM0o21g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647613231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZNMXP6J9xWB0d8DtI6D+7sf/8u+0IpppoujJx7MrKmI=;
        b=KZbNAWr8ROW2Hh/vejVSNN+lV3s40JfRJychBsQh06zBmGwPib274QeHg77np/CDIFh9qd
        XemdOoe2OqG2RdAA==
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 15/30] x86/boot: Port I/O: allow to hook up
 alternative helpers
In-Reply-To: <20220317201054.5wdykfru5hhvukvd@black.fi.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-16-kirill.shutemov@linux.intel.com>
 <87czik22wk.ffs@tglx> <20220317201054.5wdykfru5hhvukvd@black.fi.intel.com>
Date:   Fri, 18 Mar 2022 15:20:31 +0100
Message-ID: <877d8rcpg0.ffs@tglx>
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

On Thu, Mar 17 2022 at 23:10, Kirill A. Shutemov wrote:
> On Thu, Mar 17, 2022 at 01:12:59PM +0100, Thomas Gleixner wrote:
>> #define DEFINE_PORT_IO_OPS()		\
>> 	struct port_io_ops pio_ops = {	\
>>         	.inb	= __inb,	\
>>         	.outb	= __outb,	\
>>         	.outw	= __outw, }
>> 
>> Hmm?
>
> This kind of initializations are problematic. They generate run-time
> relacations that kernel cannot handle in the boot stub. Linker complains
> about this:
>
> 	ld.lld: error: Unexpected run-time relocations (.rela) detected!
>
> I will leave it as is, unless you have better ideas.

Bah, did not think about that.

Thanks,

        tglx
