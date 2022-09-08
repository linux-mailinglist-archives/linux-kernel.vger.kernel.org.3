Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539835B25D8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiIHSfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiIHSfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:35:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD00D7CAA9;
        Thu,  8 Sep 2022 11:35:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4886961DE8;
        Thu,  8 Sep 2022 18:35:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F96EC433C1;
        Thu,  8 Sep 2022 18:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662662113;
        bh=jG8t5pYfd8GeT3kRyuB48lhMQYAj49WA7ADQGwo76LQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JUBiNLwf8Ognf4jeAbJNosWehdO+1S9QGlOsdQxKKpKEHm1JDk3kdVGbt9oithhfD
         WmSzbcs7uRbKMBC8TgEQUG8MBXTJYsri0sGW4ajb5EF0jAMAo3fz7gynoZX/+e8zuV
         goI6CPYxNueLc4lDjTh9oIIrfgr1/ChlJsTz24X8Fw0YrMuvvenmlKMxa8lXZixxF8
         rK+KVrFVebvEVKmDR/SsblWa2iwpUbebYNX52T3WXsiJR53Ja8S/+sCzwfiZUnYgXO
         vB5bNOJVZ0+soF+PqQ1LvxNWn65yaH139vLdetFKd2WPqS/I8yfJ8Er4R4fZTbPdm2
         H2qb9gP3I5Hqw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 16D80404A1; Thu,  8 Sep 2022 15:35:11 -0300 (-03)
Date:   Thu, 8 Sep 2022 15:35:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Nick Forrington <nick.forrington@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] perf vendor events: Update events for Neoverse E1
Message-ID: <Yxo130Bh3Y2ZUl95@kernel.org>
References: <20220907154932.60808-1-nick.forrington@arm.com>
 <e77a66f2-f572-0960-3f6a-68ca9773a719@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e77a66f2-f572-0960-3f6a-68ca9773a719@huawei.com>
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

Em Thu, Sep 08, 2022 at 09:34:00AM +0100, John Garry escreveu:
> On 07/09/2022 16:49, Nick Forrington wrote:
> > These CPUs contain the same PMU events (as per the Arm Technical
> > Reference manuals for Cortex A65 and Neoverse E1)
> > 
> > This de-duplicates event data, and avoids issues in previous E1 event
> > data (not present in A65 data)
> > * Missing implementation defined events
> > * Inclusion of events that are not implemented:
> >    - L1D_CACHE_ALLOCATE
> >    - SAMPLE_POP
> >    - SAMPLE_FEED
> >    - SAMPLE_FILTRATE
> >    - SAMPLE_COLLISION
> > 
> > Signed-off-by: Nick Forrington <nick.forrington@arm.com>
> 
> Reviewed-by: John Garry <john.garry@huawei.com>

Thanks, applied.

- Arnaldo

