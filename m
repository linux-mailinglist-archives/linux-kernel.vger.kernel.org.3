Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0AD52610C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379930AbiEMLdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243824AbiEMLdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:33:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DC02B824D;
        Fri, 13 May 2022 04:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652441612; x=1683977612;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3EBr+y79geP5CztvBOF3MttVzuiXbWczHFziVH9D/uU=;
  b=LD/Yq+BG1WPshxerKhLcS0pNRfOuX0Agtt4uUs3fU00u6SyX/GLG3JQ7
   qO1KGAQiEMXMBylWZjblZvlxbTdZXCgFbHPkBANYQaiF/e5zXnxrjVnxi
   YcKL0Cwn3SyyxF0z3pAj9OMzcnDSe11UnJcsTHAfEouBOZjBqEhc9s8Nk
   eXI3VrZ7wEMNuEbzifhyHSWeU+syWq3/KKVmMHxmQHWpxm289GiCDFcs9
   0TqvkPnLZv8xGhoHamRJiIkwTa+qmdu7ESrx8HA6W1Ne0ZdOzJsgBRTaV
   1bD3hvlFtS6tJ8cWIEzLvVJ8JJDROj2HHZaXUVtvXGuO5qA31iDln4Ab9
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="267878197"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="267878197"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 04:33:31 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="595179512"
Received: from ychen23-mobl.ccr.corp.intel.com ([10.249.171.202])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 04:33:29 -0700
Message-ID: <b9ee331670fd40e69796dd428a844562842cdff3.camel@intel.com>
Subject: Re: [PATCH v3 2/2] hwmon: acpi_power_meter: convert to
 hwmon_device_register_with_info
From:   Zhang Rui <rui.zhang@intel.com>
To:     LABBE Corentin <clabbe@baylibre.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 13 May 2022 19:33:27 +0800
In-Reply-To: <Yn4QhhTI7t6Gi+fE@Red>
References: <20220509063010.3878134-1-clabbe@baylibre.com>
         <20220509063010.3878134-3-clabbe@baylibre.com>
         <e5f6c712-efed-2126-de2b-9a0d09150e7b@roeck-us.net> <Yn4QhhTI7t6Gi+fE@Red>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-13 at 10:02 +0200, LABBE Corentin wrote:
> Le Wed, May 11, 2022 at 07:10:29PM -0700, Guenter Roeck a écrit :
> > Corentin,
> > 
> > On 5/8/22 23:30, Corentin Labbe wrote:
> > > Booting lead to a hwmon_device_register() is deprecated. Please
> > > convert the driver to use hwmon_device_register_with_info().
> > > So let's convert the driver to use
> > > hwmon_device_register_with_info().
> > > 
> > > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > > ---
> > 
> > [ ... ]
> > 
> > > @@ -836,20 +740,20 @@ static void acpi_power_meter_notify(struct
> > > acpi_device *device, u32 event)
> > >   		if (res)
> > >   			break;
> > >   
> > > -		remove_attrs(resource);
> > > +		remove_domain_devices(resource);
> > >   		setup_attrs(resource);
> > 
> > Zhang Rui found an interesting problem with this code:
> > It needs a call to sysfs_update_groups(hwmon_dev->groups)
> > to update sysfs attribute visibility, probably between
> > remove_domain_devices() and setup_attrs().
> > 
> > >   		break;
> > >   	case METER_NOTIFY_TRIP:
> > > -		sysfs_notify(&device->dev.kobj, NULL,
> > > POWER_AVERAGE_NAME);
> > > +		hwmon_notify_event(&device->dev, hwmon_power,
> > > hwmon_power_average, 0);
> > 
> > ... which makes realize: The notification device should be the
> > hwmon device.
> > That would be resource->hwmon_dev, not the acpi device.
> > 
> 
> Hello
> 
> I will fix this, but do you have an example how to test thoses code
> path easily ?

No, I don't have one.

-rui

