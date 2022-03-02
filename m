Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A524CAD22
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 19:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244448AbiCBSM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiCBSMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:12:23 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECFA83019
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 10:11:40 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id e6so2322638pgn.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 10:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jX9Ygm07gpI/LOKtGMYfTzPsOzaiXplFsoXYxsUxE0c=;
        b=jERTxde9sNvasEDJ0Kh6Ei4s4HhlqkGn9rEeZeASuYEev9lcA5QCXo1nlwZ+NY4L2C
         mxNXsnLLInA+xnc3jwi7tdAQHXUd4evZ/Ka1fPGRfshgFlTK4JGcw+7YU3tJoee1jJ9o
         QiKbZCaR8BRP1sSXwS5h9cVY/lrdhHImsHb+OcjQGTn3Vy+uLDy0HW0sXYoXbuVvAHDD
         C+W+8dWlpKaPhhJGnbUaFhrYDTySZiNPI0wCwk+8ipkgzW4CBrbh2OAUjBc+fbM2iMsb
         TzdIxpsmSjK6RJl3n3wsbhTGpj4/u6o1Uyn3Urn4FDmTJL1pIDg5J62py9MWHAITtL/c
         wu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jX9Ygm07gpI/LOKtGMYfTzPsOzaiXplFsoXYxsUxE0c=;
        b=SBka11rpJtmdnYyeUPn+UwsdYgq27YqVEw0dYODQo2LIq5eNr1eKwU40N5V7Wm69Xe
         wCUn5ffgP906xPdRtibqs8KgfeGqbLzI5mXb+BHpkFflCGZ0RNi1PIn1G1yGaEWrRnoj
         qxzC7w/466lUj+FhSCaKP8PTkwbEP/BVNH1A4ASD7oF5aURJxh+3HqtMHcPC701eweU5
         c1j10IVS+gzdZUKmH3coPBPu+qFE5ynMG7A8bNjx85yoa5Lldv3CaIJK8oitJnQFVN9D
         fIeo4IlrTVaNzleqorNA2siJzkX4YnJzN0fxLDnV+Yzizt5swtIUpGhMV+Ob8b+IBnpP
         GjMg==
X-Gm-Message-State: AOAM531aXteSwV99Vyg0wrQaMbkf8rCm5uaXEI3J7BEuwtiUCFDgNBCT
        FqvOAK1Kxp7AJgm/ZV3s9ULSESL3eHibyw==
X-Google-Smtp-Source: ABdhPJyNBnFWxzQbhiFeBIZsXYMfQInob1tX+wLmEODFINRafKCwNE9GLMsB5ynaoGduy3gqgMeS+w==
X-Received: by 2002:a05:6a00:1d8b:b0:4f1:bd8:811 with SMTP id z11-20020a056a001d8b00b004f10bd80811mr34475082pfw.25.1646244699894;
        Wed, 02 Mar 2022 10:11:39 -0800 (PST)
Received: from [192.168.1.46] (bb42-60-144-185.singnet.com.sg. [42.60.144.185])
        by smtp.gmail.com with ESMTPSA id u8-20020a056a00098800b004f36335ecf0sm22473571pfg.146.2022.03.02.10.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 10:11:39 -0800 (PST)
Message-ID: <32164620-9ba6-db62-bc61-95c7f255d087@gmail.com>
Date:   Thu, 3 Mar 2022 02:11:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH RESEND] samples/kobject: Use sysfs_emit instead of
 snprintf
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20220302120759.380932-1-phind.uet@gmail.com>
 <Yh+EdGcsoF+lBjfX@kroah.com>
From:   Phi Nguyen <phind.uet@gmail.com>
In-Reply-To: <Yh+EdGcsoF+lBjfX@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/2022 10:51 PM, Greg KH wrote:
> On Wed, Mar 02, 2022 at 08:07:59PM +0800, Nguyen Dinh Phi wrote:
>> Convert sprintf() to sysfs_emit() in order to check buffer overrun on sysfs
>> outputs.
> 
> There are no such buffer overruns on these sysfs files.
>
I don't want to duplicate the title so I use the description of 
sysfs_emit() as the patch message. I have just realized that the title 
is also incorrect, sorry for my mistake.

>>
>> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>> ---
>>   samples/kobject/kobject-example.c | 4 ++--
>>   samples/kobject/kset-example.c    | 4 ++--
>>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> Why is this a resend?  What happened to the first version?
> 
> thanks,
> 
> greg k-h

There is no response for the first version. Actually, there is no 
Maintainer is associated with these two files (in MAINTAINERS files), 
hence, my first patch was only sent to the linux-kernel mailing list.

BR,
Phi.
