Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB954EB74F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 02:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241355AbiC3ADb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 20:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241358AbiC3ACu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 20:02:50 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85CB3204B;
        Tue, 29 Mar 2022 17:01:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id D7F6C1F41FAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648598464;
        bh=Z/ezlOM1oD5UBXdqomRa7z395TvvZljuHMXwhmKJtf8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MwoXtJ8EXu7GNgiEhgmmcAj9jpKltoggNGv7gA4f3wSbXkbN5A4XxZeR/mU+PRBh4
         IZ6LqCyvIVDUTT8MVuiHkNHPIu3KBYC3D4snAkPGb5NNi5p+Z1krkq3Gb7DbKcwLah
         ebelDCKIGFVBfloK3aquLs8pQr4evInsQNvBDPd76n6qHnduecIi8sB4Eq/KW9A5l1
         PROyITxnLurQ3IRTGQWl83VKdGOFClfOAMMJOwwuHKECE7CiJBN8skwiIifaI6JrpL
         GFjl8rE3cJZ8Nh4+aagqSG+rMWZw1shCCxYu/iSsSs3ZQ26z9I3moyExH/HulvYMuL
         LTLUmKDRX+Yjg==
Message-ID: <4ea801f4-7929-148d-4e69-d4126a9dfbf7@collabora.com>
Date:   Wed, 30 Mar 2022 03:01:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v5 2/4] memory: tegra: Add MC error logging on tegra186
 onward
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-3-amhetre@nvidia.com>
 <9ab1a77c-82e6-39be-9b90-b394037fb574@gmail.com>
 <a62bb479-fed4-ada0-ac61-fb67a663a998@nvidia.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <a62bb479-fed4-ada0-ac61-fb67a663a998@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/22 20:34, Ashish Mhetre wrote:
>>> +     switch (status & mc->soc->int_channel_mask) {
>>> +     case BIT(0):
>>> +             *mc_channel = 0;
>>> +             break;
>>> +
>>> +     case BIT(1):
>>> +             *mc_channel = 1;
>>> +             break;
>>> +
>>> +     case BIT(2):
>>> +             *mc_channel = 2;
>>> +             break;
>>> +
>>> +     case BIT(3):
>>> +             *mc_channel = 3;
>>> +             break;
>>> +
>>> +     case BIT(24):
>>> +             *mc_channel = MC_BROADCAST_CHANNEL;
>>> +             break;
>>> +
>>> +     default:
>>> +             pr_err("Unknown interrupt source\n");
>>
>> dev_err_ratelimited("unknown interrupt channel 0x%08x\n", status) and
>> should be moved to the common interrupt handler.
>>
> So return just error from default case and handle error in common
> interrupt handler with this print, right? I'll update this in next
> version.

Yes, just move out the common print.

Although, you could parameterize the shift per SoC and then have a
common helper that does "status >> intmask_chan_shift", couldn't you?
