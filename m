Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF3954EDCF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 01:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379356AbiFPXPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 19:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiFPXPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 19:15:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0247762A0A;
        Thu, 16 Jun 2022 16:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655421343; x=1686957343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Bm9Vb0LSbnkJ7TNyPuwbBBz6WhULyCYNAtvB1EzVugQ=;
  b=fiPggnN5C5hqmotl01zdGdbaq+K7HhdKsw/7lQitFVjHU9KTmBQFWApb
   VOly4cEvI0JrtA7uWQlIBNeY2hRmwyBym2owfhwplg3ng09oWDEMPe+in
   ZaYIigP6AymKLlJXhodagZLd8s6yJ83T6eKBW0rv8NmKIAgJhUnPTPP4o
   +LfuTzgUMxkPjaTdRdOvjZZExU8nlh0hTs7ZOHfE+dn0qdmB2R1C4BzXm
   DLxOKjbKHJ8A8JXHtEh96w34fgTijEuNP1XITvsh7VfGhNKWcGAaNz1VK
   4HSN66/a9f8QxVp03jWmDNbQOb2EDr3+XrFp3JHAA8rqmiUX90iTM8DIJ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="259225680"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="259225680"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 16:15:43 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="641767275"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 16:15:43 -0700
Date:   Thu, 16 Jun 2022 16:15:22 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>
Subject: Re: [PATCH 2/3] cxl/mbox: Add GET_POISON_LIST mailbox command support
Message-ID: <20220616231522.GA1529779@alison-desk>
References: <cover.1655250669.git.alison.schofield@intel.com>
 <382a9c35ef43e89db85670637d88371f9197b7a2.1655250669.git.alison.schofield@intel.com>
 <20220616194334.pvorvoozt4rrzr66@offworld>
 <20220616203400.GA1529208@alison-desk>
 <20220616224525.fufa4dnpw4vl344n@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616224525.fufa4dnpw4vl344n@offworld>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 03:45:25PM -0700, Davidlohr Bueso wrote:
> On Thu, 16 Jun 2022, Alison Schofield wrote:
> 
> >cxl list --media-errors -m mem1
> >	lists media errors for requested memdev
> >
> >cxl list --media-errors -r region#
> 
> A quick question on the tooling front: the above goes nicely with
> cxl-list, but what about the rest of the poisoning cmds? Do you have
> anything in mind? Do we want something specific for media and poison
> management instead? Ie:
> 
> cxl media --list-errors <params>
Not clear how this one differs. Seems like we can get any piece of 
the list w cxl list.

> cxl media --inject-errors <params>
> cxl media --clear-errors <params>
For inject/clear I'd probably start w what ndctl does today.
ndctl inject−error  <namespace> [<options>]
where option -d --uninject performs the clear.

> 
> Thanks,
> Davidlohr
