Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0F758E32F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiHIW1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiHIW1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:27:30 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EC75D0FF
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:27:29 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4M2SPD4sYjzDqK3;
        Tue,  9 Aug 2022 22:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1660084048; bh=Clfs8/s5EgkAhnt5gVYtFVuXJ6vl2MzKjnRcnqAKvr4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TZbiCTpLQg3kc0ahI+veCvVTIsN8sQL0Pi0UAcgHCcDcupPPUB6UINnaY5/hcZCV4
         EXK/Opv2EBWvOwsOzSC/9GVjdLjdnc4ziaOLM/pN4SWpIfgaUJVr4x75dlMnU+H+Tm
         jlq42+a4QZIQTHxWYv6ssARfd89mEchMlzmaYGvM=
X-Riseup-User-ID: 2FADD03ED1621F66C1875208BFFBBAA2CA6B609CBE6BE19B1DB2EF42D9C438CC
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4M2SPB6y6sz5vtw;
        Tue,  9 Aug 2022 22:27:26 +0000 (UTC)
Message-ID: <18e805bf-e42b-1d9f-c50f-c184f89926da@riseup.net>
Date:   Tue, 9 Aug 2022 19:27:25 -0300
MIME-Version: 1.0
Subject: Re: [PATCH v1 2/5] lib/test_cpumask: fix cpu_possible_mask last test
Content-Language: en-US
To:     Sander Vanheule <sander@svanheule.net>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
References: <cover.1660068429.git.sander@svanheule.net>
 <01cf5f4ee3a2d2ef56b19a91056496fd4d648cb1.1660068429.git.sander@svanheule.net>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <01cf5f4ee3a2d2ef56b19a91056496fd4d648cb1.1660068429.git.sander@svanheule.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/22 15:08, Sander Vanheule wrote:
> Since cpumask_first() on the cpu_possible_mask must return at most
> nr_cpu_ids - 1 for a valid result, cpumask_last() cannot return anything
> larger than this value.  As test_cpumask_weight() also verifies that the
> total weight of cpu_possible_mask must equal nr_cpu_ids, the last bit
> set in this mask must be at nr_cpu_ids - 1.
> 
> Fixes: c41e8866c28c ("lib/test: introduce cpumask KUnit test suite")
> Link: https://lore.kernel.org/lkml/346cb279-8e75-24b0-7d12-9803f2b41c73@riseup.net/
> Reported-by: Maíra Canal <mairacanal@riseup.net>
> Signed-off-by: Sander Vanheule <sander@svanheule.net>

Tested-by: Maíra Canal <mairacanal@riseup.net>

> Cc: David Gow <davidgow@google.com>
> ---
>  lib/test_cpumask.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/test_cpumask.c b/lib/test_cpumask.c
> index 4ebf9f5805f3..4d353614d853 100644
> --- a/lib/test_cpumask.c
> +++ b/lib/test_cpumask.c
> @@ -73,7 +73,7 @@ static void test_cpumask_first(struct kunit *test)
>  static void test_cpumask_last(struct kunit *test)
>  {
>  	KUNIT_EXPECT_LE(test, nr_cpumask_bits, cpumask_last(&mask_empty));
> -	KUNIT_EXPECT_EQ(test, nr_cpumask_bits - 1, cpumask_last(cpu_possible_mask));
> +	KUNIT_EXPECT_EQ(test, nr_cpu_ids - 1, cpumask_last(cpu_possible_mask));
>  }
>  
>  static void test_cpumask_next(struct kunit *test)
