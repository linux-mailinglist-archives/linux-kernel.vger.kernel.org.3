Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F6C53A604
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353285AbiFANiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240364AbiFANh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:37:58 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEB55DBC3;
        Wed,  1 Jun 2022 06:37:56 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9C2F7723;
        Wed,  1 Jun 2022 13:37:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9C2F7723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1654090675; bh=CCyKZaTM8cScZ+FvD4o5tkWic0mc4WYiquvF86vt/9s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=PYnjYLYiNnXb5BtrzwaY8VjScATB8FXb0qV68vyWL3ZYAiBRYd/4hZ3kunTyeBHZ6
         brg1zsGRX1hfURW2AUDJYJHTWZpd1DAdVsdyXBXDEMfXoh8u8vM/EUBwMACxFVRqxa
         o9uNVwSNwLR9pYR1mp3WS0GQ6NPkQhDKzrAmKbGpien5GjZsDJ1+9HntOnnygfPJki
         vSKZv5M4jodGaAVU6K/9orrduBQvVBUYixGM3u8S3b5y3rk56QpvC1Ptxw0Fo2GKsf
         v/HtyTRTtA16qJTA5Vo6Rv4Csjgj1EZuxM4Ov4BF9wcKfZIGyRPZfbVqTCqNpDBkn+
         vt3FiUYtQZP9w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Vegard Nossum <vegard.nossum@oracle.com>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Amit Shah <aams@amazon.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Solar Designer <solar@openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tyler Hicks <tyhicks@canonical.com>,
        Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH] Documentation/security-bugs: overhaul
In-Reply-To: <20220531230309.9290-1-vegard.nossum@oracle.com>
References: <20220531230309.9290-1-vegard.nossum@oracle.com>
Date:   Wed, 01 Jun 2022 07:38:05 -0600
Message-ID: <87ilpk5wsi.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vegard Nossum <vegard.nossum@oracle.com> writes:

> The current instructions for reporting security vulnerabilities in the
> kernel are not clear enough, in particular the process of disclosure
> and requesting CVEs, and what the roles of the different lists are and
> how exactly to report to each of them.
>
> Let's give this document an overhaul. Goals are stated as a comment at
> the top of the document itself (these will not appear in the rendered
> document).

...but they do appear in the plain-text document, which must also be
readable.  Thus...

[...]

> diff --git a/Documentation/admin-guide/security-bugs.rst b/Documentation/admin-guide/security-bugs.rst
> index 82e29837d5898..5f37b3f1e77dc 100644
> --- a/Documentation/admin-guide/security-bugs.rst
> +++ b/Documentation/admin-guide/security-bugs.rst
> @@ -1,96 +1,175 @@
> +..
> +    If you modify this document, please consider the following:
> +    
> +    1) The most important information should be at the top (preferably in
> +    the opening paragraph). This means contacting <security@kernel.org>;
> +    if somebody doesn't read any further than that, at least the security
> +    team will have the report.

I submit that you are breaking your own rule by putting this stuff at
the top of the document.  I'm not really convinced that you need it at
all - we don't normally include these sort of instructions - but if it
has to be here I would put it at the end.

[Haven't had a chance to look at the real material yet]

Thanks,

jon
