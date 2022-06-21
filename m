Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695EB552B76
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346583AbiFUHFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346495AbiFUHE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:04:58 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2063921812;
        Tue, 21 Jun 2022 00:04:58 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id es26so16342368edb.4;
        Tue, 21 Jun 2022 00:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0B3xaLPQDTY5CWdU4uuAJuk+lCuTNpKsZkpyLv+wZNk=;
        b=FkU5Z/5OwQTqLKI9hQ1umabBxiIBi+vrW8tWIvuS7GOONQH1byKgQ2/KWlgrn76E54
         Sp7mr57ca9YY6F1RW/r1olrbyiceopLmFgAMW2GZz6ff5nTxJwpYmw1AGjjs6UEeX0tA
         A3vG5vM/qNWiitU82KORJ/xTaRgtofVmpm+PM10gQcLUn1931APC9OnHMpj9lAnkEgww
         oLVRMdh1NiStyET0pLeLwz830sKJNcL5stopZdfBeF5OYwrR+rLNBYANY/xs11uJtZoM
         2GO9bmyZiakyjIxade2/Z1mUoIuwbfIVcq8mpbl1qpCg0WK2vTRx/ACuPC/ZteOlHkYZ
         4cqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0B3xaLPQDTY5CWdU4uuAJuk+lCuTNpKsZkpyLv+wZNk=;
        b=AMJVbJfJZz3o4WeJvq1I/uKiO1yWZxInM7mNT+g+tvnClqxZHJzLmHdNix7xgYCGEk
         qyOTbYi7I/G/sIYe0u2mzfjsDONul3jNBU3zM0p6mf8muZ+GTVrgtsFI961Q4KAwRoEt
         aK6oUVbdKKX6X/UazKxztV3w6rXLgMiPhaydYegjR0zyELYE67W4H8XCRb2EKEhIP3zd
         l1fWoFWDF/n2G0IOtucrBt2woYBJ2lQqaEaHCRuTk3NXNoReJA0uIlagnpSFGupabLp6
         /AwHQ2gVv67lp+QEAayTbWago/Lm/fm9UzbXKS6urAT2cSQPtlj0A7deHtPKTi/ENjIH
         AFrg==
X-Gm-Message-State: AJIora/IM/amx4YES1as4i00XvS/pgmoKyq59Y8ThIJ0f84uiVvd54nZ
        JgFibansYwI73uW1Om/+GMUyJb6nl893/wgxkCo=
X-Google-Smtp-Source: AGRyM1vk/fsk1xLwAiSdWUdI76LBwT9uqXC401BJldWVyTDbv2mVv+Ljf8Qlj9VQINAmNiUmrcUKC3/DfFSHrVtQ1KU=
X-Received: by 2002:a05:6402:5212:b0:42e:2fa:41a7 with SMTP id
 s18-20020a056402521200b0042e02fa41a7mr33591154edd.22.1655795096619; Tue, 21
 Jun 2022 00:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220621031113.1222877-1-zhangshida@kylinos.cn> <20220621043550.GP227878@dread.disaster.area>
In-Reply-To: <20220621043550.GP227878@dread.disaster.area>
From:   Stephen Zhang <starzhangzsd@gmail.com>
Date:   Tue, 21 Jun 2022 15:04:20 +0800
Message-ID: <CANubcdUO55kSFc7USg-EsgE5uvQR08s8wcxrf4=vHk8VOiisjw@mail.gmail.com>
Subject: Re: [PATCH] xfs: return when delta equals 0 in xfs_mod_freecounter
To:     Dave Chinner <david@fromorbit.com>
Cc:     djwong@kernel.org, zhangshida <zhangshida@kylinos.cn>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
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
=A5=E5=91=A8=E4=BA=8C 12:35=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jun 21, 2022 at 11:11:13AM +0800, Shida Zhang wrote:
> > There are cases that xfs_mod_freecounter() will get called when delta
> > equals 0 while it's unnecessary.
>
> AFAICT all of the call paths are guarded by checks to ensure the
> delta is, in fact, not zero. i.e. if the delta is zero, we shouldn't
> be calling xfs_mod_fdblocks() or xfs_mod_frextents() at all.
>
> Can you explain in more detail what code path leads to delta =3D 0
> here?
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com

Yeah. I will give it in another v2 version patch.

Cheers,

Stephen.
