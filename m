Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FA25310C4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbiEWNJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbiEWNJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:09:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3DC54000;
        Mon, 23 May 2022 06:09:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AF6B61344;
        Mon, 23 May 2022 13:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB32C385A9;
        Mon, 23 May 2022 13:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653311367;
        bh=3FWqQ6lBRWaRCCFb2djCRRQ4eov10UfYPZz+vcD4rls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sfjc23tz95+FUSHH8zPfCLpqGyoFaRPCfbuuAVakgWe+s3p+/yVaWqpy/mHbYy+F8
         Tu2glSAybK4lv9UeXxP7LZzz9NhMKpldc9mr2ZJJE4zVuAOceUfsnYtkT02FCZ5sbm
         eSL1/dYGXVMxd5BtuzMFgHNw/bRLTfCEbwferc2rQZJ9lKpT4hbYzQXgG4e6TFFtpy
         x6PjMA+z2A4lFzePSCOegfdBtcYPYEArpJi0iSvA8JFyoabx3hcn3KSNZG+8HTGjo8
         dncUSC6FiaSXMJzp3La3+1yFg/MiTV+pHNaquXcuoYwgVfIcVP9AEZMCr3JQHKUDZX
         mLCLBJT8DGcAw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7FC38400B1; Mon, 23 May 2022 10:09:25 -0300 (-03)
Date:   Mon, 23 May 2022 10:09:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Felix Fietkau <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 4/7] perf jevents: Modify match field
Message-ID: <YouHhUl1snHY7Djz@kernel.org>
References: <20220511211526.1021908-1-irogers@google.com>
 <20220511211526.1021908-5-irogers@google.com>
 <f7a4e895-82e4-b8d2-7c30-931f2a48a838@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7a4e895-82e4-b8d2-7c30-931f2a48a838@huawei.com>
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

Em Tue, May 17, 2022 at 02:35:14PM +0100, John Garry escreveu:
> On 11/05/2022 22:15, Ian Rogers wrote:
> > The match_field function looks for json values to append to the event
> > string. As the C code processes these in order the output order matches
> > that in the json dictionary. Python json readers read the entire
> > dictionary and lose the ordering. To make the python and C output
> > comparable make the C code first read the extra fields then append them
> > to the event in an order not determined by their order in the file.
> > 
> > Modify the pmu-events test so that test expectations match the new
> > order.
> > 
> > Signed-off-by: Ian Rogers<irogers@google.com>
> 
> Reviewed-by: John Garry <john.garry@huawei.com>


Applied up to here, will take a closer look at 5-7

- Arnaldo
