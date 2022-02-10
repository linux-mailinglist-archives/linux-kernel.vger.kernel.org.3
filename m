Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4ED4B034D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiBJCYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 21:24:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiBJCYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 21:24:46 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88B922BCA;
        Wed,  9 Feb 2022 18:24:48 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id ki18-20020a17090ae91200b001b8be87e9abso786203pjb.1;
        Wed, 09 Feb 2022 18:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZKkwPB7d2E+cRBeGnkjKgyuuzM5ZC8AZavMGZ2zAswg=;
        b=iWAAk2fNZw0x3C8UqaDT08HyUBFC+pgvVZcTKKQpyZCsrizpLqNb45mGqj8QsZPA39
         KBOkW7pOwEu65gvJI+OjHiLKnSPln+rn6/iH18XQP/WVgN0r5l4zuWFbJ9578w6/r72U
         0SWVC6cHmFrESwb41Us/Wp/5pvcYea2M80k/P9DsSXxzp1P4gyTEfvdQtvuezVNxA4pd
         yJ3C853JCG2qce2RszqDvGVQNDNg4ojlX39T1BlLByICybK3NmwrXr2LpOMGDnR4mnpX
         KoTOUpUc9tgd5YzR2mnBG5BU4TGylmSaqBOmx3wOKLzepVER2PvTM3RrqAgdiKclwjom
         5mmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZKkwPB7d2E+cRBeGnkjKgyuuzM5ZC8AZavMGZ2zAswg=;
        b=il8rJw5EJz2TujoUMPPcAgu9xs08uKDmlxIeYDrH7RdJXukoqEvNg3hidh4xO5ATnc
         wPJ/5D8dRIiVIksjxHsyMG2UDDYry/HCY4jjZvm+ypAECBNEenb4+Yl35uKdjqOTX0r8
         sJyjmqqTix0TNORUOFHW8+hUxWG80Ox5lIGvKicUdZZDataKe4e/ha/VpTBWIdAWvCcH
         74f1ph1uqZRgac8OXmB8/7b6YEAAhxG/2jsuu4MjNKQgeFmO04AIJZuZckfOe8XP+Vza
         1CWJLDD3LrJrycKjuwDp1Vh4KU+tdP9oECYzSCaelC/zpmQMCN0tEk4r7fxTh2w8pXCt
         BVnw==
X-Gm-Message-State: AOAM530M1teUQ828tAU47S/oeY2/s1ZOwro3WB9eXHPiZ3oBPt/Y4fCI
        Xzgt6Cj1cjjEAEhKo1O+GTg8Tc4kpxOf/w==
X-Google-Smtp-Source: ABdhPJyhQavYI41EZRXm8E4eRovxLSlJHYVyFDzZM9SFcCvP0M5SWGde1YUFIAn0mNAO3vOFTDKogw==
X-Received: by 2002:a17:90b:4ad1:: with SMTP id mh17mr378365pjb.246.1644459887700;
        Wed, 09 Feb 2022 18:24:47 -0800 (PST)
Received: from [10.199.0.6] ([85.203.23.185])
        by smtp.gmail.com with ESMTPSA id s84sm15477935pgs.77.2022.02.09.18.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 18:24:47 -0800 (PST)
Subject: Re: [BUG] usb: typec: ucsi: possible deadlock in ucsi_pr_swap() and
 ucsi_handle_connector_change()
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, kyletso@google.com,
        jackp@codeaurora.org, andy.shevchenko@gmail.com,
        unixbhaskar@gmail.com, subbaram@codeaurora.org,
        mrana@codeaurora.org,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <037de7ac-e210-bdf5-ec7a-8c0c88a0be20@gmail.com>
 <YgPQB9BYJcDzbd02@kuha.fi.intel.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <43d6c3b5-17e6-63a8-21fa-3ff9f478ada7@gmail.com>
Date:   Thu, 10 Feb 2022 10:24:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <YgPQB9BYJcDzbd02@kuha.fi.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/2/9 22:30, Heikki Krogerus wrote:
> On Wed, Feb 09, 2022 at 11:50:57AM +0800, Jia-Ju Bai wrote:
>> Hello,
>>
>> My static analysis tool reports a possible deadlock in the ucsi driver in
>> Linux 5.16:
>>
>> ucsi_pr_swap()
>>    mutex_lock(&con->lock); --> Line 962 (Lock A)
>>    wait_for_completion_timeout(&con->complete, ...) --> Line 981 (Wait X)
>>
>> ucsi_handle_connector_change()
>>    mutex_lock(&con->lock); --> Line 763 (Lock A)
>>    complete(&con->complete); --> Line 782 (Wake X)
>>    complete(&con->complete); --> Line 807 (Wake X)
>>
>> When ucsi_pr_swap() is executed, "Wait X" is performed by holding "Lock A".
>> If ucsi_handle_connector_change() is executed at this time, "Wake X" cannot
>> be performed to wake up "Wait X" in ucsi_handle_connector_change(), because
>> "Lock A" has been already held by ucsi_handle_connector_change(), causing a
>> possible deadlock.
>> I find that "Wait X" is performed with a timeout, to relieve the possible
>> deadlock; but I think this timeout can cause inefficient execution.
>>
>> I am not quite sure whether this possible problem is real.
>> Any feedback would be appreciated, thanks :)
> This is probable a regression from commit ad74b8649bea ("usb: typec:
> ucsi: Preliminary support for alternate modes"). Can you test does
> this patch fix the issue (attached)?

Hi Heikki,

Thanks for the reply and patch.
After the patch is used, my tool does not report this deadlock in the 
ucsi driver.
Thus, I think this patch should be okay to fix the deadlock :)


Best wishes,
Jia-Ju Bai
