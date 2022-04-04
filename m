Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1768E4F13D4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 13:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359634AbiDDLdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 07:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359555AbiDDLdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 07:33:12 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C14E3C732;
        Mon,  4 Apr 2022 04:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=g+Na3FfqSbBs+NfGy8udHP+G0PkiZ0hNm5glhWAuBtw=; b=b8g/9
        mY+QVzpPzjxxdP2dH/gVChi9dXExZcQzbGEr6id4eHIu733ysAaJZ/FxXSceFhCf536aHA13rR3Yz
        U/QTqOfxh0WlNPwOqaoCrczym16P+qOmWQAI79Lkx+9Fa413PvawThzreFuTUQqwxyiXB1kC0Fpc3
        0BrjD898MnrqjY4brIAoQGPWPEf54jyN34iem6Sjn93XVeILkET1QHxiZvFCdYqE2yjwG2KHQucQf
        xuTvKf7lR3eAi+OlgrMqhZsYiaIGyzh/GetT5kKSA3gUyNFIViUZCF03pqwyr07+LhxMLq/0QdVhr
        kMaI4C44AlRYQSuhpg5qRt/gjXHYg==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1nbKvQ-00051Q-N6; Mon, 04 Apr 2022 12:31:12 +0100
Date:   Mon, 4 Apr 2022 12:31:11 +0100
From:   John Keeping <john@metanate.com>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 08/33] crypto: rockchip: better handle cipher key
Message-ID: <YkrW/+DX5vN8W5cF@donbot>
References: <20220401201804.2867154-1-clabbe@baylibre.com>
 <20220401201804.2867154-9-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401201804.2867154-9-clabbe@baylibre.com>
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 08:17:39PM +0000, Corentin Labbe wrote:
> The key should not be set in hardware too much in advance, this will
> fail it 2 TFM with different keys generate alternative requests.
> The key should be stored and used just before doing cipher operations.
> 
> Fixes: ce0183cb6464b ("crypto: rockchip - switch to skcipher API")
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/crypto/rockchip/rk3288_crypto.h          |  1 +
>  drivers/crypto/rockchip/rk3288_crypto_skcipher.c | 10 +++++++---
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/crypto/rockchip/rk3288_crypto.h b/drivers/crypto/rockchip/rk3288_crypto.h
> index 8b1e15d8ddc6..826508e4a0c3 100644
> --- a/drivers/crypto/rockchip/rk3288_crypto.h
> +++ b/drivers/crypto/rockchip/rk3288_crypto.h
> @@ -245,6 +245,7 @@ struct rk_ahash_rctx {
>  struct rk_cipher_ctx {
>  	struct rk_crypto_info		*dev;
>  	unsigned int			keylen;
> +	u32 key[AES_MAX_KEY_SIZE / 4];

Should this be u8?  It's only ever memcpy'd so the fact the registers
are 32-bit is irrelevant.

(Also a very minor nit: this should probably be aligned in the same was
as the above two variables.)
