Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436D04C31AF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiBXQlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiBXQlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:41:19 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E8626AED;
        Thu, 24 Feb 2022 08:40:48 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id s24so3672378edr.5;
        Thu, 24 Feb 2022 08:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qALsUfBRNZNy1q4MnFnN/Mg68ORU7TGkkXw7GkgCc1I=;
        b=Ssjj3P1kELJ8G5JUikFQhi0FmjJbN5NEY1VUlZ/Va4BVNhkXvxOxH2PMKMAG0LTXJD
         uOe8kD+hfDyom7n8ch4Ni8Qg57So73H2MfsXxUxUCmYOZbWEuG1BRlB2QS5qyZUvHRCi
         a66Kml+ysys3+kH2Oft17MXzFK0J5qwFjIW8+b0lQ0DV1MgIu/0HQ49vAlo1UlDtWlHP
         8fkCv9eaeLa2SeYkcoChzqFoDXp03jX7KgTYrSqs4qlf76BBghLgOL5nDop0b6u9Ht03
         etRz+Neju6nQkwBHq5n7Q2tCHOOfi0g6UUdDyf1Ewld0RQJ27U/0BiYMKSKPqzn5/WZV
         S1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qALsUfBRNZNy1q4MnFnN/Mg68ORU7TGkkXw7GkgCc1I=;
        b=NMWSZXZ4rK9/OaEUidXVWybmo/vRsFWapW2raiHDQsgrd2N8jUq/x7V7SLzfGO8Dm4
         Ndjw9Qj2i+8IGOW78HtZHDev1oJ+9bp4kT0jNxKJc99LSEMNY6uCmJliY9AP7R3afFg3
         FS/qPq4pOYNuun52Cq3J8g0D+dj+DMD3m09p3lqHeG2hKoQCzQ4K6LoYCrlED2mQXpKr
         3KZtKCgv4fjTpVCG3eG/+fHPbRCGyjNB9nCL6oBpZXu0CSqOMkmiysoRLWs1jKqBY/0D
         H40lSVkPmh0OilXT2sQwO/GDlCMiNQvCn+LnvzRW7hSxq/DS8c+aGlMpM+WUYSrqaPB3
         kw2w==
X-Gm-Message-State: AOAM532bPR3IH6JIeePq+FqgMdJnmvNupm12+5+pDItkZ8AhoST3wkl7
        NeTktQyrqA6U6kgGluFBoxc=
X-Google-Smtp-Source: ABdhPJyjBea5qD7kSqwqF+o5kzXVs8iZMyCe9mWUHCCP8R6Qw0DaiQ97szh10dh6UTSupoTJtGQJow==
X-Received: by 2002:a05:6402:5cb:b0:410:82a0:5d76 with SMTP id n11-20020a05640205cb00b0041082a05d76mr3158717edx.130.1645720846536;
        Thu, 24 Feb 2022 08:40:46 -0800 (PST)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id v30sm1585123ejv.76.2022.02.24.08.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:40:45 -0800 (PST)
Date:   Thu, 24 Feb 2022 17:40:43 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Joey Gouly <joey.gouly@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 0/5] gpiolib: Handle immutable irq_chip structures
Message-ID: <Yhe1Cxdn8t3oVxMZ@orome>
References: <20220223154405.54912-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wDjQmXbwTP1gIXI+"
Content-Disposition: inline
In-Reply-To: <20220223154405.54912-1-maz@kernel.org>
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


--wDjQmXbwTP1gIXI+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 23, 2022 at 03:44:00PM +0000, Marc Zyngier wrote:
> I recently realised that the gpiolib play ugly tricks on the
> unsuspecting irq_chip structures by patching the callbacks.
>=20
> Not only this breaks when an irq_chip structure is made const (which
> really should be the default case), but it also forces this structure
> to be copied at nauseam for each instance of the GPIO block, which is
> a waste of memory.
>=20
> My current approach is to add a new irq_chip flag (IRQCHIP_IMMUTABLE)
> which does what it says on the tin: don't you dare writing there.
> Gpiolib is further updated not to install its own callbacks, and it
> becomes the responsibility of the driver to call into the gpiolib when
> required. This is similar to what we do for other subsystems such as
> PCI-MSI.
>=20
> 3 drivers are updated to this new model: M1, QC and Tegra, as I
> actively use them (though Tegra is hosed at the moment), keeping a

Hosed in what way? Anything I can help with?

Thierry

--wDjQmXbwTP1gIXI+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIXtQoACgkQ3SOs138+
s6GqbBAAhO4/JiZXWM3idaYCebTwochmkwPmAKDKubIQPPRSDMr23n5LKH7MR8QO
I45Xq0AkDNOEjxx0qCWn+gJ+f8mTn5QfCrkOT74ysx4ifZtPs4ZTxC9IFuf1VZV4
3S4Q4cv7GlCecPYs7P43Tj7EJwGp/oHFdAA87n4ESLf391p4xOMscXbu1KRVmJJm
0HcOEsjKNzXk89JDS5UyuY+Vy9mIT/+yQsnNnI3LbZug3x6I/zeu2EZjCvI8mZY6
d1GR96HuEEMkQULGYFQC/Ur/GE4ewF41LB8RLCmdb4pInXWjBakTKnKfuRJfLPbR
BB9kLBquMmb9K/fmLBiH+CA5PwwYQbpBflUcERAO3bQ+drNzN+sbzM2bXret0KQH
+jizLi6oTJmDZTiWIVXffqctZBgpJ+jX8WnSZH9BPsLl5tuX0J51vabLgknYcF+P
TRN8srwKbHpza25UeDctjyvzb7esps/ssWf7Bpay8M2J9BiJ6/MwVJ6jtDMu+NDj
nZnrUy1Mh/plKCNbPvWP/Xlwqno/1y0vYaX0g3Jd6m8b6v6SicgcezH6lx9JsPJE
tCxZGyzesMspVlCxso2UIKkO+V63e5TWiEAZmlr1KhYoaJvOVy1DpuRo1ubQMLP2
prAS4hGV6aFCSGqaQIyODIy1pploi3mjgVzGsV1dvbiriSy/co8=
=i/AT
-----END PGP SIGNATURE-----

--wDjQmXbwTP1gIXI+--
