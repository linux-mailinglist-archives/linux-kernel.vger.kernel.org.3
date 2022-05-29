Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452EC5371D5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 19:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiE2RE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 13:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiE2REY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 13:04:24 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BCC84A14
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 10:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=BLA4aQRvfntqLMm99a+1xZPVRcOluvd10rffKGFrc10=;
        t=1653843862; x=1655053462; b=nEM4ayaSXa19ifF6VUJVLPIsXrOLCakZlQEfnPxHYRwUNWQ
        sX6843SuagJYeQkiR6oJNqPHep5/uFNAkqvu0y3Mm+6jrNYuxnqmu8vIFP9Gt1Xg71+CMNigVRl/6
        lYUiE0D9+lFJ9MPAyXKKCLR+rQSTT3LIIVm5iGXwoI/gSchcJ3kT1dIpBLg/EcP5DbIXdtl/jgkBK
        LpO6UQHZ+nG1lI3hI9VlhUM7wDOi6lVhAaxWRGPo5ftlEYZHXk6nY/sAESrtcyvAQwgPA+5CARBbH
        j386URRSDpJn1Aj3NwsyXwCby7/sJ4QShWKrVHLvWozMGi54dtyhgZKNaQXvjbCQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nvMKn-007myT-UG;
        Sun, 29 May 2022 19:04:10 +0200
Message-ID: <1a4e51a4d2ed51e7ae1ff55bd4da6a47fad7c0bf.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/2] UML: add support for KASAN under x86_64
From:   Johannes Berg <johannes@sipsolutions.net>
To:     David Gow <davidgow@google.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>, linux-mm@kvack.org
Date:   Sun, 29 May 2022 19:04:08 +0200
In-Reply-To: <20220527185600.1236769-2-davidgow@google.com>
References: <20220527185600.1236769-1-davidgow@google.com>
         <20220527185600.1236769-2-davidgow@google.com>
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

On Fri, 2022-05-27 at 11:56 -0700, David Gow wrote:
>=20
> The UML-specific KASAN initializer uses mmap to map the roughly 2.25TB

You say 2.25TB here, and
=20
> +config KASAN_SHADOW_OFFSET
> +	hex
> +	depends on KASAN
> +	default 0x100000000000
> +	help
> +	  This is the offset at which the ~2.25TB of shadow memory is

here too, of course.

But I notice that I get ~16TB address space use when running,

> +/* used in kasan_mem_to_shadow to divide by 8 */
> +#define KASAN_SHADOW_SCALE_SHIFT 3
> +
> +#ifdef CONFIG_X86_64
> +#define KASAN_HOST_USER_SPACE_END_ADDR 0x00007fffffffffffUL
> +/* KASAN_SHADOW_SIZE is the size of total address space divided by 8 */
> +#define KASAN_SHADOW_SIZE ((KASAN_HOST_USER_SPACE_END_ADDR + 1) >> \
> +			KASAN_SHADOW_SCALE_SHIFT)

because this ends up being 0x100000000000, i.e. 16 TiB.

Is that intentional? Was something missed? Maybe
KASAN_HOST_USER_SPACE_END_ADDR was too big?

It doesn't really matter, but I guess then the documentation should be
updated.

johannes
