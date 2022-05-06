Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C118351DCE7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242032AbiEFQJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443466AbiEFQJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:09:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778BA17A96
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:05:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14D5161DA2
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 16:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFFCC385A9;
        Fri,  6 May 2022 16:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651853130;
        bh=k61PIfiV55WK4kP+rBpqdFoAOtpID+ycBlY6nGsNLZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ovkeor8PbjlBlEsNSXmS2VrEeAHtj76pL2woUiM2PmTFewVeTw5A8Q71LIBut9zd4
         6xj0KK2MNFixhWlNmdQaag4uyxHTPMGJNvuik3u+bqGh/IzKnFaKg+XmRSGKlkLJFV
         7NwRadeUhJd3ox6GcEvbA/nVMkDP6Fnlv/oJsB/Tz7yP3RT4oynCy8NPBSVU9RctSX
         bqVuGmSRjI4LgwPUROUZcMOWS7XWwHGUGrD8dMXRTzBZZb+Ij9nxsMeJS5PgxN4gyK
         ZDpghq/7zC+gJUb3tZZOqnrd7H7JcJsAJBsXj9UXBuBovcmjwyli7TPZo3tyub6b1i
         +AAS98CmX1l0Q==
Date:   Fri, 6 May 2022 09:05:28 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        brgerst@gmail.com, jiangshanlai@gmail.com,
        Andrew.Cooper3@citrix.com, mark.rutland@arm.com
Subject: Re: [PATCH 6/6] objtool: Fix STACK_FRAME_NON_STANDARD reloc type
Message-ID: <20220506160528.kexxny6kcpf3gnie@treble>
References: <20220506121431.563656641@infradead.org>
 <20220506121631.508692613@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220506121631.508692613@infradead.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 02:14:37PM +0200, Peter Zijlstra wrote:
> STACK_FRAME_NON_STANDARD results in inconsistent relocation types
> depending on .c or .S usage:
> 
>   Relocation section '.rela.discard.func_stack_frame_non_standard' at offset 0x3c01090 contains 5 entries:
>   Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
>   0000000000000000  00020c2200000002 R_X86_64_PC32          0000000000047b40 do_suspend_lowlevel + 0
>   0000000000000008  0002461e00000001 R_X86_64_64            00000000000480a0 machine_real_restart + 0
>   0000000000000010  0000001400000001 R_X86_64_64            0000000000000000 .rodata + b3d4
>   0000000000000018  0002444600000002 R_X86_64_PC32          00000000000678a0 __efi64_thunk + 0
>   0000000000000020  0002659d00000001 R_X86_64_64            0000000000113160 __crash_kexec + 0
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh
