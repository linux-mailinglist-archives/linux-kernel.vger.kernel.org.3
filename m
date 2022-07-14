Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C6857541E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 19:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbiGNRhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 13:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiGNRhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 13:37:51 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D79C5F10C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 10:37:50 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t3so3400016edd.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 10:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aQIp8jUeV/XH0MZXLU4tEbIH8uIqKDByVIHXKyZP/oM=;
        b=S1lYzRFvIdrkIuaNzMc/xioVsE7X9wBzpEVTIMQkFWfupjKZ6kNWPumY0Ye9sveMsW
         oaCERdVafUZh+op/+O3O+X8ETitsx6/PVxlxnnZMBOKafMqdulWvuXUMSfos9vvYhfbm
         3m/NkR3E706fZqsm4Ku3yk2exNh6VL2kASg58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aQIp8jUeV/XH0MZXLU4tEbIH8uIqKDByVIHXKyZP/oM=;
        b=tpq6DRqfW+Ip4Pqlk0/+POQkfVa+KBVFMwcRUUQuNG07oY9WmZovhCwO3w4dFzpFbk
         OU3KEulEieioBtbZ2YDH+C+lFCooi4g1SShVjtrfmlwMm69daR58guwCQYHU6/LZIMy9
         i6ifBmoRfytbtC9o/A4bE9o9LaRpQMfBXp7RZWwvPVddOEmtWeOBQFs8n9VkDJP3C9Ps
         Gz5wvKYyWfEiCKgJV3cTglfLrKUBU/6jZZ4OcMo2UMtuPgzlVrfmtoD9vm4AkQE1aWsb
         /Lg2shjtsud6qN23QDIuAwLtMndzPiYoJTURpUDZ4uTTrJ1cUSS/CFJilU4SIHbFfmHa
         Q0EQ==
X-Gm-Message-State: AJIora9PZDl782Kgl6OoOWL9/IVKK6HEUzEm1b58w8d0FmLwPvEPXx/o
        o0Y0QfGhCEO/PaswMN7cszhArsek80FWCpxzSqk=
X-Google-Smtp-Source: AGRyM1tcLKKruwAt0ApL/nqEPBDVX8GXIfUanfgaUt9QCXcMJfZ2Gx9c3Lb+CFZcoWGDO8ZLbQqzGw==
X-Received: by 2002:a05:6402:795:b0:43a:6cc5:8886 with SMTP id d21-20020a056402079500b0043a6cc58886mr13802856edy.174.1657820268830;
        Thu, 14 Jul 2022 10:37:48 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id lb22-20020a170907785600b0072b3464c043sm931197ejc.116.2022.07.14.10.37.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 10:37:48 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id bk26so3491705wrb.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 10:37:47 -0700 (PDT)
X-Received: by 2002:a05:6000:180f:b0:21d:68f8:c4ac with SMTP id
 m15-20020a056000180f00b0021d68f8c4acmr9553345wrh.193.1657820267054; Thu, 14
 Jul 2022 10:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net> <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net> <CADnq5_O6Tp2QPXyDCvpWuRXhDr6H1PM50Ow5YG2WeukqUd-GnQ@mail.gmail.com>
 <CAHk-=wj4+BSj2SPMRUr-TZ4Qg2o9HGOBWiJQE336YcF_U1sVNQ@mail.gmail.com>
 <CAMuHMdV9Pj9V-ZPpu=BMSkPt1uA_eCvU4+bxF8ZfHjteRk2CAg@mail.gmail.com>
 <CAHk-=wgnmaTVigBc02tjqgcZaNJiYz8Xw77P+ERAXhcYjkwd=Q@mail.gmail.com> <6d5ac61b-b490-4f9d-6521-a4b7477d6fd2@roeck-us.net>
In-Reply-To: <6d5ac61b-b490-4f9d-6521-a4b7477d6fd2@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Jul 2022 10:37:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh0o1-6f1skMbSh07JR+BxxZenS4ZdWuFipR-0w_Hj6Nw@mail.gmail.com>
Message-ID: <CAHk-=wh0o1-6f1skMbSh07JR+BxxZenS4ZdWuFipR-0w_Hj6Nw@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Alex Deucher <alexdeucher@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 10:24 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> We can't use virt_to_phys() and phys_to_virt() because they are defined for
> the underlying architecture. Would uml_to_phys() and uml_to_virt() be
> acceptable ? If so, I'll submit a patch.

Sure, that would be good, and make th uml helpers clearly be in the
uml namespace.

Another more traditional approach is to use underscored versions, but
exactly because that's the normal thing, things like that may then
clash with the "native architecture" version, so for uml using an
explicit uml namespace might be the better option.

               Linus
