Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A22E4F8597
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345956AbiDGRLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiDGRLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:11:20 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2241CABED
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:09:19 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id kw18so6150011pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 10:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+Cg1pUySQC4X4kBYk+LJTlgqyGdH2p2daDW19hb2yNA=;
        b=WOsUq3SlF033ixeQW0PYz1silnSsmCb4wzQqxZHnZOCDj2RxPdRr+wEWvW2TRnvdYc
         +Tdf0RWYgStx77KCZOTyjia4y2D4SrbYXy0H5/rS1hfnTudlxD9WP+yMWGRnMAHhQz5H
         k+COor9aKkFhtNrr2zuCpGP/vejeRd0y4NuHJoz/ApsEwjmr5vY7gN62t/UtRBemCI/d
         RvVvuydMRJc6XoRkrBCTizHXSLDqv4Cg1lo5iJy+Z8vjRVZo/pPl/Wlx9kMiDGww9QL5
         +vbbank+1QmSmmTm2E6+j9UvoCJ0DN7/EYC0L3xEDS/BceQwTcUlN6PH9vKhYxvZgwA7
         gJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Cg1pUySQC4X4kBYk+LJTlgqyGdH2p2daDW19hb2yNA=;
        b=y3kGDZgdFmE2zd4gLgrVzIfGYfI/3cub72oY+D+PhDzHy/+xmEhNb/wJRiQqj9p52b
         1T42dsqVb445rrR+wKw24Bd/PPhgx3UVwXj1LRIvrnwnivUBoefKFdAELZvJLe9ygdDC
         xao2tXQCpOvjf4gg1uNZy1D5Kb7A5oYVVmBqPJE9dlwUlMEM9mcBYAs5Jl00lkx6S4d1
         kDBCo3ld6ll6/mR0xDX7Olkd0LyURMQJ06fNrO4wZGCNS+jN8EUsN8F33jmOzjFoYM17
         sk5ngcfV2e+nQxPGuxjr1rOL0Z198GaAU+yY0VzcGa3klZzFX5uDA9XqQILL+3TUSeqD
         kqeQ==
X-Gm-Message-State: AOAM533lfZewp/wp7vbxnQ0f51Mg1zq6VYZd33sMVRoF7JLkck5mRohM
        UkFgSWuGqBNpN5uP43h2KgAAKg==
X-Google-Smtp-Source: ABdhPJzFbbZRjQ4KAGqhfkp0QX1gl/REeFotcLI2QoTCFdL4TuVkM/xDjQzjLLGesBR91Cxx39cPVg==
X-Received: by 2002:a17:90b:124c:b0:1bc:369b:7db5 with SMTP id gx12-20020a17090b124c00b001bc369b7db5mr16823881pjb.179.1649351358878;
        Thu, 07 Apr 2022 10:09:18 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:3a11:864:6d11:d714])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b004e15d39f15fsm23672403pfh.83.2022.04.07.10.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 10:09:17 -0700 (PDT)
Date:   Thu, 7 Apr 2022 10:09:10 -0700
From:   Benson Leung <bleung@google.com>
To:     Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     Guenter Roeck <groeck@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chrome-platform@lists.linux.dev,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Check for EC driver
Message-ID: <Yk8atphiUdlU0gPO@google.com>
References: <20220404041101.6276-1-akihiko.odaki@gmail.com>
 <Yk4DGZfpYbK8dofL@chromium.org>
 <CABXOdTcY3w56hc7kWsDLxKU-c6fCLYt_jigK13tKjjm9OHi2+w@mail.gmail.com>
 <033c1ec4-4bee-a689-140c-9694dfee435b@gmail.com>
 <CABXOdTet5ynSXf94qMimobJF4LLzHc89cVbwJ5NuAz8G6jmVdQ@mail.gmail.com>
 <0fdba110-8743-3b2d-cb30-3a89b7cfa592@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="viQeAp1xsC0BfER1"
Content-Disposition: inline
In-Reply-To: <0fdba110-8743-3b2d-cb30-3a89b7cfa592@gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--viQeAp1xsC0BfER1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Akihiko,

On Fri, Apr 08, 2022 at 02:03:52AM +0900, Akihiko Odaki wrote:
> If I read the code correctly, the registration itself happens synchronous=
ly
> and platform_device_register_data() always returns a non-NULL value unless
> it returns -ENOMEM. The driver, however, can be asynchronously bound and
> dev_get_drvdata(&typec->ec->ec->dev) can return NULL as the consequence. =
It
> would have a call trace like the following when scheduling asynchronous
> driver binding:
> platform_device_register_data()
> platform_device_register_resndata()
> platform_device_register_full()
> -  This always creates and returns platform_device.
> platform_device_add()
> - This adds the created platform_device.
> device_add()
> bus_probe_device()
> device_initial_probe()
> __device_attach()
> - This schedules asynchronous probing.
>=20
> typec->ec->ec should be pointing to the correct platform_device as the
> patched driver works without Oops on my computer. It is not NULL at least.

Can you provide more information about your test computer in this case?

Is it a Chromebook running stock firmware (if so, please let us know which
model, and which firmware version it is running).
In the past, we've also gotten some reports from people running MrChromebox
custom firmware on older Chromebooks which have exposed other bugs in
this driver.

Let us know if that's the case here, and where we can get that firmware.

Thanks,
Benson

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--viQeAp1xsC0BfER1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYk8atgAKCRBzbaomhzOw
wmvhAQC0z35R8BEqy4d5pAQ7va0d1etqr1514DiP+ue65mnFZQEAvqbl4NnrC8Hb
OmwQDepne2orty0TN9Oc7qQwZyc2vQY=
=Rr0T
-----END PGP SIGNATURE-----

--viQeAp1xsC0BfER1--
