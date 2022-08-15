Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5013E592EB9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241521AbiHOMLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiHOMKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:10:54 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C0C3897;
        Mon, 15 Aug 2022 05:10:53 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t22so6794560pjy.1;
        Mon, 15 Aug 2022 05:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=w0Mjm1yI3tFxRPUURdrFm5SP6GE+L3QToY/2DXzlvgk=;
        b=lGLY3FpDa9kFxeJRGunbWRcIA04Z1farW0ZsA8fkYWIVVBBg/f86rbsJfSD3ibtX0M
         U3dt1gpti5wKm97ffMpCka3KZBy+ikdjeUGkST3VTMXiF4k540cNl27zZdH/fYK0/d1B
         cuPYbQfwuhy28GZnC+9uAhPZIARXBXPKfTqVbMuSMaCet8U4wyD4mmQta79XcxQsoUXq
         hF7U4RiikpUDxqfnn1npFWQQu9ywiyis3iSuwl+XwcgH/UHnO6HoPEyjxJdI0w+w+CZC
         lyW02uvt+kaJYNdLfa6qROGaANZB5EMRQAPYncThTOMLD/GaYh3TEqYgbRf1I56lnRvt
         PLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=w0Mjm1yI3tFxRPUURdrFm5SP6GE+L3QToY/2DXzlvgk=;
        b=Qqt2BwfKQibaJ91EZO5poUjwtM2SDhUGMneQEFVMvxOvh/UdGh8tCs2TqkT6hTCp67
         Zui9BQoSBJDjqPu5yYRi9lntha6iv+Or6P/C8ZDsZcS7pObDPUvpa5qjcHZoyBEI3JoL
         dVnYuBt9v9rqwrdciOo2ImWvbCohlif/Kok46vSgPJVwi5MskGg4P0ACjUMrQxMsYh/h
         8jDKsrs4+o45YKcgJD9RNdw+U6oIj2sbX5fqlPdkiGUDmHgQ05NKPoeMTXZ9v/8IW1vD
         09MTB8823iyvCy08lCn7OPU4a4RY0WKlklVFuc92Sd7H3P4H2l0lm7qR1hVpKtPtkZnx
         QLeQ==
X-Gm-Message-State: ACgBeo1IB+o7reb9Olk6kUjZpUuA3DmvObSlelfWpP+2vO1trApsvlWp
        tW7DLA4hTzoTA4MYu6zIROiTdRLI8zoqLFHd
X-Google-Smtp-Source: AA6agR4syNM8Z3sSCzQzhZW2WNyv5yIvr0ICRxqdKmutKqGSYqWka1B4xOFbsbHO3K5TcK8hKP8oJw==
X-Received: by 2002:a17:90b:380d:b0:1f5:2c6d:7de8 with SMTP id mq13-20020a17090b380d00b001f52c6d7de8mr27495438pjb.18.1660565452735;
        Mon, 15 Aug 2022 05:10:52 -0700 (PDT)
Received: from [192.168.0.110] ([103.159.189.152])
        by smtp.gmail.com with ESMTPSA id fh3-20020a17090b034300b001ef87123615sm4421101pjb.37.2022.08.15.05.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 05:10:51 -0700 (PDT)
Message-ID: <2f0d50a1-b9d0-577f-d718-459ae0b1ba77@gmail.com>
Date:   Mon, 15 Aug 2022 18:10:43 +0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH] Soundwire: Initialize multi_link with fwnode props
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
References: <20220814080416.7531-1-khalid.masum.92@gmail.com>
 <CAHp75Ve4UaLsUknGKm14_-f5=qsq1s_Ws+j6h0kAY5_XMkSmQw@mail.gmail.com>
 <54dd86bd-416b-3048-9bd0-368afa3aaf2f@gmail.com>
 <741edbf0-5835-eb89-bb6a-69d7e0d00e36@linux.intel.com>
From:   Khalid Masum <khalid.masum.92@gmail.com>
In-Reply-To: <741edbf0-5835-eb89-bb6a-69d7e0d00e36@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/22 14:16, Pierre-Louis Bossart wrote:
> 
> 
> On 8/15/22 06:28, Khalid Masum wrote:
>> On 8/15/22 00:46, Andy Shevchenko wrote:
>>> On Sun, Aug 14, 2022 at 11:31 AM Khalid Masum
>>> <khalid.masum.92@gmail.com> wrote:
>>>>
>>>> According to the TODO, In sw_bus_master_add, bus->multi_link is to be
>>>> populated with properties from FW node props. Make this happen by
>>>> creating a new fwnode_handle flag FWNODE_FLAG_MULTI_LINKED and use
>>>> the flag to store the multi_link value from intel_link_startup. Use
>>>> this flag to initialize bus->multi_link.
>>>
>>> ...
>>>
>>>>           /*
>>>>            * Initialize multi_link flag
>>>> -        * TODO: populate this flag by reading property from FW node
>>>>            */
>>>> -       bus->multi_link = false;
>>>> +       bus->multi_link = (fwnode->flags & FWNODE_FLAG_MULTI_LINKED)
>>>> +               == FWNODE_FLAG_MULTI_LINKED;
>>>
>>> NAK (as far as I understood the context of the comment and the change
>>> itself).
>>>
>>> These flags are for devlink, we do not mix FW properties with those
>>> internal flags anyhow. The comment suggests that this should be az
>>> property. Also commit message doesn't explain the relation to devlink.
>>>
>> That is a good information to know. Thanks.
>>
>> I shall try to find out if I can somehow get multi_link's value from
>> fwnode in any other way and look into devlink in the process.
>>
>> If you have any suggestions regarding this TODO, please let me know.
> 
> The suggestion is to remove the TODO and leave the code as is: the
> capabilities enabled for multi-link are required as part of the
> programming sequences, even when a stream uses a single link we still
> use the syncArm/syncGo sequences.
> 
> Please don't change this.

Thanks for the suggestion! I shall send a patch with the TODO removed, 
leaving the code as is.

   -- Khalid Masum

