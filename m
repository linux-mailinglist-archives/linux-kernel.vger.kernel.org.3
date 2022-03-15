Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2296D4D980C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346828AbiCOJuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbiCOJug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:50:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 343121AF24
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:49:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25ED01474;
        Tue, 15 Mar 2022 02:49:23 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BA6D3F66F;
        Tue, 15 Mar 2022 02:49:21 -0700 (PDT)
Date:   Tue, 15 Mar 2022 09:49:19 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] arch_topology: Correct CPU capacity scaling
Message-ID: <YjBhH0qlOZ7BykQV@bogus>
References: <20220313055512.248571-1-leo.yan@linaro.org>
 <Yi+FMrG9NyBnMX0i@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi+FMrG9NyBnMX0i@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Mon, Mar 14, 2022 at 06:10:58PM +0000, Ionela Voinescu wrote:
> Hi Leo,
> 
> On Sunday 13 Mar 2022 at 13:55:09 (+0800), Leo Yan wrote:
> > This patch set is to address issues for CPU capacity scaling.
> > 
> > "capacity-dmips-mhz" property might be absent in all CPU nodes, and in
> > another situation, DT might have inconsistent binding issue, e.g. some
> > CPU nodes have "capacity-dmips-mhz" property and some nodes miss the
> > property.  Current code mixes these two cases and always rollback to CPU
> > capacity 1024 for these two cases.
> >

Ideally the schema can be made to catch such issues. While I understand
that it is work in progress, we can flag the error in the code to handle that.
Rollback to 1024 seems correct default behaviour to me.

> > Patches 01 and 02 in this set are used to distinguish the two different
> > DT binding cases, and for the inconsistent binding issue, it rolls back
> > to 1024 without CPU capacity scaling.
> >
> > Patch 03 is to handle the case for absenting "capacity-dmips-mhz"
> > property in CPU nodes, the patch proceeds to do CPU capacity scaling based
> > on CPU maximum capacity.  Thus it can reflect the correct CPU capacity for
> > Arm platforms with "fast" and "slow" clusters (CPUs in two clusters have
> > the same raw capacity but with different maximum frequencies).
> >

NACK for the approach. Just fix the DT.

>
> In my opinion it's difficult to handle absent "capacity-dmips-mhz"
> properties, as they can be a result of 3 scenarios: potential..
>  1. bug in DT
>  2. unwillingness to fill this information in DT
>  3. suggestion that we're dealing with CPUs with same u-arch
>     (same capacity-dmips-mhz)
>
> I'm not sure it's up to us to interpret suggestions in the code so I
> believe treating missing information as error is the right choice, which
> is how we're handling this now.
>

+1 for all the points above and are very much valid.

> For 3. (and patch 03), isn't it easier to populate capacity-dmips-mhz to
> the same value (say 1024) in DT? That is a clear message that we're
> dealing with CPUs with the same u-arch.
>

Indeed.

-- 
Regards,
Sudeep
