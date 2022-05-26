Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9060534C84
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 11:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344403AbiEZJ3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 05:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbiEZJ3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 05:29:36 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADF0C8BD3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 02:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=qHlaIf1SKEc8acyjb+0lgUrClk4IwVEQpDXem5UwINU=;
        t=1653557374; x=1654766974; b=tGYxo17KXtr9rBdWiQzlvRg5RVhJ4P1Rwh342Pjiu6v2UMo
        Ee+vDwH4Y6OZh1TIR4+76jGql1fIZg1SypccjlZs4k1M8eyHVnapwJdnWwivjElQxTOO9TjMsEh5K
        wtB+0LsuJohltQAPKNqv2MZrGG6T+bMH413thSKdQn3QJ2/9CkX+WSIhcK6E9RsxBdTs1YWOd2LsY
        sALgnMAcnwu8ae9l6OgVhikL/IrDfpxdFLDUKzh4toUZ4Bxo2foQXzxnkcbS55gPe4XnpEPVtqW+O
        agCECPjEmTDNVFMui/ZiezChe+5vsfIiTL/aWOluIFQZNsGsBc31a/Yv+34XLqFw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nu9o1-0055HB-74;
        Thu, 26 May 2022 11:29:21 +0200
Message-ID: <d5558b1a1ce7e1cb878f12462ae63a4d7b1b17a1.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v3] UML: add support for KASAN under x86_64
From:   Johannes Berg <johannes@sipsolutions.net>
To:     David Gow <davidgow@google.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>
Date:   Thu, 26 May 2022 11:29:20 +0200
In-Reply-To: <20220526010111.755166-1-davidgow@google.com>
References: <20220525111756.GA15955@axis.com>
         <20220526010111.755166-1-davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-25 at 18:01 -0700, David Gow wrote:
>=20
> +#ifdef CONFIG_KASAN
> +void kasan_init(void)
> +{
> +	/*
> +	 * kasan_map_memory will map all of the required address space and
> +	 * the host machine will allocate physical memory as necessary.
> +	 */
> +	kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
> +	init_task.kasan_depth =3D 0;
> +	os_info("KernelAddressSanitizer initialized\n");
>=20

Can we remove this? Or maybe print it later somehow, when the other
KASAN machinery initializes?

As it is, this gets printed even if you run just "./linux --version" or
"--help", which is a bit strange.

johannes
