Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E17C52B0DD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 05:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiERDiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 23:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiERDiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 23:38:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A562B644F6
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 20:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652845077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rp7uqVujxqtD936CplEiX+9qE6BPd3wg3x7T97P4iFY=;
        b=iq0Q5tMYWQMqR7eBnJvPBvD4WXrD2E9pQou7mmGUe5ogGKQOHpZR3i9/ZmM44gLTj9104b
        7iPWrSBhwOudwFaCamrIZSMWh/p1G4pk4J/9yXxf++npiMx7BeAOAkBVwFycmRBte7m33+
        3mYFJYyPURwUZ73vmtLJCD8PpkYSLxA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-184-giz0KG6IMVitjjgfmugkjQ-1; Tue, 17 May 2022 23:37:16 -0400
X-MC-Unique: giz0KG6IMVitjjgfmugkjQ-1
Received: by mail-qk1-f200.google.com with SMTP id 63-20020a370c42000000b006a063777620so617577qkm.21
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 20:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Rp7uqVujxqtD936CplEiX+9qE6BPd3wg3x7T97P4iFY=;
        b=g4skZCO1WILQ6ygUKHeT8TqyGVI/5pO7MTLe97s+MymQ1kX+Hb/voNchBMKa4+HGBe
         OW7L1tQlbuoiPliJeCBOxN0HUCN2ycU0Npii2y0gGlry/QDwqviyqbJd0EbhtI8ZxAUU
         saWwoQlR9vwnypKCtFPNVcIoqGjD6neXCRh0BcW9Ty1YMEg7QDvWKQMEdII+xlitTw9Z
         cAbx430f2Xhr/beK2dAIZe3kPDKEHauXnXIUdO0GXQ0i9zVLMd3ZQJC98I1dyZ93X/ZO
         fTYK6YNyKKyqHh2kX8DRxI4KZPacVYWrrxKAutrjnv+MKpsOLaKNv4eAtl574kiHV8sY
         lEIg==
X-Gm-Message-State: AOAM530dvIW/FW35pdYMFnvtvqSQjEcam7rgEArJQ4W8MEG3ChEZziPU
        0WqESAdyZ7qKBbHYWXP37dYEb6cmyRi/4vRRWbPKbSo7N3+nPZctdlYqtPOIcx4CA9+HsnGB+Aq
        NFcbFKAgXrAwih+C5Q+xaRgsf
X-Received: by 2002:a05:6214:d03:b0:45a:8f81:d880 with SMTP id 3-20020a0562140d0300b0045a8f81d880mr23214302qvh.74.1652845035583;
        Tue, 17 May 2022 20:37:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/9A7C14loah6lY2fVyMP1BmiVDodKmFI5RSGHnntjwhf+yhhK9Mx/0P9xV44qcUkmXaKrvg==
X-Received: by 2002:a05:6214:d03:b0:45a:8f81:d880 with SMTP id 3-20020a0562140d0300b0045a8f81d880mr23214286qvh.74.1652845035252;
        Tue, 17 May 2022 20:37:15 -0700 (PDT)
Received: from [192.168.98.18] ([107.12.98.143])
        by smtp.gmail.com with ESMTPSA id c23-20020a379a17000000b0069fc13ce20fsm769063qke.64.2022.05.17.20.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 20:37:14 -0700 (PDT)
Message-ID: <616dbc51-e87d-dd11-da73-e9d7229ed8ce@redhat.com>
Date:   Tue, 17 May 2022 23:37:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RFC net-next] bonding: netlink error message support for options
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>
Cc:     netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
References: <5a6ba6f14b0fad6d4ba077a5230ee71cbf970934.1652819479.git.jtoppins@redhat.com>
 <20220517154419.44a1cb6a@hermes.local> <20220517165419.540f2dc8@kernel.org>
