Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCF955485E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355724AbiFVJA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355665AbiFVJAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:00:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3250437A8A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:00:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4F64B81CF0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1176C34114;
        Wed, 22 Jun 2022 09:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655888449;
        bh=Bv7O7zd/PQvi0Um16HPJG65AlgbKCgnG3oQJhNJ3+5s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fNxrsMpcSmog6hGgpotbSyStUME5oUPoWwwYiYtUzYE2KxzvLGw05raVcLbnXNZeo
         OJtCoiJ3TNFpcKp2s+OuBOY8/La5cZC0GRjpIpwk8zbSVYFX3MdSIAi8JYPoKblmBY
         PGdT4Un43NW78VfjI7mfka3zlyXs4lQrv5e2/FLpngw9VS7qDzqf8XFEVblZUAbT+M
         PS6ltjw3t8VTwCwf8NV6l4Q7k5R1aYWdk0d4IAI5fNJQVBZEysEgyBdrLdxkBh4trc
         PZoIUZ8PhvzZ2NOHYq67DEz060KAJv8ui8LXlXQHWElPtYIt5dvWn5a/LXL/aQcz6r
         z0ACmDxYppF/w==
Message-ID: <53e69349-9e7b-b1a8-f607-ef85be8bb44d@kernel.org>
Date:   Wed, 22 Jun 2022 11:00:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] arm: mach-socfpga: Fix refcount leak bug in socfpga
Content-Language: en-US
To:     Liang He <windhl@126.com>, dinguyen@kernel.org,
        linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220617120618.4047441-1-windhl@126.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220617120618.4047441-1-windhl@126.com>
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

On 17/06/2022 14:06, Liang He wrote:
> In socfpga_sysmgr_init(), of_find_compatible_node() will return a
> node pointer with refcount incremented. We should use of_node_put()
> when it is not used anymore.
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
