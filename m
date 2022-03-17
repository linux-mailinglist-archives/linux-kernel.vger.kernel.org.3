Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7BA4DC117
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiCQI3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiCQI32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:29:28 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FC3E019;
        Thu, 17 Mar 2022 01:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647505692; x=1679041692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AtLCZOmSAc7T9bFuE0z5XJxVO7tj6pN3X+ECBIFaw9U=;
  b=ibkRs2YUfPdUrnOPEp81tK/jGiKk7+EFmeKysTZR17M+TI3x//DUA3n9
   EeQVI3yid3VAvLkl+J+f9XXAkaYNOezTtG8HrSZ2Vhz955WHoRoL+Eiw1
   NvSOAi5AEpYT6X89Wui47oZKPUKROUj6CCGBGGT2y27m36s88MfLoSo98
   xoABiGgFg2MWlG/ILLU1Wp4nzdR8NoJuuo1hp/AvgvAq5Wqec/heDaWbW
   hR810rG3+di+PQIezl/EdWGZCAaRMy8XRETyk1pGsesw/5OC0L/7XNsR/
   HXzONygGl/iqfSkxz6wqOawrbRCh3mtGLdaWEAtKUbWNizjk01uX4tK4J
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="317533323"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="317533323"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 01:28:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="645013588"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 01:28:08 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id B743320090;
        Thu, 17 Mar 2022 10:28:06 +0200 (EET)
Date:   Thu, 17 Mar 2022 10:28:06 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Kate Hsuan <hpa@redhat.com>
Cc:     Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com
Subject: Re: [PATCH v4] staging: media: ipu3: Fix AF x_start position when
 rightmost stripe is used
Message-ID: <YjLxFuRXKzg3m9HH@paasikivi.fi.intel.com>
References: <20220317075713.10633-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317075713.10633-1-hpa@redhat.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 03:57:13PM +0800, Kate Hsuan wrote:
> For the AF configuration, if the rightmost stripe is used, the AF scene
> will be at the incorrect location of the sensor.
> 
> The AF coordinate may be set to the right part of the sensor. This
> configuration would lead to x_start being greater than the
> down_scaled_stripes offset and the leftmost stripe would be disabled
> and only the rightmost stripe is used to control the AF coordinate. If
> the x_start doesn't perform any adjustments, the AF coordinate will be
> at the wrong place of the sensor since down_scaled_stripes offset
> would be the new zero of the coordinate system.
> 
> In this patch, if only the rightmost stripe is used, x_start should
> minus down_scaled_stripes offset to maintain its correctness of AF
> scene coordinate.
> 
> Changes in v2:
> 1. Remove the setting of the first stripe.
> 
> Changes in v4:
> 1. x_start is estimated based on the method for both stripes are enabled.
> 2. x_end is estimated based on the width.

Please put the changelog before '---' line. I've removed it from the commit
message this time.

-- 
Sakari Ailus
