Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE92F5A0745
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 04:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbiHYC3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 22:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbiHYC3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 22:29:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F511923CC
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 19:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661394545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3jF59bnxqmLklAHzEtiDUVdu2dFyXPidcFRU+bKjDi8=;
        b=HeLCcdTu0I+oaFDwO2H7n2LdRv3ty4q75kgm/lxBSoDD0UQsE+HvGWlhV2RMXyjwwh4wG+
        /GRqEC7vuImxSd+TJTVkXkqbFUs92m1D71JUfHqSpFdF0Ws93Ud+x+G0la6OiLEnsGBOuP
        Pn+YpEAJoBw9MHGqz2gjwX7WbqHXlUQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-675-ZVpSUUuUOf2vHK4fgeEllA-1; Wed, 24 Aug 2022 22:29:02 -0400
X-MC-Unique: ZVpSUUuUOf2vHK4fgeEllA-1
Received: by mail-qk1-f200.google.com with SMTP id bl16-20020a05620a1a9000b006bc3aa1908dso6508065qkb.15
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 19:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3jF59bnxqmLklAHzEtiDUVdu2dFyXPidcFRU+bKjDi8=;
        b=OaJRxgHo9M1sKX1vZRoPCgWUiOag4DBD9nmzaDO8F5jnhvisb3ReRoHI2i0w2Gp6in
         /LPE9onJdj/3+e37Q2CYGy9qkp3xz3aj3ltA8odLwRLyDs/14+pE9ElGPzmn7J+9oryQ
         qksUjC344xlacZG6okDyDQW281pQvOfcU47TcciJTyJptG9dR17PAmC5f/fc45FZXx4c
         uQsEgwx7SqMUZai24suTK6UUXSeDGdpBHcztIdkkEz5xcjp9++UQi076JcMLPKYeES01
         9jSYqkWIPqHcodSzEl72qclh/mpKTlvUndwpRFXxvOuOlUYFA+ey3yXbNqPk8Ck4moKl
         JdAw==
X-Gm-Message-State: ACgBeo3k5omyQ0iVBuC1PekGNmvCm5iggJqw1KCV3yVeqG6NmGshaMvP
        7RYDlWVOhuH8Rmm2Nv/TsuXAxLboJKXJ93I5fK16F7UMoZ4LG2+PXM+30dggc6MBhv+HggoSie/
        /cSuIw5JqFieSQA/oLFfKoXWh
X-Received: by 2002:a05:620a:15d8:b0:6ba:c5e3:871c with SMTP id o24-20020a05620a15d800b006bac5e3871cmr1623892qkm.572.1661394540655;
        Wed, 24 Aug 2022 19:29:00 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7bG3MtOEQ+X7T87Nh1NCt7nYPw5iq5/sxiSvBa1Ay1+p2Ifdl6EoR7sD1MulRuITnPNRG2bw==
X-Received: by 2002:a05:620a:15d8:b0:6ba:c5e3:871c with SMTP id o24-20020a05620a15d800b006bac5e3871cmr1623874qkm.572.1661394540422;
        Wed, 24 Aug 2022 19:29:00 -0700 (PDT)
Received: from [192.168.98.18] ([107.12.98.143])
        by smtp.gmail.com with ESMTPSA id j12-20020a05620a288c00b006b61b2cb1d2sm16492780qkp.46.2022.08.24.19.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 19:28:59 -0700 (PDT)
Message-ID: <320c2a05-e99a-88b4-2f67-11210ae37903@redhat.com>
Date:   Wed, 24 Aug 2022 22:28:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH net-next v2] bonding: Remove unnecessary check
Content-Language: en-US
To:     Sun Shouxin <sunshouxin@chinatelecom.cn>
Cc:     vfalico@gmail.com, andy@greyhouse.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        huyd12@chinatelecom.cn, Jay Vosburgh <j.vosburgh@gmail.com>
References: <20220824111712.5999-1-sunshouxin@chinatelecom.cn>
 <CAAoacNmKa5oM10J6DTLJ6PANmdS8k80Lcxygv_vXd_0DduXM4A@mail.gmail.com>
From:   Jonathan Toppins <jtoppins@redhat.com>
In-Reply-To: <CAAoacNmKa5oM10J6DTLJ6PANmdS8k80Lcxygv_vXd_0DduXM4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/22 14:07, Jay Vosburgh wrote:
> On 8/24/22, Sun Shouxin <sunshouxin@chinatelecom.cn> wrote:
>> This code is intended to support bond alb interface added to
>> Linux bridge by modifying MAC, however, it doesn't work for
>> one bond alb interface with vlan added to bridge.
>> Since commit d5410ac7b0ba("net:bonding:support balance-alb
>> interface with vlan to bridge"), new logic is adapted to handle
>> bond alb with or without vlan id, and then the code is deprecated.
> 
> I think this could still be clearer; the actual changes relate to the stack of
> interfaces (e.g., eth0 -> bond0 -> vlan123 -> bridge0), not what VLAN tags
> incoming traffic contains.
> 
> The code being removed here is specifically for the case of
> eth0 -> bond0 -> bridge0, without an intermediate VLAN interface
> in the stack (because, if memory serves, netif_is_bridge_port doesn't
> transfer through to the bond if there's a VLAN interface in between).
> 
> Also, this code is for incoming traffic, assigning the bond's MAC to
> traffic arriving on interfaces other than the active interface (which bears
> the bond's MAC in alb mode; the other interfaces have different MACs).
> Commit d5410ac7b0ba affects the balance assignments for outgoing ARP
> traffic.  I'm not sure that d5410 is an exact replacement for the code this
> patch removes.

I would be more comfortable with a change like this if it can be 
demonstrated that an example test case functions as expected before and 
after the change. Could a selftests test be written with veths to 
demonstrate this code is indeed redundant?

-Jon

> 
>>
>> Suggested-by: Hu Yadi <huyd12@chinatelecom.cn>
>> Signed-off-by: Sun Shouxin <sunshouxin@chinatelecom.cn>
>> ---
>>   drivers/net/bonding/bond_main.c | 13 -------------
>>   1 file changed, 13 deletions(-)
>>
>> diff --git a/drivers/net/bonding/bond_main.c
>> b/drivers/net/bonding/bond_main.c
>> index 50e60843020c..6b0f0ce9b9a1 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -1578,19 +1578,6 @@ static rx_handler_result_t bond_handle_frame(struct
>> sk_buff **pskb)
>>
>>   	skb->dev = bond->dev;
>>
>> -	if (BOND_MODE(bond) == BOND_MODE_ALB &&
>> -	    netif_is_bridge_port(bond->dev) &&
>> -	    skb->pkt_type == PACKET_HOST) {
>> -
>> -		if (unlikely(skb_cow_head(skb,
>> -					  skb->data - skb_mac_header(skb)))) {
>> -			kfree_skb(skb);
>> -			return RX_HANDLER_CONSUMED;
>> -		}
>> -		bond_hw_addr_copy(eth_hdr(skb)->h_dest, bond->dev->dev_addr,
>> -				  bond->dev->addr_len);
>> -	}
>> -
>>   	return ret;
>>   }
>>
>> --
>> 2.27.0
>>
>>
> 

