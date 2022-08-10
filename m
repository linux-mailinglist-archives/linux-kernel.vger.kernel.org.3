Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550DA58ED3D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbiHJN3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbiHJN24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:28:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE81632BA2;
        Wed, 10 Aug 2022 06:28:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B89561472;
        Wed, 10 Aug 2022 13:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B779DC433D6;
        Wed, 10 Aug 2022 13:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660138134;
        bh=rTPuHCGz6a2bI7IJ+milWeVAdLUW+haFtoK526dBSDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PY4WCm7ur+n8Y+kgz1izD5lSiKc6FV8qbzw+Xf6IirOS8EFavLSbLYzswBKs0PrKG
         LEGN4GCQ2hN0OG5N3frYQHbYF9/9Q8/I2GWVCd5GZomH8oc8q4sC9dokBeebZnVZug
         Xd8vheVL7qSQKoa3ShKpzcMy6Zf4S9E+1PYiJuKZR/xkA+bYTXMgW00RM+kJK8BGvo
         57oXrKWiWLOM9/JtmlEQ4HsN7uNK4JJk2VMG9R8Aq14yA+7+hhtZ/2jqtcFYIBhP+W
         +iaenPDbMN7bz2X8FjUGfi5UTRxQvK2UMFFqeEIPtfwT6vEzUuKk+VwBcjlqS/fN6X
         0e3+OEYuBz1rA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BF9934035A; Wed, 10 Aug 2022 10:28:52 -0300 (-03)
Date:   Wed, 10 Aug 2022 10:28:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Michael Pratt <mpratt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf: uapi: fix PERF_RECORD_SAMPLE format documentation
Message-ID: <YvOylAvzGsk5f7Tg@kernel.org>
References: <20220706210613.1987767-1-mpratt@google.com>
 <CAM9d7cjTUQtLLfj-eZiKgjByDzduBnkWM87srmH6EJKiRa3mdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjTUQtLLfj-eZiKgjByDzduBnkWM87srmH6EJKiRa3mdA@mail.gmail.com>
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

Em Fri, Jul 08, 2022 at 01:38:08PM -0700, Namhyung Kim escreveu:
> Hello,
> 
> On Wed, Jul 6, 2022 at 2:06 PM Michael Pratt <mpratt@google.com> wrote:
> >
> > The documented format of PERF_RECORD_SAMPLE does not match the actual
> > format emitted by perf_output_sample:
> >
> > * The cgroup field is missing entirely.
> > * The data_page_size and code_page_size fields are output before the aux
> >   data, but are documented before.
> >
> > Fixes: 6546b19f95ac ("perf/core: Add PERF_SAMPLE_CGROUP feature")
> > Fixes: 8d97e71811aa ("perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE")
> > Fixes: 995f088efebe ("perf/core: Add support for PERF_SAMPLE_CODE_PAGE_SIZE")
> > Signed-off-by: Michael Pratt <mpratt@google.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

This hasn't been merged yet.

- Arnaldo
