Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036B056D0C4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 20:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiGJSlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 14:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGJSlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 14:41:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A965B140A1;
        Sun, 10 Jul 2022 11:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657478467; x=1689014467;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4Bz0GuPvGpXdDoqf5PcxzaLbbJHK9G4pTar6QHiGS+I=;
  b=fpmL+IAqI0NStmW05Z7kp66dLhPL29XrrmKNDEtNDGeM50iAEyyzXt6e
   WsNQFpTTi8sU5TppOoR2nSxOtWHUdfoFz+wo67W8xXlmdii8mu6dNpZo2
   K2ZrQTXlOGsQ5ctMgStHU+FbLuGN3QmEYNbWcokI8bzuXIAdNzRIaNlDt
   oRFhblKNUYwX69m9yw+U64iuIGzlGK8TYQSGQEUf3+qtAFYtgjKlQIOuG
   rG3hcGlWEO2BXqCP1ngG5ZSfFwcfZ/gM1mGTTIC95x1QdFLSoD47hYTqY
   Pp40ZqChk7G98oTp6MWiPwmOhTjEe+9vx6yvBPMT/hat5apHwdHWIOkdy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="370842280"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="370842280"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 11:41:07 -0700
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="697402408"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 11:41:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oAbra-001A6o-0b;
        Sun, 10 Jul 2022 21:41:02 +0300
Date:   Sun, 10 Jul 2022 21:41:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] iio: pressure: bmp280: simplify driver
 initialization logic
Message-ID: <YssdPch7dVmRWDbB@smile.fi.intel.com>
References: <20220710091708.15967-1-ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220710091708.15967-1-ang.iglesiasg@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems you somehow managed to send patches separately from email perspective.
Make sure you pass parameter --thread to `git format-patch`, so it will create
a proper chain of emails.

On Sun, Jul 10, 2022 at 11:17:06AM +0200, Angel Iglesias wrote:
> Simplified common initialization logic of different sensor types
> unifying calibration and initial configuration recovery.
> 
> Default config param values of each sensor type are stored inside
> chip_info structure and used to initialize sensor data struct instance.
> 
> The auxiliar functions for read each sensor type calibration are converted
> to a callback available on the chip_info struct.

> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>

Usually this kind of tag goes before your SoB, because it's chronologically
correct.

-- 
With Best Regards,
Andy Shevchenko


