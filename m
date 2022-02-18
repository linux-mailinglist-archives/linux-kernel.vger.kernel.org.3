Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E764BC181
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239608AbiBRVDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:03:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239600AbiBRVDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:03:10 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0F528B61C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:02:51 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id h16so9012625iol.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TIOIhGACo4yRcpICfvsrQ9RUZoszNIPIS4XTNvXi2Qw=;
        b=MZB986Q5OSMTg2q6+FUc1U94/pExFm35n39q13oWTNYdQROdXMFcoR99fsh8mRRgjF
         NPE7EENmDHROij227U77hwGmuLHZIZn+6OnB3gCcog4VeC1F3yAJrZC+lUeX3GlZGpMo
         SZPkWb9QoKj+nf3PyOEkJMnyHVAGE3Vr0NL3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TIOIhGACo4yRcpICfvsrQ9RUZoszNIPIS4XTNvXi2Qw=;
        b=Vulqxm9j/LgJAKM+c2+hFM7akda0Zmf7QrpitN8Kqq0kR2Evejy/PzeEBOmwzjKbd/
         wTvyu1QQjRwgli4pgCE0OjksqRk+6tYjdWf+Z9tXhHRbzEcT2XQfrHz44ctNTwPB3qtB
         MMmtlWoxzExZxmDEhEqFcGbPEYtBQCt05LZE78l1i3WEc3C0uaKqSx2HUiebZHwaItdj
         Iwer2KjBVekm8jgT2EUp9ROGQpIs8QLHOygESpR4sjlWZlA3ST5dGH8h7+swf2rE4Lyc
         bwr+zqIO9H4LgnSq2lks2FD9yFo6n9iyJmpAN6wuJuUsWHrovT4vXXhdUXuQnBbRv8Ue
         RrXQ==
X-Gm-Message-State: AOAM532CFRh578FthyMcmthFrbrc8Wq9C9nDW0KC0MoTzOd0oqfxDLeK
        bbh7qbOGJkXpQacwdPdwvg1gFw==
X-Google-Smtp-Source: ABdhPJyo3ZOGYVP9/XlaofaMHbR2s2snoXoa1AN7h3bGWaqLBI5qvvTPK0qLjHDTttG5v3huKWsaCw==
X-Received: by 2002:a02:a411:0:b0:314:b51c:3b74 with SMTP id c17-20020a02a411000000b00314b51c3b74mr2485006jal.69.1645218170847;
        Fri, 18 Feb 2022 13:02:50 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id l1sm4536557iln.29.2022.02.18.13.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 13:02:50 -0800 (PST)
Subject: Re: [PATCH net-next v3 5/5] selftests: forwarding: tests of locked
 port feature
To:     Hans Schultz <schultz.hans@gmail.com>, davem@davemloft.net,
        kuba@kernel.org
Cc:     netdev@vger.kernel.org,
        Hans Schultz <schultz.hans+netdev@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <nikolay@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Suryaputra <ssuryaextr@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Amit Cohen <amcohen@nvidia.com>,
        Po-Hsu Lin <po-hsu.lin@canonical.com>,
        Baowen Zheng <baowen.zheng@corigine.com>,
        linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220218155148.2329797-1-schultz.hans+netdev@gmail.com>
 <20220218155148.2329797-6-schultz.hans+netdev@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0afb9bb6-e8fd-71ce-7626-1d8bf90dd1e4@linuxfoundation.org>
Date:   Fri, 18 Feb 2022 14:02:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220218155148.2329797-6-schultz.hans+netdev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/22 8:51 AM, Hans Schultz wrote:
> These tests check that the basic locked port feature works, so that no 'host'
> can communicate (ping) through a locked port unless the MAC address of the
> 'host' interface is in the forwarding database of the bridge.
> 
> Signed-off-by: Hans Schultz <schultz.hans+netdev@gmail.com>
> ---
>   .../testing/selftests/net/forwarding/Makefile |   1 +
>   .../net/forwarding/bridge_locked_port.sh      | 174 ++++++++++++++++++
>   tools/testing/selftests/net/forwarding/lib.sh |  16 ++
>   3 files changed, 191 insertions(+)
>   create mode 100755 tools/testing/selftests/net/forwarding/bridge_locked_port.sh
> 
> diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
> index 72ee644d47bf..8fa97ae9af9e 100644
> --- a/tools/testing/selftests/net/forwarding/Makefile
> +++ b/tools/testing/selftests/net/forwarding/Makefile
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0+ OR MIT
>   
>   TEST_PROGS = bridge_igmp.sh \
> +	bridge_locked_port.sh \
>   	bridge_port_isolation.sh \
>   	bridge_sticky_fdb.sh \
>   	bridge_vlan_aware.sh \

Looks good to me. Looks like TEST_PROGS # is getting close to 60.
Cool.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
