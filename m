Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF924D14A3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345766AbiCHKWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbiCHKWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:22:45 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF16442EC8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 02:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646734909; x=1678270909;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=tlfAGEzWZupbhLz4z0/Y6/HTRgwEljOiRNv5zyXFBDo=;
  b=HxhFgXCzcCAv4X2iKWaZXPMiLg9K+YefXIUSOjiCG40dq+n+lV887J0w
   O5hqeNG/74tXQu/YYTzSyRYM7TGN7i7j3T3iOgYPPUjJL/YEcTTYURh/b
   9FC8Qx7zw1ruABqcDC2pBVIbe/IA7HL9GdstGEyBPGwFagzGDoUvb6gAE
   ZH5FRqh4fD2VWLqmTyYkRAA3Q5/JNeEM6z+oamMnI1k9A+aMiFDV/mk+s
   K6YRCBl5/TDYdnu73ofOgr7nVnrF16Kyl51rJTtILIJODahDmDM7mG3pu
   1C+n0gA3/z6eBVNNjaz/3YZpmGa2l80G4Zp9/GfJyYtmaBGTSQSTbXIOT
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="254839656"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="254839656"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 02:21:49 -0800
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="513055616"
Received: from acushion-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.29.47])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 02:21:45 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     "xinlei.lee" <xinlei.lee@mediatek.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        matthias.bgg@gmail.com
Cc:     jitao.shi@mediatek.com, allen-kh.cheng@mediatek.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-mediatek@lists.infradead.org, rex-bc.chen@mediatek.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2, 0/4] Cooperate with DSI RX devices to modify dsi
 funcs and delay mipi high to cooperate with panel sequence
In-Reply-To: <9e3cd215a2f771236855bdb2f5faa172dcbd1aec.camel@mediatek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <1646388956-8033-1-git-send-email-xinlei.lee@mediatek.com>
 <87lexq2aw4.fsf@intel.com>
 <9e3cd215a2f771236855bdb2f5faa172dcbd1aec.camel@mediatek.com>
Date:   Tue, 08 Mar 2022 12:21:42 +0200
Message-ID: <87tuc8218p.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Mar 2022, xinlei.lee <xinlei.lee@mediatek.com> wrote:
> On Fri, 2022-03-04 at 13:51 +0200, Jani Nikula wrote:
>> Please also prefix cover letters with drm/mediatek if that's the only
>> place you're touching.
>
> Thanks for your review.
> Is your suggestion for me to put the fix id on the cover ?

Heh, it's not really review, just something to ease me going through the
dri-devel mails in the future.

The cover letter subject is "Cooperate with DSI RX devices to modify dsi
funcs and delay mipi high to cooperate with panel sequence" and I don't
know whether the thread is about drm dsi helpers or some drivers and
what drivers. If the cover letter subject also had the prefix
"drm/mediatek:" like all the patches, I could've just skipped it
altogether.

Just something to consider in the future, no need to do anything here.

Thanks,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
