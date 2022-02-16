Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5CF4B91CC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238365AbiBPTwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:52:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238301AbiBPTwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:52:41 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8BBFABE9;
        Wed, 16 Feb 2022 11:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645041148; x=1676577148;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Cr7vmjqZ19YsPqPC5f59BS6ggXP0WOv3DKiSQA5gj0=;
  b=Wy7pKQKZlKPl5pTw0zWLHu68FeZhPaCEkuFsJb50bLwoDi0F3vPvc1wC
   LzYhfnMxWW93z8dymlZ7d8tTLw5laH46PXNrBMB8VW5RXSLcgYMO7ar2A
   81KG6K+wqaPDUZnV2WcIg2Of34d0CjdHGwy6o1lu42fXzrDpG8yLHbwfm
   Xd6tP9Xq76mWt0+1IeoVIf1ENeSubcsF7BzbNDt/eLfFSi3g5+1DSh7/U
   D4AAQaTTqK6MoKEvEoxAffqvyTFrOc3chBkAH21DOI443YpKuiXg3wZam
   J7RfDWbIK+WTi7o1zccbuLG1JIsu6zv6FB/RkyrUqGO0oBuxE75hZAIOr
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="248310663"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="248310663"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 11:52:28 -0800
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="529677653"
Received: from ddahlenx-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.148.13])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 11:52:27 -0800
Message-ID: <1525de98e422b2978f18378c752b92513c328ccd.camel@linux.intel.com>
Subject: Re: [RFC PATCH 1/4] tools/lib/thermal: Add a thermal library
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Wed, 16 Feb 2022 11:52:27 -0800
In-Reply-To: <c5889d73-7acb-a564-b091-44e71ba5ddb3@linaro.org>
References: <20220214210446.255780-1-daniel.lezcano@linaro.org>
         <0be77e01c0dc91e227fcb7219cf89d9497b4be39.camel@linux.intel.com>
         <c5889d73-7acb-a564-b091-44e71ba5ddb3@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Wed, 2022-02-16 at 20:38 +0100, Daniel Lezcano wrote:
> 
> Hi Srinivas,
> 
> thanks for the review
> 
> On 16/02/2022 17:40, srinivas pandruvada wrote:
> > On Mon, 2022-02-14 at 22:04 +0100, Daniel Lezcano wrote:
> > > The thermal framework implements a netlink notification mechanism
> > > to
> > > be used by the userspace to have a thermal configuration
> > > discovery,
> > > trip point changes or violation, cooling device changes
> > > notifications,
> > > etc...
> > > 
> > > This library provides a level of abstraction for the thermal
> > > netlink
> > > notification allowing the userspace to connect to the
> > > notification
> > > mechanism more easily. The library is callback oriented.
> > > 
> > Some minor comments.
> > May be better use some defines instead of returning "-1" for error
> > conditions.
> 
> Do you suggest like an enum with different errors or just having -1 
> replaced by eg. THERMAL_ERROR ?
This will be fine.

Thanks,
Srinivas


> 
> 
> [ ... ]
> 
> > > + * Low level netlink
> > > + */
> > > +extern int nl_subscribe_thermal(struct nl_sock *nl_sock, struct
> > > nl_cb *nl_cb,
> > > +                               const char *group);
> > > +
> > To complete API, don't we need nl_unsubscribe which calls
> > nl_socket_drop_memberships()?
> Ah, yes. I'll add it.
> 
> Thanks
> 
> 
> 

