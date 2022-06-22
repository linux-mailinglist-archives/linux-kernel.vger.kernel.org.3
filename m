Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95123554753
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356536AbiFVI7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356021AbiFVI66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:58:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982902AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:58:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52129B81CF0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E80C34114;
        Wed, 22 Jun 2022 08:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655888335;
        bh=zEDBJcc/hdKUEzKTw+o0NSo3+GElIveIOWIAX5Umga4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RrOb+Oxnpuv9oTXXSKoSc2qCWY6eMt1SluoCJ0PZeE7QYfgEU2rEa7S4qR/bcrj/F
         DEC9M71KfVDqPI5SdJz5XYYofnAdYzTYv6hdqfoZhFDwWYDTx7pQFc0K2x25CQQTUc
         Cwj2+DuZs5SQ+MwhHnvw4heHFkRQmwLt/W/g0oNXnfrd8qrnR5sUi/ZAdlseeuc7X4
         ZhYrJeoAFUchAe21OHc0+X550LALA7nHwnfWZeZ73pqMAatUueVAs/Qc+5uG5bqkgY
         PFQtLHW/m2+E0EOap+NJAFfrWVIVtIIjQjAZ5gosTA1WJBQvtwmvFXiFRCTmCQ7+4E
         3Txko6QX5gOoA==
Message-ID: <87dd706a-6777-374f-1d41-7d791727697f@kernel.org>
Date:   Wed, 22 Jun 2022 10:58:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3] arm/mm: Fix refcount leak bugs in cache
Content-Language: en-US
To:     Liang He <windhl@126.com>, linux@armlinux.org.uk,
        rmk+kernel@armlinux.org.uk, wangkefeng.wang@huawei.com,
        ardb@kernel.org, arnd@arndb.de, akpm@linux-foundation.org,
        rppt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220619013941.4061894-1-windhl@126.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220619013941.4061894-1-windhl@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2022 03:39, Liang He wrote:
> In feroceon_of_init() and tauros2_init(), of_find_matching_node()
> will return a node pointer with refcount incremented. We should
> use of_node_put() in fail path or when it is not used anymore.
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  changelog:
> 
>  v3: (1) merge arm/mm leak bugs (2) fix bugs intro-ed by v2
>  v2: (1) use real name (2) normalize coding style
>  v1: (1) fix leak bug
> 

Before applying the patch please check it carefully. Previous evidence
[1][2] suggests that not it was not even compiled.



[1] https://lore.kernel.org/all/202206221602.odN70SHs-lkp@intel.com/

[2]
https://lore.kernel.org/all/16f9a971.44e5.1817068ee3c.Coremail.windhl@126.com/


Best regards,
Krzysztof
