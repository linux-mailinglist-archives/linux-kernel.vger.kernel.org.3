Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C985365B9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 18:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344702AbiE0QIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 12:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349586AbiE0QIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 12:08:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747B01498FA;
        Fri, 27 May 2022 09:08:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1024F61DCE;
        Fri, 27 May 2022 16:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466E1C385A9;
        Fri, 27 May 2022 16:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653667727;
        bh=OlBI8wVCIAxvvfasLZa9UH7nUKu5dc9htrYEpiULe6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j8y6/wrgqMG5Oat+epe7h7DytEaI14sZ2BQgUoEE4PpE+UZoDrLkh1p0wzQnlS+Rn
         hl/EJzYILmBt5XtutCUugflcd316cr3XKq8rns0GY/VXwsxaS4gCRxFLAxN+ft3wum
         9vOfyJmi4YXWzAK88Dmd6Vs1RYhzTrk9XXXQPkzoX8xK2Hdzu/39EM+xb52mQUqSon
         bR2sn31VpNjPTWq7gKVfKS1lmhokpmpXAOKTg7nf1dHoa7KXNZHvQNNerAJyCseEDc
         PbDMhTsXYsKqKTJF8WJyO7rhFY6I2X6yRRjJtRP6IsuBgO1KeMFan/5fCW0cGgTdAn
         Ixih7UrR73guQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CFB2D4036D; Fri, 27 May 2022 13:08:43 -0300 (-03)
Date:   Fri, 27 May 2022 13:08:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, broonie@kernel.org,
        german.gomez@arm.com, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 4/6] perf tools: Use dynamic register set for Dwarf
 unwind
Message-ID: <YpD3i2prgA8ESb7Q@kernel.org>
References: <20220509144257.1623063-1-james.clark@arm.com>
 <20220509144257.1623063-5-james.clark@arm.com>
 <Yo+gYbLNnYGOPzGs@kernel.org>
 <Yo/EytFDKnOEiWCa@kernel.org>
 <20220527061854.GA829807@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220527061854.GA829807@leoy-ThinkPad-X240s>
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

Em Fri, May 27, 2022 at 02:18:54PM +0800, Leo Yan escreveu:
> On Thu, May 26, 2022 at 03:19:54PM -0300, Arnaldo Carvalho de Melo wrote:
> 
> [...]
> 
> > Too old to support?
> > 
> >   69     7.19 ubuntu:16.04-x-arm64          : FAIL gcc version 5.4.0 20160609 (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9)
> >     arch/arm64/util/perf_regs.c: In function 'arch__user_reg_mask':
> >     arch/arm64/util/perf_regs.c:151:28: error: 'HWCAP_SVE' undeclared (first use in this function)
> >       if (getauxval(AT_HWCAP) & HWCAP_SVE)
> >                                 ^
> >     arch/arm64/util/perf_regs.c:151:28: note: each undeclared identifier is reported only once for each function it appears in
> >     /git/perf-5.18.0/tools/build/Makefile.build:139: recipe for target 'util' failed
> >     make[5]: *** [util] Error 2
> >     /git/perf-5.18.0/tools/build/Makefile.build:139: recipe for target 'arm64' failed
> >     make[4]: *** [arm64] Error 2
> >     /git/perf-5.18.0/tools/build/Makefile.build:139: recipe for target 'arch' failed
> >     make[3]: *** [arch] Error 2
> > 
> > 
> > ⬢[acme@toolbox perf]$ find . -name "*.h" | xargs grep -w HWCAP_SVE
> > ./arch/arm64/include/uapi/asm/hwcap.h:#define HWCAP_SVE		(1 << 22)
> > ⬢[acme@toolbox perf]$ 
> 
> I tested aarch64 GCC-7.4.1 which doesn't support HWCAP_SVE, but
> aarch64 GCC-8.3.0 and GCC-9.4.0 support it.
> 
> Either we can add below code:
> 
>   #ifndef HWCAP_SVE
>   #define HWCAP_SVE		(1 << 22)
>   #endif
> 
> Or directly include header file <.../asm/hwcap.h>.
> 
> Not sure which method is preferred.  Maybe the first approach can be
> de-couple with Linux kernel code?

Lets go KISS and just define it if not present, as you suggested above,
will test now.

- Arnaldo
