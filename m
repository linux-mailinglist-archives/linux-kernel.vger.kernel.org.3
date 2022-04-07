Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F0C4F77B2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241920AbiDGHi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbiDGHiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:38:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF7A20BE3;
        Thu,  7 Apr 2022 00:36:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 1E7591F45C08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649317011;
        bh=7Je/8cXZrAUAMV/Vs6keOEtTMh+F8tUpJAXYFyvKubI=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=NmAMtm7dmW+9OB6nmudtIjt39GO+zKfyMpOV8ZJ3K27WJ6h7IizoIAvwJiBOaHzYW
         28qiaatmP0mzUaCTLWKFHr3TiPDnpAVrNSKGht4WFSOl91UXOz9xZ6ph++17Q/Xooj
         QWKYY6cBb5Cze88Jt3MESCbhsPPK/y3yIWLQKi86sWr6iy+RXZNYYbVjh0U/XLSFoD
         hDN6gkw/IKZFda6VsAn1Hb8zL0TKUUJ0uriAA/v/A0CI1voYzS0RBItzHRN/M3e9bS
         nuvUovGLU4+rdzg8JLYvckejvRlxDZN9uLFLJjofLJt7MNTH1p7hCzkX4/G4Fo2t93
         O0eLrVajHPocA==
Message-ID: <abe69993-0180-a04c-56d5-10b80d339596@collabora.com>
Date:   Thu, 7 Apr 2022 12:36:41 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     usama.anjum@collabora.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, bleung@chromium.org, dtor@chromium.org,
        gwendal@chromium.org, vbendeb@chromium.org, andy@infradead.org,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v5] platform: x86: Add ChromeOS ACPI device driver
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <Yk6ODSxQTiGOrTj/@debian-BULLSEYE-live-builder-AMD64>
 <Yk6Pip7f3iUsIHTr@kroah.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Yk6Pip7f3iUsIHTr@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/22 12:15 PM, Greg Kroah-Hartman wrote:
> On Thu, Apr 07, 2022 at 12:09:01PM +0500, Enric Balletbo i Serra wrote:
>> --- /dev/null
>> +++ b/drivers/platform/x86/chromeos_acpi.c
>> @@ -0,0 +1,515 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * ChromeOS specific ACPI extensions
>> + *
>> + * Copyright 2011 Google, Inc.
>> + * Copyright 2020 Google LLC
> 
> You haven't touched this file in 2 years?
This file has been changed. I'll discuss and update this. I'll also
correct this patch's From and authorship. It got messed up.

-- 
Muhammad Usama Anjum
