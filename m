Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252424DC0B1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiCQIMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiCQIMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:12:07 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D21FD3;
        Thu, 17 Mar 2022 01:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647504651; x=1679040651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BXBqqHeuv6Kfo6eqhu67KJHFiGvTClaGi6ULPJtbxU0=;
  b=b6gRnfwYrflE/pm0iP1zrVnL7QEI3IVrzPur6C/fL5kr/qNbmmfcBnF8
   SHIOl3SfRhPncPvRQuHHOBnkP8Fioy7xPktFRWZUkl0ySes1Y3hKDMgcl
   VsCFln2z2XB9arUdLikaHBODRMBTYGCASuZBhZUWZGPdwadmoQQKmm0H3
   ET2is5Mlee0NwKEa5VbNwuuU3cFkdUDVzzYk21SzOS8BK9gHdhfFnsAUd
   xm3JyCag1baVo14QEcf5HajPpr52bpK3fOaWUtKZXWBQ9sbdHNCWfprN5
   HT1YBoNo41JEyxExQIz/dRLwR7FxrFD0m+jQr0tioesPwGDqERDz/CMDK
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="317530444"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="317530444"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 01:10:50 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="541277274"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 01:10:48 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 37AE720090;
        Thu, 17 Mar 2022 10:10:46 +0200 (EET)
Date:   Thu, 17 Mar 2022 10:10:46 +0200
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
Message-ID: <YjLtBv1/DiqH4/ez@paasikivi.fi.intel.com>
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
> 
> Signed-off-by: Kate Hsuan <hpa@redhat.com>

Thanks, Kate!

Applied to my tree.

-- 
Sakari Ailus
