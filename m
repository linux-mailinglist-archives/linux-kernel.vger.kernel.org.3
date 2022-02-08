Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8984AD92C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242524AbiBHNQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237002AbiBHMjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:39:10 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D6BC03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 04:39:09 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id a25so24232117lji.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 04:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=HHy+eZQQMBsL1hI8tFLznDb4XcFfyuw3s8T6+48nfm8=;
        b=PZ0gNesx5cRn5kgwjQIk7wsoVsH9H1A/4CLxTNQyUFpZSzlVEB//gtDX+j4DbsKegH
         26KWKRuKCw9RiObMPM/DlPjn5mRI4zhtkNGu3Mc9kRHriMCVyVqpc+SFhlNvuPgjxBBd
         uJnr43pI8P0fypehT/G1vmnbXZHrV+9H1oacBB2HztS1IxZqXOgf7XhQ/oP/g04Ku/on
         ghHg0s9sN9Z9j2NMsVSa5PxjamA6UUUlM0qfjHtvrkvhXHPbcW1lz2+R1SzBnOUem5Lz
         4oM2RaY3QqYUs3eidJTF2Ed1sMs9ICF9QSZFk7PHosWkfhn/0z5Qb3GholKUZEHtFMD3
         ovtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HHy+eZQQMBsL1hI8tFLznDb4XcFfyuw3s8T6+48nfm8=;
        b=f8roDgzQTmMg6i5uASII+oanuBDnFT2N+ginh1RkKNN/yTmSSbtazNONNcpdJAYbBq
         1UKRWbZWgEyPM5ri6+y9S23f8vjVCEPfvl/FH9QU7qPup7+SphvcYiN7K4oIHRgn2sms
         ptufxxLrhSdv/Rs6Bph5WINKU7b1TlK1AQUlyKL2DtoqdSRX0LUM9dQifMhTHvRz8b8F
         Dl8NcMtLDcbV+ztQyeAyIjaOsNxjk6s5GXdYe4osSdrCtSQL47NANkMO7Tt+Tyx6BS8e
         VY9ltkYAdiorGFwdX2M0pXaxRtqPyZG1bemFXaNXrURnzul8FEgP5m9squzCyNfyk1xV
         oU9w==
X-Gm-Message-State: AOAM530Xz3FuXcORW++cefOxxlrTI+aDIPG1G6gQ9sDB/JvTXCUah+Xa
        Sse3oFhCt7DAbia+UtZ42ELSjrnXw5kXXA==
X-Google-Smtp-Source: ABdhPJz+pkAXcU1Voc6yQ9GOqOX+yzXIwELkhK4vUxSyWCDPSidyNSqQse9jaiASwRTaoc4jBwWNjw==
X-Received: by 2002:a2e:b98a:: with SMTP id p10mr2726398ljp.195.1644323947798;
        Tue, 08 Feb 2022 04:39:07 -0800 (PST)
Received: from [192.168.1.11] ([94.103.224.201])
        by smtp.gmail.com with ESMTPSA id f15sm1906287lfg.230.2022.02.08.04.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 04:39:07 -0800 (PST)
Message-ID: <b92fb04b-e28b-4c55-8891-61e6c3fc022f@gmail.com>
Date:   Tue, 8 Feb 2022 15:39:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [syzbot] WARNING in component_del
Content-Language: en-US
To:     syzbot <syzbot+60df062e1c41940cae0f@syzkaller.appspotmail.com>,
        dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
References: <00000000000016f4ae05d5cec832@google.com>
 <0000000000001e4c2e05d77cfcbb@google.com>
 <YgJifE4GcWXS9p2H@phenom.ffwll.local>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <YgJifE4GcWXS9p2H@phenom.ffwll.local>
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

Hi Daniel,

On 2/8/22 15:30, Daniel Vetter wrote:
> On Mon, Feb 07, 2022 at 11:51:29PM -0800, syzbot wrote:
>> syzbot has found a reproducer for the following issue on:
>> 
>> HEAD commit:    555f3d7be91a Merge tag '5.17-rc3-ksmbd-server-fixes' of gi..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=130a0c2c700000

(*)

>> kernel config:  https://syzkaller.appspot.com/x/.config?x=266de9da75c71a45
>> dashboard link: https://syzkaller.appspot.com/bug?extid=60df062e1c41940cae0f
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15880d84700000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14de0c77b00000
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+60df062e1c41940cae0f@syzkaller.appspotmail.com
> 
>  From a quick grep usb seems to have indeed gained some component code, and
> I'm not aware of any drm usb drivers using component. So I think this is
> an usb issue, not a drm one.
> 

It looks like missing error handling. syzbot injected allocation failure 
inside component_add(), but usb_hub_create_port_device() just prints 
warn message in case of component_add() failure (see log (*))

And then calling component_del() on non-added item causes WARN_ON()

Can't prove my thoughts, since there is no repro :(




With regards,
Pavel Skripkin
