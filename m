Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1605547CB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355660AbiFVJAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355621AbiFVJAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:00:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A83137A0A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:00:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 020F8B81C4B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12275C34114;
        Wed, 22 Jun 2022 09:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655888439;
        bh=Au9YU8GI1WHaoKvBI9tPDpxPj6eJi1R1bciToCsvXS4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oL6c0bBSHcui+EerNo8iisLF+BWmMs1BYieTfNOM4qMNtajJfvi0zF8iJjK8rm7ux
         v/mmScWhBNFj/42rQsmC2Y5rTsU1IlWpxkZxYLDjedGpAGMz7tdcLuvg+kh+D7IU7r
         t9TcKXUrWsFcrLXOEM/POhbFb08dC0wQrGqZte31chBrrtpOH/Q1kTkpO5WXZCEvbU
         xC9Qc2f5I5UBKTB4oIkwQOvpeNtIZnT0As2e4MCo4AA9l4xl6HJlsi89oZA6u1lW/L
         hQ78u02WFs3uyqnAo/JBaB1k9x8WuRHhrt8FZeahpUsKxq0X3dxpjFXHNatyvdYNzG
         iQbvDS504+Jrw==
Message-ID: <7db10f84-f4dc-e5eb-a143-3b9edad70bf1@kernel.org>
Date:   Wed, 22 Jun 2022 11:00:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] arm: mach-imx: Fix refcount leak bug in src
Content-Language: en-US
To:     Liang He <windhl@126.com>, linux@armlinux.org.uk,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        p.zabel@pengutronix.de, saravanak@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220617121235.4047670-1-windhl@126.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220617121235.4047670-1-windhl@126.com>
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

On 17/06/2022 14:12, Liang He wrote:
> In imx7_src_init(), of_find_compatible_node() will return a node
> pointer with refcount incremented. We should use of_node_put() when
> it is not used anymore.
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---

Before applying the patch please check it carefully. Previous evidence
[1][2] suggests that not it was not even compiled.



[1] https://lore.kernel.org/all/202206221602.odN70SHs-lkp@intel.com/

[2]
https://lore.kernel.org/all/16f9a971.44e5.1817068ee3c.Coremail.windhl@126.com/


Best regards,
Krzysztof
