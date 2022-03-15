Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FAF4D9249
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 02:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344209AbiCOBe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 21:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237244AbiCOBe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 21:34:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEB728E14
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 18:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647307995; x=1678843995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yO9gbWCF9l8nH8/EqHP3dKeO8aI+4QFUfkY8XyJQW4A=;
  b=VOqQm3Aw8n6ekAsB2wajKmEMLN+tiZTsHQfyiK981JGtlD8ytMLaF4+g
   ux8BSYmTdA7EX4yp/wwpr5AC6Ji87HjgC30AqJF5LuWOE6MPsnrVTQxUn
   vdHSzgayxMwCqzpaHHF9hG2X35LP1sXNAsVGkaEe51d8b+Y0L/mxfgSMK
   0fFIZYD5/A6+4ccHhYRoy1DKiRhEkZ3jB4+8sNW/giiVk2aw1jMKITByF
   heTLURls6BKgeFpn0kA4jLQo+bNejdSCd85WUGu8okJWHOASs7I38O2Lj
   yhutZkFqmHenCyBrLeddmVnSRxrRmD/A+d8x+2Sne4Pd8XWipugOMUUn8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256377709"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="256377709"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 18:33:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="512435383"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.138])
  by orsmga002.jf.intel.com with ESMTP; 14 Mar 2022 18:33:09 -0700
Date:   Tue, 15 Mar 2022 09:33:08 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     tglx@linutronix.de, andi.kleen@intel.com, bp@alien8.de,
        dave.hansen@intel.com, hpa@zytor.com, len.brown@intel.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, paulmck@kernel.org,
        peterz@infradead.org, rui.zhang@intel.com, tim.c.chen@intel.com,
        x86@kernel.org, mtosatti@redhat.com, frederic@kernel.org
Subject: Re: [PATCH v3 1/2] x86/tsc: add a timer to make sure tsc_adjust is
 always checked
Message-ID: <20220315013308.GA36349@shbuild999.sh.intel.com>
References: <20211117023751.24190-1-feng.tang@intel.com>
 <20220314175207.274870-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314175207.274870-1-nsaenzju@redhat.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

Thanks for raising it.

On Mon, Mar 14, 2022 at 06:52:07PM +0100, Nicolas Saenz Julienne wrote:
> Hi Feng, Thomas,
> 
> > On Wed, Nov 17, 2021 at 10:37:51AM +0800, Feng Tang wrote:
> > Normally the tsc_sync will get checked every time system enters idle state,
> > but Thomas Gleixner mentioned there is still a caveat that a system won't
> > enter idle [1], either because it's too busy or configured purposely to not
> > enter idle. Setup a periodic timer (every 10 minitues) to make sure the
> > check is always on.
> > 
> > [1]. https://lore.kernel.org/lkml/875z286xtk.fsf@nanos.tec.linutronix.de/
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> 
> I can see this timer interrupting my system's nohz_full CPUs. It'd be nice to
> be able to avoid the noise. A solution is using 'tsc=reliable', but IIUC this
> is not what the flag was created for. Any ideas/suggestions?
 
This patch is about correctness. And yes, as you said, the 'tsc=reliable'
works. Another thought is to leverage the 'housekeeping_mask' to exclude
the isolated nohz_full CPUs, but the 'caveat' what the patch try to solve
remains.

Also before this patchset, the clocksource watchdog timer is fired every
500ms, which should interrupt nohz_full CUPS more? 

Thanks,
Feng

> Regards,
> Nicolas
