Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754245A66D8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiH3PFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiH3PFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:05:19 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233184621F;
        Tue, 30 Aug 2022 08:05:18 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-11f34610d4aso6545393fac.9;
        Tue, 30 Aug 2022 08:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=ZtKXHdMShbIKHwQgS2O9uskJxpg+Cgx0QazsEIKwx7I=;
        b=K2THW0Pj6e4x8WQgJg8oafyHimnmBvfY8hYx4TFkKA2dKt0RW6NsNAyi8tQqRZpotR
         4uT3QadBGIyiTNy8Yt3pXPdkV/OBEnmFZfrVOBc9H0GGvDixQJTegWAEOXaLb5kanF7m
         xGUVY5sUfjZg1qfzsbRNI30S3hXHOcTLunuImFgSyq50qXR4ry5WSkMv15ERO3pCxULW
         GLKyPentD62B+1z7EwgQYgtA3Hux54rR7mpDsXlapdRCSNmytPMZujOTDK1ad/UckE8s
         XoQWc5jbGjDZX3dWR1YvjHnHSdwluH1O0CJhQWJjAVttcxVmBlK81oXc0gmOntT5pRb4
         eIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=ZtKXHdMShbIKHwQgS2O9uskJxpg+Cgx0QazsEIKwx7I=;
        b=tBzxxl2A2cCHUm5GsaLp8847M1130I4qq/7q+jqdTb+GLCmDOMgz8SPrsKxa692dWB
         XbML0fnGmw/eldzwXaF9aQWLug8Erp8s7a+NIFw+3avs5sxeJwFprKEU3dwMMcdEvD5c
         6FCe84UCb4SXiy0nE51zQdsbBWYVsS8ZL81e7vlPMfnVTkkD+fnD+6oSxArwuSpILWhQ
         WvstGAiLyf2Cf00LboG69jf0eunryYTapQS7HqjLbFcMBrSqc6Y8h6gFW8GnIm1WP20g
         iQztsJbSAiuHwHutzTTwoA2/UqREYdNmUXXnwVENgaWrRnOT0liGuh1ge5XFcymYVT00
         /h2w==
X-Gm-Message-State: ACgBeo1xdFTaOCMYjLTW/6F0r+hGTyBHeq8/C3KAdodDh3XK6NA3YRih
        lbmmMl48t6nyAN3WrEJXMfnjFG/pZBmiCp56RYOsnCs9fIM=
X-Google-Smtp-Source: AA6agR7EuAmTMD57H2d7kPlzhVgp4d1ybgsX+rjWmazrWWx0rOMocoXaSg6g+PEKmS6XGMfczx1ddmLuIvZaVvsRKOk=
X-Received: by 2002:a05:6871:6a1:b0:11c:7c79:6bfb with SMTP id
 l33-20020a05687106a100b0011c7c796bfbmr1659490oao.205.1661871917390; Tue, 30
 Aug 2022 08:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220502160030.131168-8-cgzones@googlemail.com>
 <20220615152623.311223-1-cgzones@googlemail.com> <20220615152623.311223-8-cgzones@googlemail.com>
 <20220626223441.GA30137@mail.hallyn.com>
In-Reply-To: <20220626223441.GA30137@mail.hallyn.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 30 Aug 2022 17:05:06 +0200
Message-ID: <CAJ2a_DepL9pLqu48bsSAZzYjb6TPx6vR-U0puMzD3XjPK64yJg@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] capability: add any wrapper to test for multiple
 caps with exactly one audit message
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 27 Jun 2022 at 00:34, Serge E. Hallyn <serge@hallyn.com> wrote:
>
> On Wed, Jun 15, 2022 at 05:26:23PM +0200, Christian G=C3=B6ttsche wrote:
> > Add the interfaces `capable_any()` and `ns_capable_any()` as an
> > alternative to multiple `capable()`/`ns_capable()` calls, like
> > `capable_any(CAP_SYS_NICE, CAP_SYS_ADMIN)` instead of
> > `capable(CAP_SYS_NICE) || capable(CAP_SYS_ADMIN)`.
> >
> > `capable_any()`/`ns_capable_any()` will in particular generate exactly
> > one audit message, either for the left most capability in effect or, if
> > the task has none, the first one.
> >
> > This is especially helpful with regard to SELinux, where each audit
> > message about a not allowed capability will create an AVC denial.
> > Using this function with the least invasive capability as left most
> > argument (e.g. CAP_SYS_NICE before CAP_SYS_ADMIN) enables policy writer=
s
> > to only allow the least invasive one and SELinux domains pass this chec=
k
> > with only capability:sys_nice or capability:sys_admin allowed without
> > any AVC denial message.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
>

Kindly ping.

So far patch 3 was reviewed [1] and patch 4 was reviewed [2,3] and
partially acked [4].

Currently this series trivially rebases on top of 6.0-rc1.
Should I send a rebased v4 or what is the best way to move forward?

[1]: https://lore.kernel.org/all/7fd6f544-0bd2-62fe-bddd-869364f351e8@acm.o=
rg/
[2]: https://lore.kernel.org/all/Yqn+sCXTHeTH5v+R@pendragon.ideasonboard.co=
m/
[3]: https://lore.kernel.org/all/09374557-8c8d-1925-340c-784f29630ec5@kerne=
l.org/
[4]: https://lore.kernel.org/all/73a603a2-5e5e-1b45-8e19-ab0795027336@xs4al=
l.nl/
