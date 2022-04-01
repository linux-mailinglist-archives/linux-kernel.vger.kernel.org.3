Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE4B4EEA27
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 11:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344377AbiDAJOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 05:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbiDAJN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:13:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832C8265E9E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 02:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648804329; x=1680340329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XdMyYC78WwVD11Wesrkr5JwMfZqfI3U9bC4AfF4UdNc=;
  b=mPjFOeQ1DaPmQfAt4SMvIe5aUjkBbKOc34+rLY4b4/zjx+hqwQgU2LQk
   UliLTknn6KkoGMp8mmzQQlrZ+rZrhEO/EeFiGlFtuNnjIJ9sgAjwoD8L6
   QSfOoXZWH1vEumSyHlEurXj9+JP66tZSGjcccGwk0B/npKZiQ4OdrBgcY
   DsY+6pcwq2KpCPr199dGqKJ6UeDJQvXnprlJ/stPTjDDAp4HlWTJ74bvA
   8iAdDc7aM6oDOYLQmsPMPFFe+aGoOZIBEcqMYK57pOtl9bg1uiGH7ZFkp
   OG0KQZ1Z1tfiMUdiM9DDvx0eTwzZhBliLi1NB1tEa+drF0AV/GQi2pOI9
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="258917820"
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; 
   d="scan'208";a="258917820"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 02:12:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; 
   d="scan'208";a="606637289"
Received: from louislifei-optiplex-7050.sh.intel.com (HELO louislifei-OptiPlex-7050) ([10.239.81.43])
  by fmsmga008.fm.intel.com with ESMTP; 01 Apr 2022 02:12:07 -0700
Date:   Fri, 1 Apr 2022 17:12:59 +0800
From:   Li Fei1 <fei1.li@intel.com>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rppt@kernel.org,
        bjohannesmeyer@gmail.com, c.giuffrida@vu.nl, h.j.bos@vu.nl,
        fei1.li@intel.com
Subject: Re: [PATCH] virt: acrn: fix invalid check past list iterator
Message-ID: <20220401091259.GA32221@louislifei-OptiPlex-7050>
References: <20220330075742.GA22544@louislifei-OptiPlex-7050>
 <6E68C33F-9CBB-418C-A11D-2AD863C0B19A@gmail.com>
 <20220401011533.GA29696@louislifei-OptiPlex-7050>
 <F54F358F-FFBC-4D6D-AB5C-9BC4A617C9BF@gmail.com>
 <20220401035742.GA31162@louislifei-OptiPlex-7050>
 <CE06BFFA-93CA-4E25-AB63-524C3F293556@gmail.com>
 <20220401075711.GA31912@louislifei-OptiPlex-7050>
 <65660B0C-8888-4283-80E4-D1A334EEF166@gmail.com>
 <20220401090545.GA32168@louislifei-OptiPlex-7050>
 <0607BE1D-B2A6-4B93-9B4C-C04715B41E8C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0607BE1D-B2A6-4B93-9B4C-C04715B41E8C@gmail.com>
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

