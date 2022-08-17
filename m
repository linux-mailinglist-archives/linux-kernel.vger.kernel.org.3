Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB5259765D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 21:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241463AbiHQTVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 15:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240878AbiHQTVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:21:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D0DA3D7D;
        Wed, 17 Aug 2022 12:21:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B26861449;
        Wed, 17 Aug 2022 19:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC12C433D6;
        Wed, 17 Aug 2022 19:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660764064;
        bh=bfu/fdYyxsHWCrdmUTDnABii7LLjy3aRYRRlbMf8hWc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U90ttsaKaUkHHdlnC1zVfXiCcM+BcJoiL2ov2ienR9q33S4p7J3q0KR1t1A3Pxlh+
         tNWEX66hlEcZItzsNXWyuRfdNS6KDMYCOLT+m9YhuDEi0cKhw0R1NKFtMJ1yXkC3W0
         dGXCRmrSrtLwy+NV6VQ1DhXEd762X1P4kVuKDkW4=
Date:   Wed, 17 Aug 2022 12:21:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sergei Trofimovich <slyich@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] ia64: fix clock_getre(CLOCK_MONOTONIC) to report ITC
 frequency
Message-Id: <20220817122103.ecbd08bd545385e5bf8e0d72@linux-foundation.org>
In-Reply-To: <20220815054944.4130786-1-slyich@gmail.com>
References: <20220815054944.4130786-1-slyich@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2022 06:49:44 +0100 Sergei Trofimovich <slyich@gmail.com> wr=
ote:

> clock_gettime(CLOCK_MONOTONIC, &tp) is very precise on ia64 as it uses
> ITC (similar to rdtsc on x86). It's not quite a hrtimer as it is a few
> times slower than 1ns. Usually 2-3ns.
>=20
> clock_getres(CLOCK_MONOTONIC, &res) never reflected that fact and
> reported 0.04s precision (1/HZ value).
>=20
> In https://bugs.gentoo.org/596382 gstreamer's test suite failed loudly
> when it noticed precision discrepancy.
>=20
> Before the change:
>=20
>     clock_getres(CLOCK_MONOTONIC, &res) reported 250Hz precision.
>=20
> After the change:
>=20
>     clock_getres(CLOCK_MONOTONIC, &res) reports ITC (400Mhz) precision.
>=20
> The patch is based on matoro's fix. It adds a bit of explanation why we
> need to special-case arch-specific clock_getres().
>=20

It would be best (and nice) to include the original developer's
Signed-off-by: and to Cc =C9meric Maschino if possible?

Could you please take care of these paperwork issues?
