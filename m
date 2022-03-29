Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181F34EA995
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbiC2IsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbiC2IsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:48:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE94836B48
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 01:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648543592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rfrzm4j4zj7hUZ9sryizSYHm7gKny+CsMftwupOlLcE=;
        b=LfzZmr3u3ED6UZaRCZ36Nju55YwZAcT6adKu1JscqB1+UmDWgAkxrrnslsegC9dLtSw1mS
        j2QnwZjyYhsGKcXv4NvApk1iBECJaIXLWXMcgyyg5cLVeo+0pRWHfm95FvS+5j2T5URsDf
        oiw1ndlcKUeCJMuR6I9fSV3AT0q/8E0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-X2-RMwKSNga8ZTvBQNavdQ-1; Tue, 29 Mar 2022 04:46:28 -0400
X-MC-Unique: X2-RMwKSNga8ZTvBQNavdQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC0D11C168E5;
        Tue, 29 Mar 2022 08:46:27 +0000 (UTC)
Received: from starship (unknown [10.40.194.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 543CB2026D6B;
        Tue, 29 Mar 2022 08:46:19 +0000 (UTC)
Message-ID: <50b7fe532bf9aed071444eba6e315572599bf749.camel@redhat.com>
Subject: Re: [PATCH v4 2/6] KVM: x86: nSVM: implement nested LBR
 virtualization
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jim Mattson <jmattson@google.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wanpeng Li <wanpengli@tencent.com>
Date:   Tue, 29 Mar 2022 11:46:18 +0300
In-Reply-To: <bfe9a0ce-7f83-4264-e450-a53e4e08d785@redhat.com>
References: <20220322174050.241850-1-mlevitsk@redhat.com>
         <20220322174050.241850-3-mlevitsk@redhat.com>
         <fca4a420-bdb4-0b46-c346-bee5500be43a@redhat.com>
         <612b6524258b949e381efec12d85b4e82be53308.camel@redhat.com>
         <bfe9a0ce-7f83-4264-e450-a53e4e08d785@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-03-28 at 19:12 +0200, Paolo Bonzini wrote:
> On 3/27/22 17:12, Maxim Levitsky wrote:
> > - with LBR virtualization supported, the guest can set this msr to any value
> > as long as it doesn't set reserved bits and then read back the written value,
> > but it is not used by the CPU, unless LBR bit is set in MSR_IA32_DEBUGCTLMSR,
> > because only then LBR virtualization is enabled, which makes the CPU
> > load the guest value on VM entry.
> >   
> > This means that MSR_IA32_DEBUGCTLMSR.BTF will magically start working when
> > MSR_IA32_DEBUGCTLMSR.LBR is set as well, and will not work otherwise.
> 
> That can be fixed by context-switching DEBUGCTLMSR by hand when LBR=0 && 
> BTF=1.  Would you like to give it a shot?
> 
> Paolo
> 
Yep exactly, I didn't do that yet only because mypatches didn't made it worse,
so I wanted to do this in a separate patch (+unit test), and it kind of
went to my backlog. I'll do that soon.

Best regards,
	Maxim Levitsky

