Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66748552D37
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 10:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347700AbiFUIjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 04:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiFUIjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:39:53 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E7925EA1;
        Tue, 21 Jun 2022 01:39:53 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z19so1515080edb.11;
        Tue, 21 Jun 2022 01:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u7YnhhQYtJ0M3xC7HRSVT7bml8DDqb3tmwKspbCUexU=;
        b=eUtaQ659iBtSbi6vx63Og3HtODbQYAQNj9VhsS1EgSNPlkbhr3W2Smwq8h15cEzVSG
         AU5o3Zziy2/7i+ADUyCHgY9NACZI/PP/iRX77JwlroSG52F7gaEofiDYzobfPorXQZds
         GnpxTc6zz3co2reobFDW2tKMoR0uMm8n8/kgHPmZ9PvR/+dsSAuVx8IonB4s34v8G0sr
         qJSpx6voJhP1DXSV50ZhODltR4I1Txx38t5S010s+9bhgs1xxG5x//GZqlf8Tg8YtAp1
         ljaBdGWGL5GZHBxo2lOjZVaUgtiLF9+hbbExtMPb+ATTNKwVPFUBQKLgFd05vMGwr0LX
         OoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u7YnhhQYtJ0M3xC7HRSVT7bml8DDqb3tmwKspbCUexU=;
        b=dl0/C8nLz4BsiETwpFyTUmHMyVKa51fXt5Wi/WDfvkC+MmyrmiyQiZBOPV0iS6SPhs
         Iem02dS3/5RLR7UR6Hpw3oyux0xAQko4UV9afU1WU0vE+SysEcT68xFjlOJ2jfRnaYYI
         kVgaAZf4nKsOQjGZG9QWNq5wBVVCW+APgN6TmFppnX6Buy+z1cwr2fxYnTBH0Vv8mt5+
         bNYCi3a/7cq+9XTzPX0j/aOSsZvRADduOfhGrklhT4+S0ioMSu59dT7whzQ3Ph40jnIb
         U/m0YKvOh7VBOfWfPJ26+IH5jt5vxIWbKPh4ErqVD5f07MTkjmc0+OXede/Lp+648yLz
         aHvw==
X-Gm-Message-State: AJIora+qb2xSPkPD390CfHk8b6pCF3wzAGtz4EUjg0iaadj7aFnVDavb
        qlRJwHjvvno18q7Z0DuvW8JOoHzTUcVwEMptqBNTyp2hCnRdTg==
X-Google-Smtp-Source: AGRyM1u036K32l8dIMmb+DtsESrvBm19v/53EQEeKlkfk4W9ujWKMBWfDMHU0NzTObCZaXkVciq+YiTxlEluNjfpGbc=
X-Received: by 2002:a05:6402:2790:b0:431:4bb6:a6dc with SMTP id
 b16-20020a056402279000b004314bb6a6dcmr34533918ede.48.1655800791735; Tue, 21
 Jun 2022 01:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220621070224.1231039-1-zhangshida@kylinos.cn> <20220621073943.GQ227878@dread.disaster.area>
In-Reply-To: <20220621073943.GQ227878@dread.disaster.area>
From:   Stephen Zhang <starzhangzsd@gmail.com>
Date:   Tue, 21 Jun 2022 16:39:15 +0800
Message-ID: <CANubcdVW8cje_3MEAZsWN8TFKMO8kTe8VuNFAxsBxTh7haV8vg@mail.gmail.com>
Subject: Re: [PATCH v2] xfs: add check before calling xfs_mod_fdblocks
To:     Dave Chinner <david@fromorbit.com>
Cc:     djwong@kernel.org, dchinner@redhat.com,
        zhangshida <zhangshida@kylinos.cn>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org
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

Dave Chinner <david@fromorbit.com> =E4=BA=8E2022=E5=B9=B46=E6=9C=8821=E6=97=
=A5=E5=91=A8=E4=BA=8C 15:39=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jun 21, 2022 at 03:02:24PM +0800, Shida Zhang wrote:
> > Checks are missing when delta equals 0 in __xfs_ag_resv_free() and
> > __xfs_ag_resv_init().
>
> This describes what the patch does, not the problem being solved is.
>
> i.e. This doesn't tell the reader why the delta can be zero in these
> places, nor does it tell them what the impact of it being zero is.
> We can't use this information to identify a system that is having
> problems due to this issue because they havent' been described.
>
> Hence when I ask for more detail about how something occurs, what I'm
> asking for is a description of the how the problem was found, what
> the impact of the problem has on systems, how the problem is
> reproduced, etc.
>
> Something led you to finding this problem - tell us the story so we
> also know what you know and so can understand why the change needs
> to be made. A good commit description tells the reader everything
> you know about the problem that needs to be fixed, the code change
> itself will then describe how the problem was fixed...
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com

Thanks for your suggestion. I will try to rephrase the description.

Cheers,

Stephen.
