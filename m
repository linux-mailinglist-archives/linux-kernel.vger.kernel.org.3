Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695A35536F3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353269AbiFUP6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352432AbiFUP5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:57:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAE32E0A0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:56:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37ECE61345
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 15:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9D6C341C0;
        Tue, 21 Jun 2022 15:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655826974;
        bh=3V2OC1uVdZn/dHS93ds+EwTItxIT+MQYa/9gN9q8wtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M7Z12EqzPW9drZASeK/1CZVMklTZk7c6U0NFjOpXmeKyYlwDl2LTvagfeFygLTIhw
         j2pGI1KGShjyzxrrBrC+jHX78X3UFRKdBD6bS72OHzuQDK9IfhaxHCBox0pQpGHVCj
         Qigtm2DV+Pzl4lcFh+7V9TfCizFqjCSulh1GRQ5kKlpq/QfklMxd5rfLGWzsec/QAS
         DRoUUWxAhnKlHM1Is1CmmdBXKCu2tvTN6wDzN5LIpkxehzb9uxaHT9572DrU4CO/q/
         v8/OcUuIJ6H0Obqlf7bB+NniJnMiUUY6ZjTggt3ZdEoGfxqzzLinxVsyUeaNDu+0Xw
         8vDr9CBmk2rOg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 08B2D4096F; Tue, 21 Jun 2022 12:56:10 -0300 (-03)
Date:   Tue, 21 Jun 2022 12:56:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf build-id: Fix caching files with a wrong build ID
Message-ID: <YrHqGS0XB800GF09@kernel.org>
References: <20220621125144.5623-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621125144.5623-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 21, 2022 at 03:51:44PM +0300, Adrian Hunter escreveu:
> Build ID events associate a file name with a build ID.  However, when
> using perf inject, there is no guarantee that the file on the current
> machine at the current time has that build ID. Fix by comparing the
> build IDs and skip adding to the cache if they are different.
> 
> Example:
> 
>  $ echo "int main() {return 0;}" > prog.c
>  $ gcc -o prog prog.c
>  $ perf record --buildid-all ./prog
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.019 MB perf.data ]
>  $ file-buildid() { file $1 | awk -F= '{print $2}' | awk -F, '{print $1}' ; }
>  $ file-buildid prog
>  444ad9be165d8058a48ce2ffb4e9f55854a3293e
>  $ file-buildid ~/.debug/$(pwd)/prog/444ad9be165d8058a48ce2ffb4e9f55854a3293e/elf
>  444ad9be165d8058a48ce2ffb4e9f55854a3293e
>  $ echo "int main() {return 1;}" > prog.c
>  $ gcc -o prog prog.c
>  $ file-buildid prog
>  885524d5aaa24008a3e2b06caa3ea95d013c0fc5
> 
>  Before:
> 
>  $ perf buildid-cache --purge $(pwd)/prog
>  $ perf inject -i perf.data -o junk
>  $ file-buildid ~/.debug/$(pwd)/prog/444ad9be165d8058a48ce2ffb4e9f55854a3293e/elf
>  885524d5aaa24008a3e2b06caa3ea95d013c0fc5
>  $
> 
>  After:
> 
>  $ perf buildid-cache --purge $(pwd)/prog
>  $ perf inject -i perf.data -o junk
>  $ file-buildid ~/.debug/$(pwd)/prog/444ad9be165d8058a48ce2ffb4e9f55854a3293e/elf
> 
>  $
> 
> Fixes: 454c407ec17a0c ("perf: add perf-inject builtin")


Thanks, applied.

- Arnaldo


> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/build-id.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 82f3d46bea70..328668f38c69 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -872,6 +872,30 @@ int build_id_cache__remove_s(const char *sbuild_id)
>  	return err;
>  }
>  
> +static int filename__read_build_id_ns(const char *filename,
> +				      struct build_id *bid,
> +				      struct nsinfo *nsi)
> +{
> +	struct nscookie nsc;
> +	int ret;
> +
> +	nsinfo__mountns_enter(nsi, &nsc);
> +	ret = filename__read_build_id(filename, bid);
> +	nsinfo__mountns_exit(&nsc);
> +
> +	return ret;
> +}
> +
> +static bool dso__build_id_mismatch(struct dso *dso, const char *name)
> +{
> +	struct build_id bid;
> +
> +	if (filename__read_build_id_ns(name, &bid, dso->nsinfo) < 0)
> +		return false;
> +
> +	return !dso__build_id_equal(dso, &bid);
> +}
> +
>  static int dso__cache_build_id(struct dso *dso, struct machine *machine,
>  			       void *priv __maybe_unused)
>  {
> @@ -886,6 +910,10 @@ static int dso__cache_build_id(struct dso *dso, struct machine *machine,
>  		is_kallsyms = true;
>  		name = machine->mmap_name;
>  	}
> +
> +	if (!is_kallsyms && dso__build_id_mismatch(dso, name))
> +		return 0;
> +
>  	return build_id_cache__add_b(&dso->bid, name, dso->nsinfo,
>  				     is_kallsyms, is_vdso);
>  }
> -- 
> 2.25.1

-- 

- Arnaldo
