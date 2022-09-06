Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DD55AE88D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239543AbiIFMiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239822AbiIFMiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:38:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D1B2983F;
        Tue,  6 Sep 2022 05:38:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 373E46150F;
        Tue,  6 Sep 2022 12:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEB3C433D6;
        Tue,  6 Sep 2022 12:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662467897;
        bh=0vHsV5HC+l1IsaFdtMuDEtBLZW+5drwFHn/b6WUSBFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C7EVwfeWliv+TmYW0Q2xyZsPL+0vPbALYlgyeneap+E1265wKlj3qm9lxRKCgksIE
         1r+SJis0Yaq3UNDvAyABlbqROnon0/luM+VxTwVXiBZJ04A1dPyccObpf0BMRwCOrS
         e9q3+TdZuGx4P6g9TLyxR8bXruUhj33HDvjfxPWVAeO2htTENhaqGzUEDOLHWHNMyU
         wJVOoWgM1qUCPnv0924wt3HFfxY9C0ZfSpxq+Si/bQEX2Mmp1mogc+KhSifDBvvCpA
         fjVTdDz+OWfnbzNlQ1ymCUBUYGO+5porc5cUxe3fiGCX8KHnHF4auPzSbzIP9zsW4K
         xjnPXBQpnUGZw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 322BD404A1; Tue,  6 Sep 2022 09:38:15 -0300 (-03)
Date:   Tue, 6 Sep 2022 09:38:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Zixuan Tan <tanzixuan.me@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf/genelf: Switch deprecated openssl MD5_* functions
 to new EVP API
Message-ID: <Yxc/N52oVNz8oE+r@kernel.org>
References: <CABwm_eTnARC1GwMD-JF176k8WXU1Z0+H190mvXn61yr369qt6g@mail.gmail.com>
 <YwfYyLE3ajSFVHGQ@kernel.org>
 <CABwm_eSvcnygceTU0sNXLkBFaNfEfrThFVmwH=TS4hN=HVGrGg@mail.gmail.com>
 <CAM9d7cjsbhHnaAiHSBb6qAfH0bNgdKrBHdg16esRCt+4DPmvtQ@mail.gmail.com>
 <CABwm_eT=BHQB=ELEWTZtXG61WyYVqQfp+gy85aD3xMRycKtLwA@mail.gmail.com>
 <Yxc+H/JHcKmvRWLr@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yxc+H/JHcKmvRWLr@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 06, 2022 at 09:33:35AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Sep 06, 2022 at 05:40:24PM +0800, Zixuan Tan escreveu:
> > Hi Arnaldo, are there any updates?
> 
> Trying to apply it manually:

Done. Thanks.

- Arnaldo
 
> ⬢[acme@toolbox perf-urgent]$ am
> Applying: perf/genelf: Switch deprecated openssl MD5_* functions to new EVP API
> error: corrupt patch at line 31
> Patch failed at 0001 perf/genelf: Switch deprecated openssl MD5_* functions to new EVP API
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> ⬢[acme@toolbox perf-urgent]$ git am --abort
> ⬢[acme@toolbox perf-urgent]$
> ⬢[acme@toolbox perf-urgent]$ patch -p1 < ~/wb/1.patch
> patching file tools/perf/util/genelf.c
> patch: **** malformed patch at line 141: const void *code, size_t csize)
> 
> ⬢[acme@toolbox perf-urgent]$
> 
> ⬢[acme@toolbox perf-urgent]$ tail -30  ~/wb/1.patch
>  #endif
> @@ -142,15 +139,20 @@ gen_build_id(struct buildid_note *note,
>  static void
>  gen_build_id(struct buildid_note *note, unsigned long load_addr,
> const void *code, size_t csize)
>  {
> -       MD5_CTX context;
> +       EVP_MD_CTX *mdctx;
> 
>         if (sizeof(note->build_id) < 16)
>                 errx(1, "build_id too small for MD5");
> 
> -       MD5_Init(&context);
> -       MD5_Update(&context, &load_addr, sizeof(load_addr));
> -       MD5_Update(&context, code, csize);
> -       MD5_Final((unsigned char *)note->build_id, &context);
> +       mdctx = EVP_MD_CTX_new();
> +       if (!mdctx)
> +               errx(2, "failed to create EVP_MD_CTX");
> +
> +       EVP_DigestInit_ex(mdctx, EVP_md5(), NULL);
> +       EVP_DigestUpdate(mdctx, &load_addr, sizeof(load_addr));
> +       EVP_DigestUpdate(mdctx, code, csize);
> +       EVP_DigestFinal_ex(mdctx, (unsigned char *)note->build_id, NULL);
> +       EVP_MD_CTX_free(mdctx);
>  }
>  #endif
> 
> --
> 2.34.1
> ⬢[acme@toolbox perf-urgent]$
>  
> > Thanks,
> > - Zixuan
> > 
> > On Sat, Aug 27, 2022 at 2:32 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hello,
> > >
> > > On Fri, Aug 26, 2022 at 10:22 AM Zixuan Tan <tanzixuan.me@gmail.com> wrote:
> > > >
> > > > On Fri, Aug 26, 2022 at 4:17 AM Arnaldo Carvalho de Melo
> > > > <arnaldo.melo@gmail.com> wrote:
> > > > >
> > > > > Em Fri, Aug 26, 2022 at 01:00:58AM +0800, Zixuan Tan escreveu:
> > > > > > Switch to the flavored EVP API like in test-libcrypto.c, and remove the
> > > > > > bad gcc #pragma.
> > > > > >
> > > > > > Inspired-By: 5b245985a6de ("tools build: Switch to new openssl API for
> > > > > > test-libcrypto")
> > > > >
> > > > > How did you test the end result? Can you please describe step by step?
> > > > >
> > > > > Also please consider adding a 'perf test' entry to make sure this
> > > > > doesn't regress.
> > > >
> > > > Sorry but I don't get what you mean, what results do I need to test?
> > > >
> > > > These EVP_* APIs are just replacements for the deprecated MD5_* APIs in
> > > > openssl v3 [1][2]. With the same input, they produce the same MD5 digest.
> > > >
> > > > And this patch just does the migration work for the upgrade and does not
> > > > change the logic of the code. so...what should I test?
> > >
> > > Yeah, I understand that this merely changes the MD5 APIs.
> > > While it's good to have a test case for the genelf code, I don't think
> > > it belongs to this patch.  So,
> > >
> > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > >
> > >
> > > >
> > > > Links:
> > > > [1] https://www.openssl.org/docs/man3.0/man3/MD5.html
> > > > [2] https://stackoverflow.com/questions/69806220/advice-needed-for-migration-of-low-level-openssl-api-to-high-level-openssl-apis
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
