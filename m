Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19B75AF675
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiIFU7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiIFU7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:59:00 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3593A9DFA8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 13:58:59 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z8so16791378edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 13:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=fvIxx3pM6YU9tPyvjG8xWa+yBFQMNMJj9U2JUl1m34E=;
        b=IFcBdaK9ucbYQwaabtTyLWTzy/IbhrFKyHLoH+X2paMopYo0zL3MYqZCT/p/46tXyq
         KBAej2iKW1Vjvv6gnBmtupz65rmKGYon29bAsTHXpxjlNijXwCQr6H8rhGur2PMKCvS0
         YFIdCYpwzkaSlwrCNbD+lnOVoQzY2qbyBOjEnlvs758PkqB7DquNU8i1RwAqESTdpaRb
         la87FFJdtBKEpnV3v1c0mD/EPlcp0/pRrZeGBj9Y3MOn6cYLgZAlwwx3wtea7pKRreF4
         fxjgOybpQHS7OJ/OiEoefJT+qGJxUUIBUq1xdb89f9e8gxbDN7bnRnjwjc6xkckk0stO
         JxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=fvIxx3pM6YU9tPyvjG8xWa+yBFQMNMJj9U2JUl1m34E=;
        b=Bz2DjEmDoWpZnFYZ+fJKFqAEzdVQQ71ZrL8xXX8rhwhYVXz9wtvrbmQn2lTSnyWF7J
         VetQfX3ckBdHpGjeIQDetet9XOcMlmz3J5o88nzjloBbvAqHL/NEHvXB1sBbDAZ28t8k
         tUoI7ygvrt2jbBVPEvcaCcDMUzIQBnCxW1ezmfIgJQxFjuylPxMf5a/YIQIqwkP9eMFh
         xcy2/XV2GtkGPrqEBpzMS9jA3uYRq8pXBg0RHCP1786EdoSWkAqLvUC0cScSxeYZOsgR
         1+IIMuPDecCSeDiww5rbNCrRU1oMw6oI3GuTHeLwUncKii8sbRZHWceBH6g3SuOGteLK
         E30g==
X-Gm-Message-State: ACgBeo0/q/tUksqcHdEGHS4y9u9dkoRAEePvq8VwlDEEdwTGimbcOoLD
        KMd+3TTcTkkwulm7qED2dpA=
X-Google-Smtp-Source: AA6agR4LjpM/+Aw8Nw0PU0jYdC16U6+0GpvtseQ4m+BOclJP4ntlBXfEn6bqizda5g0PfMLB4X1aCA==
X-Received: by 2002:aa7:c44b:0:b0:44e:e6aa:1558 with SMTP id n11-20020aa7c44b000000b0044ee6aa1558mr396181edr.263.1662497937626;
        Tue, 06 Sep 2022 13:58:57 -0700 (PDT)
Received: from [192.168.0.10] (ip5f5bd57f.dynamic.kabel-deutschland.de. [95.91.213.127])
        by smtp.gmail.com with ESMTPSA id kw19-20020a170907771300b0073c5192cba6sm7124644ejc.114.2022.09.06.13.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 13:58:56 -0700 (PDT)
Message-ID: <0d2875d6-280f-c901-a7b4-92ea6a84e966@gmail.com>
Date:   Tue, 6 Sep 2022 22:58:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2] amba: Fix use-after-free in amba_read_periphid()
To:     Isaac Manjarres <isaacmanjarres@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@google.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        patches@armlinux.org.uk, Guenter Roeck <linux@roeck-us.net>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
References: <20220818172852.3548-1-isaacmanjarres@google.com>
 <094b6125-6b3e-1b8e-024f-a924e4775305@gmail.com>
 <CABfwK12ChYDmhvR2EO1q2NUS4Zhd1WO8UWWoSVNY331wwbKS0w@mail.gmail.com>
Content-Language: en-US
From:   Gabriel Francisco <frc.gabriel@gmail.com>
In-Reply-To: <CABfwK12ChYDmhvR2EO1q2NUS4Zhd1WO8UWWoSVNY331wwbKS0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2022 19:54, Isaac Manjarres wrote:
> On Sun, Sep 4, 2022 at 4:15 AM Gabriel Francisco <frc.gabriel@gmail.com> wrote:
>> This patch alone on top of v6.0-rc2 still gives me the null pointer.
>>
>> But combining it with Zhen Lei's patch (from
>> https://lkml.org/lkml/2022/8/27/164) my device boots successfully.
> Hi Gabriel,
>
> Thanks for your e-mail. I think my AMBA bus patch and
> https://lore.kernel.org/all/20220817184026.3468620-1-isaacmanjarres@google.com/
> (merged in 6.0-rc4), instead of Zhen Lei's patch, should fix the
> problem entirely.
>
> Thanks,
> Isaac

I'm afraid the issue is still showing up (looks similar when I tested 
with 6.0-rc2 + your patch and it went away when combining with Zhen 
Lei's one).

I added the dmesg log at 
https://bugzilla.kernel.org/attachment.cgi?id=301756

Thank you,

Gabriel Francisco


