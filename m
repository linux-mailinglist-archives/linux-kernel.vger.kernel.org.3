Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064435A1415
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242238AbiHYOjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242470AbiHYOjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:39:09 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9085B81CB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:38:13 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id g5-20020a4ac4c5000000b0044af7c8c4b3so3364011ooq.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=dD45AotZgawn6j7yXm8vQJ+UE0Dbo/KkcTzZcEiShZk=;
        b=K+RHoh+HUw7Lslc17S1hk0nZmNLDzJbF6N73rs6R1mYJ3SRr9ELrDwFpg8vwZDVZZk
         kWho5V+GGmA/3LXG0xZg/pXSPJIsSxNTZm3LoYXiEWZUz3DwzwEDHf86rQPNrypZ8hNe
         JFIsycyNk6fxTk+XVGjPCwqV5/oFim0dzEXAnh5TQJJ6w7AugQtrZxfVxzxbw8FR07AL
         t/GgwYpeJJPm7NGYhygh5BCUkXY5dG2rGrr2b/kwecVXAfTN/nrvEhWhUhUXtZoEbJl2
         8nf109NW7dKi+crgRh0sRpGxoBzEb/HvWY+Fdrcy3D1FDyxKcIuoDJK70zQ/5RiqyXt4
         H2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=dD45AotZgawn6j7yXm8vQJ+UE0Dbo/KkcTzZcEiShZk=;
        b=PVKcwbm+WHgBLzplRYdhLvR+rqLFHWM4BsdP9sTjvRsLifNLD4s2Uno7iC6hyOM5B6
         9Xs/OVG546+0fJIeQSIelTWdhwJKrp+MhAPGhKCDcSQUjqUw8B3D9jI4rVNKT/zkGwim
         VD+c5h/XURl5Zu4EaZmRAqQynEZCrNvrpbGBYUTECPaQBSznoWXb6QxcPqCYunWgAxka
         AFUntwNKVzR1b+EljihzB1rnSWvk2jishHmILUW7B9fuwQjmXQG0YXSzmpWZ7y/h1+QX
         bRLUjQeLSxSIX+/k7skS+6u3DqzNCfoAMZEtfiFLPoxUhy/12COEacGk2SrKyBGfFqR/
         voGg==
X-Gm-Message-State: ACgBeo1LfEaBu4ljziMNjMKW8LsLFbLrYqOnj9TsRePK+r0kO8KhVHSq
        Y0crQI3Y+bTLIK7Y9MIccAnFIA==
X-Google-Smtp-Source: AA6agR5b55IUOFFbPyjXVGsBwjiEhvECpdWI/tNtXaH7xbcjDHW403RlhV5oD7vQe80xy+iy4VwRYg==
X-Received: by 2002:a4a:c113:0:b0:435:4ce0:9794 with SMTP id s19-20020a4ac113000000b004354ce09794mr1364871oop.87.1661438293205;
        Thu, 25 Aug 2022 07:38:13 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id k19-20020a9d7013000000b0063696cbb6bdsm5196989otj.62.2022.08.25.07.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 07:38:12 -0700 (PDT)
Date:   Thu, 25 Aug 2022 10:03:43 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        David Lechner <david@lechnology.com>,
        Jonathan.Cameron@huawei.com
Subject: Re: [PATCH] counter: Move symbols into COUNTER namespace
Message-ID: <YweBP30SLb5JMDq0@fedora>
References: <20220815220321.74161-1-william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Awi6TV3gD/mTDbk7"
Content-Disposition: inline
In-Reply-To: <20220815220321.74161-1-william.gray@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Awi6TV3gD/mTDbk7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 15, 2022 at 06:03:21PM -0400, William Breathitt Gray wrote:
> Counter subsystem symbols are only relevant to counter drivers. A
> COUNTER namespace is created to control the availability of these
> symbols to modules that import this namespace explicitly.
>=20
> Cc: Patrick Havelange <patrick.havelange@essensium.com>
> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Cc: Oleksij Rempel <linux@rempel-privat.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: David Lechner <david@lechnology.com>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

Applied to counter-next branch.

William Breathitt Gray

--Awi6TV3gD/mTDbk7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYweBPwAKCRC1SFbKvhIj
Kz8xAQDVpcs6TSh1nCA9NTh9HkIp7VdzcBsSUUucshnYANY8FAEAhqF9QuAzFdoP
jT18GCZH6jgDLd+3tR1jau8IU8doFwI=
=6kcl
-----END PGP SIGNATURE-----

--Awi6TV3gD/mTDbk7--
