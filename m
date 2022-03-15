Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C324C4D96D3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346249AbiCOI4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241081AbiCOI4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:56:30 -0400
Received: from hostingweb31-40.netsons.net (hostingweb31-40.netsons.net [89.40.174.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F508642E;
        Tue, 15 Mar 2022 01:55:18 -0700 (PDT)
Received: from [77.244.183.192] (port=63198 helo=[192.168.178.39])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1nU2xY-0006YT-GB; Tue, 15 Mar 2022 09:55:16 +0100
Message-ID: <a146f554-837a-d19a-425c-b1fd790a0497@lucaceresoli.net>
Date:   Tue, 15 Mar 2022 09:55:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] clk: vc5: Enable VC5_HAS_PFD_FREQ_DBL on 5p49v6965
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>, linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, cstevens@beaconembedded.com,
        Claude Fillion <Claude.Fillion@mksinst.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
References: <20220313115704.301718-1-aford173@gmail.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
In-Reply-To: <20220313115704.301718-1-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam, Claude,

thanks for your patch.

On 13/03/22 12:57, Adam Ford wrote:
> The 5p49v6965 has a reference clock frequency doubler.
> Enabling it adds versaclock_som.dbl to the clock tree,
> but the output frequency remains correct.
>
> Suggested-by: Claude Fillion <Claude.Fillion@mksinst.com>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
> index e7be3e54b9be..4d190579e874 100644
> --- a/drivers/clk/clk-versaclock5.c
> +++ b/drivers/clk/clk-versaclock5.c
> @@ -1211,7 +1211,7 @@ static const struct vc5_chip_info idt_5p49v6965_info = {
>  	.model = IDT_VC6_5P49V6965,
>  	.clk_fod_cnt = 4,
>  	.clk_out_cnt = 5,
> -	.flags = VC5_HAS_BYPASS_SYNC_BIT,
> +	.flags = VC5_HAS_BYPASS_SYNC_BIT | VC5_HAS_PFD_FREQ_DBL,


If my understanding is correct, the doubler is not mentioned by the
datasheet, but it exists. Maybe it's worth a line of comment to help
future readers not waste their time in finding out:
  /* Frequency doubler not mentioned on datasheet */

Can you confirm that:
 - the en_ref_doubler bit value defaults to zero when reading it, as the
   register guide says?
 - if set to 1 the frequencies double?

With that confirmed, the patch looks good.

Thanks,
-- 
Luca
