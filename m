Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D00C51D684
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 13:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391272AbiEFLXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 07:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243024AbiEFLXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 07:23:42 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCC45DA36
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 04:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1651835994;
        bh=58oURv2d1sC3UHpxw7+6haohpmNCYl41EdKlr3w1Gzs=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=rvRyz0Ty4ATkdIMBIHIdYONhNe2YlbhcwWSrfooDFsQJnvKfp2c0Cez0KAyMxmAPt
         3B0P3qDYuTN4e2t5lelQBef5mvIqr+cBBZJsMKQF1317pJ4wc0La9yYVZbJYjsAhjA
         wy8cfSVRmK3GBfw+O/Q3/owPxgHBeMoEOubUByV8=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 01D4D12868AC;
        Fri,  6 May 2022 07:19:54 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QzPQXx1m3v7s; Fri,  6 May 2022 07:19:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1651835993;
        bh=58oURv2d1sC3UHpxw7+6haohpmNCYl41EdKlr3w1Gzs=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=cAIErAhXSrfSYxHPIDMU2Hy+rQ0GY1U1TOPJy96YHxQErIgBAR+1zcUr90dCnkQ+f
         iIOTTzVLJ/lsCZLxlhyq4UbbXOzrPHO9g7F28fzugCtsQUhra9+kVRVEt3zD0d6w+Z
         XIQ7CkKROdKS/AErgxI8vBAn6sI6c2vh9U0ek9uA=
Received: from [172.20.4.189] (unknown [173.211.218.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 0687A1286866;
        Fri,  6 May 2022 07:19:52 -0400 (EDT)
Message-ID: <7e20c844dadacb3dac822220ca108f4d786ceb7d.camel@HansenPartnership.com>
Subject: Re: [PATCH v1 1/3] kallsyms: avoid hardcoding the buffer size
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     rust-for-linux@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>
Date:   Fri, 06 May 2022 07:19:51 -0400
In-Reply-To: <20220505191704.22812-2-ojeda@kernel.org>
References: <20220505191704.22812-1-ojeda@kernel.org>
         <20220505191704.22812-2-ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-05 at 21:16 +0200, Miguel Ojeda wrote:
> From: Boqun Feng <boqun.feng@gmail.com>
> 
> This makes it easier to update the size later on.
> 
> Furthermore, a static assert is added to ensure both are updated
> when that happens. The relationship used is one that keeps the new
> size (512+1) close to the original buffer size (500).
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  scripts/kallsyms.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 8caabddf817c..880c4404731b 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -27,8 +27,18 @@
>  
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
>  
> +#define _stringify_1(x)	#x
> +#define _stringify(x)	_stringify_1(x)
> +
>  #define KSYM_NAME_LEN		128
>  
> +/* A substantially bigger size than the current maximum. */
> +#define KSYM_NAME_LEN_BUFFER	512
> +_Static_assert(
> +	KSYM_NAME_LEN_BUFFER == KSYM_NAME_LEN * 4,
> +	"Please keep KSYM_NAME_LEN_BUFFER in sync with KSYM_NAME_LEN"
> +);
> +
>  struct sym_entry {
>  	unsigned long long addr;
>  	unsigned int len;
> @@ -197,15 +207,15 @@ static void check_symbol_range(const char *sym,
> unsigned long long addr,
>  
>  static struct sym_entry *read_symbol(FILE *in)
>  {
> -	char name[500], type;
> +	char name[KSYM_NAME_LEN_BUFFER+1], type;

When you raise KSYM_NAME_LEN to 512, this on stack allocation becomes
2049 bytes.  How did you manage not to trigger the frame size warning,
which is 1024 on 32 bit and 2048 on 64 bit by default?

James

