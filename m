Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6F14E8B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 01:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiC0X2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 19:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiC0X2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 19:28:45 -0400
Received: from gateway23.websitewelcome.com (gateway23.websitewelcome.com [192.185.49.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FB94ECEB
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 16:27:04 -0700 (PDT)
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 00F6A2AD21
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 18:27:04 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id YcFpnQJyGdx86YcFqn3bY2; Sun, 27 Mar 2022 18:25:03 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gauRBf2vhf2Cx2zI8ZsLSbYehhbV2o8Kb5BqMRkcLJA=; b=D2RWCf63CwlLxQaDf6hcYt75sl
        oeFt6KgJpogO1HRIZFwL03lVXV3O4PvF6v/rlA3Z0YhO2Oz52YYe/f7rYjCmI+vvx3S0ICC0uRNMB
        wykLIhe6wWvoILnmaxnRbxF2OrMUgtgaqraSnwi03f8u5SSOZc9wP0oNBEdjOfl5oI5OpfTY4hRdm
        vI4Sdt9AipjKO9K9vDtYxqrU6c98fW0lhEtw7fH1QQjjDN+CCZMNgiko6loG/21YrMwYyhxgdZAcC
        fDdp+MxRcmT+6cWzq0EUEHEdxLQ5yLDoH38S0outxvQifvmYgBngSdW8E9zmLtqatigdA540api4I
        NF1182PQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54520)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nYcFp-003RWH-HQ; Sun, 27 Mar 2022 23:25:01 +0000
Message-ID: <a2a3ab35-7e21-51f9-fee2-67f6686b13c8@roeck-us.net>
Date:   Sun, 27 Mar 2022 16:25:00 -0700
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
 <a1607f0d-9d6c-fb55-d0d2-b57e4fdfda23@roeck-us.net>
 <CAB95QAQTtVWMs3dOx87G+D_GzGuMjnmPGiYQLqqQiCHT939Upw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAB95QAQTtVWMs3dOx87G+D_GzGuMjnmPGiYQLqqQiCHT939Upw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nYcFp-003RWH-HQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54520
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 1
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/22 11:51, Eugene Shalygin wrote:
> On Sun, 27 Mar 2022 at 20:04, Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> What is the problem other than that the string is split across
>> multiple lines ? That can easily be fixed by not splitting it,
>> so you'll have to be more specific.
> 
> Yes, the problem is that it is split. When merged it exceeds the 80-th
> column and creates problems for editors instructed to format text on
> paste. And I would not like to neither split the string onto two debug
> messages, nor shorten the debug message itself. Maybe there is an
> elegant solution I'm not aware of?
> 

First, you can go up to 100 columns nowadays. Second, the column
limit is waived for strings because it is more important to not
split them. If you _still_ want to stick with 80 columns, sorry,
no, I don't have a solution. Your problem is with the editor,
not with kernel formatting rules.

Guenter
