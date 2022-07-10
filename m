Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B0B56D0AF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 20:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiGJSMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 14:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGJSMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 14:12:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F570A188;
        Sun, 10 Jul 2022 11:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657476755; x=1689012755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kp/CSizk1lD3N+N92mt1x3FTwXV7OEfzLNstnxjIUno=;
  b=lRr42yzMLsp2cenaWspBAPkuCC+WsDtXhJjJsTo1pP96g9KCJUKCz3gz
   7V0pW+E+R0rsv/0bbgPsq4uzTfOibpWe/rm9Pv8QhwFHG7Z4f4pIsiLCY
   wA6DpxXMH3RA+d8hq7kpP4WtPsXW1Ax1mNDm8MwFUvx7OFuE27e9MxdJ0
   0kM9qaPdB4Xe0lL0pb7dxY++ZrJIP5KJpoLwBMoZzdgvCkFj87Os42ECG
   QdjhQQuyWZu9jQ+QLLgM3mMU3UpWWDXQ4paMMFlPQEZv7HIIJSk1AVWLr
   RqPvoRwtrz0YOJzr/VKNymMVOoWtA2shFE0cicuaMAeEMy8Iez8azaZ5o
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="285657809"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="285657809"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 11:12:34 -0700
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="621818834"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 11:12:34 -0700
Date:   Sun, 10 Jul 2022 11:12:33 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jithu Joseph <jithu.joseph@intel.com>, markgross@kernel.org,
        ashok.raj@intel.com, gregkh@linuxfoundation.org,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v2] platform/x86/intel/ifs: Allow non-default names for
 IFS image
Message-ID: <YssWkQegNlki4XNZ@agluck-desk3.sc.intel.com>
References: <20220710160011.995800-1-jithu.joseph@intel.com>
 <535ccbeb-b6e5-b7ef-47b4-894af24c00b0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <535ccbeb-b6e5-b7ef-47b4-894af24c00b0@redhat.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2022 at 06:12:44PM +0200, Hans de Goede wrote:
> Not doing the initial load at module-load time will also speed-up
> the module initialization and thus booting the system. Especially
> on many-core servers this might make a measurable difference
> in module-init time.

The load is per-socket, not per core. So "many-core" doesn't matter
as much as number of sockets.

-Tony
