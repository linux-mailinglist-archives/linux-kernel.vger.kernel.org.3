Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D29154FB75
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 18:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiFQQuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 12:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382886AbiFQQuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 12:50:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A8C55498;
        Fri, 17 Jun 2022 09:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655484579; x=1687020579;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qyf3AMLlerC57Tqjq0VUahZAf2HuNr4dMDrL7K8rrsQ=;
  b=T0NEfuoyfmPrtAratv8l0ZHYy0AUCut+GAqSHHlofTBtrI4/lCfZW/uw
   GDEO3l6zn6tVjDeEJqcLHEnT25/pqiFzTBk2XYScwFkKc3SBi3ytJ+QFO
   l55SfNAd3MNvlbiYlvyR1nd/YF03Khn6Mfxw3m4SAXzl2qZd4xUH5i+hz
   EEOY74fZ9BsKRUYKcwSwunfXyUbr3q3AXO8LYWGUWeER281wNxwEELkGz
   z3QBM6x9MG5NM0J3qtNYYyCfUpcw0PP9Xl/7fmz6LyZLbJYrH8lq0K2L4
   C/b/btRvyHSdOHa5qvCEKgDLeBE4ZAIiGFGA83vYDzPheJPDlTo/NkLnF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="277062179"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="277062179"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 09:29:58 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="728388803"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 09:29:57 -0700
Date:   Fri, 17 Jun 2022 09:29:35 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/mbox: Add GET_POISON_LIST mailbox command support
Message-ID: <20220617162935.GA1532720@alison-desk>
References: <cover.1655250669.git.alison.schofield@intel.com>
 <382a9c35ef43e89db85670637d88371f9197b7a2.1655250669.git.alison.schofield@intel.com>
 <20220617150508.0000266a@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617150508.0000266a@Huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 07:05:08AM -0700, Jonathan Cameron wrote:
> On Tue, 14 Jun 2022 17:10:27 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > CXL devices that support persistent memory maintain a list of locations
> > that are poisoned or result in poison if the addresses are accessed by
> > the host.
> > 
> > Per the spec (CXL 2.0 8.2.8.5.4.1), the device returns this Poison
> > list as a set of  Media Error Records that include the source of the
> > error, the starting device physical address and length. The length is
> > the number of adjacent DPAs in the record and is in units of 64 bytes.
> > 
> > Retrieve the list and log each Media Error Record as a trace event of
> > type cxl_poison_list.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> A few more things inline.
> 
> Otherwise, can confirm it works with some hack QEMU code.
> I'll tidy that up and post soon.
> 
> > +int cxl_mem_get_poison_list(struct device *dev)
> > +{
snip
> > +
> > +			trace_cxl_poison_list(dev, source, addr, len);
> 
> Need to mask off the lower 6 bits of addr as they contain the source
> + a few reserved bits.
> 
> I was confused how you were geting better than 64 byte precision in your
> example.
>
Ah...got it. Thanks!

> > +		}
> > +
> > +		/* Protect against an uncleared _FLAG_MORE */
> > +		nr_records = nr_records + le16_to_cpu(po->count);
> > +		if (nr_records >= cxlds->poison_max)
> > +			goto out;
> > +
> > +	} while (po->flags & CXL_POISON_FLAG_MORE);
> So.. A conundrum here.  What happens if:
> 
> 1. We get an error mid way through a set of multiple reads
>    (something intermittent - maybe a software issue)
> 2. We will drop out of here fine and report the error.
> 3. We run this function again.
> 
> It will (I think) currently pick up where we left off, but we have
> no way of knowing that as there isn't a 'total records' count or
> any other form of index in the output payload.

Yes. That is sad. I'm assume it's by design and CXL devices never
intended to keep any totals.

> 
> So, software solutions I think should work (though may warrant a note
> to be added to the spec).
> 
> 1. Read whole thing twice. First time is just to ensure we get
>    to the end and flush out any prior half done reads.
> 2. Issue a read for a different region (perhaps length 0) first
>    and assume everything starts from scratch when we go back to
>    this region.

Can you tell me more about 2 ?

Also, Since posting this I have added protection to this path to ensure
only one reader of the poison list for this device. Like this:

if (!completion_done(&cxlds->read_poison_complete);
              return -EBUSY;
wait_for_completion_interruptible(&cxlds->read_poison_complete);
	...GET ALL THE POISON...
complete(&cxlds->read_poison_complete);

And will add the error message on that unexpected _FLAG_MORE too.

Alison
> 
> Jonathan
> 



> > +
> > +out:
> > +	kvfree(po);
> > +	return rc;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_mem_get_poison_list, CXL);
> > +
> >  struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
> >  {
> >  	struct cxl_dev_state *cxlds;
> 
