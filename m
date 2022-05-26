Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E2953519E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbiEZPol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiEZPoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:44:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0B9D9EB9;
        Thu, 26 May 2022 08:44:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62E6961C83;
        Thu, 26 May 2022 15:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED3EC385A9;
        Thu, 26 May 2022 15:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653579875;
        bh=pBD/3X+frAfug8ysE+SH0WD80ktftL6zAncoJ45+7zg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DFea7dCJN4pQtp7UGXvd/zQrwc/PbLdMUJmSsuIPj2Tk1txvHc+tC5l4r/uum80MK
         PJYQv5N5Vy+PAgCYP/sOo9Q7RNS125Iv3Bf/J/T+5Em659Wa4zjhIHPTYR3A2V66Bq
         ASDLqRzmsKWlAzszK53Ld9/rr6d5Oc4tESsCK0liB9HjHFVrnEWm1P3coh6V8Wsa0z
         dHMIBAnfM3B1BvYNYcF2wW0VzmVCOER3QGXYnFxsZ7Omg8ecS5GdYMAnErMeHP91AM
         Pl09tY7juClJji+lw5nP6cgOHaJryHow4NTyEH9w2qcIhr10dASr2LDRgmvesYfBxb
         wvSKwSwRKInMQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AADFE4036D; Thu, 26 May 2022 12:44:33 -0300 (-03)
Date:   Thu, 26 May 2022 12:44:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, broonie@kernel.org,
        german.gomez@arm.com, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 4/6] perf tools: Use dynamic register set for Dwarf
 unwind
Message-ID: <Yo+gYbLNnYGOPzGs@kernel.org>
References: <20220509144257.1623063-1-james.clark@arm.com>
 <20220509144257.1623063-5-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509144257.1623063-5-james.clark@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 09, 2022 at 03:42:52PM +0100, James Clark escreveu:
> Architectures can detect availability of extra registers at
> runtime so use this more complete set for unwinding. This
> will include the VG register on arm64 in a later commit.
> 
> If the function isn't implemented then PERF_REGS_MASK is
> returned and there is no change.

Committer notes:

Added util/perf_regs.c to tools/perf/util/python-ext-sources so that
'perf test python' passes, i.e. the perf python binding has all the
symbols it needs, addressing:

  $ perf test -v python
   19: 'import perf' in python                                         :
  --- start ---
  test child forked, pid 2037817
  python usage test: "echo "import sys ; sys.path.append('/tmp/build/perf/python'); import perf" | '/usr/bin/python3' "
  Traceback (most recent call last):
    File "<stdin>", line 1, in <module>
  ImportError: /tmp/build/perf/python/perf.cpython-310-x86_64-linux-gnu.so: undefined symbol: arch__user_reg_mask
  test child finished with -1
  ---- end ----
  'import perf' in python: FAILED!
  $
 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/evsel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d38722560e80..a881784da966 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -875,7 +875,7 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
>  					   "specifying a subset with --user-regs may render DWARF unwinding unreliable, "
>  					   "so the minimal registers set (IP, SP) is explicitly forced.\n");
>  			} else {
> -				attr->sample_regs_user |= PERF_REGS_MASK;
> +				attr->sample_regs_user |= arch__user_reg_mask();
>  			}
>  			attr->sample_stack_user = param->dump_size;
>  			attr->exclude_callchain_user = 1;
> -- 
> 2.28.0

-- 

- Arnaldo
