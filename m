Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12797537A34
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbiE3LyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235841AbiE3Lx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:53:57 -0400
X-Greylist: delayed 169 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 May 2022 04:53:55 PDT
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395B26FA2E
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8VyoAg5ZFlu79SSDc3rfKS4ICjJpwoRquD3CfBZ6TtM=; b=iUk611ByWZqTdPUMZrYWfZb8Va
        yCKWmjQPiSoGFX/9hdU0bf2t4fclJClpBzs5B9Ar3AwQni7XpfViyY3BoITnQq6c66X03i2eRI/Ss
        04tSiTsXxTZfwee4HRl5qS7jlUml452YTtqrXEzAEcep0vvcuqTu0q+b/ZqdMhUN8ChIi+ohMldXj
        Cunxlfh1x0hb2nrZtNHjUyftWq70pm8ZCYGt79dhqK2lJupLbzYwFvOm6UqgHGfE8FDxaIfEkEsBN
        +IZR5hjoM0ID3Ie5SdHBdAW5LqByQfPKiaTswkG07rUNAC4NF0tFp8ea9D3e9pKrlY6mk/9BYbi9r
        PVaQBYlg==;
Received: from [2a01:799:961:d200:140a:b605:56ea:1c6d] (port=50308)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1nvdvM-0005i1-2S; Mon, 30 May 2022 13:51:04 +0200
Message-ID: <4fca264e-6c07-a68d-f8a1-52db555a2b2c@tronnes.org>
Date:   Mon, 30 May 2022 13:51:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] drm/mipi-dbi: align max_chunk to 2 in spi_transfer
To:     Yunhao Tian <t123yh.xyz@gmail.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>,
        David Lechner <david@lechnology.com>
References: <20220510030219.2486687-1-t123yh.xyz@gmail.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220510030219.2486687-1-t123yh.xyz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 10.05.2022 05.02, skrev Yunhao Tian:
> In __spi_validate, there's a validation that no partial transfers
> are accepted (xfer->len % w_size must be zero). When
> max_chunk is not a multiple of bpw (e.g. max_chunk = 65535,
> bpw = 16), the transfer will be rejected.
> 
> This patch aligns max_chunk to 2 bytes (the maximum value of bpw is 16),
> so that no partial transfer will occur.
> 
> Fixes: d23d4d4dac01 ("drm/tinydrm: Move tinydrm_spi_transfer()")
> 
> Signed-off-by: Yunhao Tian <t123yh.xyz@gmail.com>
> ---

Thanks, applied to drm-misc-next.

Noralf.

>  drivers/gpu/drm/drm_mipi_dbi.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
> index 71b646c4131f..00d470ff071d 100644
> --- a/drivers/gpu/drm/drm_mipi_dbi.c
> +++ b/drivers/gpu/drm/drm_mipi_dbi.c
> @@ -1183,6 +1183,13 @@ int mipi_dbi_spi_transfer(struct spi_device *spi, u32 speed_hz,
>  	size_t chunk;
>  	int ret;
>  
> +	/* In __spi_validate, there's a validation that no partial transfers
> +	 * are accepted (xfer->len % w_size must be zero).
> +	 * Here we align max_chunk to multiple of 2 (16bits),
> +	 * to prevent transfers from being rejected.
> +	 */
> +	max_chunk = ALIGN_DOWN(max_chunk, 2);
> +
>  	spi_message_init_with_transfers(&m, &tr, 1);
>  
>  	while (len) {
