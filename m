Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67ACF55872F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 20:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbiFWSVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 14:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237173AbiFWSR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 14:17:56 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16515B3C1C;
        Thu, 23 Jun 2022 10:24:18 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i18so111624lfu.8;
        Thu, 23 Jun 2022 10:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vd6I47XVnnsBhvyCl3F2FOHX4RVw1fOk5Ka4rUmvOyw=;
        b=AfKR0c24ywYANVT/yo48pwbD67+tfKAyJ5mxn73xIoJZFyu1YGuFdFJAD3avh68hHf
         L9mG2F4voRL2y8BD4ffFqMytVW6zDLtNFU1OyahEiYd+0W961n8howXJhbrYRim8pKnS
         TsJ107hrjN4/VPbCfTiRNIh1nKzxwTM7mftm7IyVU3dmJZRX+tFBzLzlf9OirlkDGLPK
         XH+DYiAuqGPryc78DuqNHDUckevTjKEC+Izsm+Ck8I6XnB8pTGGnpN1r7gO/SNSeBpzT
         FHP+6upHqMjsGC9xp79r1Rw2W4gDheEuLSHeVz4CozYrWvlO8KkLmGdGRHECYw0GHHkR
         BV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vd6I47XVnnsBhvyCl3F2FOHX4RVw1fOk5Ka4rUmvOyw=;
        b=CdFQbQ5DcboTglYypdlV+OY8WmZdAi++9mj4vmWWZRC4RByfUVIKAzJECgTlcruPmd
         9nexaiuqg5oR+tWeiqSG9ErY4dIUbWfCKpsxsjQU049RGLdnF/4akpVJ+J308QMzgZUj
         YLGmYwxgNA1nJgHt+p2pjlWCcH+ft/F7AhvDlxfHGL/nQtnGBx4Fme8bn+NAOKDjY8KE
         rS+6oVcXTN5gkp9qGWj8eLyGAx8uyGD3nldK+3YrXFixhzKi+qtBZretZZk/la6saDkP
         T+IGS3XsAmhPVPPJDzmPUBKRh8N6GVdEKJLItarWK3i8XV9OTBZHx/x3ZJ9SggjpbUXR
         /cuw==
X-Gm-Message-State: AJIora/9J/OExdGf7nFPulhkOHO3RsufiOaXvWGdzmRb55Cyvu8PW8+p
        p5aq+0Tav81hKkbjhYCajnM=
X-Google-Smtp-Source: AGRyM1uGcwmA4B2BYgcxHcSU64lGKl2lkAP50JWq/nzLH/mLaOoHxPa9gArlBKjn55ukt20bk9e+Wg==
X-Received: by 2002:a05:6512:2241:b0:479:6426:15af with SMTP id i1-20020a056512224100b00479642615afmr6111281lfu.631.1656005057043;
        Thu, 23 Jun 2022 10:24:17 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id v6-20020a05651203a600b0047f9cfa914csm677369lfp.18.2022.06.23.10.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 10:24:15 -0700 (PDT)
Date:   Thu, 23 Jun 2022 19:26:05 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] iio: adc: mcp3911: add support to set PGA
Message-ID: <YrSiLdFzkXtCZIBi@gmail.com>
References: <20220623170844.2189814-1-marcus.folkesson@gmail.com>
 <20220623170844.2189814-10-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lGrmasrXvQkSs9iU"
Content-Disposition: inline
In-Reply-To: <20220623170844.2189814-10-marcus.folkesson@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lGrmasrXvQkSs9iU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 23, 2022 at 07:08:44PM +0200, Marcus Folkesson wrote:
> -		.info_mask_shared_by_type_available =		\
> -			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
> +		.info_mask_shared_by_type_available =           \
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO)	\

This change was not supposed to sneak in. Removed in v2.

/Marcus



--lGrmasrXvQkSs9iU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmK0oicACgkQiIBOb1ld
UjJvmQ/+O1qb9I5+2vmxERYd3bqBZ7uUt0KqGiSxxvQJ8ZkEhN95leqvOtCicSsl
9zRV1VyQc6z6dB4Hwol4FZ27FKPL3bzNQatSnBIbDqX7nQKGGT0uY2UWwrhcqm/I
dRgc5WBODVjjpqcZPR/KkWhHBBO+qDhPTRVq6Q2OZIueKNcG26+5XIsNo5Uhw1dB
p2yj3jfySqp4Q4FIQlcM7wB72/0rc9T4BbvQDRNcdin7UaSl4rWmtfxg7ZPOje1p
9O6ek1soQKuEDqj18h7N2VD3zuG2FN4DtBNxPERqRF9rqkgiyf4/pvpYl9ontZp1
zEJujWE0aUodxaN9A8q3RvDRPT2TbmE5OxcBdYvUot9tHX99NNiscZjdV1Wp61Wt
pbZklmGOiQ0PcwNsakZRRer9+e6JGSm5KpC3ssckadejOVOT32C/v1iErGBuvlru
vA18SDq3ZvPmO5s/WybjIGnpmqJ/YK9khZSn247/YOiOC8IgcDKWIv8SfItOhJN/
mQLqmHXDZPH9Mhf7rM/EnvjVUjBDZyBwt0guZMkgMS45iS9eEvSoWyMXgC6fmgtJ
i4jmRNTXc3IbBibdvuX4xIEjEeLJJjmlQZWL0F/TTAuL1Xxx0FC1WaTcKWYD141S
eMbTVMPXie6rK8p8pGx5OTv+6fJe6A5BO0uxf6g2CSW+FlVAb5U=
=DB3I
-----END PGP SIGNATURE-----

--lGrmasrXvQkSs9iU--