On Fri, Apr 01, 2022 at 11:08:02AM +0200, Jakob Koschel wrote:
> 
> 
> > On 1. Apr 2022, at 11:05, Li Fei1 <fei1.li@intel.com> wrote:
> > 
> > On Fri, Apr 01, 2022 at 10:50:51AM +0200, Jakob Koschel wrote:
> >> 
> >> 
> >>> On 1. Apr 2022, at 09:57, Li Fei1 <fei1.li@intel.com> wrote:
> >>> 
> >>> On Fri, Apr 01, 2022 at 09:16:48AM +0200, Jakob Koschel wrote:
> >>>> 
> >>>> 
> >>>>> On 1. Apr 2022, at 05:57, Li Fei1 <fei1.li@intel.com> wrote:
> >>>>> 
> >>>>> On Fri, Apr 01, 2022 at 05:22:36AM +0200, Jakob Koschel wrote:
> >>>>>> 
> >>>>>>> On 1. Apr 2022, at 03:15, Li Fei1 <fei1.li@intel.com> wrote:
> >>>>>>> 
> >>>>>>> On Thu, Mar 31, 2022 at 01:20:50PM +0200, Jakob Koschel wrote:
> >>>>>>>> 
> >>>>>>>>> On 30. Mar 2022, at 09:57, Li Fei1 <fei1.li@intel.com> wrote:
> >>>>>>>>> 
> >>>>>>>>> On Sat, Mar 19, 2022 at 09:38:19PM +0100, Jakob Koschel wrote:
> >>>>>>>>>> The condition retry == 0 is theoretically possible even if 'client'
> >>>>>>>>>> does not point to a valid element because no break was hit.
> >>>>>>>>>> 
> >>>>>>>>>> To only execute the dev_warn if actually a break within the loop was
> >>>>>>>>>> hit, a separate variable is used that is only set if it is ensured to
> >>>>>>>>>> point to a valid client struct.
> >>>>>>>>>> 
> >>>>>>>>> Hi Koschel
> >>>>>>>>> 
> >>>>>>>>> Thanks for you to help us to try to improve the code. Maybe you don't get the point.
> >>>>>>>>> The dev_warn should only been called when has_pending = true && retry == 0
> >>>>>>>> 
> >>>>>>>> Maybe I don't understand but looking isolated at this function I could see a way to call
> >>>>>>>> the dev_warn() with has_pending = false && retry == 0.
> >>>>>>> Yes, even has_pending = true && retry == 0 at the beginning, we could not make sure
> >>>>>>> has_pending is true after schedule_timeout_interruptible and we even didn't check
> >>>>>>> there're other pending client on the ioreq_clients (because we can't make sure
> >>>>>>> when we dev_warn this clent is still pending). So we just use dev_warn not higher log level.
> >>>>>> 
> >>>>>> I'm sorry, I don't quite understand what you mean by that.
> >>>>>> Do you agree that has_pending = false && retry == 0 is possible when calling the dev_warn()
> >>>>>> or not?
> >>>>>> 
> >>>>> Yes, so what ? It just a hint there may have pending request.
> >>>> 
> >>>> if has_pending == false && retry == 0 when calling dev_warn() there are very clear
> >>>> dependencies met:
> >>>> 
> >>>> * has_pending == false means that the list_for_each_entry() macro it *not* exit early.
> >>>> * since list_for_each_entry() did *not* exit early, client will not hold a valid list entry
> >>>> * using client->name is not safe and will not point to a valid string (perhaps not even an address)
> >>> So you'd better to check when the client in ioreq_clients would been destroyed, right ?
> >> 
> >> I'm afraid I don't know exactly what you mean here.
> >> 
> >> More specifically:
> >> to check what? and I'm also not sure what you mean with "when client in ioreq_clients would been destroyed".
> >> 
> >> Actually thinking about it more the check should be
> >> 
> >> 	if (client && retry == 0)
> >> 
> >> to be correct.
> > The client in ioreq_clients would always been "valid" (here valid means the client struct would not
> > been destroyed) when this function been called. That's guaranteed by the code logic.
> 
> Now I'm very confused.
> Didn't you say the dev_msg() can be called with has_pending == false && retry == 0?
> Then the 'client' used in the dev_msg() cannot be valid.
I think I would not reply you before you understand how ACRN ioreq works.

