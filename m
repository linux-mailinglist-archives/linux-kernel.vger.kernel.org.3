Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3182158E479
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 03:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiHJBZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 21:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiHJBYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 21:24:37 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3EE60686
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 18:24:36 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v3so16188901wrp.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 18:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=mXbQNg6xL4amK0e8t2R+lhFBx4wz53d/3c+qVrE8XHQ=;
        b=op7XGQ/C392xu2zrnE49ze1FL2X/BB3TSORunubDIWKmitp1TLcY6O90TfdNYXvIW/
         I7nWo69gvFaL3WiOO7zePx5tpo2DJNfPXcdSNBZYKedmn0vrrNrh7n7zFL+Def1g2U7/
         fMUlVyAIFFHQR74Wfsfp6J21m1Y35D2MyCLOOIKEKnJToIz3tp/+fi7Ap/jiLfKkvDaz
         mAp9Zz851/7pQPHSJXlCxdQq8uKfxguAT27V+Hze0qDBI896Jia8hJShF/FbA/RBLlhK
         elLfNrOA702fCyHYKMBhdUEr85bN/XPjGgenSxWZCDEhg3PzcxR2Hf0b5J+V7D6IagQd
         wqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=mXbQNg6xL4amK0e8t2R+lhFBx4wz53d/3c+qVrE8XHQ=;
        b=TRQmdvGMtoFG6AH6xtt0lX+hw8N+w/6hb4P+EmJogjjOT/N8m/Kql/psRX+y+BnjJs
         Ee+zjmDPnZXDhtwYTrmghJNXA2ToehncK+hPontIWSUGOf9Us3Kuj0KyNk2ub0xSVW3Y
         MJ0FPSwpXP8zxEYK+kgxryKC+dTkxl5rzQLAU7HnqZDILb1HEDu8FjhAyfPc/LVnWHID
         fSwXZZQTPiqEvvHltC72/bn5zfPrvMIEIL0ggZ27PzJogAzK2xausOIwKd5KsktbW1hR
         j4vks7D5hYyepPrLoiYtEab1CfAamH8vXMZ1b/Ql559wjgp1JPpcFijmEhV+K7HNpEqw
         cRQg==
X-Gm-Message-State: ACgBeo34wmtefwmVO6q61cCX5orMRLnXEcB4GPKqY64l/3aw7Z44kZEv
        fxUdF5JuyQbxcDjjaFvgRhdTTXkuzcDlxT7wuHWwIQ==
X-Google-Smtp-Source: AA6agR7YwzWUpfkACpeYV8uYguM7R+gPEIWJxB4Le3ZfVGmWnbsjVoQBJaXHBRBWgEBkMKC/Ubjqi4/VywGWwd8ntvM=
X-Received: by 2002:a05:6000:1869:b0:220:639b:8337 with SMTP id
 d9-20020a056000186900b00220639b8337mr16291929wri.572.1660094674949; Tue, 09
 Aug 2022 18:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220805214734.1937451-1-eugenis@google.com> <875yj1x0k0.wl-maz@kernel.org>
 <CAFKCwrjVaOdrGktxVHLCDPyJSRjZ0B3FHTGsb3PXMULL=dw9rA@mail.gmail.com>
 <87v8r1uztz.wl-maz@kernel.org> <CAFKCwriq-Vh+fhxso=xqtKzkL95QkYOOkMR8XwTOJfeg1M-2qQ@mail.gmail.com>
In-Reply-To: <CAFKCwriq-Vh+fhxso=xqtKzkL95QkYOOkMR8XwTOJfeg1M-2qQ@mail.gmail.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 9 Aug 2022 18:24:23 -0700
Message-ID: <CAMn1gO5Va0eVFqzoOLLLJ+C+x-5=cc4qXDTw0e9J7v0RpYWusA@mail.gmail.com>
Subject: Re: [PATCH] mte: Follow arm64.nomte override in MMU setup.
To:     Evgenii Stepanov <eugenis@google.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Aug 9, 2022 at 10:29 AM Evgenii Stepanov <eugenis@google.com> wrote:
>
> On Tue, Aug 9, 2022 at 9:49 AM Marc Zyngier <maz@kernel.org> wrote:
> >
> > In which case what is the tag memory doing in the linear map?
> > Shouldn't it be marked as reserved, not mapped, and in general
> > completely ignored by the NS OS?
>
> That would be wasteful. The idea is to only reserve the parts of the
> tag memory that correspond to the TZ carveout and release the rest to
> the NS OS.

More generally, one can imagine a system where *any* tagged memory
transaction can result in an SError because the MTE implementation was
not configured by an earlier bootloader phase, e.g. because the
bootloader was configured to disable MTE at runtime. On such systems,
the kernel must refrain from causing tagged memory transactions to be
issued via the linear map, and that's exactly what this patch does.

Peter
