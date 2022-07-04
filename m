Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C565564E87
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbiGDHTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbiGDHTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:19:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E27CC2ACD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 00:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656919148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XZvdib+oo3lvrA14EYB6RpofmfTNnpFnXxq1/Do0txY=;
        b=RVgyP0uv9dKOCvZY7PR0BzivTRLeLLuDK795CR18Av1wuYBL9ACvhPfAjt/5OcH3SfOM7a
        8WYpVV16YSE0zWptLGqJuuUKcJMOJblp8Bf+tCceLWHQvuHYChiZeLT5Vp0Fic0TMUttzf
        KA6Pm361UWEmvvU4N65PkNQsN6XcE+I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-1oG3vJSWMpeCY7iu8EmRUA-1; Mon, 04 Jul 2022 03:19:06 -0400
X-MC-Unique: 1oG3vJSWMpeCY7iu8EmRUA-1
Received: by mail-wm1-f69.google.com with SMTP id h125-20020a1c2183000000b003a0374f1eb8so6972227wmh.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 00:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XZvdib+oo3lvrA14EYB6RpofmfTNnpFnXxq1/Do0txY=;
        b=l92Tx8Nx4jfO1n7SKEbLXihwmsQb2KCe9W1ExoazZtg7w2tPA/Zf7nUzIN6ZwD3f6n
         srRgYfvGjV3ZkFD00WcZ7zBdIWmW/nwB8lx+X1SKi3CjAvQLhAEyqV4OUUYb8PzAwTz9
         ma7b9aIzRZ7AxyK9FV/aIyBHds4jbzWcyWatoMqGzruQiFoLTeusW6S8vWLS7MlfwKK1
         WwsglroszHWJjtutIkhrwWJcyGMYRGrIxSHtfNB4Te7v7q96loM7Z4illjmumlElVH/L
         RZDZg3LC0S7/AEe6OkvNtDe7IYAPfsr/3sBg/TjCQ7nY7/BuyoeGc7unUl38OcESQMXX
         cIOA==
X-Gm-Message-State: AJIora9oNX4n4wIGiVpkiEkQR7qsJ5Ib8lrv5+0pSBfwWA/xZ0IP8r7H
        IcxGP7If+JnGmotrLVvDP5EqkaYV8L+TD4cAVYt93cTpNiQZRbIMiFhN1bTNkyTM1wltctWEmCT
        ABXv2m18u2wRpeRI5ceYm1XG26hmrmWL/6q0fNRFF
X-Received: by 2002:a7b:cd08:0:b0:3a0:37f9:6e5d with SMTP id f8-20020a7bcd08000000b003a037f96e5dmr29297869wmj.167.1656919145686;
        Mon, 04 Jul 2022 00:19:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tkdZbo2UPOn3erwRwVBiaO/vhxvuXgkMCqyD6lyQOAT9BAwU6xS4YUbV77VaB9q2ElZmkyOxqjB6Wsp4Bc8ZM=
X-Received: by 2002:a7b:cd08:0:b0:3a0:37f9:6e5d with SMTP id
 f8-20020a7bcd08000000b003a037f96e5dmr29297854wmj.167.1656919145478; Mon, 04
 Jul 2022 00:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-12-kirill.shutemov@linux.intel.com> <6be29d38-5c93-7cc9-0de7-235d3f83773c@intel.com>
 <87a6a3aw50.fsf@email.froward.int.ebiederm.org> <20220624020005.txpxlsbjbebf6oq4@black.fi.intel.com>
 <20220628235105.z6ytdzxofrdkjti4@black.fi.intel.com> <88fe385c-fe40-d659-5081-7f3cdd9493e4@intel.com>
 <20220629005915.gieli3dbjzvjbk5i@black.fi.intel.com>
In-Reply-To: <20220629005915.gieli3dbjzvjbk5i@black.fi.intel.com>
From:   Dave Young <dyoung@redhat.com>
Date:   Mon, 4 Jul 2022 15:18:54 +0800
Message-ID: <CALu+AoQdEGpecj1wm9U2MpKqPbN5UmFF6+w3JaJSvddeRwf0dw@mail.gmail.com>
Subject: Re: [PATCHv7 11/14] x86: Disable kexec if system has unaccepted memory
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2022 at 08:59, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Tue, Jun 28, 2022 at 05:10:56PM -0700, Dave Hansen wrote:
> > On 6/28/22 16:51, Kirill A. Shutemov wrote:
> > > On Fri, Jun 24, 2022 at 05:00:05AM +0300, Kirill A. Shutemov wrote:
> > >>> If there is some deep and fundamental why this can not be supported
> > >>> then it probably makes sense to put some code in the arch_kexec_load
> > >>> hook that verifies that deep and fundamental reason is present.
> > ...
> > > +   /*
> > > +    * TODO: Information on memory acceptance status has to be communicated
> > > +    * between kernel.
> > > +    */
> >
> > So, the deep and fundamental reason is... drum roll... you haven't
> > gotten around to implementing bitmap passing yet?!?!?   I have the
> > feeling that wasn't what Eric was looking for.
>
> The deep fundamental reason is that everything cannot be implemented and
> upstreamed at once.

If the only thing is to pass bitmap to kexec kernel, since you have
reserved the bitmap memory I guess it is straightforward to set the
kexec bootparams.unaccepted_memory as the old value.  Not sure if
there are problems when the decompress code accepts memory again
though.
for kernel kexec_file_load, refer to function setup_boot_parameters()
in arch/x86/kernel/kexec-bzimage64.c for kexec_file_load,
for kexec-tools kexec_load code refer to
setup_linux_system_parameters() kexec/arch/i386/x86-linux-setup.c

Thanks
Dave

