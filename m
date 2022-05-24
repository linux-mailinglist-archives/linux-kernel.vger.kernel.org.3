Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1A0532FFA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 20:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240107AbiEXSAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 14:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237893AbiEXSAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:00:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABA362214
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 11:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y3aUQdLDs72jwQMclOfWKd9fujycyfSnuRptoFLfjIA=; b=EjJTKKQYh9pdLcDTSbGVJTdCiC
        W+Ajh4wyDAp3O3Q7hPTKQBKK2ZQLtN9gwecWnygYCqRdrcg1gEvWGbP+QX7QqLEmd1Luv0pXbTKU9
        SVAky/DxDZQ2OsPscIJ/T5ketroO0TGNjCTmTvDs1Lv2jSsJ1VZBEVwtFlHtKKMEOGQosnqv7ustw
        +E3yUHk/e870X2w1fFYrsxDZC1jSAl0y71K8OD9ZiBtoUyajf7kVsLI3gYdtxbZro9a0MwRADRF6y
        ube6ghSWXHT5ADL+26tODlO0LfRvrRt0SoRVVRI8EO3QkXbsdP07R/TgolVSjx9jiad5ndsdQLJU/
        EnilShiQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntYp7-001OXR-Du; Tue, 24 May 2022 18:00:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DEC08300222;
        Tue, 24 May 2022 19:59:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A553E201A996B; Tue, 24 May 2022 19:59:57 +0200 (CEST)
Date:   Tue, 24 May 2022 19:59:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, aik@ozlabs.ru,
        sv@linux.ibm.com, rostedt@goodmis.org, jpoimboe@redhat.com,
        naveen.n.rao@linux.vnet.ibm.com, mbenes@suse.cz,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 3/7] objtool: Use target file class size instead
 of a compiled constant
Message-ID: <Yo0dHcq7VYlt79nj@hirez.programming.kicks-ass.net>
References: <cover.1653398233.git.christophe.leroy@csgroup.eu>
 <c4b06b5b314183d85615765a5ce421a057674bd8.1653398233.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4b06b5b314183d85615765a5ce421a057674bd8.1653398233.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 03:17:43PM +0200, Christophe Leroy wrote:
> -	sec = elf_create_section(elf, relocname, 0, sizeof(GElf_Rela), 0);
> +	if (size == sizeof(u32))
> +		sec = elf_create_section(elf, relocname, 0, sizeof(Elf32_Rela), 0);
> +	else
> +		sec = elf_create_section(elf, relocname, 0, sizeof(GElf_Rela), 0);

Probably best to use Elf64_* here instead of GElf_*.
