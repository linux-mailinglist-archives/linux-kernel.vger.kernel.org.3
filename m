Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F6F4ECDE0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 22:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350947AbiC3UWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 16:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiC3UWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 16:22:08 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0E8120B1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 13:20:23 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id o13so18352794pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 13:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7GYno+krC6IOtpVdASJomU37rNZvhE4iCAsR7KxbR9U=;
        b=B/yuDQO8XMbWqdbzv+ApRG3fQ939NoSmM33lNvOTQTKTORmb+6GX7HpIDEvYC9SJJB
         lHrcsCnXa4Lh3figKm47sRC8TRsT+4nIGF2jHOMuL52cxPiRHc17z1OFbTIP4BVBbcLp
         fPnDNzAv52s0l8MOkl5hudqtB4AnI+KMHo3DSfFR8RV4Dbp28nQE3KzAi59ZLt2Zs0Iy
         xv1ztsWchDwAxMxmhCCgWvP9Oq6nMv18nhDU+tb+6TMu23osQ0k1lpnLRqBsPrwT7Vwu
         3GCfNJVyO4R0T5jOXBUuIsF38CjBSGyosM42Ip1XHTb0GRYQpciEDG8cXN7vCTfm53/p
         L9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7GYno+krC6IOtpVdASJomU37rNZvhE4iCAsR7KxbR9U=;
        b=wn4UQJShm2kHtjI7BKxdD0nkVh9aaaLQlB5/uOFSrY3nb6HOVjgkt8ywCYF6BFOZKk
         RtUXJevuBJt+za71JWUbs2x0UGMsnUIuBVNwHusNDes5PRb5k5xqjdS75mNN+UjwXxrN
         omieGUt78AX/rhWVZw56Bks666VCbzwh2pMWGQbQvYLaaR4vfnD4c272zAsCO+0+4o/r
         oV+CriaFilurZiHEuXHkVc23eLqBhgcEkEko9gdAqyYCEpLc+bjjc1z8DlFvVD9ftU0B
         y3C8xoumOLT5/0zovRaO7xy+jYhp3eMbWfefqaCQ+OJg5iuaRBbg9y44NcPt0ZPXM1un
         IHuw==
X-Gm-Message-State: AOAM533AR7axXZPDRUolr4hKGFwrhPML6oseDiItZcHcaisYKKR8yt4H
        I1kXViNJ75g2vnjBmfddTM3f03MWGrMk/g==
X-Google-Smtp-Source: ABdhPJwR/7XatlrrWh9KJayLzX/JjV7W/Sptl5FnGqgLoBl1kkmX4PWiDeC3iRPVlqDoXmg/6VablQ==
X-Received: by 2002:a63:194e:0:b0:372:c757:c569 with SMTP id 14-20020a63194e000000b00372c757c569mr7642527pgz.516.1648671622351;
        Wed, 30 Mar 2022 13:20:22 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:b186:b6:fb89:818c])
        by smtp.gmail.com with ESMTPSA id e10-20020a17090a280a00b001c9ec7a7f5asm3959402pjd.49.2022.03.30.13.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 13:20:20 -0700 (PDT)
Date:   Wed, 30 Mar 2022 13:20:14 -0700
From:   Benson Leung <bleung@google.com>
To:     Won Chung <wonchung@google.com>
Cc:     Prashant Malani <pmalani@chromium.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] misc/mei: Add NULL check to component match callback
 functions
Message-ID: <YkS7fiItcIBH18C4@google.com>
References: <20220330175850.2030509-1-wonchung@google.com>
 <CAFivqmLqDXWDyEiYMXvkjQTif9jjqau5nE9YtpYyy=F-PybvDg@mail.gmail.com>
 <CAOvb9yimjRJiX-RD8L_BUdpSWeZ+a76do=f-1-NDXC2Q2VjQ6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GHrXQ45rgVODPjoz"
Content-Disposition: inline
In-Reply-To: <CAOvb9yimjRJiX-RD8L_BUdpSWeZ+a76do=f-1-NDXC2Q2VjQ6g@mail.gmail.com>
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


--GHrXQ45rgVODPjoz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Won,

On Wed, Mar 30, 2022 at 11:43:33AM -0700, Won Chung wrote:
> On Wed, Mar 30, 2022 at 11:18 AM Prashant Malani <pmalani@google.com> wro=
te:
> >
> > Hi Won,
> >
> > On Wed, 30 Mar 2022 at 10:58, Won Chung <wonchung@google.com> wrote:
> >>
> >> Component match callback functions need to check if expected data is
> >> passed to them. Without this check, it can cause a NULL pointer
> >> dereference when another driver registers a component before i915
> >> drivers have their component master fully bind.
> >>
> > IMO this should have a "Fixes"  tag, and be picked back to stable branc=
hes.
> > Also, please use my chromium.org account (pmalani@chromium.org) for ups=
tream communications.
> >
> > Thanks!
>=20
> Hi Prashant,
>=20
> This currently does not fix a patch in the upstream, but is for a
> future patch of adding component_add to usb4_port. Would we need the
> "Fixes" tag for a future patch too?

I believe it is considered a fix to an original patch. Won, you should go
back through git blame of this file to see which original commit originally
added the component match callback in this and the other files.


> Thinking again, I think it might be a better idea to have this as a
> series of patches along with the patch to be sent after this one.
>=20

I think these are focused enough that you don't need to send them in series.

> I changed the recipient email to send this to your chromium.org
> account. Sorry for that.
>=20
> Thanks,
> Won

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

--GHrXQ45rgVODPjoz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYkS7fQAKCRBzbaomhzOw
wvMgAP9l7ZFw1Hj6Mlthn3iGa6RqN0HG1Ll8Mgs65Al5eaJmKQEA59+1Rd34bTsG
PJ8CK8Vgy69vW+jTzLGY9iIKhVIP5QM=
=p7Li
-----END PGP SIGNATURE-----

--GHrXQ45rgVODPjoz--
