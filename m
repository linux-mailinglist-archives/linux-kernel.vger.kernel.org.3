Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6E2545134
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242382AbiFIPsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbiFIPsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:48:52 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D1E51584;
        Thu,  9 Jun 2022 08:48:51 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BF199732;
        Thu,  9 Jun 2022 15:48:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BF199732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1654789730; bh=wzS4sH2vP/NmHZejwgyf+MxzmvQDlQlgWpCRyix8Jtw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YvqV3u3gaSodZonxEOQl7lpMs4fYJiNOq9svxxs3OUkua7GmJNRqkJqdwsxqEgoR7
         91rJzPbzIh2Ex5HR/7NMRz/Z1b0nJHk/N8sUAnuqR3TfHRu7drhB3pEvYFXQwV5/Sm
         SAOMwaGXWoVSIp+TFRcyvxrwx7XEoplRrLYyPGjhrEbLAPklA0MVsp1GRZejXR726U
         CZu+I3vpshVYT1nN/D+S1fp9HJ+CbreFVhdx7YTr1zz0MaCAkrPfykSQpt4w7y/KGR
         PnZDeiIStPVmexsHTbnP+6xw35dhhyE5zVOOKig1CH7tTdzIcRXj6H0huPaHxoJGz/
         dL2wxsl2XccPA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, oss-drivers@corigine.com,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>,
        Louis Peens <louis.peens@corigine.com>
Subject: Re: [PATCH] scripts: kernel-doc: Always increment warnings counter
In-Reply-To: <20220608142601.832926-1-niklas.soderlund@corigine.com>
References: <20220608142601.832926-1-niklas.soderlund@corigine.com>
Date:   Thu, 09 Jun 2022 09:48:50 -0600
Message-ID: <87mtel4z31.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Niklas S=C3=B6derlund <niklas.soderlund@corigine.com> writes:

> Some warnings did not increment the warnings counter making the behavior
> of running kernel-doc with -Werror unlogical as some warnings would be
> generated but not treated as errors.
>
> Fix this by always incrementing the warnings counter every time a
> warning related to the input documentation is generated. There is one
> location in get_sphinx_version() where a warning is printed and the
> counter is not touched as it concerns the execution environment of the
> kernel-doc and not the documentation being processed.

So this seems like an improvement, but I have to ask: wouldn't it be far
better to just add a function to emit a warning and use that rather than
all these print/++$warnings pairings?  The current way seems repetitive
and error-prone.

I also have to ask...

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
> Signed-off-by: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: Louis Peens <louis.peens@corigine.com>

What does this signoff chain mean?  If it really took three people to
make this patch, then we need Co-developed-by tags to reflect that.

Thanks,

jon
