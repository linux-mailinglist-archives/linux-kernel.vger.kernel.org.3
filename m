Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C6850A595
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiDUQ2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbiDUQNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:13:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2286B1FCF0;
        Thu, 21 Apr 2022 09:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B368A61568;
        Thu, 21 Apr 2022 16:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C9CC385A1;
        Thu, 21 Apr 2022 16:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650557415;
        bh=iLVPxAK/KMYALe2s91jOF3emo6JFCgR6wtoMr9gWDqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HO8CoV6YBMRZ8WhObFwrc5WtxrTzISLhbGlUPOx//29pdnSD1cQzF360meDAD2pMr
         gIGvbG0nldbun5OcOZNVWCQivl1bFq+nHxs00LTADFARN4Tn0xdG7HkGAALgKm3piw
         Ah1fVQ3rILvZcg104/BdUEm2q0EKYLt45Dqgsi2U=
Date:   Thu, 21 Apr 2022 18:10:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/8] cxl/acpi: Add root device lockdep validation
Message-ID: <YmGB5DMVAaIq3HYl@kroah.com>
References: <165055518776.3745911.9346998911322224736.stgit@dwillia2-desk3.amr.corp.intel.com>
 <165055519869.3745911.10162603933337340370.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165055519869.3745911.10162603933337340370.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:33:18AM -0700, Dan Williams wrote:
> The CXL "root" device, ACPI0017, is an attach point for coordinating
> platform level CXL resources and is the parent device for a CXL port
> topology tree. As such it has distinct locking rules relative to other
> CXL subsystem objects, but because it is an ACPI device the lock class
> is established well before it is given to the cxl_acpi driver.
> 
> However, the lockdep API does support changing the lock class "live" for
> situations like this. Add a device_lock_set_class() helper that a driver
> can use in ->probe() to set a custom lock class, and
> device_lock_reset_class() to return to the default "no validate" class
> before the custom lock class key goes out of scope after ->remove().
> 
> Note the helpers are all macros to support dead code elimination in the
> CONFIG_PROVE_LOCKING=n case.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/acpi.c     |   15 +++++++++++++++
>  include/linux/device.h |   25 +++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)

Much simpler, great work.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
