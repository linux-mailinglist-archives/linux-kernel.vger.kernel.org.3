Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13AC470C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 21:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243262AbhLJVCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238910AbhLJVCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:02:08 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EACC061746;
        Fri, 10 Dec 2021 12:58:32 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id o4so14874911oia.10;
        Fri, 10 Dec 2021 12:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jhY+dourX5ruR9IyecXR72j1TU2NMOd+79sNBJUZl78=;
        b=QmDJFUD5gpJVROtjphiTGTHzLhQvOPP+RjquTBBO0O90mmEq+hnfmwcuBrCTPPMxbz
         RnBSZ5kxrIugWoEc7v1PPUHb3d3HFWbnv3scMN0IOONniG0CI1tJ7iIN4jQnUiRYJ/da
         cJYTQ9gbV9kNYvwn2WAHvDC0WWtAdtzfbxQCyD7d+QGXEDrWV3zkNxJnM+L2yyHlYbj/
         k8A1G1DmH13aAcxRTPz3BBzCQEkkFhH1hxWh6CTWGOvpiZ48RGX09qiZeCGqOm6yWMXG
         f41mFgdxaMYXHF5G4FpnkdSAWxsgCfe/3lyaTlpE2S2hqcrAJTxZiWX2MH3+f358vT//
         gPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jhY+dourX5ruR9IyecXR72j1TU2NMOd+79sNBJUZl78=;
        b=MfD4zRAacp5p26/nfwvuXe7XQsAgxgXn2ZUM9Hqe35WOqodJc2i9B05y/IAXAjvauP
         RWOyln+OzabcxVReFSqC4gvWJQt8GL32svCRo/DkGbg9XEwBamq03OOK0aLqrWg9qUXx
         XkRsyLjgPyIL0lb2GDwkzFwlSdKKhL7A3QkyErWiC0gOPRKttPalMhsq8nDru5aQCpmW
         RpLxA/vYCIciFdmptE5qwELrHvaNhFS1EHTZSJAkN1CcWbs/Wz9nlqhy2CbK/KvvUoEU
         /7twahZMAHwrI45hqp4WBZsCFIzKhS/ytG83DJmgiSJGjQvP7KVuzGVh6ix+bYX8c+TG
         N2Tg==
X-Gm-Message-State: AOAM530lwQOAiLspJDSrm/NSD8OuOWtGgvky3SdH7XECz0C/IPOq2pQg
        Suw+JWbu8SmGFMgKvHYVsX9dvMo+xl0=
X-Google-Smtp-Source: ABdhPJwS24r3ZrF1dV13Za2VT2sBfyu2qj5BbnBJI0rtm7x2ZYb3QPIAU6vSAc6V1EXr1txgs27FmQ==
X-Received: by 2002:a05:6808:3d2:: with SMTP id o18mr14689493oie.14.1639169911905;
        Fri, 10 Dec 2021 12:58:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o2sm1037365oik.11.2021.12.10.12.58.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 12:58:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] hwmon: (nct6775) add support for TSI temperature
 registers
To:     Zev Weiss <zev@bewilderbeest.net>, linux-hwmon@vger.kernel.org
Cc:     Renze Nicolai <renze@rnplus.nl>, Jean Delvare <jdelvare@suse.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Bernhard Seibold <mail@bernhard-seibold.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org
References: <20211110231440.17309-1-zev@bewilderbeest.net>
 <YbMM63VKYBTmZYiX@hatter.bewilderbeest.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <50008074-7dbf-2521-8e75-caf97a85b38e@roeck-us.net>
Date:   Fri, 10 Dec 2021 12:58:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbMM63VKYBTmZYiX@hatter.bewilderbeest.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 12:16 AM, Zev Weiss wrote:
> On Wed, Nov 10, 2021 at 03:14:39PM PST, Zev Weiss wrote:
>> These registers report CPU temperatures (and, depending on the system,
>> sometimes chipset temperatures) via the TSI interface on AMD systems.
>> They're distinct from most of the other Super-IO temperature readings
>> (CPUTIN, SYSTIN, etc.) in that they're not a selectable source for
>> monitoring and are in a different (higher resolution) format, but can
>> still provide useful temperature data.
>>
>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>> Tested-by: Renze Nicolai <renze@rnplus.nl>
>> ---
>>
>> This patch has been tested on NCT6779 and NCT6798[1] hardware on
>> (respectively) ASRock Rack ROMED8HM3 and X570D4U boards, and seems to
>> work as expected; the implementation for the other chips supported by
>> the driver is purely based on the datasheets and has not been tested
>> (for lack of available hardware).
>>
>> [1] Or at least, its chip ID registers identify it as an NCT6798 and
>> it seems to behave consistently with that, though it's actually
>> physically labeled as an NCT6796.
>>
>> drivers/hwmon/nct6775.c | 136 ++++++++++++++++++++++++++++++++++++++--
>> 1 file changed, 130 insertions(+), 6 deletions(-)
>>
> 
> Ping...any thoughts/feedback on this patch?
> 

I don't want to apply the patch without testing it first, and I did
not find the time to do that.

Guenter

