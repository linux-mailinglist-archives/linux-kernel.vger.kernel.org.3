Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435655A9FD9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbiIATYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbiIATYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:24:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D047288DC2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 12:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hy5o61o9Oglth8HH2RjC1xWHND1RP4dktCh8fxtlJ7s=; b=BiKYZO7comEUiIgcSUEUEiRy+h
        NkHMhqsOiNSFJm/CsNEbBkgFYl5Bu5OJwlnL3cV0mN5WewmHr9rBBhU3BvuZs0jBmYnsZ9bIFIV9D
        0mstv9BDRyCAMLFPsJvtRjjCGG5WRVLvmzvHyiNT5AV1J2MtbL+rcz3VA7KYo17o+Y7ZpN6IoLM7S
        a2GoYUkZaAipbGJBgvqeK9IkIvR/IXrTdTe2ZmqWMNKlxR6C3G0LSvywrEtWh+1H7DuDQm5yZ9gaR
        p/lvmcUUMiOXBas4boRm1dF3+Y63e601/0cHbOhr7VL301ghhsc16aB/uBVZzJY/eAGBGpyFumE7o
        RD+BYk/Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTpn7-008TG9-Bq; Thu, 01 Sep 2022 19:23:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0323630010B;
        Thu,  1 Sep 2022 21:23:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E8B1E2B8BD272; Thu,  1 Sep 2022 21:23:52 +0200 (CEST)
Date:   Thu, 1 Sep 2022 21:23:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH v2 10/16] objtool: Use target file class size instead of
 a compiled constant
Message-ID: <YxEGyMkLTsjoP2BP@hirez.programming.kicks-ass.net>
References: <20220829055223.24767-1-sv@linux.ibm.com>
 <20220829055223.24767-11-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829055223.24767-11-sv@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 11:22:17AM +0530, Sathvika Vasireddy wrote:
> From: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> In order to allow using objtool on cross-built kernels,
> determine size of long from elf data instead of using
> sizeof(long) at build time.
> 
> For the time being this covers only mcount.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  tools/objtool/check.c               | 16 +++++++++-------
>  tools/objtool/elf.c                 |  8 ++++++--
>  tools/objtool/include/objtool/elf.h |  8 ++++++++
>  3 files changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index a948b2551520..0ecf41ee73f0 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -851,9 +851,9 @@ static int create_ibt_endbr_seal_sections(struct objtool_file *file)
>  static int create_mcount_loc_sections(struct objtool_file *file)
>  {
>  	struct section *sec;
> -	unsigned long *loc;
>  	struct instruction *insn;
>  	int idx;
> +	int addrsize = elf_class_addrsize(file->elf);

If there is a respin, please make this a reverse-x-mas-tree thingy.

>  
>  	sec = find_section_by_name(file->elf, "__mcount_loc");
>  	if (sec) {
> @@ -869,23 +869,25 @@ static int create_mcount_loc_sections(struct objtool_file *file)

> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -1124,6 +1124,7 @@ static struct section *elf_create_rela_reloc_section(struct elf *elf, struct sec
>  {
>  	char *relocname;
>  	struct section *sec;
> +	int addrsize = elf_class_addrsize(elf);
>  

idem.
