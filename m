Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F2B51F3E2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 07:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbiEIFhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 01:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbiEIFbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 01:31:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 414BF3ED34
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 22:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652074036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eNbW88joc1WQormM6ug+550JQKLgPb1W/CR1qXZE5SQ=;
        b=SLpt+2XVeBmkoZqUTY45/nhvjNePLKeNCG5wmW0Tr5BWsIrO9GE1EPkPeJApYndaAgwuHq
        ZDsMNnfsBXXT2QTLpyovfVHWqyfjifc4vGt95pfHIamd/YjAdynzvHI1IZvjqdE5Db0+qm
        nvvLEAOpiNN92WuRL9GZ0at66tUg8cA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-V-K_kfjLMYiiNSbbAzXMAA-1; Mon, 09 May 2022 01:27:10 -0400
X-MC-Unique: V-K_kfjLMYiiNSbbAzXMAA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EAE7C85A5BE;
        Mon,  9 May 2022 05:27:09 +0000 (UTC)
Received: from localhost (ovpn-13-212.pek2.redhat.com [10.72.13.212])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DAE62166B2F;
        Mon,  9 May 2022 05:27:02 +0000 (UTC)
Date:   Mon, 9 May 2022 13:26:59 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Sourabh Jain <sourabhjain@linux.ibm.com>
Cc:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v8 1/7] x86/crash: fix minor typo/bug in debug message
Message-ID: <YnimI5cZWXKeNSHY@MiWiFi-R3L-srv>
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-2-eric.devolder@oracle.com>
 <72764a3c-8b8c-8652-945e-9b15f31cda15@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72764a3c-8b8c-8652-945e-9b15f31cda15@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/22 at 10:46am, Sourabh Jain wrote:
> 
> On 06/05/22 00:15, Eric DeVolder wrote:
> > The pr_debug() intends to display the memsz member, but the
> > parameter is actually the bufsz member (which is already
> > displayed). Correct this to display memsz value.
> > 
> > Signed-off-by: Eric DeVolder<eric.devolder@oracle.com>
> > Reviewed-by: David Hildenbrand<david@redhat.com>
> > Acked-by: Baoquan He<bhe@redhat.com>
> > ---
> >   arch/x86/kernel/crash.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> > index e8326a8d1c5d..9730c88530fc 100644
> > --- a/arch/x86/kernel/crash.c
> > +++ b/arch/x86/kernel/crash.c
> > @@ -407,7 +407,7 @@ int crash_load_segments(struct kimage *image)
> >   	}
> >   	image->elf_load_addr = kbuf.mem;
> >   	pr_debug("Loaded ELF headers at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> > -		 image->elf_load_addr, kbuf.bufsz, kbuf.bufsz);
> > +		 image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
> > 
> I think we can push this patch separately.

Boris has taken this into tip/x86/kdump.

