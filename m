Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBC15A9FC2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbiIATSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbiIATSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:18:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEA674BAB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 12:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xsPsFUacKALvy0iN36SZwsKJ9Pd26W49L4HYw/L2SpU=; b=owrDPyPtRLbddHDYRReZ94YIJF
        CawjrDXM1L0q5fKm7giYew2pszCLLa/RbvF/dsiAxklDviJlSn20eO/9c34cDsp9c7mc/tWrgBLl/
        QNGp200ArpeseWsY2hfozXccfSlEpMALDPXrFVMjgP4E3wTr1Lqls9ukqMX2cERoZQLvjd8DerGrQ
        bYL7r2tZjhhwPkYMpG6XqfyT/R7EOoWxldYofzEZ9AHS7RvMgkyPQHow6HVtHTOHWjUI/SOLVO5FK
        ExbQmbyrL1glq1QPt7f32AIB+55DiA2QJI4HTkmzWyXe3FbSXdPmxXYSsrijfgW2LHwRdDEupm0J8
        mGsmj9/Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTphQ-006ILq-Nc; Thu, 01 Sep 2022 19:18:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A1C33300230;
        Thu,  1 Sep 2022 21:17:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89DA32B8BD272; Thu,  1 Sep 2022 21:17:57 +0200 (CEST)
Date:   Thu, 1 Sep 2022 21:17:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH v2 05/16] powerpc: Skip objtool from running on
 drivers/crypto/vmx/aesp8-ppc.o
Message-ID: <YxEFZXCnCH7F8yku@hirez.programming.kicks-ass.net>
References: <20220829055223.24767-1-sv@linux.ibm.com>
 <20220829055223.24767-6-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829055223.24767-6-sv@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 11:22:12AM +0530, Sathvika Vasireddy wrote:
> With objtool enabled, below warnings are seen when trying to build:
> 
> drivers/crypto/vmx/aesp8-ppc.o: warning: objtool: aes_p8_set_encrypt_key+0x44: unannotated intra-function call
> 
> drivers/crypto/vmx/aesp8-ppc.o: warning: objtool: .text+0x2448: unannotated intra-function call
> 
> drivers/crypto/vmx/aesp8-ppc.o: warning: objtool: .text+0x2d68: unannotated intra-function call
> 
> Skip objtool from running on this file, for two main reasons:
> 
> Since this file comes from OpenSSL, and since it is a perl file
> which generates a .S file, it may not be the best choice to
> make too many code changes to such files, unless absolutely
> necessary.
> 
> Second reason is that, at least as far as the objtool --mcount
> functionality is concerned, we do not have to run objtool on
> that file because that file does not have any calls to _mcount.
> 
> Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
> ---
>  drivers/crypto/vmx/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/crypto/vmx/Makefile b/drivers/crypto/vmx/Makefile
> index 2560cfea1dec..7b41f0da6807 100644
> --- a/drivers/crypto/vmx/Makefile
> +++ b/drivers/crypto/vmx/Makefile
> @@ -9,3 +9,5 @@ targets += aesp8-ppc.S ghashp8-ppc.S
>  
>  $(obj)/aesp8-ppc.S $(obj)/ghashp8-ppc.S: $(obj)/%.S: $(src)/%.pl FORCE
>  	$(call if_changed,perl)
> +
> +OBJECT_FILES_NON_STANDARD_aesp8-ppc.o := y

Just be aware that the moment you start to run objtool on vmlinux.o this
annotation becomes unstuck.

Specifically things like LTO builds require this because there simply
isn't an object file before that.
