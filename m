Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10FE531618
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbiEWUFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 16:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbiEWUE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 16:04:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BD38CB04;
        Mon, 23 May 2022 13:04:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC1DAB8159E;
        Mon, 23 May 2022 20:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3041BC385A9;
        Mon, 23 May 2022 20:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653336290;
        bh=VCr+7lkLQToR6Gio/RU+YAX+4G+XyxkoG7z0HQlZc1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CC96xKYgJWBc5/HF5oqiLYTYAcPzTCjgXGDI9a8r7NvI1VNe4v4ahbpJa6UJ1YOM3
         kGt/6i96ibrfvGR/EudBjy23Iaj9ZzJY2n5LJxr3/pEwd5QwxJfKfW2nxr1xo4z4ss
         CecgeB++xdDOY/HR3hGQVszWbBfhDadg1xqHJ5PzlP0fu0nVX9FAdpZO1FriMuu9r0
         WuiL+Mzy9MIXwr7sZ9/buOHD859EiHiu+FjHASbBfn2pOvrpD+CCYlz7n3thj66uUZ
         W7wIMtDbn9OC128PdAYYZCr8ORbkVzwo+OgflXz5kOWVFE/QaSQp8KKNu470r+zh/7
         J+YmxcAP7Z63g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8910240483; Mon, 23 May 2022 17:04:47 -0300 (-03)
Date:   Mon, 23 May 2022 17:04:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        james.clark@arm.com, leo.yan@linaro.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC PATCH 0/1] perf test cs-etm: Add end-to-end tests for
 CoreSight decoding
Message-ID: <Yovo33Qh7eE7pTn1@kernel.org>
References: <20220523144952.364370-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220523144952.364370-1-german.gomez@arm.com>
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

Em Mon, May 23, 2022 at 03:49:51PM +0100, German Gomez escreveu:
> Hi
> 
> While discussing running more tests for CoreSight, we thought it might
> be a good idea to upstream some EndToEnd tests for CoreSight decoding in
> order to lock down the behaviour. I am sending this as RFC to get some
> feedback from the community first.
> 
> The test relies on pre-geneated perf.data files that are downloaded
> during the test. I'm not sure it's a good idea to commit those files to
> the Linux repository, so they would have to live in an external source
> and be downloaded during the test.

That is ok, but please cache it locally, so that from the second 'perf
test' run onwards one doesn´t have to incur in the download delay and
also be able to run the tests while not connected.

- Arnaldo
 
> For this RFC, the files are stored in a Github repository [1]. As an
> idea, I think we could store them in a new repo in the ARM-software
> namespace. Any hosting suggestions are very welcome.
> 
> Thanks,
> German
> 
> [1] https://github.com/ARM-software/data/tree/984cde8fb0bb22591e284826a80b338bb79c3655/perf/coresight
> 
> German Gomez (1):
>   perf test cs-etm: Add end-to-end tests for CoreSight decoding
> 
>  tools/perf/tests/shell/lib/arm_auxtrace.sh    | 21 +++++++
>  .../tests/shell/test_arm_coresight_decoder.sh | 57 +++++++++++++++++++
>  2 files changed, 78 insertions(+)
>  create mode 100644 tools/perf/tests/shell/lib/arm_auxtrace.sh
>  create mode 100755 tools/perf/tests/shell/test_arm_coresight_decoder.sh
> 
> -- 
> 2.25.1

-- 

- Arnaldo
