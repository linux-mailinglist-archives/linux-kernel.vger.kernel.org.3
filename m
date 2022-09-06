Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BC75AEED3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239740AbiIFP3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239829AbiIFP3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:29:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DB76F266;
        Tue,  6 Sep 2022 07:40:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E46756153A;
        Tue,  6 Sep 2022 14:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577F6C433D6;
        Tue,  6 Sep 2022 14:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662475183;
        bh=UOsnnpLppYPpbsDkpHaDmc77HuAeAd3zvlBZGZ0INGU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P/n+Y8l+zc0C3UizitRrMLWs5qO23ptIUSUhV80HBrxAXj2g4QD6GiZmxOjCMvRpU
         bSLm4F+zDJtr5FgUuRKyGqwME6vBTe2sAZvo6A9jirw1bFIy3HCyUMcnrQIrbAjAdP
         QgZTftu2XalW60j4QlWFPq16UG1Oy3K8J1u7x/a12a044H8ftwoE2qYXCIkLyXSjOy
         yX2TtsA/icfJJJHRvnrPR0PsM2RG+4Tul+Iv/uS3Z41R/VHcYsOfU2rTJ9oDTR9X7t
         r1/lVmM8GXDu0xqy5nbSPJedHdL0Z1Pg5Il1KEhTA66++ImC519xFxyoh5whOR3oHx
         N3YkwJaZCS6Vg==
Received: by mail-vk1-f182.google.com with SMTP id 134so5604857vkz.11;
        Tue, 06 Sep 2022 07:39:43 -0700 (PDT)
X-Gm-Message-State: ACgBeo0kB83la8UPdudfQi5DMr4VBz586m7Y4T7Pbcm2vODocd/L5t4y
        Nl7zg5C7hXX0kkbOjOnWeAhgJMvTZIcTZz2ifw==
X-Google-Smtp-Source: AA6agR6b8hZYwJBLm7SLsCAO/aDS4ocsOKNPA6oXV5y0JmR0eVsUiPdTEKIihaSDtWt0cXx/BWWu6dkQqN3LRIxu+kc=
X-Received: by 2002:ac5:cd54:0:b0:39e:937c:333d with SMTP id
 n20-20020ac5cd54000000b0039e937c333dmr1077487vkm.15.1662475182280; Tue, 06
 Sep 2022 07:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220826220017.188066-1-marek.bykowski@gmail.com>
 <CAL_JsqKGgZOSdWQ2ithipvrRAYwt-vOL1z9-RM++-_h6pA=C_Q@mail.gmail.com> <20220830153500.49206b5a@ubuntu.armcompdev.pub.tds.tieto.com>
In-Reply-To: <20220830153500.49206b5a@ubuntu.armcompdev.pub.tds.tieto.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 6 Sep 2022 09:39:31 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLbpbWavxs6ifO_RRSMreOjj1ToSSDS11P2wuVDeBj_7A@mail.gmail.com>
Message-ID: <CAL_JsqLbpbWavxs6ifO_RRSMreOjj1ToSSDS11P2wuVDeBj_7A@mail.gmail.com>
Subject: Re: [PATCH] of/fdt: Don't calculate initrd_start from the DT if
 'linux,initrd-end' is 0
To:     Marek Bykowski <marek.bykowski@gmail.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 10:35 AM Marek Bykowski
<marek.bykowski@gmail.com> wrote:
>
> On Sun, 28 Aug 2022 20:12:41 -0500
> Rob Herring <robh+dt@kernel.org> wrote:
>
> >
> > Shouldn't we just check that start < end?
> >
> > Can we check this somewhere not DT specific (and also not arch
> > specific)? Then we don't have to worry if any other method of setting
> > initrd could have the same error.
>
> Yes, we can switch from checking on the end being 0 to that proposed:
> - if (!end)
> -     return;
> + if (start >= end)
> +     return;
>
> Then the check would even go further as would also catch cases where
> end < start.
>
> My taking is early_init_dt_scan_chosen() that sets initrd size
> incorrectly is DT specific but generic/arch agnostic. So that if
> the error got introduced by a bootloader/U-Boot through the DT
> chosen node, we should catch it in DT and react.
>
> ARM64, for example, before going down for mapping for the incorrect
> address (some extra large address resulting from the negative to
> positive value conversion), has a check after DT parsing if
> phys_initrd_size is other than 0 to proceed, and it is so that it
> passes or in other words it doesn't catch the error.

Okay.

Please send an updated patch.

Rob
