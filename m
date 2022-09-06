Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFC95ADD3D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 04:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbiIFCVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 22:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiIFCVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 22:21:17 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C54321828
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 19:21:16 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id v4so9351099pgi.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 19:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=/vAljfHVQKdDbVhAfIrYOWlHcfdpbbyTa3VRahPWfYI=;
        b=O534L2W272BxM0WSHH7xszDUnnM5xK4dX03HeHuoLgKr150AVhpf66fgsMEUZjQfNP
         tpnfdNXZr7sJ8y3Kth6JswL5u99JAF2fdSMBsnMO5sfcSdxACOZCwzbd4hkzaTy9QHlg
         TekDgr8EDQ85jqHZDYlXnI6baPUmt+P99+qnor2yOJx5+86JdId0fUIzzmtPxUqC8pAN
         7lYnkkW34CfMwcw39DGd5/CIiaDslnZ8tzSvBP11ZWVpGknSoYgE2xW30cCNUPqY7Z+r
         SCzg0Tom91+6ckqCYubi/u7kaZcrgk5umR+OzdwRZxyfe7VNkHTHL4je9Bd6adOULgSS
         xpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/vAljfHVQKdDbVhAfIrYOWlHcfdpbbyTa3VRahPWfYI=;
        b=DxHdLObvdMsjnFNw4PljWFeXp5fH4HD54nGbZRocWxrZlE4ZAj2WWuu/Wjj3oE9kNV
         rUfH/B5xz9BxajGTjMbyWKmS8aLGteeq9EBl1Tn0E3JkVTFE4WKP35arJF7/iAmxcQL6
         MS2BspSCvjIHS9SOP82rqp0Z8fUJN8G5gRIABG5PS0hc4rM/rOrsryniRLi6rNvdHBnK
         9xGR8arBEP0hRyuy4+l0tNxRwrL+2c2WVbDROG4J/nJGW02CHeUS7lL2lvQqReSx0veW
         dp0iBxPF1n+ZpuD96hkJ6uDhUxQabpCuUYhTE0KbGJaoWmFH1AqvoDncr4dgmqUxKvqQ
         oqqg==
X-Gm-Message-State: ACgBeo0c30XD0iMxWdLkLHVbRxCTIeqoodelj5N+G7TC26gWhIQFpfgL
        bGYkFSpIQB6ZLkd0z+2rVmE=
X-Google-Smtp-Source: AA6agR4xwamrVgwrwIQTJpnWfOmv0Rb4f9pW+MVs//kAtusqemNCS2zH+QizXMXLsyaXpzm8PFzCjQ==
X-Received: by 2002:a63:1e12:0:b0:42b:bb36:f898 with SMTP id e18-20020a631e12000000b0042bbb36f898mr37094069pge.469.1662430875629;
        Mon, 05 Sep 2022 19:21:15 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-83.three.co.id. [180.214.233.83])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090322ca00b0016b865ea2ddsm8406737plg.85.2022.09.05.19.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 19:21:15 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id BA9F9103CFD; Tue,  6 Sep 2022 09:21:11 +0700 (WIB)
Date:   Tue, 6 Sep 2022 09:21:11 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Charles Mirabile <cmirabil@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nicolassaenzj@gmail.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, rh-kdlp@googlegroups.com,
        Joel Slebodnick <jslebodn@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Subject: Re: [PATCH v10 0/6] Raspberry Pi Sense HAT driver
Message-ID: <Yxaul73DR7BVT7/C@debian.me>
References: <20220823174158.45579-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0d7ie7tAKFEy7O0I"
Content-Disposition: inline
In-Reply-To: <20220823174158.45579-1-cmirabil@redhat.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0d7ie7tAKFEy7O0I
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 23, 2022 at 01:41:53PM -0400, Charles Mirabile wrote:
> This patch series adds a set of drivers for operating the Sense HAT
> peripheral device. This board is an add on for the Raspberry Pi that is
> designed to connect using the GPIO connector and communicate via I2C.
>=20

Better say "Add a set of drivers for Sense HAT peripheral add-on device
for Raspberry Pi. The device is connected using GPIO connector and
communicate via I2C".

> This is a refactor of the work of Serge Schneider, the author of a
> version of this driver that is currently in the Raspberry Pi downstream
> kernel. We modified his code to make it suitable for upstream Linux.
>=20

s/We modified his code/The driver code is modified/

Also, I see that description of individual patches is written in
descriptive mood. However, it is preferable to write in imperative
instead (see "Describe your changes" in
Documentation/process/submitting-patches.rst). The specific suggested
wordings are in reply to each patch.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--0d7ie7tAKFEy7O0I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYxaujgAKCRD2uYlJVVFO
o/KVAQD5X62mGGJfyokbCip9gU9D0JaVjC8Fv8RYHyhdNzTrGQEAmYIRyFqqj7T3
L4QZk//cVLDCmpu8jgI4FMM3a2XAiwQ=
=/4Ra
-----END PGP SIGNATURE-----

--0d7ie7tAKFEy7O0I--
