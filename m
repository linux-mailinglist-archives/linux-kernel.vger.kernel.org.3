Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12491512DF0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343563AbiD1IQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343921AbiD1IPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:15:44 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33444985BA;
        Thu, 28 Apr 2022 01:12:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 5CC3E1F45063
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651133549;
        bh=8bMyqaACFiy7OVrp3cMwiVvolfDCzZMcBSLFx20Uw90=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=EaSvayxCmdmZsLuclunB5vMl9alBjuoeXNSwKOFrE9jRXk0kC4L3YY53WNkwAwqee
         RcDDMp91NWvx9VvP9S3R09OhjLH2e6xombOgZaGeO6YI3bB2tIt4eVRkrLdo8pIfi8
         Pjub2DCvS6qoNStEOneXVx11apS5IYn1Ku9vxy5s894V1EhQsuQrx24T3lMx/4l86r
         VIWRzVlC7H0VjKNm6lEfDenXal3dVqss8pI2+pCZCc8lsmClMxdIUzaEk4t1+WXLFn
         RXtExmeIGQ12+ZjVBkbiDTrpugOw9oDdo9fhYKnLfaGC9PvnUwHolRsgTa4+vIuCHU
         /CPXRcDbwddYg==
Message-ID: <28534819-647e-1fef-2754-63aba75f821e@collabora.com>
Date:   Thu, 28 Apr 2022 13:12:19 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     usama.anjum@collabora.com,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, dtor@chromium.org,
        Len Brown <lenb@kernel.org>, gwendal@chromium.org,
        vbendeb@chromium.org, andy@infradead.org,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH v8] platform: x86: Add ChromeOS ACPI device driver
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Benson Leung <bleung@chromium.org>
References: <Ylmmf03fewXEjRr0@debian-BULLSEYE-live-builder-AMD64>
 <e4c150a8-6e68-d06b-c695-a428ccba14c8@collabora.com>
 <ded85a65-2631-cf7d-88f7-532a26eec5ed@collabora.com>
 <a855bf87-aa73-0977-ed31-6855aa1ce426@redhat.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <a855bf87-aa73-0977-ed31-6855aa1ce426@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/27/22 7:22 PM, Hans de Goede wrote:
> On 4/22/22 16:47, Muhammad Usama Anjum wrote:
>> Hi Hans,
>>
>> Can I add you as a maintainer of drivers/platform/x86/chromeos_acpi.c?
>> You already maintain some other drivers in this directory.
> If you want to rely on me as default/fallback maintainer
> for the new chromeos_acpi driver, then simply don't add
> a MAINTAINERS entry for this driver.
> 
> I'm the default maintainer for everything under
> drivers/platform/x86/ .
> 
> With that said:
> 
> 
>> On 4/18/22 10:57 PM, Muhammad Usama Anjum wrote:
>>> Hi Benson,
>>>
>>> We are very near to getting this patch in. I can see that you are
>>> maintaining Chrome Platform support. This driver is in
>>> drivers/platform/x86/chromeos_acpi.c. Can you maintain this driver as
>>> well? I'll add you to the maintainers.
> now that you mention it, moving this to drivers/platform/chrome/
> actually seems like the most sensible thing to do given that
> this is chrome specific platform code. So please move it
> there for the next version.
> 
This driver was added in platform/x86 as it is only x86 specific.
Definitely it makes more sense to move it to platform/chrome. I'll move it.

> Talking about the next version, please address all review
> remarks from Barnabás for the next version.
> 
After Greg's comment to define attributes at compile time, the driver
will change completely and way simpler.

> Regards,
> 
> Hans
> 
> 
> 

-- 
Muhammad Usama Anjum
