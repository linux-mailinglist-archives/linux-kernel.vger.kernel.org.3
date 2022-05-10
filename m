Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3015A52259D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 22:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiEJUmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 16:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiEJUmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 16:42:12 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994E0532D0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 13:42:09 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id w123so407805oiw.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 13:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VIAQOazJPjJfrZdIk0eSxwF2xbtTrMY68Mwjij7d8gE=;
        b=WCBx2+IfqAmZC8sXmKqzLtNc8sHWu8odkNtBLzkoy3C8snxpSkQIsZ5EaT/JcbeW1I
         FpzmywcEv1N9JRw3dvg2+UuJ4xV+7lQQ0JIaIYxyikEWF6w00JzdeN+kdA4G3t/oLd3j
         7Gb11tLiEjhmT4XNI0DlsXRpz0g4De9qK8I1prbAHKcPD9eCnIn71VWnRY7BXX8LELRw
         ZVns+2/DAi4ZnhuYldcbuf/2foYJ9wKJqOAlZXWt2VoUqNuAHcdVrSSi9cLx9W3ovx6O
         /NiurRgWVIk1qXf81GsW296h7fzNIkmi8+vMcuMIKreliJjY4lUp6lxRG+zUrlRSSany
         2QVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VIAQOazJPjJfrZdIk0eSxwF2xbtTrMY68Mwjij7d8gE=;
        b=QmgCxjnz1/q38ASHss6DD5UYT/c4Ug5vEalCL7tTUTmu/GHUJcqNjnvuWS5RQhnRKN
         wLjqkId2gEtT0I/DrA2Xb+hayfVu3bjVZDM+JrPi3SUawfHUgOaybBs2/yV7uZ3QqA3h
         vqDwsft3l+qgFMEEB0PMcZwmMYhpJCz1wDcjKQfiA1kWASk03jGokXYRfa2cjrrcR4zG
         5S+N4t1RPkMyc0GkmpyfprmlJ4FZVBp7jaTyhlifCfLAaF5zGXWtLIZ0WSPPE/dDTbvR
         luZv13eANe5cd1qA5a3W8ILQUEU+lUZHcHvL4BKoHB19jbj97h1JNi+7JqaF9C4XqW47
         IR1w==
X-Gm-Message-State: AOAM531ptdgZw3P0ZFFWOONOrAglteKn1JCMB40HN62hhlibTTZDfqZ2
        4bjqFuatg5a1SdYogsV092k5vuFoCdEQja0LIk4=
X-Google-Smtp-Source: ABdhPJyiYvR8gCRPu/xnvVY/i7Ko/yIUH9sG0FYEQoYT5AaJrawyX4S+NkTMMg/TFQj6Z7EX1WGqeksfxdGAvinnHOU=
X-Received: by 2002:a05:6808:f8e:b0:328:a601:a425 with SMTP id
 o14-20020a0568080f8e00b00328a601a425mr963626oiw.253.1652215328989; Tue, 10
 May 2022 13:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <YnTAc96Uv0CXcGhD@suse.de> <CADnq5_NT3UtawpGuPDwF+dgmRdaoysb7sD_-oWWBC=T3BoUH7Q@mail.gmail.com>
 <YnpIjdTT3esZ72Bf@suse.de> <CADnq5_NYVvjcUru9hfbnATfcHJR5+eiK9bJAA9m41WKa=OJsog@mail.gmail.com>
 <505081FC-4323-4424-87A9-89B95A89515D@suse.de>
In-Reply-To: <505081FC-4323-4424-87A9-89B95A89515D@suse.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 May 2022 16:41:57 -0400
Message-ID: <CADnq5_PoWLHydAGqHXKNwBnnc_Uz7xc01Mmp2ri-h+RtnRqgfQ@mail.gmail.com>
Subject: Re: [BUG] Warning and NULL-ptr dereference in amdgpu driver with 5.18
To:     =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <jroedel@suse.de>
Cc:     "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Tue, May 10, 2022 at 2:17 PM J=C3=B6rg R=C3=B6del <jroedel@suse.de> wrot=
e:
>
>
> > Am 10.05.2022 um 17:31 schrieb Alex Deucher <alexdeucher@gmail.com>:
> >
> > On Tue, May 10, 2022 at 7:12 AM J=C3=B6rg R=C3=B6del <jroedel@suse.de> =
wrote:
> >>
> >> Gentle ping. This is a 5.18 regression and I also see it with
> >> 5.18-rc6. Please let me know if you need anything else to debug.
> >>
> >
> > Are you doing anything special when it happens?  I.e., does it happen
> > when the monitor is coming out of DPMS or something like that?
> >
>
> Yes, it usually happens when I return to the machine and press some butto=
n on the keyboard to get the screens enabled again. It doesn=E2=80=99t happ=
en always, it seems to depend on how slow the monitors come out of power sa=
ving mode.
>

Does setting amdgpu.runpm=3D0 on the kernel command line in grub help?
If so, that should fixed with:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Df95af4a9236695caed24fe6401256bb974e8f2a7

Alex


> Regards,
>
> J=C3=B6rg R=C3=B6del
> jroedel@suse.de
>
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5
> 90409 N=C3=BCrnberg
> Germany
>
> (HRB 36809, AG N=C3=BCrnberg)
> Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev
