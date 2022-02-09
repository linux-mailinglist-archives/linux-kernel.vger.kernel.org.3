Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB7B4AF05B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiBIL5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiBIL4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:56:06 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943DAE03E230
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644404201; x=1675940201;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=k4hLpxCP5zG4YqnamMN0O5VXPbh5iT9Em3+ShBxtEzQ=;
  b=axZpmKuSrrplNlJ/dmgF2+Ed7DUL2WxIMfNRpIj4Mb0Lv4WXX6fg8XaT
   J2HB91VWbxpL3TD0lhTIgvscPYTcqDGg1A4EGytYiJrFJSOqBO49XGLi+
   WfAgJovWFTFf1YT08I4bPwbP81bMItt8kZJ0C69nXRSQVPqzAE7ZRCGnu
   OWmnP+0LlfUI90Fi/5GbUmdNTOGWLW5jyV9gitJ4J43OkPPl3vZZN8hQm
   itByyFOQjMC2ztiR33rnNHQGfmz21DSyLqqopFM/YrKkPDn5GoDKxhW4x
   I+pbhmJbndvd7glG2/+yuLAGJNpB2B9lWMHNm7ciYcDxW5U6VRz1VbfK/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="229131597"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="229131597"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 01:05:03 -0800
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="485168645"
Received: from rcallina-mobl3.ger.corp.intel.com (HELO localhost) ([10.252.18.41])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 01:04:59 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Zhi Wang <zhi.wang.linux@gmail.com>, hch@lst.de, jgg@nvidia.com,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Vivi Rodrigo <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Terrence Xu <terrence.xu@intel.com>
Subject: Re: [PATCH v6 1/3] i915/gvt: Introduce the mmio table to support
 VFIO new mdev API
In-Reply-To: <20220209072805.GA9050@lst.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220208111151.13115-1-zhi.a.wang@intel.com>
 <871r0dqtjf.fsf@intel.com> <20220209072805.GA9050@lst.de>
Date:   Wed, 09 Feb 2022 11:04:57 +0200
Message-ID: <87v8xopg06.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Feb 2022, Christoph Hellwig <hch@lst.de> wrote:
> On Tue, Feb 08, 2022 at 05:15:00PM +0200, Jani Nikula wrote:
>> >  #ifdef CONFIG_DRM_I915_GVT
>> > +
>> > +#define D_BDW   (1 << 0)
>> > +#define D_SKL	(1 << 1)
>> > +#define D_KBL	(1 << 2)
>> > +#define D_BXT	(1 << 3)
>> > +#define D_CFL	(1 << 4)
>> > +
>> > +#define D_GEN9PLUS	(D_SKL | D_KBL | D_BXT | D_CFL)
>> > +#define D_GEN8PLUS	(D_BDW | D_SKL | D_KBL | D_BXT | D_CFL)
>> > +
>> > +#define D_SKL_PLUS	(D_SKL | D_KBL | D_BXT | D_CFL)
>> > +#define D_BDW_PLUS	(D_BDW | D_SKL | D_KBL | D_BXT | D_CFL)
>> > +
>> > +#define D_PRE_SKL	(D_BDW)
>> > +#define D_ALL		(D_BDW | D_SKL | D_KBL | D_BXT | D_CFL)
>> 
>> If these really need to be in a header in i915/, I think they need to be
>> longer with some namespacing or something. I do wish these could be
>> hidden though.
>
> I think we could actually kill them off entirely.  They are used as
> arguments to the macros that setup the mmio table.
>
> Thefunctions to build these tabls are already organized by families,
> so we'd need relatively few conditions to just build them the right
> way.  There also are some runtime checks in the callbacks, but they
> seem entirely superflous as far as I can tell.
>
> Only the cmd parser is a bit messy.  So maybe we could keep these
> constants just for the cmd parser inside of gvt for now (and clean
> that up later) and remove them entirely from the mmio table.

I'm fine with cleaning this up in follow-up, provided the follow-up
actually happens! ;)

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
