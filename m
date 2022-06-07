Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E778B53ED13
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiFFRhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 13:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiFFRhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 13:37:31 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D418E18A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 10:37:30 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id a15so24423918lfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 10:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JrUCHDV/B4VsIskumMgOVA+zun0SZZfvJ9SUQK9Ped0=;
        b=hpch6RMMl19NjgUugT4b8eX/vUbvGeMyguIjW1q7ywrR/Nhc6fDnsHDWFxHhMX64Z6
         OdF4ERrF6B4Sip2D/a2woNKQeucy71ArF21CwisItz4umAXm60/4ZxyfHi0dT5fMj1vH
         YpcNVAqkKO0D9/Nf99PxbgIl+KHzfZuYdROKocmQFjZvsJlwy953ZFB+SZaDRy12nEp/
         E2rIXrQoD7AsDpdjLSANTi8R11+9R7VLnlHe2pX/4sI4BypamWK7DkKGK40Tku7WBEkH
         wmGJhQnYPcITS9wRYIbNMAwK+VCsl8lrCUcCYtCIFlC2PId8EXyc8WiUB56KToN7m58T
         Gc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JrUCHDV/B4VsIskumMgOVA+zun0SZZfvJ9SUQK9Ped0=;
        b=FqN5dQLLEGpRlequR2w42T+zjloYflJ//+KCFh16lCcL56RdTKkog8onSIRZAjeshF
         VlKQb1F3nQOHAl6Dthnr9V6v1Zm9hwYsvRyIYui99EMFUoI2Y0TtXmjzgAl1Wt0ozRb9
         /7YmFPbc6C1osMRvupajqBbQUjkJqgiYZpR6Rh3x78UCPs7SrUBUPdxrNkrpfbH1I+5H
         s+owGi3w8+Ch/92ox6LPj7SnG0MbcmaBc72027gXmry4aYdT5CxSxwGyRPQd3byFvgkv
         ftjkbTnpnKjnMQRl1JgopakblkbNXWQdufGuLqMHl2NZlTlvXPbOeYqLLIfYLFLkiotC
         pQqQ==
X-Gm-Message-State: AOAM533SOc41aJTGwbTN24l03IleclT9QHXQNJ2vKaceKLHMtdvOAl/b
        DYd4ZiwzV076CPq/0zKWuQPt/Q==
X-Google-Smtp-Source: ABdhPJw3mNZINYtsHd+u+uA7Z70hbWUIv0yqvCgISRT/07X3iFaOTJtEwziwUg9mdX//ff49pG1mVg==
X-Received: by 2002:a05:6512:3a8e:b0:479:d8f:1a0c with SMTP id q14-20020a0565123a8e00b004790d8f1a0cmr15215467lfu.227.1654537048352;
        Mon, 06 Jun 2022 10:37:28 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id d21-20020a05651c089500b0025567827117sm2538623ljq.13.2022.06.06.10.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 10:37:27 -0700 (PDT)
Message-ID: <0e714a5a-d2ed-9b44-fdbe-04b5595165da@openvz.org>
Date:   Mon, 6 Jun 2022 20:37:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH memcg v6] net: set proper memcg for net_init hooks
 allocations
Content-Language: en-US
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, cgroups@vger.kernel.org
References: <6b362c6e-9c80-4344-9430-b831f9871a3c@openvz.org>
 <f9394752-e272-9bf9-645f-a18c56d1c4ec@openvz.org> <Yp4F6n2Ie32re7Ed@qian>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <Yp4F6n2Ie32re7Ed@qian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/22 16:49, Qian Cai wrote:
> This triggers a few boot warnings like those.
> 
>  virt_to_phys used for non-linear address: ffffd8efe2d2fe00 (init_net)
>  WARNING: CPU: 87 PID: 3170 at arch/arm64/mm/physaddr.c:12 __virt_to_phys

Thank you for reporting the problem,
Could you please provide me your config file via private email?

Thank you,
	Vasily Averin
