Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6576F529DF7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244744AbiEQJ1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244995AbiEQJ0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:26:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6154065DB
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652779575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bK+s6fnFoumBldn8FT3W5sY0gFW246RSo3CcSBZreoU=;
        b=Ee7l6jdn1x3zxSka+uSgPCPiuy66uJg3i8hrLUOBvs+pInzZ+Cl6lLikEf97u0o8iEtcgD
        5dvNrhkpqql1xA2rkZhRWpvCFhNC0+vmJE8uI9GpbZE+SzDdTTENn+XUazmMBD4SJJYlG/
        rWpXFepWQcQXhyGr2b84ipI6Z0wrCyE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-tieaqBz7OfeWMwCJZdjpRg-1; Tue, 17 May 2022 05:26:12 -0400
X-MC-Unique: tieaqBz7OfeWMwCJZdjpRg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E415811E78;
        Tue, 17 May 2022 09:26:11 +0000 (UTC)
Received: from localhost (ovpn-13-143.pek2.redhat.com [10.72.13.143])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6ED3B492C14;
        Tue, 17 May 2022 09:26:10 +0000 (UTC)
Date:   Tue, 17 May 2022 17:25:59 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Eric Biederman <ebiederm@xmission.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH] kexec_file: Drop pr_err in weak implementations of
 arch_kexec_apply_relocations[_add]
Message-ID: <YoNqJ/MOSIVwKP/o@MiWiFi-R3L-srv>
References: <20220425174128.11455-1-naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425174128.11455-1-naveen.n.rao@linux.vnet.ibm.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/25/22 at 11:11pm, Naveen N. Rao wrote:
> kexec_load_purgatory() can fail for many reasons - there is no need to
> print an error when encountering unsupported relocations.
> 
> This solves a build issue on powerpc with binutils v2.36 and newer [1].
> Since commit d1bcae833b32f1 ("ELF: Don't generate unused section
> symbols") [2], binutils started dropping section symbols that it thought

I am not familiar with binutils, while wondering if this exists in other
ARCHes except of ppc. Arm64 doesn't have the ARCH override either, do we
have problem with it?

> were unused.  This isn't an issue in general, but with kexec_file.c, gcc
> is placing kexec_arch_apply_relocations[_add] into a separate
> .text.unlikely section and the section symbol ".text.unlikely" is being
> dropped. Due to this, recordmcount is unable to find a non-weak symbol

But arch_kexec_apply_relocations_add is weak symbol on ppc.

> in .text.unlikely to generate a relocation record against. Dropping
> pr_err() calls results in these functions being left in .text section,

Why dropping pr_err() can make arch_kexec_apply_relocations_add put in
.text?

> enabling recordmcount to emit a proper relocation record.
> 
> [1] https://github.com/linuxppc/issues/issues/388
> [2] https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=d1bcae833b32f1
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  kernel/kexec_file.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 8347fc158d2b96..55d144c58b5278 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -121,7 +121,6 @@ int __weak
>  arch_kexec_apply_relocations_add(struct purgatory_info *pi, Elf_Shdr *section,
>  				 const Elf_Shdr *relsec, const Elf_Shdr *symtab)
>  {
> -	pr_err("RELA relocation unsupported.\n");
>  	return -ENOEXEC;
>  }
>  
> @@ -138,7 +137,6 @@ int __weak
>  arch_kexec_apply_relocations(struct purgatory_info *pi, Elf_Shdr *section,
>  			     const Elf_Shdr *relsec, const Elf_Shdr *symtab)
>  {
> -	pr_err("REL relocation unsupported.\n");
>  	return -ENOEXEC;
>  }
>  
> 
> base-commit: 83d8a0d166119de813cad27ae7d61f54f9aea707
> -- 
> 2.35.1
> 

