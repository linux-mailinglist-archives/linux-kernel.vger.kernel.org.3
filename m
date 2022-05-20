Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2327A52ED01
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349506AbiETNVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349641AbiETNUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:20:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A16516A260
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 06:20:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA1C21477;
        Fri, 20 May 2022 06:20:34 -0700 (PDT)
Received: from bogus (unknown [10.57.66.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B74F3F73D;
        Fri, 20 May 2022 06:20:32 -0700 (PDT)
Date:   Fri, 20 May 2022 14:20:25 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Atish Patra <atishp@atishpatra.org>, linux-kernel@vger.kernel.org,
        Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/8] arch_topology: Set thread sibling cpumask only
 within the cluster
Message-ID: <20220520132025.sbbmnusnmls3ruow@bogus>
References: <20220518093325.2070336-1-sudeep.holla@arm.com>
 <20220518093325.2070336-3-sudeep.holla@arm.com>
 <db6dc5e0-780a-5542-5e49-711cd454a9d8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db6dc5e0-780a-5542-5e49-711cd454a9d8@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 02:32:19PM +0200, Dietmar Eggemann wrote:
> On 18/05/2022 11:33, Sudeep Holla wrote:
> > Currently the cluster identifier is not set on the DT based platforms.
> > The reset or default value is -1 for all the CPUs. Once we assign the
> > cluster identifier values correctly that imay result in getting the thread
> > siblings wrongs as the core identifiers can be same for 2 different CPUs
> > belonging to 2 different cluster.
> > 
> > So, in order to get the thread sibling cpumasks correct, we need to
> > update them only if the cores they belong are in the same cluster within
> > the socket. Let us skip updation of the thread sibling cpumaks if the
> > cluster identifier doesn't match.
> 
> So this issue should be there on ACPI systems as well then. Kunpeng920
> and Ampere Altra don't have SMT, so very likely nobody has noticed this
> so far.

No, I think it is handled correctly. May be the wordings of my commit log
needs changing. Previously the core ids were generated and unique across the
platform. But with this change I am assigned the id as read from the DT
node using core@<id>. That results in the problem and needs to be taken care.
This doesn't change the end result(the actual mask) but the way we arrive at
that. In short this is not fixing any issue that was broken before.

-- 
Regards,
Sudeep
