Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922524BB515
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbiBRJMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:12:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiBRJMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:12:10 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA021FAA3B;
        Fri, 18 Feb 2022 01:11:53 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id j4so6676611plj.8;
        Fri, 18 Feb 2022 01:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LIyRE3EdCpuyED3eL5M9fHMS8or7gH1mbvyGPDXk7Ho=;
        b=mimdAcxFhT2El1z1fVFEL0MJ4/Pp7o6E1+DqHWP+bFNzUuaCVast9XxCbMtrMQrD98
         ANWiMfRGgzZT1ka8MMYuLFJusueUZk4X4+Yaz9QgKS/gKss8MExYmjI+r7ZikIYzTQM/
         2tK6Xm61C21KtbTW8jCGEuTiPVKOjV3ikNRIfAa736bX3pTfEGBkKIKa5kzAmwW+zZXS
         i+r1FJ5Wbj+PZaGWq5ZaxCoki9Qe3cqYbKmNDbbqQPI0g47xWPjx2D6gwiBDAQ7TWeO6
         0FA7QyJ9wOp2DKBuGNeyo+eDyNhFdNRmFbK0VVcCIR0Eabbv7hbEj/AKgkjIZquzl9N7
         5yYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LIyRE3EdCpuyED3eL5M9fHMS8or7gH1mbvyGPDXk7Ho=;
        b=rei2udyRrGQAZ6AgdtivxP2kMFrEJ5qDElRPdjrc4i/C5kxsvBeO1QwTo/eYQXNpZx
         tncyakAIvvuTgbNgwVAtpZVCzkHy6C9fkZzmecgukQ7rOy1NUo2W06113hk7zerRHy+D
         DW9MFW5WAM9qcvXBw9mekI7YEGcDW+MgOO4aETB6d5J0SYVUqIY0jRQsBEQ4CSCIwx3D
         zu3Us+1pneWyU8UA8fovBgiXhJsWgObpgNqZTmjgkHmEyFm1HfOiSGorRXMC1TQi4AFN
         CCuELX4xHT7dWLdGCmFpz2AkP3mwoT2iPRRj8gSHNc7v4NixsSu2A+KTshFskWyVLkP6
         d16g==
X-Gm-Message-State: AOAM531y41wzDuEONaLUqbmCCasVKm9xDbdghxJzroCTDMWzE+cDebkK
        r6Nav1DILK8VGVVWV3TUBAG56vjMPIwW7A==
X-Google-Smtp-Source: ABdhPJwJ9QuWZ+uW0njIFCa4HTx3lVBs2R5lPDA4/gn9iBSrA230PM1YWkUrMOl0zzSab4+V0CO4EA==
X-Received: by 2002:a17:902:8497:b0:14f:919:9fdd with SMTP id c23-20020a170902849700b0014f09199fddmr6766127plo.52.1645175513425;
        Fri, 18 Feb 2022 01:11:53 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id s9sm4038660pjk.1.2022.02.18.01.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 01:11:52 -0800 (PST)
Date:   Fri, 18 Feb 2022 18:11:46 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] counter: Stop using dev_get_drvdata() to get the counter
 device
Message-ID: <Yg9i0lvLAurmp3M+@shinobu>
References: <YfzPcyusGwAOkys6@shinobu>
 <20220204082556.370348-1-u.kleine-koenig@pengutronix.de>
 <YgHKekl9rJ2jH5j4@shinobu>
 <b9099ac3-a5fa-1aba-92a3-05a7212525ab@linux.intel.com>
 <20220217160308.oo3fmghapnvmummz@pengutronix.de>
 <Yg7de1ZlUJoNGYNa@shinobu>
 <20220218074751.3xjsxwy7s63jshwv@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RXQcv7FYYhz4E3ZR"
Content-Disposition: inline
In-Reply-To: <20220218074751.3xjsxwy7s63jshwv@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RXQcv7FYYhz4E3ZR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 18, 2022 at 08:47:51AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Fri, Feb 18, 2022 at 08:42:51AM +0900, William Breathitt Gray wrote:
> > On Thu, Feb 17, 2022 at 05:03:08PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Thu, Feb 17, 2022 at 04:48:50PM +0200, Jarkko Nikula wrote:
> > > > On 2/8/22 03:42, William Breathitt Gray wrote:
> > > > > On Fri, Feb 04, 2022 at 09:25:56AM +0100, Uwe Kleine-K=C3=B6nig w=
rote:
> > > > > > dev_get_drvdata() returns NULL since commit b56346ddbd82 ("coun=
ter: Use
> > > > > > container_of instead of drvdata to track counter_device") which=
 wrongly
> > > > > > claimed there were no users of drvdata. Convert to container_of=
() to
> > > > > > fix a null pointer dereference.
> > > > > >=20
> > > > > > Reported-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > > > > Fixes: b56346ddbd82 ("counter: Use container_of instead of drvd=
ata to track counter_device")
> > > > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutron=
ix.de>
> > > > >=20
> > > > > I'll pick this up and apply it to my tree.
> > > >
> > > > Perhaps late but I hit this same issue, patch here fixes it and I w=
anted to
> > > > confirm it.
> > > >=20
> > > > Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > >=20
> > > I wonder if this patch is scheduled for 5.17. Currently it's not even=
 in
> > > next ... :-\
> >=20
> > I've got it in my tree. I'm sending a pull request for the Counter
> > patches for 5.17 next week, so they should all be merged after that.
>=20
> That's good. Still I think you could make live easier for your users to
> find fixes if your tree was included in next. And in MAINTAINERS.
>=20
> Best regards
> Uwe

That's a fair point, I'll update MAINTAINERS and set up my fixes branch
for inclusion in linux-next.

Incidentally, it looks like this is the only fix I have merged; I'll
submit it now by itself so we don't have to wait until next week.

Thanks,

William Breathitt Gray

--RXQcv7FYYhz4E3ZR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmIPYsUACgkQhvpINdm7
VJJCMQ//Wdh681Ssq3mGlMHywQtFBbf0m1/a5uYyzOjnvlCKcAGWyYnwGuFh195T
GSVHd+k8KszChljN2lSr2EQ6010sTslEt6eeg77KkglYZGJYzmHw4IO8oFvGCWtT
4AbGpEoL/NzXzhx4Gog5Xqui6bM6amoElVi4usUn5rk+n4Fdy3qA0UWM9nqotAn3
/nSYSxTllY5L3ysSseVsmFS7xJwYuKFz0j3SUBMs0rsZo2NKWoQrRFdEslQGADql
DvX5umL21rticnD0HJpasqeXT156/tdjmw/r7THcwo84fgHEuxyGZOfNrOyDYuJU
3irJENsE5fPJMstm3UozR2ePtAtya44zRQtGpogMxgqmEcd/fd8kdBB0lrm9ekwn
JELHRFgshNQuHdBm4R4whQglvTgJNt8RtrU8zsaDFxw4PlPIwvxOlJg0FLstYZ6b
putyrukmCmu+Gd+cybYyZkSKGcghBSCrgmJTTMLFk9VVahou+tC4kTDt5Z797f1G
kXX/cpbyVOMBZ/OOXmhEAdzZgnXr2PrlDIuAQG9KIvUcOuU39k58C9OVwCjgBSMd
VtSNEF5ZClbpi+MQUBOQXW6BkVWpwAh5DBAZNJOL9mpqJnX8Pbg9tBBEgsXnvmcF
8WW9cyuzOaz0DLXLIlvdOyNdoMs6QuAmNYSiDRUwkATiZa1qnzk=
=7/fD
-----END PGP SIGNATURE-----

--RXQcv7FYYhz4E3ZR--
