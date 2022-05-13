Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD96525E72
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378588AbiEMIrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378581AbiEMIrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:47:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 965E356C17
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:47:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E75D113E;
        Fri, 13 May 2022 01:47:02 -0700 (PDT)
Received: from bogus (unknown [10.57.65.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82A563F73D;
        Fri, 13 May 2022 01:47:00 -0700 (PDT)
Date:   Fri, 13 May 2022 09:46:54 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>
Subject: Re: [PATCH V2] arch_topology: support parsing cluster_id from DT
Message-ID: <20220513084654.woxpjvtmtxx7cpik@bogus>
References: <1652262776-3056-1-git-send-email-wangqing@vivo.com>
 <Yn0XE3szFk9f2VyL@bogus>
 <SL2PR06MB3082CAA7318834D00872DE0DBDCA9@SL2PR06MB3082.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SL2PR06MB3082CAA7318834D00872DE0DBDCA9@SL2PR06MB3082.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 08:30:10AM +0000, 王擎 wrote:
> 
> >> From: Wang Qing <wangqing@vivo.com>
> >> 
> >> Use nested cluster structures in DT to support describing multi-level
> >> cluster topologies and increase the parsing of nested cluster.
> >> 
> >> Notice: the clusters describing in DT currently are not physical
> >> boundaries, since changing "cluster" to "socket" is too involved and error
> >> prone, this patch will not have any effect on one-level cluster topo, but
> >> can support the mutil-level cluster topo to support CLUSTER_SCHED.
> >
> >Sorry the socket/package_id is broken. If we are playing with cluster_id
> >which is now wrongly presented as package_id, you are forced to fix that
> >too. We don't want to break that in a different way or leave that as is
> >since the cluster_id and package ids now show up as same now. Earlier the
> >cluster_id was -1.
> >
> >I had a look when I started reviewing your patch. Assuming we don't need
> >nested cluster support yet, I have some patches(not built or tested
> >unfortunately yet). Let me know your thoughts. If you think you still
> >need support for some kind of nested cluster, build that on top of this.
> >Also I haven't bothered about sched domains as this purely relates to
> >topology and how this is mapped to sched domain is orthogonal.
> >
> >If anything is broken, that needs to be fixed separately there. I see the
> >idea here is correct and would like to push the patches once I build/test
> >and get some review/more testing.
> >
> >Regards,
> >Sudeep
>
> You have to modify all DTS(rename "cluster" to "socket"), otherwise, 
> new package_id = -1 and new cluster_id = old package_id.
>

Nope. I am handling absence of socket nodes and that is a must for backward
compatibility with existing DT.

> This will affect MC and CLS useage, do you have any plans about this?
>

I don't have much knowledge on scheduler domains and I will defer that to
the experts. I am just trying to get the topology read from DT correct and
to align with PPTT. Though LLC is not yet considered but that is not part
of cpu-map. I am trying to get only the /cpu-map part of topology correct
at first. We(you, me or anyone interested) can get the LLC part updated
after that.

--
Regards,
Sudeep
