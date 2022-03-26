Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45E44E8151
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 15:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbiCZOGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 10:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiCZOGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 10:06:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C43166E2D;
        Sat, 26 Mar 2022 07:05:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47E6C60EF5;
        Sat, 26 Mar 2022 14:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F896C340EE;
        Sat, 26 Mar 2022 14:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648303500;
        bh=YV78RkwSqUG0hLwgVwl5hr9tAbUXieZCvNBdqQm1qeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T95ZysXDWz4DxLK2/bdoG2u1QAl1UMbT7gLNzWUboVeAHh7jV4bLRV+7JzYUWnhVn
         2RXOBc7kF2oYb7VKWJi0rjrJGCCXpYO2D0DF8yaGNWQ6dI1IWiRoG8/ZJZARmAUe6c
         LSuMIO8rhK6/YJYLAuAAm39D7HBhsO/esZNGlmXgUB0zi+Tv7o5/7kG/ShwleFC+JI
         6WxUJhUBo/YVE/nHoXYCB/C8yin0zbjnDeGupOrvxXjpK37PYw57Ybed+JloBXKIu5
         RM4pzu6u9qktN1YtmiGc4OScezfpAR1kXqfNj4y8EvHvTYhfrNofwopT2PIP8vuHQF
         AE9Ts1e9JQf0g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6AF8D40407; Sat, 26 Mar 2022 11:04:58 -0300 (-03)
Date:   Sat, 26 Mar 2022 11:04:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, german.gomez@arm.com,
        benh@kernel.crashing.org, Nick.Forrington@arm.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v4 2/4] perf arm-spe: Use SPE data source for neoverse
 cores
Message-ID: <Yj8ditXSBemA41Z3@kernel.org>
References: <20220324183323.31414-1-alisaidi@amazon.com>
 <20220324183323.31414-3-alisaidi@amazon.com>
 <20220326134754.GD20556@leoy-ThinkPad-X240s>
 <Yj8age/PSIouUiKy@kernel.org>
 <20220326135653.GE20556@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220326135653.GE20556@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Mar 26, 2022 at 09:56:53PM +0800, Leo Yan escreveu:
> On Sat, Mar 26, 2022 at 10:52:01AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Sat, Mar 26, 2022 at 09:47:54PM +0800, Leo Yan escreveu:
> > > On Thu, Mar 24, 2022 at 06:33:21PM +0000, Ali Saidi wrote:
> > > > +static void arm_spe__synth_data_source_neoverse(const struct arm_spe_record *record,
> > > > +						union perf_mem_data_src *data_src)
> > > >  {
> > > > -	union perf_mem_data_src	data_src = { 0 };
> > > > +	/*
> > > > +	 * Even though four levels of cache hierarchy are possible, no known
> > > > +	 * production Neoverse systems currently include more than three levels
> > > > +	 * so for the time being we assume three exist. If a production system
> > > > +	 * is built with four the this function would have to be changed to
> > > > +	 * detect the number of levels for reporting.
> > > > +	 */

> > > > -	if (record->op == ARM_SPE_LD)
> > > > -		data_src.mem_op = PERF_MEM_OP_LOAD;
> > > > -	else
> > > > -		data_src.mem_op = PERF_MEM_OP_STORE;

> > > Firstly, apologize that I didn't give clear idea when Ali sent patch sets
> > > v2 and v3.

> > Ok, removing this as well.

> > Thanks for reviewing.

> Thanks a lot, Arnaldo.  Yeah, it's good to give a bit more time to
> dismiss the concerns in this patch.

Sure, at least it was build tested on many distros/cross compilers and
this part is ok 8-)
 
> Sorry again for the inconvenience.

np.

- Arnaldo
