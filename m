Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDC04BF71D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 12:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiBVLTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 06:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiBVLTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 06:19:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFF71108778
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645528725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A2gckBtnixMVaahVtnNibGnabKhb0jcedbRGPNNAXj0=;
        b=YQNUO0erd2QUKYfR/AbHaCec38fv2MvrXL9NyGsZ5/82YTC2MaN4IgtzSMiB9Yge8qgNat
        Ur8BG5GNECbfZc3MdfXA61qVvtnA+TEEtaRL5sLC7rnGBm3uuhWoalzAsEVcCulJC7K2Ok
        JaIvIvoOu7TLAekXNuCLYv2BYoYyTew=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-UHa7RaLOP4KA4u_DAbwn8A-1; Tue, 22 Feb 2022 06:18:43 -0500
X-MC-Unique: UHa7RaLOP4KA4u_DAbwn8A-1
Received: by mail-lj1-f198.google.com with SMTP id 20-20020a05651c009400b002462f08f8d2so3892409ljq.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:18:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A2gckBtnixMVaahVtnNibGnabKhb0jcedbRGPNNAXj0=;
        b=ACBt0ntsq2WCX0fi1d+J8qXplj3uWh87ElKld5KRtaYj84N0EXZk+9gDk/lGcayvyV
         OkpYLwBRhQdDCeM71kJ8ZgNjl4kAgdNpSb7ws5BPJoCFbthyjyKEUpP+1kJlbqdPmD8b
         52H/wgT8jLEFTsS0QS+4kr4ryoPMnawc0UteB6fs1TCxabrXU4l81ahbo037477QT47a
         WZqnU75uwyNH0gf90UFEwzQWEO9HkHws8NojbS+6C3KOQBK+7u/2A+imysHNYyb8qGJF
         a6b4yO5LWu6bCndxkPYlVEP878AuXOFTkryO3s4VqB0urHQihBaqLkduQ18P5+V197st
         3y4Q==
X-Gm-Message-State: AOAM533h8kvS6KdMJBL8Of/jB1Tpl3PjhAvRp5so8nMVTC4E05SVGQKL
        2lr3Ccw82aptNIngUdTOo1tiFCfT04avdPYvQpBYcaujTFxxEyP3MOBCd5keGRC3FObQRiMCKD3
        BX1pFCn84nvWaTIXyApxccXyQhakgECg2wMQNPYY=
X-Received: by 2002:ac2:5cd0:0:b0:443:b112:e512 with SMTP id f16-20020ac25cd0000000b00443b112e512mr14638302lfq.118.1645528722355;
        Tue, 22 Feb 2022 03:18:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyfIlZqtjd+JGObGg/qk7CWDZ/9xEu4n9eTUbEhI/8LWxeCG+1eUeDp/NcygYU0N+2juzdpOKkYm0z34f9B6/A=
X-Received: by 2002:ac2:5cd0:0:b0:443:b112:e512 with SMTP id
 f16-20020ac25cd0000000b00443b112e512mr14638272lfq.118.1645528722101; Tue, 22
 Feb 2022 03:18:42 -0800 (PST)
MIME-Version: 1.0
References: <20220218212511.887059-1-atomlin@redhat.com> <YhBSBzmuiDQ4yMER@bombadil.infradead.org>
In-Reply-To: <YhBSBzmuiDQ4yMER@bombadil.infradead.org>
From:   Aaron Tomlin <atomlin@redhat.com>
Date:   Tue, 22 Feb 2022 11:18:30 +0000
Message-ID: <CANfR36jqAk2DMxVOawYZfAz-BL-g-Dxj=x-mOes3wqnukz+VAg@mail.gmail.com>
Subject: Re: [PATCH v6 00/13] module: core code clean up
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     "Lameter, Christoph" <cl@linux.com>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, jeyu@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org, live-patching@vger.kernel.org,
        Aaron Tomlin <atomlin@atomlin.com>,
        Grzegorz Halat <ghalat@redhat.com>,
        Allen <allen.lkml@gmail.com>, Joe Perches <joe@perches.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michal Suchanek <msuchanek@suse.de>, oleksandr@natalenko.name
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-02-18 18:12 -0800, Luis Chamberlain wrote:
> On Fri, Feb 18, 2022 at 09:24:58PM +0000, Aaron Tomlin wrote:
> > Hi Luis,
> >
> > As per your suggestion [1], this is an attempt to refactor and split
> > optional code out of core module support code into separate components.
> > This version is based on Linus' commit 7993e65fdd0f ("Merge tag
> > 'mtd/fixes-for-5.17-rc5' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux").
> > Please let me know your thoughts.
>
> Fantastic, thanks for doing all this work, I've pushed this out to
> modules-next so that the testing can start as this will be in linux-next
> soon. I'll obviously wait for more reviews, we have a long time before this
> gets merged to Linus, so just want to start getting testing done now rather
> than later. And other folks are depending on your changes to start
> getting their own code up too.

Hi Luis,

No problem. Unfortunately, this was not the complete series. I can send a
v7 later today with the suggested improvements made by Christophe.


Kind regards,

-- 
Aaron Tomlin

