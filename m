Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8823B4E892C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 20:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbiC0SF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 14:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbiC0SF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 14:05:56 -0400
Received: from gateway22.websitewelcome.com (gateway22.websitewelcome.com [192.185.47.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF91724F19
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 11:04:17 -0700 (PDT)
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 4C2F4120A9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 13:04:17 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id YXFRn4CSLb6UBYXFRnCQIS; Sun, 27 Mar 2022 13:04:17 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=y0TymoW1/EHyK8EcWmQLz2OyazkUOJVHtE/BKhoGZqU=; b=jmoaOlvmFTqS0WAkv82OTHV6OZ
        4V17ERb7dRVBIRX5YVLNuQdICPL6Jbefu6lY9QlFoV/LN0mnb2150lnz9YNTq23XoHWF9KiFL+WPe
        ANFcn8hV3nzIPrw6haZdXOdHrF51zHQy6bRSaiGm4KQ4Q/F4NFfEoOSH66y+ZygEZJ97mm3tGG6RZ
        rAchapmHNt+L9Ci3csMU6rVWv58nM2NQp6yhPQf2R3LMWfL8M3L7R8GyDUwKxbHcRGxqeXBQOokjF
        AvY7R20QsC75/fCIKgIkM6j0Nc845sn+SIJ6TMdhNRGo6lXf0mKWBKZeysT/QIm5TBCL3CMpQJjrZ
        wM2FYvfA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54516)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nYXFQ-0046TH-TF; Sun, 27 Mar 2022 18:04:16 +0000
Message-ID: <a1607f0d-9d6c-fb55-d0d2-b57e4fdfda23@roeck-us.net>
Date:   Sun, 27 Mar 2022 11:04:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/4] hwmon: (asus-ec-sensors) implement locking via the
 ACPI global lock
Content-Language: en-US
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     darcagn@protonmail.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220327121404.1702631-1-eugene.shalygin@gmail.com>
 <20220327121404.1702631-3-eugene.shalygin@gmail.com>
 <CAB95QASpZTz4eMger46WEa9xWJNmARShBUNb7edJA1eij3KBwA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAB95QASpZTz4eMger46WEa9xWJNmARShBUNb7edJA1eij3KBwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nYXFQ-0046TH-TF
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54516
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 1
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/22 09:21, Eugene Shalygin wrote:
> On Sun, 27 Mar 2022 at 14:15, Eugene Shalygin <eugene.shalygin@gmail.com> wrote:
>> +       /* number of board EC sensors */
>> +       u8 nr_sensors;
> 
> Re-added by mistake, will be fixed in the next patch version.
> 
>> +               if (ACPI_FAILURE(status)) {
>> +                       dev_err(dev,
>> +                               "Failed to get hardware access guard AML mutex"
>> +                               "'%s': error %d",
>> +                               mutex_path, status);
> 
> Can't choose between various options to fix this broken string
> literal. Would be thankful, Günter, for a suggestion.
> 

What is the problem other than that the string is split across
multiple lines ? That can easily be fixed by not splitting it,
so you'll have to be more specific.

Guenter
