Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AC15AA8DB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbiIBHkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbiIBHkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:40:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC221C107
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 00:40:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MJqZd3SdQz4xD3;
        Fri,  2 Sep 2022 17:40:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1662104428;
        bh=NeXxW+9N3skjzMTPgfxhJL+s6krkN3MaKG4hR660B9I=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MHJKQ5Gf3tD/Q0iRbZUR791dPvFcchhyDYV0jW4eUA5CgfJfqEi8c4W+LkBrjKYKm
         Z6qUzfVyde6/yg1ZSq6uq/B7sw95CECvhvmQMls0b3KSucxlYYpW4AODGdTm8oAsg7
         8YpQyASHlKdtSoj1JhDVZeTdWrBJzVvCTTeLfyAg1Mx8vrYoDLPJrj8hmAhqj7FP4a
         QRoD1IBnPdviiQQ0udUQW5B6NUCRVXhKgXtNE2XYlEBKHVt5IxkraTkxGjS+zcTvEa
         txTDdC9VpA3LgQTj/ZH7ZLYogv06GbRmXQqUmpHvnfTGYVbCjT4S0LWC0AimKVlc2I
         5wENMGMy0f6XA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Peter Zijlstra <peterz@infradead.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mingo@redhat.com,
        christophe.leroy@csgroup.eu, rostedt@goodmis.org, mbenes@suse.cz,
        npiggin@gmail.com, chenzhongjin@huawei.com,
        naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH v2 07/16] powerpc: Skip objtool from running on VDSO files
In-Reply-To: <YxEFxJk+2fog+oRx@hirez.programming.kicks-ass.net>
References: <20220829055223.24767-1-sv@linux.ibm.com>
 <20220829055223.24767-8-sv@linux.ibm.com>
 <YxEFxJk+2fog+oRx@hirez.programming.kicks-ass.net>
Date:   Fri, 02 Sep 2022 17:40:24 +1000
Message-ID: <87r10uteaf.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Mon, Aug 29, 2022 at 11:22:14AM +0530, Sathvika Vasireddy wrote:
>> Do not run objtool on VDSO files, by using
>> OBJECT_FILES_NON_STANDARD
>> 
>> Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
>> ---
>>  arch/powerpc/kernel/vdso/Makefile | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
>> index 096b0bf1335f..a49a0d6a1c53 100644
>> --- a/arch/powerpc/kernel/vdso/Makefile
>> +++ b/arch/powerpc/kernel/vdso/Makefile
>> @@ -102,3 +102,5 @@ quiet_cmd_vdso64ld_and_check = VDSO64L $@
>>        cmd_vdso64ld_and_check = $(VDSOCC) $(c_flags) $(CC64FLAGS) -o $@ -Wl,-T$(filter %.lds,$^) $(filter %.o,$^) ; $(cmd_vdso_check)
>>  quiet_cmd_vdso64as = VDSO64A $@
>>        cmd_vdso64as = $(VDSOCC) $(a_flags) $(CC64FLAGS) $(AS64FLAGS) -c -o $@ $<
>> +
>> +OBJECT_FILES_NON_STANDARD := y
>
> Just to clarify; your linker script will place the VDSO in .rodata or a
> similar !.text section, right?

Not the linker script, but we incbin it into .data.

See arch/powerpc/kernel/vdso64_wrapper.S

cheers
