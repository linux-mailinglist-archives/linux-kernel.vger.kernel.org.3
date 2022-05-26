Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617C8535162
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344609AbiEZPZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiEZPZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:25:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA29BA9B9;
        Thu, 26 May 2022 08:25:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F03261C41;
        Thu, 26 May 2022 15:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9323BC385A9;
        Thu, 26 May 2022 15:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653578737;
        bh=Ku4hdE4QnTkWrQu5yxYySdeI4ksk3o3IHLc7K1VuUA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sRAE54i401ZllZra/r8Zgo2GnB4Xst/GpO+HfIvYSf0CN+kzlUuuV3GGY8NO2kUbe
         SWpn4lZoXAO0EKJe137ViutbMO4PjkbqtoqQcnU03XsZxN4tgBkkuOCMpQqvGPTxpW
         s3NMPF9L1fFvAEMhAM9S8BU9PHskO6geqAn44bMwn2+9KgERXUH8ac+o+BrVVyLAxa
         OlvZolMTP/JJKHgPUZLIoouVmsENjU63URW5g8RoGaWkEI8BBqRFPBdRKOw3YCiHfs
         5N8dxEeTJlss0eTSXkQ8DWZJZ5K4x/Z9r8mQXgOd+tY/PLM/CREuI43gUr1t3RqxLs
         WJStMBQUSvQhw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 56F644036D; Thu, 26 May 2022 12:25:35 -0300 (-03)
Date:   Thu, 26 May 2022 12:25:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     zhengjun.xing@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com
Subject: Re: [PATCH] perf jevents: Fix event syntax error caused by ExtSel
Message-ID: <Yo+b79zg9hsS0H9Q@kernel.org>
References: <20220525140410.1706851-1-zhengjun.xing@linux.intel.com>
 <CAP-5=fUm4G043v6-pToBiT-psxt-_r4kxtsWwkjLh=ARmhmP_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUm4G043v6-pToBiT-psxt-_r4kxtsWwkjLh=ARmhmP_A@mail.gmail.com>
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

Em Wed, May 25, 2022 at 07:27:08AM -0700, Ian Rogers escreveu:
> On Wed, May 25, 2022 at 7:04 AM <zhengjun.xing@linux.intel.com> wrote:
> >
> > From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> >
> > In the origin code, when "ExtSel" is 1, the eventcode will change to
> > "eventcode |= 1 << 21”. For event “UNC_Q_RxL_CREDITS_CONSUMED_VN0.DRS",
> > its "ExtSel" is "1", its eventcode will change from 0x1E to 0x20001E,
> > but in fact the eventcode should <=0x1FF, so this will cause the parse
> > fail:
> >
> >   # perf stat -e "UNC_Q_RxL_CREDITS_CONSUMED_VN0.DRS" -a sleep 0.1
> > event syntax error: '.._RxL_CREDITS_CONSUMED_VN0.DRS'
> >                                   \___ value too big for format, maximum is 511
> >
> > On the perf kernel side, the kernel assumes the valid bits are continuous.
> > It will adjust the 0x100 (bit 8 for perf tool) to bit 21 in HW.
> >
> > DEFINE_UNCORE_FORMAT_ATTR(event_ext, event, "config:0-7,21");
> >
> > So the perf tool follows the kernel side and just set bit8 other than bit21.
> >
> > Fixes: fedb2b518239 ("perf jevents: Add support for parsing uncore json files")
> > Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

