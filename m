Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33894C31A2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiBXQji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiBXQjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:39:35 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C8F14CCA3;
        Thu, 24 Feb 2022 08:39:05 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id q17so3684553edd.4;
        Thu, 24 Feb 2022 08:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8ww14R/0doMbb1GnnkQOuIVoZujutPBK0hfKVk+ApXY=;
        b=BT7WEMy0rlnh82V+S8R5fT/DjCHh1QvgOhGph5OTDiiTsVhFskdqRaungLGpCGw5vk
         iS0gSSf81Y8cCkqzcWFYC/lFfyQi0YS/Ude/pkXSYOrp7TqrtfcEQG7EOBYczW5WSe/I
         JdV4ljZWsJZj+RquInApUvlaOl3RGG47yhK3XIkwO9b/d+IcvcyCqO+uxmRr2e4ep2ML
         5PG4ZZdZFZO9ZbndOnm6DHwUbTJwNGodKfYteXQ6lJ/qSfiJMfXuMm2PCMt/2XSHc3q9
         3Pw+L8cDv5VXqbHJCvcxq8ehEgx3mm0qudnH4Qj7LqJrvORB3xGAoq848aAivyf3xWGd
         6ZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8ww14R/0doMbb1GnnkQOuIVoZujutPBK0hfKVk+ApXY=;
        b=Q+o7HgbUerLvuYF1w20Rw/CPOlLn4lNV9PiHNq5ZZWLLCFYr7ZkcOCvU0o9h6DrgCk
         kOS60f7u5Ve5rAL3tLdZO6/qha8GcSvVgnwxp+pzBqDjvv6LrqJWvMPh4PQpPRlGr2+5
         kMloSzOqx4KV8xipVQTwSkJhf0z27UDIS+kWtwak4vRcjHbPu9823ZEJ6Y1G0eQsPbLD
         P36PQ8whfbwDKZPYovBnGlFQgONDvU+j3ijm+B+vKyhfMRfNUwKsJH8hL2u7BT6eUzt5
         MhEA27jRWPqPF0HehRoWcsqfeCD8H7FT+A204h2at5h8eNFW9gyD7oq4i0+Wf3TeW9fW
         J6aw==
X-Gm-Message-State: AOAM532gErARLF7PTqLVGgr6B0SRl0N+z1ux6L2HjvnteRo73mDqSCm9
        /BlRM2xkgwmC3KzO9y5XK0U=
X-Google-Smtp-Source: ABdhPJwJoHH32eVYGJKm8Bcye+DcONzdjP7VEdHc1ObU8Z95hbpmJAqjIx539QkZIjEd/tLs2VJtKA==
X-Received: by 2002:a05:6402:1435:b0:410:d2e1:e6dc with SMTP id c21-20020a056402143500b00410d2e1e6dcmr3160043edx.138.1645720743929;
        Thu, 24 Feb 2022 08:39:03 -0800 (PST)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id g15sm1775861edb.11.2022.02.24.08.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:39:02 -0800 (PST)
Date:   Thu, 24 Feb 2022 17:39:00 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        jonathanh@nvidia.com, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        smangipudi@nvidia.com, Manish Bhardwaj <mbhardwaj@nvidia.com>
Subject: Re: [PATCH] gpio: tegra186: add Tegra234 PMC compatible in GPIO
 driver
Message-ID: <Yhe0pCpfeCpyfPWg@orome>
References: <20220224082409.12559-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lsEbeFBk5FrbFEHX"
Content-Disposition: inline
In-Reply-To: <20220224082409.12559-1-pshete@nvidia.com>
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


--lsEbeFBk5FrbFEHX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 24, 2022 at 01:54:09PM +0530, Prathamesh Shete wrote:
> From: Manish Bhardwaj <mbhardwaj@nvidia.com>
>=20
> Using this patch we are adding PMC compatible string for
> Tegra234 in GPIO driver so the irq hierarchy can be set.

s/irq/IRQ/, but otherwise looks good:

Acked-by: Thierry Reding <treding@nvidia.com>

--lsEbeFBk5FrbFEHX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIXtKQACgkQ3SOs138+
s6F4Bg//bdcp/cCBhMmhRROLgl8W/gI7aGWofrewPJUM28kDVshWPUyxxzCm99Ly
+ebwJ2ILgqPSloqFOwPM7cQzzhEGupRzTWGp2/e9PWlQmBW2t7J0Ft8bmI25cyyB
YBnK6OlkFij7lHnVsVj2ECbcyBtOL6oc8se/Q55twiPfQihY2hOZF3NoVmiPNcBt
q7XJMUTqfvMDHPqduey9FDVSexlPm5GPGVw8WcojxCAuasYL2brNhkCUFO1714Dg
UeUff2CSR/0Dr1SX37YbqcfhOZpMJS6xQMnrsStdC96LDn7DRvvRC1ljO3v/2w7x
435QsTn2s84ynQQr7ACVFfkALwm3UNSvSIx4oubv0vsjx6bQ30FG4cTKqtvrMbzw
hnWtEb8zsHtvQ9HdPzMSA/2LlZ9F+aFsaaoOF2ni0EOreSKX3rPVx5Q2mf7iyHnH
KJdRAZFNisiHvf9PcFFN5omlbDx6AuTuzMFJAxYf43TsMeaoowkS4+LNFwiRrmN/
08wq0xy8Gw6ig0n5sKNEhDcOPAnqBH6Mh8abWJKWP8dvXCEirVCpFxSACS+5sKEJ
pU9JSQgvSUovlCw/AfuezB/35+VQ9yBASf0e+YWje9Pk4Qb2BGmlyjR60zkDUcYn
KxewUtg5lqh1hajjfTFAncrIK9omiTkxW57Z7fFBbI/0QbAMaE4=
=e1QQ
-----END PGP SIGNATURE-----

--lsEbeFBk5FrbFEHX--
