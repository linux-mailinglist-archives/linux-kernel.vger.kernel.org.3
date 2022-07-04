Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD6D564D68
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 07:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbiGDFo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 01:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiGDFoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 01:44:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282DA1EB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 22:43:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0DB8B80D14
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E64C3411E;
        Mon,  4 Jul 2022 05:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656913395;
        bh=7DfuY5XxRaCJ/JJc77L8f/sUPg9aXEsMmG4x+Akyq3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ekLrtKc7kfUwIrnVZDU5MnNeb9hcL0VpyOERthDddi580aA0XvmNZPYDOhTRYKuV2
         nV/UECsUw5EViHBeFl+4a6TMZTjyvNlB5l4yW1vsmuxRdLsB3PqFMgt4Jiu7hBJRV8
         iqgs/9DCOUXeJbNUSqudYTeJDRQ4d3ow2w09cxv2O39urniJiOlUCZE41+hG/C2dkJ
         1NmD6IOg9+85fXgpbAUifSM6DA2ZHBuLM/4x6Vk3D5tVi1lqU6MsEETy6l3rWr41kp
         U3IYn6hbhko40PIR6PNkc7TAbunhoQ0Zabs4Jlo7I33puv1TSSopCW7xSrfikLPyz1
         MwSPmOmPrvNdg==
Date:   Mon, 4 Jul 2022 11:13:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: bus_type: fix remove and shutdown support
Message-ID: <YsJ97kNAmz7U+42m@matsya>
References: <20220610015105.25987-1-yung-chuan.liao@linux.intel.com>
 <YrQca7YH8v6XCl02@matsya>
 <a861f3b2-dec4-982d-0939-1dfc18dd2f53@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a861f3b2-dec4-982d-0939-1dfc18dd2f53@linux.intel.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-06-22, 09:54, Pierre-Louis Bossart wrote:
> 
> 
> On 6/23/22 02:55, Vinod Koul wrote:
> > On 10-06-22, 09:51, Bard Liao wrote:
> >> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> >>
> >> The bus sdw_drv_remove() and sdw_drv_shutdown() helpers are used
> >> conditionally, if the driver provides these routines.
> >>
> >> These helpers already test if the driver provides a .remove or
> >> .shutdown callback, so there's no harm in invoking the
> >> sdw_drv_remove() and sdw_drv_shutdown() unconditionally.
> > 
> > Okay sounds good
> > 
> >> In addition, the current code is imbalanced with
> >> dev_pm_domain_attach() called from sdw_drv_probe(), but
> >> dev_pm_domain_detach() called from sdw_drv_remove() only if the driver
> >> provides a .remove callback.
> > 
> > Am not sure I follow what is imbalance, pm_domain_attach/detach?
> 
> Yes, the dev_pm_domain_detach() is done conditionally, depending on the
> presence of a driver .remove callback, that's not so good.

Sorry am bit confused now, this is what I have in sdw-next

static int sdw_drv_remove(struct device *dev)
{
        struct sdw_slave *slave = dev_to_sdw_dev(dev);
        struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
        int ret = 0;

        if (drv->remove)
                ret = drv->remove(slave);

        dev_pm_domain_detach(dev, false);

        return ret;
}

I see that dev_pm_domain_detach() is called unconditionally and not
dependent on remove method which seems right to me.

The code seems same since 9251345dca24b

-- 
~Vinod
