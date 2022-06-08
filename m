Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD975432E0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241730AbiFHOnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242050AbiFHOmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:42:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C573A1BB;
        Wed,  8 Jun 2022 07:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=CRsWP2G+wghkUNt8S+tGdaVaiP+VpO+A8Nv2DBBotgM=; b=bGo4iGu2HpMKf252eq1uEtnpjj
        akPOmAWyf8pvG+BywRGLgG5fOMaX6wl7YyT6Ez3R2dDMG+3wPjNrEFJpjbcE6SoIC8Zbu70aWSeZ8
        9mdGka0Bx2c8E0l+agsf3pk6HFYtLGgsnddsBXuSxkIxlefCSBrj1giqEwCoEjegMqX9AvsvB0PdJ
        KFPA1T41+FAq39v6UPCsrkHj5GulwVIQJiEjKFhc6ICWylVGvPxR6lkG96dFqLjVFasfmVTS8WGk2
        kRXeoxWZJVFNQvC6SaG8rLZ2KtBDAf8fN+uI9Z4fDZl5mCD3MuYYC8RFroBLYlfbRd1JJCpvt8ryu
        5m70+7lw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nywsp-00665h-51; Wed, 08 Jun 2022 14:42:07 +0000
Message-ID: <74a53856-281d-0443-1141-af116abab991@infradead.org>
Date:   Wed, 8 Jun 2022 07:41:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] scripts: kernel-doc: Always increment warnings counter
Content-Language: en-US
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@corigine.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, oss-drivers@corigine.com,
        Simon Horman <simon.horman@corigine.com>,
        Louis Peens <louis.peens@corigine.com>
References: <20220608142601.832926-1-niklas.soderlund@corigine.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220608142601.832926-1-niklas.soderlund@corigine.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/22 07:26, Niklas Söderlund wrote:
> Some warnings did not increment the warnings counter making the behavior
> of running kernel-doc with -Werror unlogical as some warnings would be
> generated but not treated as errors.
> 
> Fix this by always incrementing the warnings counter every time a
> warning related to the input documentation is generated. There is one
> location in get_sphinx_version() where a warning is printed and the
> counter is not touched as it concerns the execution environment of the
> kernel-doc and not the documentation being processed.
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
> Signed-off-by: Niklas Söderlund <niklas.soderlund@corigine.com>
> Signed-off-by: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: Louis Peens <louis.peens@corigine.com>
> ---
>  scripts/kernel-doc | 10 ++++++++++
>  1 file changed, 10 insertions(+)

LGTM. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy
