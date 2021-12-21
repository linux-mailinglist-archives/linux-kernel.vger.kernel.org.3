Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1892947C913
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 23:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbhLUWJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 17:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbhLUWJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 17:09:48 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28891C061574;
        Tue, 21 Dec 2021 14:09:48 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id s1so843290wrg.1;
        Tue, 21 Dec 2021 14:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yx3Hxv+78f40uScsbHbvBLp+egG0tLrB1eCHiLBEbO0=;
        b=FbkMGC2RYfsoU4fiIimQAocfP/B8qF3rPSoGOawXoT5iUUbCx9Dk1f/ZPcJb9iu5GK
         NFpS+tliNVxNkSTLJ5v9mU4kSJw6FWb2opbz70vYnrgAMBeVG8m3zlu1hcpfJzcUh55c
         1GlWw6JHuXSibmNhxLx1x1+ctc/8NqnhIFC2TPm+Be6wZz2sv+2j+Hkgz2tto1fZ3c1P
         2KuqN743+dOp9ImYZhT/ql/PlC1BIGR7mVS9i2pXRdZffu0PWf2E8mE8R69a7Z23zAe6
         7MXu+SUDlu1dEqNFIrLEUPhuzKFKMwcp86F2OruXVy0T+9kpaTTVk9B0Gh6LJ5OG9p9h
         VIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yx3Hxv+78f40uScsbHbvBLp+egG0tLrB1eCHiLBEbO0=;
        b=1PkARtwuGXHaFJ5U3nOJcFPA4Qu0b/J7fCRTr1od/Eq+Agbl7TEqEo60gZmyT/Qm8V
         I4pZCxLGgltZq/3hPtaKO82ilpZm3M3OUktQsLLR5lW9fr5b/jECYG9YV0ZnIMYuo3M+
         XTk8q3EGs073+IqNsRoUDmeL/lRGDX7iu3OP1IhfCODOdAg326TOk/7bty++ypdnAnjn
         DFYyBznZHirqjCU4ezbJ84KnFKyOH+U/aTCCwYUA3y+fAGmOuydmlSljUO/yyMyjw2ew
         nsEYt9JtkL68FU/8lhxTlV/dUGcUg9jAo9cC8AF1ASGa5hvXRD4RweBIfuvIy0aDC95/
         E1bA==
X-Gm-Message-State: AOAM532oTKqvP8NgLIKMLp4tZ4UDRThUjakW15D+kYh4ikVx5ST8Wcpn
        oQ0rsbw21SghPNrQ8l8tVDDl6Z1aOlI=
X-Google-Smtp-Source: ABdhPJwLQPl19nVt1DeNJ7naimrBfpO3ma7jqeXNweaRv3kOL8hvARAZ8pa7R0BTcW72+a+GL5tvAQ==
X-Received: by 2002:adf:97c2:: with SMTP id t2mr122717wrb.577.1640124586740;
        Tue, 21 Dec 2021 14:09:46 -0800 (PST)
Received: from [192.168.0.16] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id n2sm3411860wmi.36.2021.12.21.14.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 14:09:46 -0800 (PST)
Subject: Re: [PATCH] software node: fix wrong node passed to find nargs_prop
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211220210533.3578678-1-clement.leger@bootlin.com>
 <CAHp75Vf+F2L4EFmokRYD+-M9hSuz+SbiiWnqHvFZttRyfKS-mg@mail.gmail.com>
 <d9f5b201-2a00-799d-3a0f-7c9709d77102@gmail.com> <YcGfky32lSXeABEF@kroah.com>
 <YcGiIHAJS7/qXcJv@paasikivi.fi.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <800d89c5-c9e3-d969-ea9a-08ec0362a90c@gmail.com>
Date:   Tue, 21 Dec 2021 22:09:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YcGiIHAJS7/qXcJv@paasikivi.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari

On 21/12/2021 09:45, Sakari Ailus wrote:
> Hi Greg, Andy,
> 
> On Tue, Dec 21, 2021 at 10:34:11AM +0100, Greg Kroah-Hartman wrote:
>> On Mon, Dec 20, 2021 at 11:37:07PM +0000, Daniel Scally wrote:
>>> Thanks Andy
>>>
>>> On 20/12/2021 22:13, Andy Shevchenko wrote:
>>>> + Sakari, Dan
>>>>
>>>> On Monday, December 20, 2021, Clément Léger <clement.leger@bootlin.com
>>>> <mailto:clement.leger@bootlin.com>> wrote:
>>>>
>>>>     nargs_prop refers to a property located in the reference that is found
>>>>     within the nargs property.
>>>
>>> I think this is right (it's not used in the ACPI version, and the OF
>>> version is quite convoluted so a bit hard to follow)...but also I note
>>> that none of the users of fwnode_property_get_reference_args() pass
>>> anything to nargs_prop anyway...do we even need this?
>>
>> Looks like it is unused, please just remove it.
> 
> If you remove nargs_prop argument, then callers will have to use OF
> property API instead to parse references with property-defined number of
> arguments. The goal has been to cover all functionality in a
> firmware-independent way.

My mistake, I missed that of_parse_phandle_with_args() has a ton of
direct users. I guess we should try to replace those with
fwnode_property_get_reference_args() where appropriate.
