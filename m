Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3621C549D85
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349683AbiFMTWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343931AbiFMTVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:21:36 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C455E110B;
        Mon, 13 Jun 2022 10:18:08 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0A335736;
        Mon, 13 Jun 2022 17:18:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0A335736
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1655140688; bh=c6lIsFQ+NWEImD41NwrKBPBx7AxmBW0WsXXocbKtZ3Q=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HPiyOJpDMdEGGeZSyRLvvB0lyI08Vz4LJhuP+R8C6aAeLLjgfB0h/TyvkVu5v1LNL
         XGicJSLAO9iuy+kEuNncqAVlORTHKxOHXvePMI4oZimAdvcTzuzhPRp9OcwVjs/tm0
         H+CprU+qGn9dwV+ZAIgc12wSx6cPwDUpNHh7z09L012UqYilubpMCXmP3m7gcosqUm
         b9crKXu+FvsgH2vJJHJD1AuTEtCIbfk+j1+HxulpJHI2tH+wALlcVc2/jkxLyYErST
         +NJbsqqRLtdOq8LNy4shyWHQNXusfw6k2/lIOKeGWL15jMDjRu+aSc402EA0GCyEaD
         27PPFWsecTDSQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, oss-drivers@corigine.com,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@corigine.com>
Subject: Re: [PATCH v2] scripts: kernel-doc: Always increment warnings counter
In-Reply-To: <20220613090510.3088294-1-niklas.soderlund@corigine.com>
References: <20220613090510.3088294-1-niklas.soderlund@corigine.com>
Date:   Mon, 13 Jun 2022 11:18:07 -0600
Message-ID: <87h74o1nzk.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Niklas S=C3=B6derlund <niklas.soderlund@corigine.com> writes:

> Some warnings do not increment the warnings counter making the behavior
> of running kernel-doc with -Werror unlogical as some warnings will be
> generated but not treated as errors.
>
> Fix this by creating a helper function that always incrementing the
> warnings counter every time a warning is emitted. There is one location
> in get_sphinx_version() where a warning is not touched as it concerns
> the execution environment of the kernel-doc and not the documentation
> being processed.
>
> Incrementing the counter only have effect when running kernel-doc in
> either verbose mode (-v or environment variable KBUILD_VERBOSE) or when
> treating warnings as errors (-Werror or environment variable
> KDOC_WERROR). In both cases the number of warnings printed is printed to
> stderr and for the later the exit code of kernel-doc is non-zero if
> warnings where encountered.
>
> Simple test case to demo one of the warnings,
>
>     $ cat test.c
>     /**
>      * foo() - Description
>      */
>     int bar();
>
>     # Without this change
>     $ ./scripts/kernel-doc -Werror -none test.c
>     test.c:4: warning: expecting prototype for foo(). Prototype was for
>     bar() instead
>
>     # With this change
>     $ ./scripts/kernel-doc -Werror -none test.c
>     test.c:4: warning: expecting prototype for foo(). Prototype was for
>     bar() instead
>     1 warnings as Errors
>
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund@corigine.com>
> ---
> * Changes since v1
> - Added a helper emit_warning() to print the message and increment the
>   counter instead of adding statements to increment the counter where it
>   was missing.

Thanks for making this change.  Anything that rationalizes this horrific
script even a little bit is more than welcome.

I've applied the patch, thanks.

jon
