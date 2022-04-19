Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532BA50645D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347723AbiDSG0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbiDSG0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:26:10 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7738721264;
        Mon, 18 Apr 2022 23:23:29 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id t11so30734802eju.13;
        Mon, 18 Apr 2022 23:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jwP013axk/Xi3hjjpQ/OgIUjcQAwbf0qJU2JCTW85/0=;
        b=DO236g7Y+7NwCXMlxzw8aj/O6/eS8mfdKhAnCPZmZ91T0hWQ5TbyLnh1ACVlUq0DeK
         kpITidB0I6gLuIauI9SP02BLRw1nUcf3XwTMZGt6a8dvZ/h3dIWGRd5tQk3L/qArUUcA
         XHXb1vyQT/PDYZ5jQbZMHI9X5sJmlYp57VC1s8T0f4tS2AUWffpsHWpRErdXX4vXfIJ9
         BOg4qRQCM3eRMSflljiV2Wp24Fsr6We6RXuQH3Mhd6Xvw8ePSUZbgqjDpEI2dTQnzxat
         lQ36gtfLaZCJIpLt8YlEzukbnMCPzjiupp7mlmkTHmy8Y3G6IkSae3bc8pX9/9WvA89+
         qT5w==
X-Gm-Message-State: AOAM530thmnyuk6HoXjEAlE2WLPc5FAZmLHHxhsiPe+3w7A1Yr1gKLwH
        MePw8oswpR+tC8KCBDv9D1w=
X-Google-Smtp-Source: ABdhPJxU9AMXblps61nJCRVhiTakkkkx6QrNcnqkpqnkYCWD9TwwB6qS/UxRAgYNSNA10BjRaElryw==
X-Received: by 2002:a17:907:6d91:b0:6e8:9b49:436a with SMTP id sb17-20020a1709076d9100b006e89b49436amr12244061ejc.464.1650349407850;
        Mon, 18 Apr 2022 23:23:27 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id p17-20020a17090635d100b006efcc06218dsm1133415ejb.18.2022.04.18.23.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 23:23:25 -0700 (PDT)
Message-ID: <2a54f2da-cdc0-078a-5dce-d79a736e9ebc@kernel.org>
Date:   Tue, 19 Apr 2022 08:23:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] scripts: dummy-tools, add pahole
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
References: <20220414091419.7654-1-jslaby@suse.cz>
 <CAK7LNATn2QrFn0fTixnbtZ-VOtWid2PvFKPmjfX+z_UtZgTMgA@mail.gmail.com>
 <ace87421-eefb-f4f6-307f-cd2990fb25eb@suse.cz>
 <810ab2b8-4138-1506-fc90-ae5c6ab0522e@suse.cz>
 <CAK7LNATgfosGQ6LRmu8DUxwnWL=Dyu1cOUUq1GBRtP6+BppNbw@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CAK7LNATgfosGQ6LRmu8DUxwnWL=Dyu1cOUUq1GBRtP6+BppNbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14. 04. 22, 17:18, Masahiro Yamada wrote:
>>> Well, the question is how do I that for every kernel developer in SUSE?
>>
>> IOW it'd be quite easier if the scripts/dummy-tools/pahole part of the
>> patch was in the tree. (I don't insist on the Makefile change.)
> 
> 
> I do not mind  scripts/dummy-tools/pahole

Perfect!

> although you need to do
> make CROSS_COMPILE=scripts/dummy-tools
> PAHOLE=scripts/dummy-tools/pahole  menuconfig

That's easy -- the developers use a script that I can modify. (Oppositng 
to writing files to their homes etc.)

Will send a v2.

thanks,
-- 
js
suse labs
