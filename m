Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1664E2240
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345291AbiCUIez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243898AbiCUIev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:34:51 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE52019C3D;
        Mon, 21 Mar 2022 01:33:26 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id h196so11111689qke.12;
        Mon, 21 Mar 2022 01:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lgbn95GaqkaWrHL6lRh7q4XgqWtuDli+cU2zPOFKkFA=;
        b=mHtUj+RrDRqWSpPHCVZONVGDK9NAKmdn+SAbQqbfdIdge9jNVa8UeQOFOZo/oJhkzt
         fG2fFt3THlSS/xWroxDQURGWy7uOpdsQW/q0RI48TPjMIUb6dr/z8/74ApHC9CGH1lWy
         vzK9GBP8kFBqxq+3FrGrsGu+uadB5+U8XO+N2sgn/jtiEPm0wL9OQ4A/kDVFuL6bUVtg
         7bTJyvfkwErsoQnq9ndq9wjzUCBjKtP/hKVQzFxBmkeLQbX18JU+EWzM4uMISeeuPqpY
         Jm1IAdPqeRlA2WcQHpWEJMgAK8ubT3UIRF83/qG6PtBriOWr+PMtWNBRTey0Akdf8N/Q
         gyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lgbn95GaqkaWrHL6lRh7q4XgqWtuDli+cU2zPOFKkFA=;
        b=5ribDpbBK8yBbE9BMl+HRE2G/UHLveFT+9lrfPRGw/Cgpyk8qnyuFkApLEif064WG9
         6OGWK9B8plozIXiu3b2tmY2rHh2mSZbMO1aGM/zQhSnPEP4kONZo/8qcnytSZdUFdpp3
         EpDQW2jf6v3YiIo13WWpbTdceI7XqYUDe4hQBuDegxDxs1rv4pethUryObjE/ta0nrpx
         p/BeYmJ6gCqJlCptHJTfF+jyzpzlwT1ia3aPhkBAN01e5sBK5EwI74ZiCyQkkQiV+DSB
         DDy8yiplEmI3bnxs64VY1oeHMys6UpDhBzL/5nlCvfw1+c1UnvrT4BAav/twes8E8ojK
         +qxA==
X-Gm-Message-State: AOAM531G7DKWjsC2T8nBV4Y2GJmMdBb/QvCTaNnHWi5+SxNSAC6sUu+9
        75DMDexzahvITIno7+Sl8GGg0oMecDc=
X-Google-Smtp-Source: ABdhPJw+GWk50gV9/1wgOLhU3z6N7p7AIvpMX3uvTLLQPU0opKrzG2JSX3NF5WhObtLrF+72/ZwfIg==
X-Received: by 2002:a37:65d3:0:b0:67e:9cbf:b1ec with SMTP id z202-20020a3765d3000000b0067e9cbfb1ecmr2132269qkb.138.1647851605607;
        Mon, 21 Mar 2022 01:33:25 -0700 (PDT)
Received: from vps.qemfd.net (vps.qemfd.net. [173.230.130.29])
        by smtp.gmail.com with ESMTPSA id g21-20020ac85815000000b002e06e2623a7sm11397415qtg.0.2022.03.21.01.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 01:33:25 -0700 (PDT)
Received: from schwarzgerat.orthanc (schwarzgerat.danknet [192.168.128.2])
        by vps.qemfd.net (Postfix) with ESMTP id 97B012B6E2;
        Mon, 21 Mar 2022 04:33:24 -0400 (EDT)
Received: by schwarzgerat.orthanc (Postfix, from userid 1000)
        id 80F45600415; Mon, 21 Mar 2022 04:33:24 -0400 (EDT)
Date:   Mon, 21 Mar 2022 04:33:24 -0400
From:   nick black <dankamongmen@gmail.com>
To:     "G. Branden Robinson" <g.branden.robinson@gmail.com>
Cc:     linux-man@vger.kernel.org,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] console_codes.4: ffix
Message-ID: <Yjg4VHMhrabggl88@schwarzgerat.orthanc>
References: <YeEc2pYvKEckcAmv@schwarzgerat.orthanc>
 <CAN4uE+p-uKzHNYry2YhCMfEFBQ2jUqpDAGx=+eha01w-L4fAjg@mail.gmail.com>
 <20220320160217.gws42lklp6ishzub@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+z8w45qClGzS9KLx"
Content-Disposition: inline
In-Reply-To: <20220320160217.gws42lklp6ishzub@localhost.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+z8w45qClGzS9KLx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

G. Branden Robinson left as an exercise for the reader:
> I have some suggestions for further improvement, but please don't gate
> the patch application on these.

always good to hear from you, GBR. i replied to alejandro's
request with the original, not wanting to mess with (and then
test) groff right at the moment, but i've saved your
animadversions. i've got a patch outstanding for the linux
console right now, and once it lands, i'll need come back and
modify this page again (indeed, that's why i was looking at it
in the first place). i'll effect your suggestions then, thanks!

--=20
nick black -=3D- https://www.nick-black.com
to make an apple pie from scratch,
you need first invent a universe.

--+z8w45qClGzS9KLx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEmi//dHmU4oe+xCLxX0NADCHL+swFAmI4OFQACgkQX0NADCHL
+szYCg//Xj9aJBwd6LjC2AWfEgrdq8ZuZWR84HuO57e2ZCO9UH9QGY3fETq6eCWk
/xtrPvwjHK/NDa9LO4b1vyyGhovg9rjwNsYS/ct2jfJICDk7FKrOUk5Z9kJVWRXB
/YQprfF4G7qd3IR0qszxviVv5V4wI3TzUhiQwR6IEmOeF9N+phXCc7EZqQigWoas
cq2pkMSqXWgqC/tr+K8FAv75E09955Ghpo5olqDWSRsS8wyVeDmSkw3kXORZO8ZQ
9JFGfIZFTsVUsWMpi9EGiGNbPSbprG+rN5eODDkorB2LPTOHhhVIB6QcHo1s/bsP
A8hhR0SvmyTFV2uTNEFqm+WiuWd9n3nbAdW7QPLW+0encYqzioo1wQNzGEaIUZiJ
gXw2NBrXCEoMaeIYqqa59A9X/7ia+nzd1K8NywroHUzhftzV4IFio7gQTGtyTwCm
w8NUmBQuJDZrrelE8nL9iiSb4e+rYRj89gQRx2WkKbSqIaQ1Tfdz2AtxJsSHFx6N
zQYzw8r7YDOBsEk53dO8LbCwj6ICjvgvG+LbyQFWD/eH8YeVSiAPa2Dd2XkSzsGk
SERjmUeIXLO+uiUiqw7GagNze3q0nzICsZNAcmMWKLysuflXnsCQEvYxLuKVuZ7l
qMVJGKTN9APyWDJV3WDMP/6VD5LajvwiyOTBG57C3bfVrjd5awo=
=9Cjm
-----END PGP SIGNATURE-----

--+z8w45qClGzS9KLx--
