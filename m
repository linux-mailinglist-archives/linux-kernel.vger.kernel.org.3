Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8675149CE26
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242785AbiAZP1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:27:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47182 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiAZP1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:27:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 369EBB81E71
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C768C340E3;
        Wed, 26 Jan 2022 15:27:04 +0000 (UTC)
Date:   Wed, 26 Jan 2022 10:27:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Tom Zanussi <zanussi@kernel.org>,
        lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: kernel/trace/trace_events_hist.c:6174
 event_hist_trigger_parse() error: we previously assumed 'glob' could be
 null (see line 6166)
Message-ID: <20220126102702.6b896353@gandalf.local.home>
In-Reply-To: <20220126145020.GB1978@kadam>
References: <202201250054.975KVd1O-lkp@intel.com>
        <20220126093918.268d0e42@gandalf.local.home>
        <20220126145020.GB1978@kadam>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022 17:50:20 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> > I just reviewed the code, and it looks like the logic should keep glob from
> > ever being NULL.  
> 
> Smatch can also figure that out, and does not warn, if you have the
> cross function DB.  Unfortunately, that's not feasible for the zero day
> bot because it takes too long to build the DB.
> 
> I was puzzled why this warning showed up now when the code is from 2018.

Well it is called from trigger_process_regex() that gets buf passed in, and
that gets called by trace_boot_init_histograms(),
trace_boot_init_one_event() and event_trigger_regex_write(). All of which
pass in something for that glob parameter.

But I can see it being difficult to catch all that.

I have no problem adding the WARN_ON(), just to make it cleaner.

-- Steve

