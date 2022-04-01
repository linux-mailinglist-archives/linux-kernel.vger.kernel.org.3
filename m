Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB4F4EE59D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 03:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243697AbiDABQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 21:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiDABQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 21:16:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD58F90CC7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 18:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648775683; x=1680311683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+LQvb0o6BbIjna+vHxD9G2yeTvIukIQ8fnyVLrjAyRM=;
  b=NBqihaVDWnYB+c7F4KE5t1m35hNclWY8Su7Rz+Qy+bzeqX0W9UdaU7i2
   dA2uGzvvd+kAJMqSbRDFqhe8zSXr9ZK0aRP1eTHh6zpc47TGi63tz4lhi
   LedoEDzfNl0/5QcheWPLCUdaHbyRrhQ8sj5yKG/e9aKp/Jv0cLh+WG9WB
   pTHVvL8xmNyHD07KCTX5k/e026nBVp6dwFVWsI3aJqJ+whN9r0UscbHHj
   FBOv6EkkBJUFxUmyxiyDHPHvSUh8H74ScTQDwgdVgPDBNK8wPIK5P2niF
   Z6JgI0O8yWWjkdvLrqTH3Xv6JClx8F8qmx9ycmcGjDDB6/pUfWjKQN9sy
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="240605910"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="240605910"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 18:14:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="547593104"
Received: from louislifei-optiplex-7050.sh.intel.com (HELO louislifei-OptiPlex-7050) ([10.239.81.43])
  by orsmga007.jf.intel.com with ESMTP; 31 Mar 2022 18:14:41 -0700
Date:   Fri, 1 Apr 2022 09:15:33 +0800
From:   Li Fei1 <fei1.li@intel.com>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rppt@kernel.org,
        bjohannesmeyer@gmail.com, c.giuffrida@vu.nl, h.j.bos@vu.nl,
        fei1.li@intel.com
Subject: Re: [PATCH] virt: acrn: fix invalid check past list iterator
Message-ID: <20220401011533.GA29696@louislifei-OptiPlex-7050>
References: <20220319203819.2559993-1-jakobkoschel@gmail.com>
 <20220330075742.GA22544@louislifei-OptiPlex-7050>
 <6E68C33F-9CBB-418C-A11D-2AD863C0B19A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6E68C33F-9CBB-418C-A11D-2AD863C0B19A@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 01:20:50PM +0200, Jakob Koschel wrote:
> 
> > On 30. Mar 2022, at 09:57, Li Fei1 <fei1.li@intel.com> wrote:
> > 
> > On Sat, Mar 19, 2022 at 09:38:19PM +0100, Jakob Koschel wrote:
> >> The condition retry == 0 is theoretically possible even if 'client'
> >> does not point to a valid element because no break was hit.
> >> 
> >> To only execute the dev_warn if actually a break within the loop was
> >> hit, a separate variable is used that is only set if it is ensured to
> >> point to a valid client struct.
> >> 
> > Hi Koschel
> > 
> > Thanks for you to help us to try to improve the code. Maybe you don't get the point.
> > The dev_warn should only been called when has_pending = true && retry == 0
> 
> Maybe I don't understand but looking isolated at this function I could see a way to call
> the dev_warn() with has_pending = false && retry == 0.
Yes, even has_pending = true && retry == 0 at the beginning, we could not make sure
has_pending is true after schedule_timeout_interruptible and we even didn't check
there're other pending client on the ioreq_clients (because we can't make sure
when we dev_warn this clent is still pending). So we just use dev_warn not higher log level.
> 
> > 		list_for_each_entry(client, &vm->ioreq_clients, list) {
> > 			has_pending = has_pending_request(client);
> > 			if (has_pending)
> > 		}
> > 		spin_unlock_bh(&vm->ioreq_clients_lock);
> 
> imagine has_pending == false && retry == 1 here, then client will not hold a valid list entry.
What do you mean "client will not hold a valid list entry" ? 

> 
> > 
> > 		if (has_pending)
> > 			schedule_timeout_interruptible(HZ / 100);
> > 	} while (has_pending && --retry > 0);
> 
> since has_pending && --retry > 0 is no longer true the loop stops.
> 
> > 	if (retry == 0)
> > 		dev_warn(acrn_dev.this_device,
> > 			 "%s cannot flush pending request!\n", client->name);
> client->name is accessed since retry == 0 now, but client is not a valid struct ending up
> in a type confusion.
> 
> > 
> > If retry > 0 and has_pending is true,  we would call schedule_timeout_interruptible
> > to schedule out to wait all the pending I/O requests would been completed.
> > 
> > Thanks.
> 
> Again, I'm not sure if this is realistically possible. I'm trying to remove
> any use of the list iterator after the loop to make such potentially issues detectable
You may think we still in the loop (could we ?), even that we didn't write the list iterator then.
> at compile time instead of relying on certain (difficult to maintain) conditions to be met
> to avoid the type confusion.
> 
> Thanks,
> Jakob
> 
