Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC052577D98
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbiGRIgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbiGRIf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:35:59 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFA2DF36
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:35:57 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a5so15928201wrx.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=P3caFHY/AQzs5BO83S5M5JAahAivvQwwjdxW9ETjPso=;
        b=c1gqFmeiSJxeyYwyGaYT01eKgOKge3crMM+Iug/PbsGgFyaV75muyKgPaCLRG5yuHD
         lAO4Va7DQHQZCspzgdCn9A/do9wpBi0NCG9As1nSPVgBFqN3LMfJscMGd1AbY9Y2HjCo
         Tur7H4li1TfcQBSouSSqpepsM2XkKvIBqoW1Km1gWjwnWnSe+RAUGAAAMaY3j3LNVyRc
         H2r+gcNOzH1mWw/Eg508NlxtQGSEACNWHIYrTPymgvwkOa9THvOaB2qfRrdCYu6Idk4T
         f9IIOPnn4h2T36J/nZRGg3QNLuTDlMnBNxQy2rrclgJGwGsOUX2aFy1NbCk1KhieUEfj
         y4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:organization
         :in-reply-to:content-transfer-encoding;
        bh=P3caFHY/AQzs5BO83S5M5JAahAivvQwwjdxW9ETjPso=;
        b=bDnKOrBV5b1xU/PakVZcuEVRl34sDOMmsYXEPvM/+d3rt8Pd4ivDqHT1f2N6ciYczm
         FYFaO+pnOZmy8d50wqS9ULZ9GjaJ8Bz/hZ7pufDwYyfyBLHCTme3QxAWNv914H1ty1cz
         y5exkzSA7PvX0+TcuQ+iD5OK3H7gfFaBIzRrhiULJWzqIRp6eIPkC2w+p8fpn/OyN2u9
         fNnUitzqJTg36/DUidrdN65ZJuaP0JxW7zEMOWmMyjpJGeWXV17ps0Zxcchw2N+eD6uW
         v2TsT9CijgTi3qsDyhTFAm8I6zJe6CFZdcBk9eXeJsG/j1lpEBps+co9YYwJmUmbjI+u
         KW3w==
X-Gm-Message-State: AJIora/ci8TQGZWyhKwEGECexFgI9TQLbGi/jhzOjf8d3egSw5D4OJd4
        TlxuMzjE6Mygn1+RjanDJVq4Ug==
X-Google-Smtp-Source: AGRyM1tDM/s8v4j0V30r2zgq3FJ2MuBDbR1MlAWNZYhPb9yvIldp/WFIstZykhk7BX2oqcsxI8eSSA==
X-Received: by 2002:a05:6000:25a:b0:21d:727b:5017 with SMTP id m26-20020a056000025a00b0021d727b5017mr21464678wrz.184.1658133356325;
        Mon, 18 Jul 2022 01:35:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:d436:f98:472e:dac? ([2a01:e0a:b41:c160:d436:f98:472e:dac])
        by smtp.gmail.com with ESMTPSA id e5-20020adfe385000000b0021d9630d50dsm10107617wrm.42.2022.07.18.01.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 01:35:55 -0700 (PDT)
Message-ID: <d6240f70-858b-07ac-cab0-8483e16eff57@6wind.com>
Date:   Mon, 18 Jul 2022 10:35:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v3 net-next 2/3] net: ipv6: new accept_untracked_na option
 to accept na only if in-network
Content-Language: en-US
To:     Jaehee Park <jhpark1013@gmail.com>, netdev@vger.kernel.org
Cc:     davem@davemloft.net, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        dsahern@gmail.com, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
        aajith@arista.com, roopa@nvidia.com, roopa.prabhu@gmail.com,
        aroulin@nvidia.com, sbrivio@redhat.com
References: <cover.1657755188.git.jhpark1013@gmail.com>
 <56d57be31141c12e9034cfa7570f2012528ca884.1657755189.git.jhpark1013@gmail.com>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <56d57be31141c12e9034cfa7570f2012528ca884.1657755189.git.jhpark1013@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 14/07/2022 à 01:40, Jaehee Park a écrit :
