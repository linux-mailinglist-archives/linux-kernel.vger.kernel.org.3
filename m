Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478364B1B19
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346744AbiBKBU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:20:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346731AbiBKBUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:20:24 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A467267F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:20:24 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id o2so13705924lfd.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p20Mnkh2w9fHFzqQS240a6Li74kH9AJpNbVo4YqzCTM=;
        b=muUwC1dkv3stGMotFKnvE8Qz9eFh2FcXMX+VRGDLc7hwU3znP5MNvzjTpkRPpsf2dH
         sOFo678SZ/qYn/VDuxWnsMOz0flJtziwoLc8AHdZqr4geurwy+406IjoH+8lc5tiRExY
         E5YJPGkuu+Gk0+v3T9hJXON3IKeHGX7hId+YNJaxWhDJgnL6zYiNGsEU9fkhoPqXOMAq
         DzAa/V5QRL1hFBvunZlxEel3O4n/8KSUuleXNm/4vawDjkXpwGsLf3ogsHdHZc16GkYU
         6bSWH8ISB6Lq7CW55tA9crfpJCRzP9MoRHr4SyPWEKFfG5OmjTxApwXfxSh9gFde80Km
         qGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p20Mnkh2w9fHFzqQS240a6Li74kH9AJpNbVo4YqzCTM=;
        b=GEG9zJFVLi1NmL6mRFw5gUS/n1zCbjvNlV1PqbmfVmn441QGDQjJYhVwqw/+zwGJ/I
         Zo9IrRwLFeg56uqkHUWN+roLNI+qUDN5MW0dlAsylGabJZgGj1v6Zk/XyyygeQo3lCD+
         FoE5OUkljPuUY9b4UfBpBv9Zw230Ac/tpQsLzF2KrWxbRqs9w07EbCSrqI7lZeCp7vNy
         nrheP89tfZ6bxdsgO3bz6nG15MptgpIVGwL+DrKWb97jDYrYP4MKpqeCgJlTVrKV58Z4
         h3aO3EqA9WAWtgHmsOYFn8eR08T+27ZKD1krmxQ4BGB5GxXlCfXNoTusqR7zCy49zssW
         bY4w==
X-Gm-Message-State: AOAM530Oiys/7IJp/HNuISkc5FjaHnxgHap977g6zMXiDY5xxfANqKVQ
        A/T5acCNuGBXK6MrkTHajm2hLraoBfAOvjZPmmLbbA==
X-Google-Smtp-Source: ABdhPJxg4mMwdgYMDoe7+u/+SFYFaScNg4KRbuYQdxOANLojmsumlh2QdGPGUC9Qd0iLQOKPq42g0emjDbKZCX2/Zyw=
X-Received: by 2002:ac2:5627:: with SMTP id b7mr7108700lff.489.1644542422012;
 Thu, 10 Feb 2022 17:20:22 -0800 (PST)
MIME-Version: 1.0
References: <20220125113200.3829108-1-mark.rutland@arm.com>
 <20220125113200.3829108-3-mark.rutland@arm.com> <YgUmvuJYfycnhODA@FVFF77S0Q05N>
In-Reply-To: <YgUmvuJYfycnhODA@FVFF77S0Q05N>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 10 Feb 2022 17:20:10 -0800
Message-ID: <CAKwvOdmWV6AL2RM2SQNYQ7fu3kQwPf+W57LZ_szrfZm2eLtBcw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] linkage: add SYM_{ENTRY,START,END}_AT()
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>, acme@redhat.com,
        ardb@kernel.org, bp@alien8.de, broonie@kernel.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        jpoimboe@redhat.com, jslaby@suse.cz,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        will@kernel.org, llvm@lists.linux.dev,
        James Y Knight <jyknight@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 6:52 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Both GCC and clang are happy to treat labels as constant expressions:
>
> | [mark@lakrids:~/asm-test]% cat test-label.S
> |         .text
> |
> | start:
> |         nop
> | end:
> |
> |         .if (end - start) == 0
> |         .err
> |         .endif
> |
> | [mark@lakrids:~/asm-test]% usekorg 11.1.0 aarch64-linux-gcc -c test-label.S
> | [mark@lakrids:~/asm-test]% usellvm 13.0.0 clang --target=aarch64-linux -c test-label.S
>
> ... but only GCC is happy to treat symbol definitions as constants:
>
> | [mark@lakrids:~/asm-test]% cat test-symbol.S
> |         .text
> |
> | .set start, .;
> |         nop
> | .set end, .;
> |
> |         .if (end - start) == 0
> |         .err
> |         .endif
> |
> | [mark@lakrids:~/asm-test]% usekorg 11.1.0 aarch64-linux-gcc -c test-symbol.S
> | [mark@lakrids:~/asm-test]% usellvm 13.0.0 clang --target=aarch64-linux -c test-symbol.S
> | test-symbol.S:7:6: error: expected absolute expression
> |  .if (end - start) == 0
> |      ^
> | test-symbol.S:8:2: error: .err encountered
> |  .err
> |  ^
>
> This is obviously a behavioural difference, but I'm not sure whether it's
> intentional, or just an artifact of the differing implementation of GNU as and
> LLVM's integrated assembler. Nich, Nathan, any thoughts on that?
>
> Does clang have any mechanism other than labels to define location constants
> that can be used as absolute expressions? e.g. is there any mechanism to alias
> a label which results in the alias also being a constant?

s/constant/absolute/

Nothing off the top of my head comes to mind as a substitute that will
work as expected today.

I've filed https://github.com/llvm/llvm-project/issues/53728 to
discuss more with folks that understand our AsmParser better.

From what I can tell, our AsmParser is falling down because the
operands of the binary expression themselves are not considered
absolute.

I doubt we will be able to handle the general case of symbol
differencing; the symbol reference operands could refer to symbols in
different sections that haven't been laid out yet (or whose order
could be shuffled by the linker).  But if they're in the same section
(or "fragment" of a section), we might be able to special case this.

For the expression

> .if (qwerty_fiqin_end - qwerty_fiqin_start) > (0x200 - 0x1c)

can you use local labels (`.L` prefix) rather than symbolic
references? or is there a risk of them not being unique per TU?
-- 
Thanks,
~Nick Desaulniers
