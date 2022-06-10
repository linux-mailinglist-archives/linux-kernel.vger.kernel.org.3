Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3486254674E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245088AbiFJN0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242456AbiFJN0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:26:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60F41BE659;
        Fri, 10 Jun 2022 06:26:11 -0700 (PDT)
Received: from [192.168.2.145] (109-252-136-92.dynamic.spd-mgts.ru [109.252.136.92])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 74DF76601724;
        Fri, 10 Jun 2022 14:26:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654867570;
        bh=tT1jJ5a9K7KdBiLm8g0dOgTvRZsIIl3nYsCefhYiaKE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JtfphsybuNf9jwA62JOvrpW2KC2UX/VuEo7eJvFHDbDMDZ8+PS0O0oRXnNT+lEddW
         xUJe48C/W2diI+BjpeBTTJs0m+JXTWQGpzPx0q5nH4+VtM6AIolI5F95UuwVD29Uqv
         my99LRuc7hXy6LyBrgFglX+9HcT9bUoPE1NqOYvji8PkzuN7KXX4MoIVrXNB/k/Wx1
         5ENAtraBwUS2yEZ4/hRQmA+npqJiZ/S53A/FUymrRKBZTxdPD3yvNRZrucGIILhbjK
         OXVMY3hRBSTzW3PxgwT6paWSPWS1Kpace4Nn2vKieWsXDdSKLQFRMJ+dlu8Wlu2tfb
         r7TpYKUWgVp4Q==
Message-ID: <dabcc9ff-2fec-2f84-936e-3e0b71ad7ca3@collabora.com>
Date:   Fri, 10 Jun 2022 16:26:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1 1/5] media: rkvdec: Disable H.264 error detection
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     kernel@collabora.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220610125215.240539-1-nicolas.dufresne@collabora.com>
 <20220610125215.240539-2-nicolas.dufresne@collabora.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220610125215.240539-2-nicolas.dufresne@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/22 15:52, Nicolas Dufresne wrote:
> Quite often, the HW get stuck in error condition if a stream error
> was detected. As documented, the HW should stop immediately and self
> reset. There is likely a problem or a miss-understanding of the self
> self reset mechanism, as unless we make a long pause, the next command
> will then report an error even if there is no error in it.
> 
> Disabling error detection fixes the issue, and let the decoder continue
> after an error. This patch is safe for backport into older kernels.
> 
> Fixes: cd33c830448b ("media: rkvdec: Add the rkvdec driver")
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---

Nit: won't hurt to add the explicit stable tag if you'll make the v2.

Cc: stable@vger.kernel.org

-- 
Best regards,
Dmitry