From:   Jonathan Toppins <jtoppins@redhat.com>
In-Reply-To: <20220517165419.540f2dc8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/22 19:54, Jakub Kicinski wrote:
> On Tue, 17 May 2022 15:44:19 -0700 Stephen Hemminger wrote:
>> On Tue, 17 May 2022 16:31:19 -0400
>> Jonathan Toppins <jtoppins@redhat.com> wrote:
>>
>>>      This is an RFC because the current NL_SET_ERR_MSG() macros do not support
>>>      printf like semantics so I rolled my own buffer setting in __bond_opt_set().
>>>      The issue is I could not quite figure out the life-cycle of the buffer, if
>>>      rtnl lock is held until after the text buffer is copied into the packet
>>>      then we are ok, otherwise, some other type of buffer management scheme will
>>>      be needed as this could result in corrupted error messages when modifying
>>>      multiple bonds.
>>
>> Might be better for others in long term if NL_SET_ERR_MSG() had printf like
>> semantics. Surely this isn't going to be first or last case.
>>
>> Then internally, it could print right to the netlink message.
> 
> Dunno. I think pointing at the bad attr + exposing per-attr netlink
> parsing policy + a string for a human worked pretty well so far.
> IMHO printf() is just a knee jerk reaction, especially when converting
> from netdev_err().

For some subsystems it is not a convert from netdev_err, it is an AND. 
In this RFC there are instances where changing the message from 
netdev_err() to the macro was trivial;

@@ -240,12 +243,14 @@ static int bond_changelink(struct net_device 
*bond_dev, st
ruct nlattr *tb[],
                 int arp_interval = 
nla_get_u32(data[IFLA_BOND_ARP_INTERVAL]);

                 if (arp_interval && miimon) {
-                       netdev_err(bond->dev, "ARP monitoring cannot be 
used with MII monitoring\n");
+                       NL_SET_ERR_MSG(extack,
+                                      "ARP monitoring cannot be used 
with MII monitoring");
                         return -EINVAL;
                 }

These are trivial because the path does not have to care about sysfs or 
some other legacy configuration interface. These macros become rather 
annoying to use once a system needs to support multiple configuration 
paths and is trying to utilize as much common configuration code[0] as 
possible so that all interfaces largely operate the same way.

> 
> Augmenting structured information is much, much better long term.
> 
> To me the never ending stream of efforts to improve printk() is a
> proof that once we let people printf() at will, efforts to contain
> it will be futile.
> 
At least for bonding I was trying to reuse the most amount of code which 
needs to deal with both sysfs and netlink. And I don't think it is a 
good idea to split the code paths, so if I am suppose to use statically 
allocated strings to support netlink errors that basically means 
anything that has to support multiple interfaces gets to sprinkle `if 
(extack)` everywhere[0]. Not great. The ownership model of the error 
buffer seems odd to me with the current macros, I am suppose to set a 
pointer in a structure subsystem X didn't allocate and has no control 
over its lifetime. Then netlink takes this pointer and does whatever 
with it. And somehow subsystem X is suppose to guarantee the pointer's 
lifetime exists forever, making a `const static char[]` buffer the only 
option. I don't understand why netlink doesn't provide the buffer and a 
subsystem just populates it. Using memcpy or snprintf doesn't matter, to 
me its a lifetime issue that makes the API not great to work with when 
you have to handle cases other than netlink.

Also as Joe Perches points out in this thread[1,2] the way the macros 
are written it is bloating the kernel because the error messages are 
getting duplicated for subsystems that need to support multiple 
configuration interfaces.

-Jon

[0] 
https://lore.kernel.org/netdev/e6b78ce8f5904a5411a809cf4205d745f8af98cb.1628650079.git.jtoppins@redhat.com/
[1] https://lore.kernel.org/netdev/cover.1628306392.git.jtoppins@redhat.com/
[2] 
https://lore.kernel.org/netdev/c8b69905c995ab887633ef11862705ee66c60aad.camel@perches.com/

