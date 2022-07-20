Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3206257B925
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238300AbiGTPFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGTPFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:05:36 -0400
X-Greylist: delayed 251 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Jul 2022 08:05:33 PDT
Received: from vern.gendns.com (vern.gendns.com [98.142.107.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4279411C14;
        Wed, 20 Jul 2022 08:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZfQyOsBYMPAchfb9RIgin1ZPAG//moE/GIBgoK5KNGE=; b=dpua5mNPC3u7y1wfwGMhWUHoNf
        vebV7vrK4KoHi26ZBq2KA64BHl414nnXlIS8VXc3iscCpXSCB4oyGaIgmrp5oMksiOlgg8/mTz/2Y
        QI4AYJEh0wp9Ubpq2nrN18kQNA/1W6Twf/CumelIwBopXRSmw08dTfUWKX8xpMrbmwXWOo+3mJk9C
        fKPKg8i9Y2NqayvoJoS3WOc48Quj4uUN6j7x+wAARsBwm+EtG4ZIbgzcxOftjUJdC+ggTRccJCQcA
        ByH9O+/5TpxbTgxzE7Wtj3NDGCUETIcGN8kUGiSVGXT22u2uiK/Y/+viOieQymH4/u3/ygjUEJrsg
        Zjz1bmsw==;
Received: from [2600:1700:4830:1658::fb2] (port=48194)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <david@lechnology.com>)
        id 1oEBGM-0003w5-CZ;
        Wed, 20 Jul 2022 11:05:30 -0400
Message-ID: <6f72d1ec-6624-8fc3-6848-ece1035e27de@lechnology.com>
Date:   Wed, 20 Jul 2022 10:05:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] clk: davinci: remove PLL and PSC clocks for DaVinci
 DM644x and DM646x
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220720082934.17741-1-lukas.bulwahn@gmail.com>
From:   David Lechner <david@lechnology.com>
In-Reply-To: <20220720082934.17741-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/22 3:29 AM, Lukas Bulwahn wrote:
> Commit 7dd33764486d ("ARM: davinci: Delete DM644x board files") and commit
> b4aed01de486 ("ARM: davinci: Delete DM646x board files") removes the
> support for DaVinci DM644x and DM646x boards.
> 
> Hence, remove the PLL and PSC clock descriptions for those boards as well.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>