> 
> >> 
> >> if has_pending == false I read the code as if no client was found that has a pending request 
> >> so I don't follow how:
> >> 
> >> 	"%s cannot flush pending request!\n", client->name);
> >> 
> >> can be valid since no client has a pending request.
> >> 
> >>> 
> >>>> 
> >>>> I'm *only* talking about the case where has_pending == false, in case that's not clear.
> >>>> 
> >>>> 
> >>>>> Even retry == 0 && has_pending = true,
> >>>>> When we call dev_warn, the clent may not is pending.
> >>>>> 
> >>>>> 
> >>>>>>>> 
> >>>>>>>>> 		list_for_each_entry(client, &vm->ioreq_clients, list) {
> >>>>>>>>> 			has_pending = has_pending_request(client);
> >>>>>>>>> 			if (has_pending)
> >>>>>>>>> 		}
> >>>>>>>>> 		spin_unlock_bh(&vm->ioreq_clients_lock);
> >>>>>>>> 
> >>>>>>>> imagine has_pending == false && retry == 1 here, then client will not hold a valid list entry.
> >>>>>>> What do you mean "client will not hold a valid list entry" ? 
> >>>>>> 
> >>>>>> Imagine a very simple example:
> >>>>>> 
> >>>>>> 	struct acrn_ioreq_client *client;
> >>>>>> 	list_for_each_entry(client, &vm->ioreq_clients, list) {
> >>>>>> 		continue;
> >>>>>> 	}
> >>>>>> 
> >>>>>> 	dev_warn(acrn_dev.this_device,
> >>>>>> 		 "%s cannot flush pending request!\n", client->name); /* NOT GOOD */
> >>>>>> 
> >>>>> If there're pending request, we would call schedule to schedule out then schedule back
> >>>>> to check the list from the beginning. If there's no pending client, we point to the last
> >>>>> client and break out the while loop.
> >>>>> 
> >>>>> The code doesn't want to find the pending client and break out the while loop and call
> >>>>> dev_warn. Please see the function comment.
> >>>>> 
> >>>>> 
> >>>>>> 
> >>>>>> Since there is no break for the list_for_each_entry() iterator to return early,
> >>>>>> client *cannot* be a valid entry of the list. In fact if you look at the list_for_each_entry()
> >>>>>> macro, it will be an 'bogus' pointer, pointing somewhere into 'vm'.
> >>>>>> Essentially before the terminating condition of the list traversal the following code is called:
> >>>>>> 
> >>>>>> 	list_entry(&vm->ioreq_clients, struct acrn_ioreq_client *, list);
> >>>>>> 
> >>>>>> resulting in a:
> >>>>>> 
> >>>>>> 	container_of(&vm->ioreq_clients, struct acrn_ioreq_client *, list);
> >>>>>> 
> >>>>>> &vm->ioreq_clients however is not contained in a struct acrn_ioreq_client, making
> >>>>>> this call compute an invalid pointer.
> >>>>>> Therefore using 'client' as in the example above (e.g. client->name) after the loop is
> >>>>>> not safe. Since the loop can never return early in the simple example above it will
> >>>>>> always break. On other cases (the one we are discussing here) there might be a chance that
> >>>>>> there is one code path (in theory) where the loop did not exit early and 'client'
> >>>>>> holds that 'invalid entry'.
> >>>>>> 
> >>>>>> This would be the case with has_pending = false && retry == 0.
> >>>>>> 
> >>>>>> I hope this makes sense.
> >>>>>> 
> >>>>>>> 
> >>>>>>>> 
> >>>>>>>>> 
> >>>>>>>>> 		if (has_pending)
> >>>>>>>>> 			schedule_timeout_interruptible(HZ / 100);
> >>>>>>>>> 	} while (has_pending && --retry > 0);
> >>>>>>>> 
> >>>>>>>> since has_pending && --retry > 0 is no longer true the loop stops.
> >>>>>>>> 
> >>>>>>>>> 	if (retry == 0)
> >>>>>>>>> 		dev_warn(acrn_dev.this_device,
> >>>>>>>>> 			 "%s cannot flush pending request!\n", client->name);
> >>>>>>>> client->name is accessed since retry == 0 now, but client is not a valid struct ending up
> >>>>>>>> in a type confusion.
> >>>>>>>> 
> >>>>>>>>> 
> >>>>>>>>> If retry > 0 and has_pending is true, we would call schedule_timeout_interruptible
> >>>>>>>>> to schedule out to wait all the pending I/O requests would been completed.
> >>>>>>>>> 
> >>>>>>>>> Thanks.
> >>>>>>>> 
> >>>>>>>> Again, I'm not sure if this is realistically possible. I'm trying to remove
> >>>>>>>> any use of the list iterator after the loop to make such potentially issues detectable
> >>>>>>> You may think we still in the loop (could we ?), even that we didn't write the list iterator then.
> >>>>>> 
> >>>>>> I'm not exactly sure which loop you are referring to but no, I don't think we are still in
> >>>>>> the do while loop.
> >>>>>> 
> >>>>>> The only thing we know after the do while loop is that: !has_pending || retry == 0
> >>>>>> And iff has_pending && retry == 0, then we shouldn't call the dev_warn().
> >>>>>> 
> >>>>>>>> at compile time instead of relying on certain (difficult to maintain) conditions to be met
> >>>>>>>> to avoid the type confusion.
> >>>>>>>> 
> >>>>>>>> Thanks,
> >>>>>>>> Jakob
> >>>>>> 
> >>>>>> 	Jakob
> >>>> 
> >>>> 	Jakob
> 
