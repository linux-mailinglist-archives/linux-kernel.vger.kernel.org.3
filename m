Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BA255CA91
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242315AbiF1HXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241877AbiF1HXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:23:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA7B2DD6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:23:10 -0700 (PDT)
Received: from [192.168.2.145] (109-252-118-164.nat.spd-mgts.ru [109.252.118.164])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 26D926601856;
        Tue, 28 Jun 2022 08:23:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656400989;
        bh=tkMWwHg3XLqb6lHOLMAd96X4R33y38F3yPePIgGCoK4=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=DS4rM0xlJ/PsTDzSk5MFk9QRUuAF4NvI53elJoysMMoSbdStn25/OGcattMVg66ZY
         mj8oGKbiUSXJESayjg0iEwFwm6fb66nD4BD+Ea/Py3FBW0lpqMJQE19YjGK8MljcQs
         gzzxmPNjqAZvLepvbTbrYQnzInrAeZ6PJJM1HZSDhw39VHxxkUl7+XDaioBSsODIC6
         yj25QOcHqBLjT+Oo2GxUFRb55Wa9nzo8/dxcSegJ5vsgGEJsbhAQgjUE/w6rJpCHWI
         sDNhPDdozSSc8wQXYu9F3jIJ4aNNZTiSwPzfQJVVEW92xI5eBPnVLWhldKRC83OiF1
         aaAExN1t8Y9qg==
Message-ID: <253e9ec1-bcd8-c790-95b8-afbcc21e7163@collabora.com>
Date:   Tue, 28 Jun 2022 10:23:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1] ARM: Silence proc-v7-bugs.c spam about disabled
 Spectre workarounds
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220519161310.1489625-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20220519161310.1489625-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 19:13, Dmitry Osipenko wrote:
> Print message about disabled Spectre workarounds only once to stop
> endless spam into KSMG each time CPU goes out from idling state.
> This spam makes system unusable with CONFIG_HARDEN_BRANCH_PREDICTOR=n
> for those who don't care about security and wants maximum performance.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  arch/arm/mm/proc-v7-bugs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mm/proc-v7-bugs.c b/arch/arm/mm/proc-v7-bugs.c
> index fb9f3eb6bf48..f9730eba0632 100644
> --- a/arch/arm/mm/proc-v7-bugs.c
> +++ b/arch/arm/mm/proc-v7-bugs.c
> @@ -108,8 +108,7 @@ static unsigned int spectre_v2_install_workaround(unsigned int method)
>  #else
>  static unsigned int spectre_v2_install_workaround(unsigned int method)
>  {
> -	pr_info("CPU%u: Spectre V2: workarounds disabled by configuration\n",
> -		smp_processor_id());
> +	pr_info_once("Spectre V2: workarounds disabled by configuration\n");
>  
>  	return SPECTRE_VULNERABLE;
>  }

Hello Russell,

Could you please apply this patch? I tried to use yours patch tracker
today and it doesn't allow me to recover my password (server error: MAIL
FROM command failed Detail: Space shortage).

Thanks!

-- 
Best regards,
Dmitry
