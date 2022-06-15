Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2C154C7F7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347631AbiFOL4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347021AbiFOLz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:55:58 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968B46470
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 04:55:57 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id u8so8635564qvj.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 04:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MPOz4vgepz2ltUJZ6fEyvEaVgIdF4j+lXzNxdrCQ1W4=;
        b=Kv1/sBXQy+VkaqfjY5/Yt1paxNw4IwE49hKbnnu4UqH8luwltTGeQ6HRlFn9chHIPH
         kj7417kDRfRvsgSOxPDs6mnjM1s+LpvFCf6b0I3EJnWeL5zJR6MHLHHHuJmb2eKtB2uB
         Xm9qMpVab9KKZ0YFri9hts+IWOMdO/3QigWYfzKTK3FyIW6sjLH1qdmKoIDvpqC7KD4p
         nTZSHDsN3ayn6gMT+eSpMRwyyQBYfpOibtwxf3CsiGIxlO5wMOzAkJ8R6yCXT2hyjJSZ
         JiCfhMrB5Qj9RhuIuIYRwoao0q/ktEUFUXwnoC414xL/DL1s4d8olS2trt41pI1wZ3qo
         59bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MPOz4vgepz2ltUJZ6fEyvEaVgIdF4j+lXzNxdrCQ1W4=;
        b=w9q1CNvjRpIgLwVnMQ7bt8wI9GrxV+L/w33sPuJV49Ecxzy1sXC93EckCN0/hX+7JF
         Zha8gReaR186yHLVspsNtLz3B9+oqvzOfJa2471lYihwjJAoq6fOxCWOPY+CMNbzW0Xi
         98jWQ75paOcXj0r3pR20vK6Umfs8HHyhAJyoO2GPgE3NIHLvnpuB2zqbGI6xGkszxTtM
         OzPc4ycKQqazgRPemU8Bdtr8TXIXJyhWe3xsvWMdcgMGstdEPOEq8GQ/YGkCfvEwqL/R
         cA3E+fO5LI3lo+jCRJ9KiWj0VT4e+SFFAaJJ5imqDaKIXTwrMhMMn3ORuIFDUDI7otLz
         suzQ==
X-Gm-Message-State: AJIora/XURjjPCzw4DOLcPdJx6CbUZhYakwgKbth2/gKvAFqZ0//77cz
        YKO6dvcMaE4e5a1WQrPWri2xlQ==
X-Google-Smtp-Source: AGRyM1u5vb133j77m9fDqaCMzeSfdNbNW6c5WeARrgXqYyBlVNo2I0dfX5nGQ9k4RhKIsKc74EZvsg==
X-Received: by 2002:a05:6214:1025:b0:46e:5510:e764 with SMTP id k5-20020a056214102500b0046e5510e764mr7551774qvr.78.1655294156742;
        Wed, 15 Jun 2022 04:55:56 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id p22-20020ac84616000000b003051f450049sm9393159qtn.8.2022.06.15.04.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 04:55:56 -0700 (PDT)
Date:   Wed, 15 Jun 2022 07:55:54 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: adc: stx104: Implement and utilize register
 structures
Message-ID: <YqnIygHDSUbV5yws@fedora>
References: <cover.1654118389.git.william.gray@linaro.org>
 <a2dca9435f7f1f727c696a1faa0ab9e27927f9f3.1654118389.git.william.gray@linaro.org>
 <CAHp75VepZ8P_cqnN8qJ_Wb=xM0LW3y-a22tv1otDReFSqRDFYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LoQy7Axdwa0I3j9u"
Content-Disposition: inline
In-Reply-To: <CAHp75VepZ8P_cqnN8qJ_Wb=xM0LW3y-a22tv1otDReFSqRDFYA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LoQy7Axdwa0I3j9u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 15, 2022 at 11:44:54AM +0200, Andy Shevchenko wrote:
> On Mon, Jun 6, 2022 at 4:27 PM William Breathitt Gray
> <william.gray@linaro.org> wrote:
> >
> > Reduce magic numbers and improve code readability by implementing and
> > utilizing named register data structures.
>=20
> Can we consider using regmap APIs instead?
>=20
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

The regmap API may be more appropriate here. I'll investigate and see if
I can convert this over to it.

William Breathitt Gray

--LoQy7Axdwa0I3j9u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYqnIygAKCRC1SFbKvhIj
KyVdAP9p1cEf2MxISHsQN2H9PTN6/GHta0g18vZLUlDtVJbEIgEA+fO5VJ4K/vgD
0e0CDHy8qRSYdkBhsczHE5v0eC/Vnw8=
=j35z
-----END PGP SIGNATURE-----

--LoQy7Axdwa0I3j9u--