> This patch adds a third knob, '2', which extends the
> accept_untracked_na option to learn a neighbor only if the src ip is
> in the same subnet as an address configured on the interface that
> received the neighbor advertisement. This is similar to the arp_accept
> configuration for ipv4.
> 
> Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
> Suggested-by: Roopa Prabhu <roopa@nvidia.com>
> ---
>  Documentation/networking/ip-sysctl.rst | 51 +++++++++++++++-----------
>  net/ipv6/addrconf.c                    |  2 +-
>  net/ipv6/ndisc.c                       | 29 ++++++++++++---
>  3 files changed, 55 insertions(+), 27 deletions(-)
> 
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index 5c017fc1e24d..722ec4f491db 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -2483,27 +2483,36 @@ drop_unsolicited_na - BOOLEAN
>  
>  	By default this is turned off.
>  
> -accept_untracked_na - BOOLEAN
> -	Add a new neighbour cache entry in STALE state for routers on receiving a
> -	neighbour advertisement (either solicited or unsolicited) with target
> -	link-layer address option specified if no neighbour entry is already
> -	present for the advertised IPv6 address. Without this knob, NAs received
> -	for untracked addresses (absent in neighbour cache) are silently ignored.
> -
> -	This is as per router-side behaviour documented in RFC9131.
> -
> -	This has lower precedence than drop_unsolicited_na.
> -
> -	This will optimize the return path for the initial off-link communication
> -	that is initiated by a directly connected host, by ensuring that
> -	the first-hop router which turns on this setting doesn't have to
> -	buffer the initial return packets to do neighbour-solicitation.
> -	The prerequisite is that the host is configured to send
> -	unsolicited neighbour advertisements on interface bringup.
> -	This setting should be used in conjunction with the ndisc_notify setting
> -	on the host to satisfy this prerequisite.
> -
> -	By default this is turned off.
> +accept_untracked_na - INTEGER
> +	Define behavior for accepting neighbor advertisements from devices that
> +	are absent in the neighbor cache:
> +
> +	- 0 - (default) Do not accept unsolicited and untracked neighbor
> +	  advertisements.
> +
> +	- 1 - Add a new neighbor cache entry in STALE state for routers on
> +	  receiving a neighbor advertisement (either solicited or unsolicited)
> +	  with target link-layer address option specified if no neighbor entry
> +	  is already present for the advertised IPv6 address. Without this knob,
> +	  NAs received for untracked addresses (absent in neighbor cache) are
> +	  silently ignored.
> +
> +	  This is as per router-side behavior documented in RFC9131.
> +
> +	  This has lower precedence than drop_unsolicited_na.
> +
> +	  This will optimize the return path for the initial off-link
> +	  communication that is initiated by a directly connected host, by
> +	  ensuring that the first-hop router which turns on this setting doesn't
> +	  have to buffer the initial return packets to do neighbor-solicitation.
> +	  The prerequisite is that the host is configured to send unsolicited
> +	  neighbor advertisements on interface bringup. This setting should be
> +	  used in conjunction with the ndisc_notify setting on the host to
> +	  satisfy this prerequisite.
> +
> +	- 2 - Extend option (1) to add a new neighbor cache entry only if the
> +	  source IP address is in the same subnet as an address configured on
> +	  the interface that received the neighbor advertisement.
>  
>  enhanced_dad - BOOLEAN
>  	Include a nonce option in the IPv6 neighbor solicitation messages used for
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 88becb037eb6..6ed807b6c647 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -7042,7 +7042,7 @@ static const struct ctl_table addrconf_sysctl[] = {
>  		.data		= &ipv6_devconf.accept_untracked_na,
>  		.maxlen		= sizeof(int),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> +		.proc_handler	= proc_dointvec,
>  		.extra1		= (void *)SYSCTL_ZERO,
>  		.extra2		= (void *)SYSCTL_ONE,
Maybe keeping proc_dointvec_minmax with SYSCTL_TWO for extra2 is better to avoid
accepting all values. It enables to add another value later.


Regards,
Nicolas
