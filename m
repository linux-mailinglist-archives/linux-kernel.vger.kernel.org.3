Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EDA5A138B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242079AbiHYO0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241888AbiHYO0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:26:17 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DE4B6D74
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:25:24 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id r6so6255709qtx.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=9q5E2dO7Vvuh3mZ+3q9Pzgh7cxNE5Dy6aCcYQ91ZiBw=;
        b=z8GV6tlcZFkSNZP4uYd0O7d0oixQplR8b8QdeZZZVmvm1B5qa8Dx+u6Li8ZaLdEv15
         /ObGaSZggDd9w2/ZUVIufW0eJUOTocH9W+qTMCEhS50XVBF9vhIvLOZlui+ilFNFuH7E
         zkAp7KZKV22QKK6a+pFHp6JM/i60JVJNfQ3nNZvjHOi6Ltx6u/qrbZC9xv4Zzmcqop8J
         HVyys3S9AMJf5Z8ojNOUiZ3Mzmn/Vd1cQu/I+amG36Ii0/+gmADaobzXmrOtu0nNZcPB
         AE7/BrUnizOyF9v9iFJ8rvnyMlCOIm/eHU49LyXDV0cqsbR1p9ZuqLimedl2scUlZJmW
         WbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=9q5E2dO7Vvuh3mZ+3q9Pzgh7cxNE5Dy6aCcYQ91ZiBw=;
        b=Q+9s8zPL4sSP+t+iKOQlUrn/0rLHPW78ZKOVit68QXGeodSc3k3M33pVdVUFe28e8h
         uPPLOW+6f4i+4hoHTNZJBvR/jQM7/PEWxo8xGt56gF3y4Z2XLqqNl3xv7AoI8dv9RGwb
         pbkOp9mJ02wEXlASbNZMig9H+Jvm881UHsp16/cCpxjJmqjL0rAoiEPG3GGllCljnJgG
         MLi1R3XxhkF/GoGKOx2dXQzg4yKeWrbJu0aVT8XZUNyNoBcfszkVoG6D+G3UURmY0YRd
         c1BMo9DL4q2S0CBGFfEJ+OepKSh3jY1nZsY9jmh3aYGr+ys6A8pIj8U6qsW7qe4dMB4X
         /e9A==
X-Gm-Message-State: ACgBeo356YSNaK0LJ+XDHTQQHV7hA8pqlKzDfq/Nc/+LbCutW0c74sda
        Se7lW7w5wqQWw8ZZGEiSTR7jqP4+ml/+LQ==
X-Google-Smtp-Source: AA6agR5wE3eOiAXbmnPqIYW2w3jLofEw0gDUxMOxhLoflF7uLUgsyqig0sIj3oy+OC4WTWAskIm1QQ==
X-Received: by 2002:ac8:5e0a:0:b0:344:9b69:eef0 with SMTP id h10-20020ac85e0a000000b003449b69eef0mr3798389qtx.666.1661437522981;
        Thu, 25 Aug 2022 07:25:22 -0700 (PDT)
Received: from ishi ([2600:1700:5668:ac50::42])
        by smtp.gmail.com with ESMTPSA id bs43-20020a05620a472b00b006b9b7879964sm17697072qkb.28.2022.08.25.07.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 07:25:22 -0700 (PDT)
Date:   Thu, 25 Aug 2022 10:25:20 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: 104-quad-8: Fix skipped IRQ lines during events
 configuration
Message-ID: <YweGUIh/TuZ6KUhA@ishi>
References: <20220815122301.2750-1-william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7/wmN6eEarodysVb"
Content-Disposition: inline
In-Reply-To: <20220815122301.2750-1-william.gray@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7/wmN6eEarodysVb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 15, 2022 at 08:23:01AM -0400, William Breathitt Gray wrote:
> IRQ trigger configuration is skipped if it has already been set before;
> however, the IRQ line still needs to be OR'd to irq_enabled because
> irq_enabled is reset for every events_configure call. This patch moves
> the irq_enabled OR operation update to before the irq_trigger check so
> that IRQ line enablement is not skipped.
>=20
> Fixes: c95cc0d95702 ("counter: 104-quad-8: Fix persistent enabled events =
bug")
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

Applied to counter-greg branch.

William Breathitt Gray

--7/wmN6eEarodysVb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEESdocE8T8CMGLP5oTJYqFfHOePQsFAmMHhkMACgkQJYqFfHOe
PQsC0Qf/VmZbA9hKO6hKjRigTL6o6BphZZOyCdnL81/SSUZpEC69d2PJ46D+Hc2u
akISOb4qdHJaFowlym1Xi/iNLi/uuDfOlWmhqF+j+dOnLA6RTY3osHUugGQEwS3v
/D6V5EBlG53VEuu8r46PRh3Xa1p48lS3PYKq6vQ6hliwIq8Ui2xlXI5gkWnThUsU
XL75UrG55xOgy24DMhbIOx+KVt6YdrvE7+9H/rGeVTdQL/fqRxzwd1XXDRSI7cGR
VOs2dSRRcJLonj6rQmTmu9t8pNypdS3DQSCdueCSZhBHSjhoYZqokbXdUMlmKEe+
cJwn/gHM+ijDlw0xFxu5t251KYFpKA==
=bQZH
-----END PGP SIGNATURE-----

--7/wmN6eEarodysVb--
