Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F105266E3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 18:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382346AbiEMQTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 12:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350972AbiEMQT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:19:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1DCF27FE4
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652458766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=frGYcCkK5A8jh6LdB3zI7LDlx8SFLbfWhQGLiMx1rJs=;
        b=YYVCSfun/w0jQ9HnwScJD5oQHpso8rtWJddiuhyOAxES6+EU4zNwPjN4sl6mh95AyCLyiL
        6acw/fOV3Q/7DBU8EGvpYAs93N2v2Yb2ALRbXQufsUX7pUjuI/luzvVjm+ljXOuDGomtnG
        aIwNRnxEYsSar38io+80tEQyiwDeRbM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-MZ22hQpEP1CodsE0QiPdqg-1; Fri, 13 May 2022 12:19:25 -0400
X-MC-Unique: MZ22hQpEP1CodsE0QiPdqg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDBC6185A7A4;
        Fri, 13 May 2022 16:19:24 +0000 (UTC)
Received: from [10.22.11.63] (unknown [10.22.11.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7F08C15D40;
        Fri, 13 May 2022 16:19:24 +0000 (UTC)
Message-ID: <f819f288-7f67-77d1-5d92-f0a5545c1c48@redhat.com>
Date:   Fri, 13 May 2022 12:19:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] kselftest/cgroup: fix test_stress.sh to use OUTPUT dir
Content-Language: en-US
To:     Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org
Cc:     mkoutny@suse.com, tj@kernel.org
References: <20220512143439.26104-1-pauld@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220512143439.26104-1-pauld@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/12/22 10:34, Phil Auld wrote:
> Running cgroup kselftest with O= fails to run the with_stress test due
> to hardcoded ./test_core. Find test_core binary using the OUTPUT directory.
>
> Fixes: 1a99fcc035fb ("selftests: cgroup: Run test_core under interfering stress")
> Signed-off-by: Phil Auld <pauld@redhat.com>
> ---
>   tools/testing/selftests/cgroup/test_stress.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/cgroup/test_stress.sh b/tools/testing/selftests/cgroup/test_stress.sh
> index 15d9d5896394..109c044f715f 100755
> --- a/tools/testing/selftests/cgroup/test_stress.sh
> +++ b/tools/testing/selftests/cgroup/test_stress.sh
> @@ -1,4 +1,4 @@
>   #!/bin/bash
>   # SPDX-License-Identifier: GPL-2.0
>   
> -./with_stress.sh -s subsys -s fork ./test_core
> +./with_stress.sh -s subsys -s fork ${OUTPUT}/test_core


I would suggest using "${OUTPUT:-.}" as the variable OUTPUT may not be 
defined if test_stress.sh is run interactively.

Cheers,
Longman

