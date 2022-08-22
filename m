Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD6259B991
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbiHVGcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbiHVGcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:32:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32690286DA;
        Sun, 21 Aug 2022 23:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661149930; x=1692685930;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QGOOUVY1UttGpoh4fn64fD2DCKVeoaHT6Wdx5UQslNc=;
  b=YnhQ1XXnzelEJyCWykCpvpmCBhi27gWKcC8On3xzOcxlueCNnI0Kwh39
   BQdjCGBWo/9ob6iQPJYMLE306JESLUL+B6j6rh9VE6wDnSSTH0VhDWCjP
   DPzXKYNlgQDWuqHllwtyo4vEUqtzYskAhZETQ0BuEkbhhfvR1ErisXROA
   BOOyXb64tdmnAfRKqHhXZKDmvD+uUQEKUE/H8Lr1RWN/MFs7RSv2kVPHH
   v3DMIuIEZQCbmoieEiq/A8GvYNY57xyFz31zqi9R6Kga4zGcdd56ZkABR
   OhfcURrdgKflpVng1+SiDUyz+RgRGDxnOLJOTMdzvE//3Wj7J+xFG2ulj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="319366786"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="319366786"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 23:32:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="712056636"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 23:32:07 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id BF63A20656;
        Mon, 22 Aug 2022 09:31:35 +0300 (EEST)
Date:   Mon, 22 Aug 2022 06:31:35 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     mchehab@kernel.org, laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, akinobu.mita@gmail.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 3/4] media: mt9m111: fix device power usage
Message-ID: <YwMix1+Bm1jEbWqv@paasikivi.fi.intel.com>
References: <20220818144712.997477-1-m.felsch@pengutronix.de>
 <20220818144712.997477-3-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818144712.997477-3-m.felsch@pengutronix.de>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Thu, Aug 18, 2022 at 04:47:11PM +0200, Marco Felsch wrote:
> Currently the driver turn off the power after probe and toggle it during
> .stream by using the .s_power callback. This is problematic since other
> callbacks like .set_fmt accessing the hardware as well which will fail.
> So in the end the default format is the only supported format.

It'd be much better to add runtime PM support to the driver instead.

-- 
Sakari Ailus
