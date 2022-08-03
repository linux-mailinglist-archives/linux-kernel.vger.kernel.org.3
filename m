Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63767588AAC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbiHCKjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbiHCKi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:38:59 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8DADF81
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 03:38:58 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LySyP0kWzz4x1J;
        Wed,  3 Aug 2022 20:38:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1659523133;
        bh=cZzR6q2FC68zDJPpV+tjLqwkyB0kdhohIKX2ZW6ahVU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KEW9aIfVu20bRph3tSKCXmLslC5VsGcwfUzOYm1MZslcIr9AYIP/4zoqQTWJ0391c
         1W8yy9NLlPyQvZdSFlwpi13uMHfiIEASKn2U0dHJMaqZUWwBg5dHR0gvFu7tpwn4Sk
         ZpOALjuJ9BGIN1npA4FJx4a7GKGM0+ECN2EtiP+7BvEg235qcaz2j5FH50/E4avAGd
         cYlfmJMBBNveyoLDCBR3gV3kmCy4B/ytDh3hxLFgxrsigD3kHein5LaAKokvexOAbO
         s/D3+NSVHju4MaQMaJXHmIyjbaVfUewfxnFX9joocEIBTn3/wGMrmzxflQG93ONquM
         ZIIVJLeSAamAQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] powerpc/ppc-opcode: Define and use PPC_RAW_TRAP()
 and PPC_RAW_TW()
In-Reply-To: <1659513939.dxqqwb8mat.naveen@linux.ibm.com>
References: <b2d762191b095530789ac8b71b167c6740bb6aed.1657205708.git.christophe.leroy@csgroup.eu>
 <52c7e522e56a38e3ff0363906919445920005a8f.1657205708.git.christophe.leroy@csgroup.eu>
 <1659513939.dxqqwb8mat.naveen@linux.ibm.com>
Date:   Wed, 03 Aug 2022 20:38:48 +1000
Message-ID: <87les5a9xj.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Naveen N. Rao" <naveen.n.rao@linux.ibm.com> writes:
> Christophe Leroy wrote:
>> Add and use PPC_RAW_TRAP() instead of opencoding.
>> 
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>  arch/powerpc/include/asm/ppc-opcode.h | 2 ++
>>  arch/powerpc/include/asm/probes.h     | 3 ++-
>>  arch/powerpc/xmon/xmon.c              | 2 +-
>>  3 files changed, 5 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
>> index 89beabf5325c..5527a955fb4a 100644
>> --- a/arch/powerpc/include/asm/ppc-opcode.h
>> +++ b/arch/powerpc/include/asm/ppc-opcode.h
>> @@ -581,6 +581,8 @@
>>  
>>  #define PPC_RAW_BRANCH(offset)		(0x48000000 | PPC_LI(offset))
>>  #define PPC_RAW_BL(offset)		(0x48000001 | PPC_LI(offset))
>> +#define PPC_RAW_TW(t0, a, b)		(0x7f000008 | ___PPC_RS(t0) | ___PPC_RA(a) | ___PPC_RB(b))
>
> Shouldn't that be 0x7c000008 ?

Yes, my script agrees.

https://github.com/mpe/misc-scripts/blob/master/ppc/ppc-instruction-encode

$ ./ppc-instruction-encode 0:31 6:t0 11:ra 16:rb 21:4 31:
.long 0x7c000008
t0 << 21
ra << 16
rb << 11


I guess the only user is PPC_RAW_TRAP() which passes t0 = 31, so that's
why nothing has broken.

Send a fixup? :)

cheers
