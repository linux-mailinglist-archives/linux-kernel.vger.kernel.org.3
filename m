Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1289A4B59EA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 19:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbiBNSab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 13:30:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353761AbiBNSa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 13:30:28 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0F1652DF;
        Mon, 14 Feb 2022 10:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644863420; x=1676399420;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2SuiWkTsCmL0kmekpSa89GaVmY8ni1VlZC8DxtgnZ6g=;
  b=idin0OSHJv0cTfDKd9ETgFibS8HLd8QpeqG5tws0/HtipHvi2uuLqyO2
   6Ck86oj51C0iUSAFFiE4AQ3hPnL04vH/L7SemfvMgxQWE/EfK3qAaYgMD
   87G55pw6MO4FPETEHouZHZ02YBKKF8sQ3luABgGHXFU6+awW8a5PJRBuc
   ll3K5xm0Vj0viP9f8aBvoWr8nwrtEIsJJiWx4O7AX3/WIfsrZfZsUyU+3
   8O4BIM9bR6PXSsUBvKPsFltvyFtPnJrwItPmoXilA00aqfLt1DIaSYTmZ
   8oOw48gw0t9y10/I7DpQw5MFyDbX/OvVNeX0vD9QJz3xG8qozOncOa7iR
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="274728429"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="274728429"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 10:30:20 -0800
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="624372837"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 10:30:15 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 0993C202D5;
        Mon, 14 Feb 2022 20:30:13 +0200 (EET)
Date:   Mon, 14 Feb 2022 20:30:13 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 37/66] media: sun6i-csi: Move power management to
 runtime pm in capture
Message-ID: <YgqftcDgfrsZfTdF@paasikivi.fi.intel.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-38-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220205185429.2278860-38-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Sat, Feb 05, 2022 at 07:54:00PM +0100, Paul Kocialkowski wrote:
> Let's just enable the module when we start using it (at stream on)
> and benefit from runtime pm instead of enabling it at first open.
> 
> Also reorder the call to v4l2_pipeline_pm_get.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Nice patch!

Do you still need v4l2_pipeline_pm_put()? Removing it would be a separate
patch of course.

-- 
Kind regards,

Sakari Ailus
