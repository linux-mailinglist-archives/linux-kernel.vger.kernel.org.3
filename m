Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB6D517215
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 16:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385632AbiEBPBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348651AbiEBPBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:01:32 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6500E0B5;
        Mon,  2 May 2022 07:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1651503483;
  x=1683039483;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6Jk5Cj5k7nAQkN54Q8EOZFK50a7XWFdMHwlCJE+rGok=;
  b=AcpTowzkJ0GT7LMhXxhIxLhoIksXkHAIxvrpd4qqp3d/0qEZXzs8n2ZB
   CGOkN62PW+teJtU9lQDpgehS+JHoOykJxWp8IZvbYpyPC/tPfiNNWSgeH
   rI72d+uwxe5hzdF4Ujv4lfuDc+ulmkXJi7HZ1VsBI2WlAY7ztBE7i/21/
   WZc3HzJJU54wY1hiynbKQ/5GOez8+4/yeIsOq20sFR5a9mNKOkdbUhKYH
   Bo1biD2dzaqM/5MM51XhceXaPcgzyPF/0/55VrGcxeLYliYqhTHSh12oV
   LXU5tmeAifHAw9pbgF4L6kbpWsBttHP4ZLLJPRXa/mxDoXeHBuLNa62jQ
   Q==;
Date:   Mon, 2 May 2022 16:58:00 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Camel Guo <Camel.Guo@axis.com>, Jean Delvare <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        kernel <kernel@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] hwmon: (tmp401) Add of_match_table
Message-ID: <20220502145800.GA21695@axis.com>
References: <20220502091942.1083067-1-camel.guo@axis.com>
 <a2e81680-e62c-dddd-ee58-6f5aa3664d2f@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a2e81680-e62c-dddd-ee58-6f5aa3664d2f@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 03:57:50PM +0200, Guenter Roeck wrote:
> On 5/2/22 02:19, Camel Guo wrote:
> > When tmp401 is built as kernel module, it won't be automatically loaded
> > even through there is a device node in the devicetree. e.g:
> >      i2c {
> >        #address-cells = <1>;
> >        #size-cells = <0>;
> > 
> >        sensor@4c {
> >          compatible = "ti,tmp401";
> >          reg = <0x4c>;
> >        };
> >      };
> > In order to make sure it is loaded automatically, this commit adds
> > of_match_table for tmp401.
> > 
> 
> As mentioned before, historically i2c devices would instantiate based
> on the i2c match table. You are claiming that this is no longer the case.

Note that while the commit message in the first version of the patch did
wrongly claim that probe would not work without the of_match_table, this
corrected description in v2 does mention the actual problem: that the
module will not be automatically loaded without the of_match_table.  (If
the module is loaded manually or the driver is built-in to the kernel,
there is no problem.)

See commit 72fc64c68decf119466 ("hwmon: (tmp103) Add OF device ID
table") or commit 98b16a09861aa85d6 ("hwmon: (max31785) Add OF device ID
table") for similar changes to other hwmon drivers.

The potential future change mentioned in the commit messages of
72fc64c68decf119466 and 98b16a09861aa85d6 happened in commit
af503716ac1444db61d80 ("i2c: core: report OF style module alias for
devices registered via OF").  The commit message of
af503716ac1444db61d80 has a lot of details about the change being made,
and while it says that all in-tree drivers had been converted, it looks
like some of them, like tmp401, were missed.

> The above is no evidence; that would require a log output on an affected
> system showing that the sensors are not or no longer longer instantiated.

A log would simply show nothing happening so that's probably not going
to be that useful, but here is what the modaliases look like.  As you
can see, the modalias of the device in sysfs does not match any of the
alias patterns of the module without this patch:

$ cat /sys/bus/i2c/devices/4-004c/modalias
of:Ntemperature-sensorT<NULL>Cti,tmp431

modinfo without this patch:

$ modinfo ./modules/lib/modules/5.18.0-rc1/kernel/drivers/hwmon/tmp401.ko
filename:       /storage2/femfyra/linux-2.6/.roadtest/./modules/lib/modules/5.18.0-rc1/kernel/drivers/hwmon/tmp401.ko
license:        GPL
description:    Texas Instruments TMP401 temperature sensor driver
author:         Hans de Goede <hdegoede@redhat.com>
alias:          i2c:tmp435
alias:          i2c:tmp432
alias:          i2c:tmp431
alias:          i2c:tmp411
alias:          i2c:tmp401
depends:        
intree:         Y
name:           tmp401
vermagic:       5.18.0-rc1 mod_unload 

modinfo after this patch:

$ modinfo ./modules/lib/modules/5.18.0-rc1/kernel/drivers/hwmon/tmp401.ko
filename:       /storage2/femfyra/linux-2.6/./.roadtest/modules/lib/modules/5.18.0-rc1/kernel/drivers/hwmon/tmp401.ko
license:        GPL
description:    Texas Instruments TMP401 temperature sensor driver
author:         Hans de Goede <hdegoede@redhat.com>
alias:          i2c:tmp435
alias:          i2c:tmp432
alias:          i2c:tmp431
alias:          i2c:tmp411
alias:          i2c:tmp401
alias:          of:N*T*Cti,tmp435C*
alias:          of:N*T*Cti,tmp435
alias:          of:N*T*Cti,tmp432C*
alias:          of:N*T*Cti,tmp432
alias:          of:N*T*Cti,tmp431C*
alias:          of:N*T*Cti,tmp431
alias:          of:N*T*Cti,tmp411C*
alias:          of:N*T*Cti,tmp411
alias:          of:N*T*Cti,tmp401C*
alias:          of:N*T*Cti,tmp401
depends:        
intree:         Y
name:           tmp401
vermagic:       5.18.0-rc1 mod_unload 
