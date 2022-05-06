Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A09E51DF3A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 20:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376397AbiEFSpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 14:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiEFSpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 14:45:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44BFC5548C
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 11:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651862525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IutWs/AAIWN2kdaL06tOXzC11yEkd5/tsS3ZCS9FxNc=;
        b=NC1etv7nkQe5I8JopzI1dHp99lG8XQWc8YtxFqkHJPMFBPHLnkLN/+dgu1CYH72V7pFWTc
        ylEvcdXMJrMMw/uXC1ILC+Zk9i1ENZS356Z1tuBhEOWmMk3Glg2pS5MBi1KObibuKxBOOf
        8b8F9HYlKBq7H2SXQMDGLP9KrFKy8VM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-Hu4SDntAPwezB5p3fn1x8g-1; Fri, 06 May 2022 14:42:04 -0400
X-MC-Unique: Hu4SDntAPwezB5p3fn1x8g-1
Received: by mail-ej1-f70.google.com with SMTP id jg5-20020a170907970500b006f42a861bb9so4786806ejc.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 11:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IutWs/AAIWN2kdaL06tOXzC11yEkd5/tsS3ZCS9FxNc=;
        b=iQEpUx+qSpMbFDcG1Dy6eD78ntp48G36NN796LB2FU8bfyUjz+JlhRP0zjQG8Ipfsq
         aUYq6SIo1LjNHzXoUPcQ3J7Mnh7JHH5MnS5VzPj81VNT8tAe8UmhrIiwgE49E7pcN5lv
         Bdz1LzM36lVD+rr2G0srMVAXDcvwBM/oFCTW8F+xZmXijdUi1ae67eGiqxrtYCA6wrU3
         GQQMxFLx0NdfSGAgrOzLQ58/pQbYFabMDlyG4r7+pUQHFhPjaaLXuKmwEkOPYVlBSI2a
         h1fgQ4P5+tmx+l9WWwDueyxvprGiGVtm1B5f6tMp4HJGR/JdqCfuj8Ofs2kDvHnEG9A7
         Sylw==
X-Gm-Message-State: AOAM5307KxuFBc38qQY+x4DnNweOs9El7qp/hQ+WdluuSEUdc8uKQrgG
        FlG7SAMyGKRdcZJvSKQTsVnlxsl1mGH2LayLqmVFqlEuyoYsomGJ8DGlaUzBdYiXyQphthNHkEQ
        VDsGYkDbk4CLwXzsUQuGRWmgX
X-Received: by 2002:a17:907:9605:b0:6f5:c66:7c13 with SMTP id gb5-20020a170907960500b006f50c667c13mr4098131ejc.66.1651862522982;
        Fri, 06 May 2022 11:42:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw++pW+zoYzTYOHGCeDdAFw8juVOYeKHg0KEBZ0ZNL6LniqL5SEZeYX9EZMh6IEZI9oT6xsJg==
X-Received: by 2002:a17:907:9605:b0:6f5:c66:7c13 with SMTP id gb5-20020a170907960500b006f50c667c13mr4098108ejc.66.1651862522821;
        Fri, 06 May 2022 11:42:02 -0700 (PDT)
Received: from [192.168.43.126] ([109.38.131.108])
        by smtp.gmail.com with ESMTPSA id ra48-20020a17090769b000b006f3ef214da0sm2227765ejc.6.2022.05.06.11.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 11:42:02 -0700 (PDT)
Message-ID: <4fda831b-c132-53cd-cd75-4f46b45219ac@redhat.com>
Date:   Fri, 6 May 2022 20:41:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 00/10] Introduce In Field Scan driver
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
References: <20220422200219.2843823-1-tony.luck@intel.com>
 <20220428153849.295779-1-tony.luck@intel.com>
 <13054c5c-ed48-b7a2-a800-25b9b1b1ab0d@redhat.com> <YnFK+gXFx0jQB1dz@zn.tnic>
 <b18234d7-a1f4-d5a4-e59b-f5439c38c2d0@redhat.com>
 <15cca88b82cd46a3a2a98b7cf336a6ed@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <15cca88b82cd46a3a2a98b7cf336a6ed@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/6/22 17:53, Luck, Tony wrote:
>> I'll give it some more time for review for v6 and then pick up v6
>> (or v7 if review leads to more changes).
> 
> Hans,
> 
> Thomas has found one substantive problem, and a few minor things (so far ... he
> still seems to be working through v6). 

Ok.

> So there will be a v7. Likely early next week. Is that OK?

That is fine.

> Do you still take patches after -rc6?

If the patches are send soon (1-2 days) after rc6 I can still take them.

Regards,

Hans

