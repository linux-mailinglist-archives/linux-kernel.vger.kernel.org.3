Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FD250D2A3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 17:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbiDXPKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 11:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbiDXPJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 11:09:36 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6420E65D03
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 08:06:35 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id p10so22153432lfa.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 08:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ax4NjK8XwA1ohbPa662SFas+biBOwlGNHqnQ69auqV8=;
        b=jhpgXc8M4iR38j4MFOGx8d5eDvEq3d+VuBEvwo2EztQHHj2bj+D9qzwstMclvxVwRN
         uYkx3lSRd+6ubulZs90LexcOLSZShC9rmUOZgWZcT0UCjSkJ5Eq+RjzIh4KEjtbIoIjT
         qteh+kIfUou7KM1tm6cOpxe3DjDBmoucooGVIPE3xNPsc6NdnmVungrN22yq1P9DxHga
         fLiJFStM280kt7i1sEKTjgFjL8/2PNyCYHp8Ww92vJNWzcKK6+hysz5eXlJHF5awRLAT
         yxYH8kffX37VA1d2lXMaJfn1y5Cb782qoqOaGjPZDjlPST9pymngixKZiS0H1u5iFuly
         RmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ax4NjK8XwA1ohbPa662SFas+biBOwlGNHqnQ69auqV8=;
        b=Dn2BIYNln3DfNv7bNr2UO4GY0bR1g2HfSJabxHwZPRpt5nKKSKYvbiWhdh/mLukvKZ
         0zFsHmd5ubRYM6xv0FO309xPA+V+Oxba8wvHvrHwJ9zWQGoGjgPFZbplfZhE0f+xiVvO
         zM3pvz7IjqkYtfS3upbgxtI4sTkukt8nPQpQbbKkzT66xyAOVRpeAMj3LYRHflrLlTdr
         afGITXCrBwJu4WD374TwYhxdtsMPSkXSQWS1l/t6cVarO7HYuIbcXL1umDNi6uwA/+c0
         yxUYltsg0vZw0YwWdHfgHvH1zLRdiz1VrGj52pnESFOERIB29duITHhQLn04TgplPf6e
         61QQ==
X-Gm-Message-State: AOAM530Qpy+vFt77E5hkA6GGDOMu/Qov4u9TBYyFnErf9TYYXkTd0pMn
        OfJzQLDKTSF0qdYIjfLYWnQ=
X-Google-Smtp-Source: ABdhPJzIC/OMqVHYwx3wVPo6mHHn8DnIt0notOSFzK1CVHndztLcHi5iYrH7PqPv1mdEHa0jjrk78A==
X-Received: by 2002:a05:6512:6c5:b0:472:3b6:a980 with SMTP id u5-20020a05651206c500b0047203b6a980mr1476934lff.542.1650812793457;
        Sun, 24 Apr 2022 08:06:33 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.225.17])
        by smtp.gmail.com with ESMTPSA id y37-20020a0565123f2500b0044a1e1c6b37sm1043084lfa.53.2022.04.24.08.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 08:06:33 -0700 (PDT)
Message-ID: <c2296090-2e9b-fafb-35da-e01b025b53b7@gmail.com>
Date:   Sun, 24 Apr 2022 18:06:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [BUG] staging: r8188eu: KASAN: slab-out-of-bounds in
 rtw_cmd_thread
Content-Language: en-US
To:     Solomon Tan <wjsota@gmail.com>,
        Michael Straube <straube.linux@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <67e2d10b-7f0f-9c5a-ce31-376b83ffba9e@gmail.com>
 <YmU+cqEZfrGz5XsT@ArchDesktop>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <YmU+cqEZfrGz5XsT@ArchDesktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Solomon,

On 4/24/22 15:11, Solomon Tan wrote:
> On Sun, Apr 24, 2022 at 12:00:12PM +0200, Michael Straube wrote:
>> Hi,
>> 
>> It looks like
>> commit 0afaa121813e ("staging: r8188eu: use in-kernel ieee channel")
>> intoduced a. See KASAN output below.
>> 
>> That commit replaced the use of struct rtw_ieee80211_channel with struct
>> ieee80211_channel.
>> 
>> There are several calls to memcpy that used sizeof(struct
>> rtw_ieee80211_channel)
>> and now use sizeof(struct ieee80211_channel) but the sizes of these two
>> structures are not equal.
>> 
> 
> Oh no. When does this issue get triggered?
> 
>> regards,
>> Michael
>> 
>> dmesg:
>> 
>>  ==================================================================
>> [  422.214237] BUG: KASAN: slab-out-of-bounds in rtw_cmd_thread+0x1e8/0x430
>> [r8188eu]
>> [  422.214277] Write of size 3600 at addr ffff8881e149d200 by task
>> RTW_CMD_THREAD/2563
>> 
>> [  422.214289] CPU: 11 PID: 2563 Comm: RTW_CMD_THREAD Tainted: G C OE
>> 5.18.0-rc2-staging+ #47 94e3ca73bebf5b7fec506721475e4fff2a023bb9
>> [  422.214301] Hardware name: Gigabyte Technology Co., Ltd. B550M S2H/B550M
>> S2H, BIOS F15a 02/16/2022
>> [  422.214309] Call Trace:
>> [  422.214313]  <TASK>
>> [  422.214317]  dump_stack_lvl+0x45/0x5b
>> [  422.214327]  print_report.cold+0x5e/0x5dc
>> [  422.214335]  ? kasan_set_track+0x21/0x30
>> [  422.214342]  ? kasan_set_free_info+0x20/0x40
>> [  422.214349]  ? rtw_cmd_thread+0x1e8/0x430 [r8188eu
>> 91924fe1575bf49b9b37985ffde2c585d847446d]
>> [  422.214386]  kasan_report+0xab/0x120
>> [  422.214394]  ? rtw_cmd_thread+0x1e8/0x430 [r8188eu
>> 91924fe1575bf49b9b37985ffde2c585d847446d]
>> [  422.214430]  kasan_check_range+0xf6/0x1d0
>> [  422.214436]  memcpy+0x39/0x60
>> [  422.214442]  rtw_cmd_thread+0x1e8/0x430 [r8188eu
>> 91924fe1575bf49b9b37985ffde2c585d847446d]
>> [  422.214479]  ? rtw_setassocsta_cmdrsp_callback+0xd0/0xd0 [r8188eu
>> 91924fe1575bf49b9b37985ffde2c585d847446d]
>> [  422.214516]  kthread+0x15d/0x190
>> [  422.214523]  ? kthread_complete_and_exit+0x20/0x20
>> [  422.214531]  ret_from_fork+0x22/0x30
>> [  422.214540]  </TASK>
> 
> Sorry, I am not familiar with KASAN. How should I interpret this output?
> I see the paragraph above has references to rtw_cmd_thread. I assume
> that is its way of indicating that rtw_cmd_thread is the cause of the
> problem, but the one below refers to other functions. I'm not sure where
> I should start looking. I would start looking at `rtw_sitesurvey_cmd` and
> `rtw_scan_ch_decision`, which call the memcpy on the
> rtw_ieee80211_channel structure, but they are not on the call trace.
> 

drivers/staging/r8188eu/core/rtw_cmd.c:276: memcpy() call.

As Michael said the sizes of structures do not mach and the memcpy 
writes below allocated buffer.



With regards,
Pavel Skripkin
