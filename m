Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D6759AF8E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbiHTSTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbiHTSSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:18:21 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E06560501;
        Sat, 20 Aug 2022 11:17:55 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so2541240wmk.3;
        Sat, 20 Aug 2022 11:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=Ot/2qCk1sVFCIXa97iihEBRIIxJgd3yuL6Y0NghrcF4=;
        b=PgpB/q4+cqWGQvVc/3bLQXT1DYBI1mGjgRVMq76w3Zz0s7qSP0M/fb8FuTbvU/yIhK
         GlppMMW4FyoCD1NXXsG9upt+WJk4qzz/uIMsIOhzE5J+Z7c7bpW4xI6OoBDOM6908YKi
         A5UntrUx/ybN6rqh/MNUvkIToKOPed0Zpp27IqgWpMCpvRh7UZMeDXl4rLO7PVG12rAl
         yihfNFVF5DfEExy4rlvpCK+/4EaYvwcojQ7HFKGNj+n6cmCRh9EN2WlxX/b3ps+SrQGm
         b8YHuTkWH2/2i1qF/vq0ggd0sJt9592KkhN9DyjeFt6+Ufj7c0K/hdyy/Zd1Ez4NljnB
         fNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Ot/2qCk1sVFCIXa97iihEBRIIxJgd3yuL6Y0NghrcF4=;
        b=jDAbX6cw1loKUvblm8leILAaECdtp3O0bkAbEkbImoQA/533fbBkIWOfjGlPflPS2o
         0teQ/MLnFMh8vHZG/UvGpi0pMg3xXvGyvdqGYZ6X/DW9sV8RfxoMKme3IivHhNtV3Pon
         KFDNp9Az9two9HWMlXGrgBjUmh8agbd0XuSxYKyXz0DN1jgKFzmrMiHFkDXbIZOeRzYs
         0WH8u7ZC5E5bQtBjQDQa0OqdNlKNypI2HhJCSUfjwdxGmPN4kAxxE0vLoAJIHeZOnjBD
         cY8fmsbU3wFHW48okWKfjyW6hj8R4mj1XIPqIgrtpRwun6G8RmhKuGvcZ6KN+Mt3CNli
         Zj0w==
X-Gm-Message-State: ACgBeo3D78idssGZ/qrcpzdNSgRBXWnmcrlxvsFm9aV85IMIppG2bXMV
        2Fz1U6cJwomgSgm0mfF1WY1vQT/CsQA=
X-Google-Smtp-Source: AA6agR7TJi//HnUlSP8y1b7eHUVb87ui0lzTcNbU9TdRx/yaxZOICVWxAi9A46XyKZINRCqWrYg3Fg==
X-Received: by 2002:a05:600c:1c93:b0:3a5:cceb:4d6f with SMTP id k19-20020a05600c1c9300b003a5cceb4d6fmr7979827wms.82.1661019473009;
        Sat, 20 Aug 2022 11:17:53 -0700 (PDT)
Received: from nz (host81-129-83-151.range81-129.btcentralplus.com. [81.129.83.151])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c4e9200b003a6091b3a96sm13830326wmq.23.2022.08.20.11.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 11:17:52 -0700 (PDT)
Date:   Sat, 20 Aug 2022 19:17:51 +0100
From:   Sergei Trofimovich <slyich@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] ia64: fix clock_getre(CLOCK_MONOTONIC) to report ITC
 frequency
Message-ID: <20220820191751.26b125af@nz>
In-Reply-To: <20220817122103.ecbd08bd545385e5bf8e0d72@linux-foundation.org>
References: <20220815054944.4130786-1-slyich@gmail.com>
        <20220817122103.ecbd08bd545385e5bf8e0d72@linux-foundation.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2022 12:21:03 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon, 15 Aug 2022 06:49:44 +0100 Sergei Trofimovich <slyich@gmail.com> =
wrote:
>=20
> > clock_gettime(CLOCK_MONOTONIC, &tp) is very precise on ia64 as it uses
> > ITC (similar to rdtsc on x86). It's not quite a hrtimer as it is a few
> > times slower than 1ns. Usually 2-3ns.
> >=20
> > clock_getres(CLOCK_MONOTONIC, &res) never reflected that fact and
> > reported 0.04s precision (1/HZ value).
> >=20
> > In https://bugs.gentoo.org/596382 gstreamer's test suite failed loudly
> > when it noticed precision discrepancy.
> >=20
> > Before the change:
> >=20
> >     clock_getres(CLOCK_MONOTONIC, &res) reported 250Hz precision.
> >=20
> > After the change:
> >=20
> >     clock_getres(CLOCK_MONOTONIC, &res) reports ITC (400Mhz) precision.
> >=20
> > The patch is based on matoro's fix. It adds a bit of explanation why we
> > need to special-case arch-specific clock_getres().
> >  =20
>=20
> It would be best (and nice) to include the original developer's
> Signed-off-by: and to Cc =C3=89meric Maschino if possible?
>=20
> Could you please take care of these paperwork issues?

Sounds good!

I'll use matoro's nickname as is for S-o-B the way matoro is comfortable
with to share it. Will add =C3=89meric in v2 and send out in a few minutes.

--=20

  Sergei
