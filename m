Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349E44C45D7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241110AbiBYNTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiBYNTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:19:09 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1895D1DEAB8;
        Fri, 25 Feb 2022 05:18:37 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id s13so4481694wrb.6;
        Fri, 25 Feb 2022 05:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TUNqvCWmIrBg9AkYSUR1RB4M4A7kfSnYMvROvFnKfhg=;
        b=j34xvGzqjyBYiAAOwY7JHrdHu1rkNvDOGXX7gxXtmyjkerHILCJokmNP41CJIZnryB
         ZEH3/Hik489CnU4J629rErfejhVEk4/5e+GfdkrT4gvi8ZFkATfEiOHhizMwrmi7enwT
         uK7Hk4YTx+JoxB6xpBEhyFXhWkp9DSAXDCxKbcX4mkXDjbByTftwo/gcbBuz3S1EYQ8I
         D34V/rEMWW/SS8FMVqmfLUSF0nVV7M/Etg3SYTY4lp9E13CrL4hdpWSIiNrswZJ8sR20
         iTt6OpInQ/fi5rYwdx0sDjmYSZwITpLEGX1wgoW7qJ3vST3z+EMVNL/DoUV582g5Vabz
         acuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TUNqvCWmIrBg9AkYSUR1RB4M4A7kfSnYMvROvFnKfhg=;
        b=BIOfKLUQFoaXjcQUK2gIc8WvTB6drlZ3m0uYvnSEyhY3u4aEnz5dU2AW9eFGbs2HNO
         1tI6tQxuvcUGYfp4Oxt66oV1vDuKQTLz+CxNKXFecQj6Blqno+S6qbySt3gUdW2xCskH
         2lndpUeSoRh/VWdi9+cvHbjNv8EH9N0mtEGeSmknuNuFjRg8R0tSZVfupsZFxoTZmofO
         E3hFd+hwrTTEG5TdvAgTpnj+FQNjbFTT3taqN16bTIoZxVGCAhTQ0228Ik1XjLb+iDey
         MSoTjqVpRMvkiTPEwlX6qJWafvH2FqvNN1cmvS/0OMLHYi1zLDz8xbpu0WoPTuFxlhkd
         Tbug==
X-Gm-Message-State: AOAM531TduUQ7TomJxgoCXauZ0TgX1GIWv92mjPcYvPhd8lO3nWXBSPH
        zKAkMXwQ9tMwmoapp5GT1HU=
X-Google-Smtp-Source: ABdhPJwdToPn6zXqf0btBQUbsIS1HEM2rWHiwnrHufoGb3rKSRGNweoBfq5nI9RGMEFTVexq0CNuEg==
X-Received: by 2002:a05:6000:15cb:b0:1ea:78fc:2201 with SMTP id y11-20020a05600015cb00b001ea78fc2201mr6384877wry.362.1645795115668;
        Fri, 25 Feb 2022 05:18:35 -0800 (PST)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b0037d62a899b1sm2512792wmq.6.2022.02.25.05.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 05:18:34 -0800 (PST)
Date:   Fri, 25 Feb 2022 14:18:32 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Wayne Chang <waynec@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        zhangqilong3@huawei.com, yangyingliang@huawei.com,
        rikard.falkeborn@gmail.com, chunfeng.yun@mediatek.com,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: gadget: tegra-xudc: Do not program SPARAM
Message-ID: <YhjXKLVYgpop27R9@orome>
References: <20220107090443.149021-1-waynec@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gl8CDPNI6wZnzrfJ"
Content-Disposition: inline
In-Reply-To: <20220107090443.149021-1-waynec@nvidia.com>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gl8CDPNI6wZnzrfJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 07, 2022 at 05:04:43PM +0800, Wayne Chang wrote:
> According to the Tegra Technical Reference Manual, SPARAM
> is a read-only register and should not be programmed in
> the driver.
>=20
> The change removes the wrong SPARAM usage.
>=20
> Signed-off-by: Wayne Chang <waynec@nvidia.com>
> ---
>  drivers/usb/gadget/udc/tegra-xudc.c | 8 --------
>  1 file changed, 8 deletions(-)

What's the impact on this? Does it fix a bug? Or is it more of a
cosmetic change?

Thierry

--gl8CDPNI6wZnzrfJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIY1ygACgkQ3SOs138+
s6HEHg/7BPV/te79tMNbpLbDXsmVdevmiKD9gyzneQk9jA2xEg7SNmeNCMuhyL7h
FVl1Kd46D2ZYfcOTXQ/FANEWLRRaqY3KLCdp3OsjqibkiR98tRGcvrjHIxZGaiU+
qMcV+Ok1rLesSfdvEi0tlFVkL1+jE3pHnX4KvOWb7KRQ2obnXpusYL2e4XJo+i5W
iyEe7BIrnq1SFBQTq3L3G8V/s3BeHVpmpcgyAPvsmq7gG7cF8X6WbeKnE5Z8GXi0
8RzT3L7S29RYqjWnSfWE4p6HKX1jTL7LPILl1nbLJyelJJCsVgPSoaL/Ls4aq+QJ
3wluNy2h40YcBEORncgr15l0FxVTZUhYPOMh5FT+cqVpAISHYKyfvnvL4Chiaibb
ZwG7SGY8Z9pYH/96vXr3CXddRfzmhhZ7kPi2LZ6HJ47QRTnnYnMtQBP2KlsR04fO
1DZzJWqovwtKuescW0Zq++6ga3jtifHdh36LFf9w2uIxaNUpwLc8tgZ7l2H4phvj
W4zahDZyxvZy6zstgxy/lmw8u6Sxnw6nRHbXC+c3UbbmOCl3vnBnzbQPME8CJy2l
dR316IDKh0+lo+ZyHQRgZfbpFQwV2dN1m3P8owKvN+HcJ1Twi6ZAQl2hJS09Nyjg
aFTPbwA4CbkJlJIeF91zx+bwSkOXIxN9PJpFU+A3oRATQ/Y6vfk=
=A+Ss
-----END PGP SIGNATURE-----

--gl8CDPNI6wZnzrfJ--
