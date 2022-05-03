Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCC9518D2B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241917AbiECTcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiECTby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:31:54 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41102CC98;
        Tue,  3 May 2022 12:28:21 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 7so10876208pga.12;
        Tue, 03 May 2022 12:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GZ6eqNLssHc32OEt9qQ63e14RAJlNJ1pmtBeXBNIEK4=;
        b=TdnnU13ZZk6lFLy2HTB50zPLiB9k3/3MdETi+PfdtsoawEVEDJFCHe6o6o3GXOvXxH
         od1obeiprUNbZT/BDdOYago/NnC+gvg0WopgB3F7QhggpujTz2azjTk5WKCKKrSTzpDH
         9ZcIYCT8yJcQ2Z6+NMAk7zVqeHt4zSYT70h/sE2oamhFwgfp0pSrRIH5xcceZTV2DjIY
         jNXSmnpe7tEZAQioznGe9MDRrTGXhnc4q/MGmxoedVJe38DY37cqNd8iMGWcAik4v5NM
         1yFsQiOI3IbPQGc3Vf3hkVyfbpiMIXgNCr5UG4wxXWO0NyWulKRiLWCLMk5maaIGMf/S
         AEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GZ6eqNLssHc32OEt9qQ63e14RAJlNJ1pmtBeXBNIEK4=;
        b=ah4g3BLNkDhmiTQhn+mbxRXCVF98eZig8zal7Ahvhe97XWlk0vqb2i/6skUcjozmTJ
         EssbD34ko43WjeqW7rhG9I7S5qZy17A/xIiDyCGjwMEWioPMgbTrEmDDOFku3vpSkc83
         8XwRMqaNyQ8i93Xfu9qvXzFTEbBMlEJVIpxYH0rCaH6hudpFazMkoikCKNKW3YCa2qlZ
         Ut00mGICbGCM9qYovnRCVBMsuHSLhipbJDfOeUed781cV75NdbwAahosXT5oyVnHloYb
         dAiEgxP3SqlHpk0OEo/UesHOwsoWis/10MJ99cdEfA7bnNS6Jfve2CBdI5reHOQALwuP
         BYkw==
X-Gm-Message-State: AOAM530+7S4uw7qTxjvUcydsboZpy4A6mVeRkeuWkO+PkEnwXbi7mlBX
        /JEJ6Tmi2zcMYg1kiglDcVg=
X-Google-Smtp-Source: ABdhPJxYF3Ky0d86wSzJ1gkX4BDcT5U4D+I/ov3erZUUlPi9G4g7UO3jQ6rzc/pvuc/MAM5FEK5s7A==
X-Received: by 2002:a63:6fc4:0:b0:393:9567:16dc with SMTP id k187-20020a636fc4000000b00393956716dcmr14763338pgc.593.1651606101144;
        Tue, 03 May 2022 12:28:21 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u18-20020a170902e21200b0015e8d4eb23esm6263712plb.136.2022.05.03.12.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 12:28:20 -0700 (PDT)
Message-ID: <092fbb39-9a62-80ce-b3bc-62a597d8a718@gmail.com>
Date:   Tue, 3 May 2022 12:28:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/1] firmware: tee_bnxt: Use UUID API for exporting the
 UUID
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Allen Pais <apais@linux.microsoft.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220412113250.57997-1-andriy.shevchenko@linux.intel.com>
 <e9c81a3d-d03a-5b13-ee14-9ba6103093f7@gmail.com>
 <YnEBtk4ltlsep5/m@smile.fi.intel.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <YnEBtk4ltlsep5/m@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/22 03:19, Andy Shevchenko wrote:
> On Wed, Apr 13, 2022 at 08:38:41AM -0700, Florian Fainelli wrote:
>> On 4/12/2022 4:32 AM, Andy Shevchenko wrote:
>>> There is export_uuid() function which exports uuid_t to the u8 array.
>>> Use it instead of open coding variant.
>>>
>>> This allows to hide the uuid_t internals.
>>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> ---
>>> v3: rebased on the latest vanilla, added Andrew since it has no move for 1y+
>>
>> I don't think this is going to be picked up unless we designate a entry in
>> the MAINTAINERS file, I don't mind taking this via the Broadcom ARM SoCs
>> pull request if this does not move.
> 
> I saw your patch has been picked up to up-to-date MAINTAINERS record.
> Can this one now be picked up too?

Please resubmit targeting David Miller's net-next tree since this is how 
patches would be merged moving forward. Thanks!
-- 
Florian
