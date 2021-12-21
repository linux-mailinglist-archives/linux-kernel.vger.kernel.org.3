Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5577547C910
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 23:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbhLUWIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 17:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbhLUWIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 17:08:46 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E9FC061574;
        Tue, 21 Dec 2021 14:08:46 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v11so761972wrw.10;
        Tue, 21 Dec 2021 14:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q96MZHRchYCi4GEQczB2rYsWppR4uUY1vzFfkHdoZS0=;
        b=F8WToSYtnhkKRuJoqFZgz0EDWjLNKs8GVy7x8WPxOftoVI4i1nuC+syP8egCi75WBw
         IlqeiQTj4L+4gZb2zNftSF1Tifv2dXm6Mz4cKcABiba3Cu/FZXyPvWQPPhIlJovXEnhk
         v+THjCfzPZz7tS799RkSNSreJEevPlutGONofqaoTubW8xzCSiZbW/t7MVO1Mv0AoQ2E
         U9gAt7EAOTmuXlOvzO45HMJ12EehWQPcReQfgbCE4hEMsm8RfFfUpoIV5jQmA1TNTTrs
         JKiwk4EklU5Ob6xcBT8A0QDrGcrOuGKDyuf1fi53HInodqO+1AZvZDK7r+dHvmZoFPJP
         Jy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q96MZHRchYCi4GEQczB2rYsWppR4uUY1vzFfkHdoZS0=;
        b=0RA2/h+JeyBNRqj+bsl+aMEyx9uRDDHh24W4nANyCtgCco75C72sEBpOPJ0sIWApG7
         0DaO+o8HXIUFBazndZqlGOAWta7NkpD4svZFf4ovSoACFxut7yXjpM4Ezk/m7uPi2rFD
         veLRWKwhoVS7JLjwjAOSrKs6SrVR0c4Z19Zn+2m1bA1Me721LRTh5Z2W/UUaUuPx7fS3
         m9oFhkc8NCR29Rscx73mlIxqnzvu/zjeaOOOWj57OiLFcq+kvN2fX2AAJvYfWuTMr7qp
         lTn1a1xhzsUbEwZjJqvDiDuf7INVXPUYN6+r3e2/lqBcCJURroeRp5fln95japWBlZ4R
         g5HQ==
X-Gm-Message-State: AOAM533YrXT6qiWKEPXs3wp4qHWF+EKWyPgTSKX2PGgobfLkxzeQ/luf
        GGms6+xfTC4PNhUFkYEsyJkwttdZw/M=
X-Google-Smtp-Source: ABdhPJyCkkzcflx6faLOL4lQY7BAX9t0RpuoOO9ENfCbTtRAJPciqleyUwTPZ+0Z6SBOtqhSepoBXg==
X-Received: by 2002:adf:f245:: with SMTP id b5mr138626wrp.506.1640124524627;
        Tue, 21 Dec 2021 14:08:44 -0800 (PST)
Received: from [192.168.0.16] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id h14sm201963wrz.31.2021.12.21.14.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 14:08:44 -0800 (PST)
Subject: Re: [PATCH] software node: fix wrong node passed to find nargs_prop
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211220210533.3578678-1-clement.leger@bootlin.com>
 <CAHp75Vf+F2L4EFmokRYD+-M9hSuz+SbiiWnqHvFZttRyfKS-mg@mail.gmail.com>
 <d9f5b201-2a00-799d-3a0f-7c9709d77102@gmail.com>
 <20211221104659.2f8af03a@fixe.home>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <36e29eb4-c3ab-af60-5106-04b289a87128@gmail.com>
Date:   Tue, 21 Dec 2021 22:08:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211221104659.2f8af03a@fixe.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 21/12/2021 09:46, Clément Léger wrote:
> Le Mon, 20 Dec 2021 23:37:07 +0000,
> Daniel Scally <djrscally@gmail.com> a écrit :
> 
>> Thanks Andy
>>
>> On 20/12/2021 22:13, Andy Shevchenko wrote:
>>  [...]  
>>
>> I think this is right (it's not used in the ACPI version, and the OF
>> version is quite convoluted so a bit hard to follow)...but also I note
>> that none of the users of fwnode_property_get_reference_args() pass
>> anything to nargs_prop anyway...do we even need this?
> 
> Indeed, this is currently not used anywhere, nargs is always used
> instead of nargs_prop. The usage is meant to be (almost) the same as
> of_parse_phandle_with_args().
> 
> ie:
> 
>  ret = of_parse_phandle_with_args(node, "resets", "#reset-cells",
> 				  index, &args);
> 
> can be replaced by:
> 
>  ret = fwnode_property_get_reference_args(node, "resets",
> 					  "#reset-cells", 0 index,
> 					  &args);
> 
> I have some patches that uses that with software nodes and that will
> need this support.

Ok, in that case I think this is the right thing to do and you can have my:

Reviewed-by: Daniel Scally <djrscally@gmail.com>

Might be nice to transfer the function comment from
of_parse_phandle_with_args() to fwnode_property_get_reference_args(), as
that's nice and clear.

>>
>> Use the correct reference node in call to
>>>     property_entry_read_int_array() to retrieve the correct nargs value.
>>>
>>>     Fixes: b06184acf751 ("software node: Add
>>>     software_node_get_reference_args()")  
>>
>> I think this might have been introduced later...maybe 996b0830f95d1,
>> maybe e933bedd45099
> 
> From what I saw, it was already in the original commit adding this but
> I can be wrong.

You're right of course - sorry for the noise

>>
>>>     Signed-off-by: Clément Léger <clement.leger@bootlin.com
>>>     <mailto:clement.leger@bootlin.com>>
>>>     ---
>>>      drivers/base/swnode.c | 2 +-
>>>      1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>>     diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
>>>     index 4debcea4fb12..0a482212c7e8 100644
>>>     --- a/drivers/base/swnode.c
>>>     +++ b/drivers/base/swnode.c
>>>     @@ -529,7 +529,7 @@ software_node_get_reference_args(const struct
>>>     fwnode_handle *fwnode,
>>>                     return -ENOENT;
>>>
>>>             if (nargs_prop) {
>>>     -               error =
>>>     property_entry_read_int_array(swnode->node->properties,
>>>     +               error =
>>>     property_entry_read_int_array(ref->node->properties,
>>>                                                           nargs_prop,
>>>     sizeof(u32),
>>>                                                          
>>>     &nargs_prop_val, 1);
>>>                     if (error)
>>>     -- 
>>>     2.34.1
>>>
>>>
>>>
>>> -- 
>>> With Best Regards,
>>> Andy Shevchenko
>>>
>>>   
> 
> 
> 
