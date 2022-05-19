Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A722752C9F2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 04:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiESC7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 22:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiESC7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 22:59:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E86F9CF6D
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 19:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652929155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5kzeoZApr8FUKk2j/pFGghwvpVuJdLnN2byvPzMd2Qg=;
        b=UQsoWTBtR115NcULcy/xo0pG5/CTEiaIhiAZdqNBW83EZPXJeMfiLW5P4zwKY6Ma9UP5zS
        rsVuSuysb6li9iYPHEUgwLngNOK7xoS4T0Eh2Eq8baht7BDDeuey55azKyBN1y5bQkbTXw
        vbO+ytXryv6zE3pZCphs9s8zZ7lmp/4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-b9Br-tgWP4aKMJ2HLUzw3A-1; Wed, 18 May 2022 22:59:10 -0400
X-MC-Unique: b9Br-tgWP4aKMJ2HLUzw3A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 024A0185A7A4;
        Thu, 19 May 2022 02:59:06 +0000 (UTC)
Received: from localhost (ovpn-13-136.pek2.redhat.com [10.72.13.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23C551121314;
        Thu, 19 May 2022 02:59:04 +0000 (UTC)
Date:   Thu, 19 May 2022 10:58:19 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kexec_file: Drop weak attribute from
 arch_kexec_apply_relocations[_add]
Message-ID: <YoWySwbszfdZS9LU@MiWiFi-R3L-srv>
References: <20220518181828.645877-1-naveen.n.rao@linux.vnet.ibm.com>
 <87ee0q7b92.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ee0q7b92.fsf@email.froward.int.ebiederm.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 05/18/22 at 04:59pm, Eric W. Biederman wrote:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> 
> > Since commit d1bcae833b32f1 ("ELF: Don't generate unused section
> > symbols") [1], binutils (v2.36+) started dropping section symbols that
> > it thought were unused.  This isn't an issue in general, but with
> > kexec_file.c, gcc is placing kexec_arch_apply_relocations[_add] into a
> > separate .text.unlikely section and the section symbol ".text.unlikely"
> > is being dropped. Due to this, recordmcount is unable to find a non-weak
> > symbol in .text.unlikely to generate a relocation record against.
> >
> > Address this by dropping the weak attribute from these functions:
> > - arch_kexec_apply_relocations() is not overridden by any architecture
> >   today, so just drop the weak attribute.
> > - arch_kexec_apply_relocations_add() is only overridden by x86 and s390.
> >   Retain the function prototype for those and move the weak
> >   implementation into the header as a static inline for other
> >   architectures.
> >
> > [1] https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=d1bcae833b32f1
> 
> Any chance you can also get machine_kexec_post_load,
> crash_free_reserved_phys_range, arch_kexec_protect_protect_crashkres,
> arch_kexec_unprotect_crashkres, arch_kexec_kernel_image_probe,
> arch_kexec_kernel_image_probe, arch_kimage_file_post_load_cleanup,
> arch_kexec_kernel_verify_sig, and arch_kexec_locate_mem_hole as well.
> 
> That is everything in kexec that uses a __weak symbol.  If we can't
> count on them working we might as well just get rid of the rest
> preemptively.

Is there a new rule that __weak is not suggested in kernel any more?
Please help provide a pointer if yes, so that I can learn that.

In my mind, __weak is very simple and clear as a mechanism to add
ARCH related functionality.

Thanks
Baoquan

