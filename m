Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C3451350C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347096AbiD1N3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347337AbiD1N3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:29:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926D3B0A7B;
        Thu, 28 Apr 2022 06:26:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C16E86209C;
        Thu, 28 Apr 2022 13:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EACC385A9;
        Thu, 28 Apr 2022 13:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651152362;
        bh=09Hl6oSetqVN5HFGm8OzMmoV77aDSHC1Wz+qVhdohVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mrECKqx+fDChACFLciuZBFdjI81Hm5XjpSdrCdSLC4T0WvdaDbhhR6TD6kZDPxp/z
         gqDsYrMSUjf9T1RMUHoy2S+GOo3B1l6x/Zz4uWKYukVLYQ9mjoiFb0HxC+DdDddmVC
         fwccbFMKZhBPDkZYH7uS/gmSpRYbrGgBSUEDjLkrgKL+AGyCyhmUYOFrkCNzktkzUN
         BmAF+Sfh4k3FH5PxHXbtifDjnN4nUPXi/3KpOATSOjCOw72oRKSejoSQZqYW8alal2
         wSQSnCI2TIycDX4IVZ+jF0GFjuPU6wImTwwM8Q6pERI+Yb9sbMmirSdQ0yNpfodhHb
         ny6wNM7Hn28Kw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1178A400B1; Thu, 28 Apr 2022 10:25:58 -0300 (-03)
Date:   Thu, 28 Apr 2022 10:25:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH] perf test: Fix test case 81 on s390x
Message-ID: <YmqV5o0XFfewhNkC@kernel.org>
References: <20220428122821.3652015-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428122821.3652015-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 28, 2022 at 02:28:21PM +0200, Thomas Richter escreveu:
> perf test -F 81 -v fails on s390x on the linux-next branch.
> The test case is x86 specific can not be executed on s390x.
> The test case depends on x86 register names such as
> 
>   ... | egrep -q 'available registers: AX BX CX DX ....'

Thanks,

Ian, I guess this will break on other !x86 arches as well. Can you
please take a look?

- Arnaldo
 
> Skip this test case on s390x.
> 
> Output before:
>  # perf test -F 81
>  81: perf record tests                       : FAILED!
>  #
> 
> Output after:
>  # perf test -F 81
>  81: perf record tests                       : Skip
>  #
> 
> Fixes: 24f378e66021 ("perf test: Add basic perf record tests")
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/tests/shell/record.sh | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index cd1cf14259b8..d98f4d4a00e1 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -37,6 +37,8 @@ test_register_capture() {
>    echo "Register capture test [Success]"
>  }
>  
> +# Test for platform support and return TEST_SKIP
> +[ $(uname -m) = s390x ] && exit 2
>  test_per_thread
>  test_register_capture
>  exit $err
> -- 
> 2.35.1

-- 

- Arnaldo
