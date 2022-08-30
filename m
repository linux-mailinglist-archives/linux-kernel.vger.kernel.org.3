Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403615A5FA3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiH3Jlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiH3Jli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:41:38 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6C2A00F8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:41:36 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id x10so10728327ljq.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=BboZ2k1ZrLnFL+YAv3p1DNTGY12X8IX6koEiGVuEdyc=;
        b=UPoRIAAcwSc7ixggxm/4UNxqVh0Sp3YCJY3ez0W6zobW3ra9FNBlhQVYkTXv7NSNLo
         WSCdPHX7Ii5sWVpM7BBnxpKWFIp3jAktVLcYIvyGSHjqoIKKQb12d5fFJrYUJo8zYum2
         6D58sEOpfhcpwUhg3hcpDvjwdtLKTbhw39V08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=BboZ2k1ZrLnFL+YAv3p1DNTGY12X8IX6koEiGVuEdyc=;
        b=ERuI7O7Enii9WmFa7PtOZeCK88Kyb3l4w+jq6CNkdJ+Fr1blmG62n2tJ7TOmArAluu
         hyY6qqaHeD9BDK3XiTjhaXkzgH/pVD7JiH0h4+g1LUWhUPr5k+Z0sC7H4f3wMU8vxD3F
         bQUO3Vk7awgY1tViiCXD2SdUPyD3EN2RTxutXylPi7Zx54VB1p9Q08Q25d3rKfRDaP7u
         I6WgYw5LDZrHCoyujIrt53tw0Bj6CKQlqSFOkHonqZJ/v8TUa3h31DoeBiAoGtXWIJMJ
         eA2BOaalyTpc/Cxuom0MspZJ3UXRviqarfHe8MyeMIMqYxxyro4bUIMPeEN20OpIkuF3
         2eZg==
X-Gm-Message-State: ACgBeo3JWu1CDNIhxNWPVMNFBnuu+zMfWIlRaQhGAfHfK2z9qF6JVlfl
        557qJPoNZgsR4AF9nzeSAKhwuw==
X-Google-Smtp-Source: AA6agR7gRZiPDe17h7Jn6oLM9xgWEhASKU/qgUVXfvqIZ40YDDniqIb0SfOfZhBDwd0in9ZhvkDp+g==
X-Received: by 2002:a2e:86c6:0:b0:266:8f88:9689 with SMTP id n6-20020a2e86c6000000b002668f889689mr1738197ljj.515.1661852495165;
        Tue, 30 Aug 2022 02:41:35 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id x12-20020a05651c104c00b0025e6de76589sm1629759ljm.106.2022.08.30.02.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 02:41:33 -0700 (PDT)
Message-ID: <d2399574-ec64-7765-b6ef-1e792a7e0d5c@rasmusvillemoes.dk>
Date:   Tue, 30 Aug 2022 11:41:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] testing/selftests: Add tests for the is_signed_type()
 macro
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Isabella Basso <isabbasso@riseup.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sander Vanheule <sander@svanheule.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yury Norov <yury.norov@gmail.com>
References: <20220826162116.1050972-1-bvanassche@acm.org>
 <20220826162116.1050972-2-bvanassche@acm.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20220826162116.1050972-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2022 18.21, Bart Van Assche wrote:
> Although not documented, is_signed_type() must support the 'bool' and
> pointer types next to scalar and enumeration types. Add a selftest that
> verifies that this macro handles all supported types correctly.
> 

> +static void is_signed_type_test(struct kunit *test)
> +{
> +	KUNIT_EXPECT_EQ(test, is_signed_type(bool), false);
> +	KUNIT_EXPECT_EQ(test, is_signed_type(signed char), true);
> +	KUNIT_EXPECT_EQ(test, is_signed_type(unsigned char), false);

Nice. You could consider adding

#ifdef __UNSIGNED_CHAR__
KUNIT_EXPECT_EQ(test, is_signed_type(char), false);
#else
KUNIT_EXPECT_EQ(test, is_signed_type(char), true);
#endif

The kernel depends on the compiler providing __UNSIGNED_CHAR__ in two
places (one in ext4, one in printf test suite).

> +	KUNIT_EXPECT_EQ(test, is_signed_type(int), true);
> +	KUNIT_EXPECT_EQ(test, is_signed_type(unsigned int), false);
> +	KUNIT_EXPECT_EQ(test, is_signed_type(long), true);
> +	KUNIT_EXPECT_EQ(test, is_signed_type(unsigned long), false);
> +	KUNIT_EXPECT_EQ(test, is_signed_type(long long), true);
> +	KUNIT_EXPECT_EQ(test, is_signed_type(unsigned long long), false);
> +	KUNIT_EXPECT_EQ(test, is_signed_type(enum unsigned_enum), false);
> +	KUNIT_EXPECT_EQ(test, is_signed_type(enum signed_enum), true);

Yeah. But enum types are one of the weirdest aspects of C. Taking your
example and expanding with a positive value that doesn't fit an int:

#include <stdio.h>

#define is_signed_type(t) ((t)-1 < (t)1)

#define typeinfo(t) printf("%-24s signed %d, size %zu\n", #t,
is_signed_type(t), sizeof(t))

enum unsigned_enum {
	constant_a = 3,
	constant_d = 3000000000,
};

enum signed_enum {
	constant_b = -1,
	constant_c = 2,
};

int main(int argc, char *argv[])
{
	enum unsigned_enum a = constant_a;
	enum unsigned_enum d = constant_d;
	enum signed_enum b = constant_b;
	enum signed_enum c = constant_c;

	typeinfo(enum unsigned_enum);
	typeinfo(enum signed_enum);
	typeinfo(typeof(constant_a));
	typeinfo(typeof(constant_b));
	typeinfo(typeof(constant_c));
	typeinfo(typeof(constant_d));

	typeinfo(typeof(a));
	typeinfo(typeof(b));
	typeinfo(typeof(c));
	typeinfo(typeof(d));

	return 0;
}

This gives me

enum unsigned_enum       signed 0, size 4
enum signed_enum         signed 1, size 4
typeof(constant_a)       signed 1, size 4
typeof(constant_b)       signed 1, size 4
typeof(constant_c)       signed 1, size 4
typeof(constant_d)       signed 0, size 4
typeof(a)                signed 0, size 4
typeof(b)                signed 1, size 4
typeof(c)                signed 1, size 4
typeof(d)                signed 0, size 4

That is, typeof(constant_a) is not the same type (different signedness)
as enum unsigned_enum! While both constant_d (due to its size) and
variables declared as 'enum unsigned_enum' do indeed have that
underlying unsigned type.

At least gcc and clang agree on this weirdness, but I haven't been able
to find a spec mandating this. Anyway, this was just an aside.

Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
