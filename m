Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356F45880CE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 19:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiHBRKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 13:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbiHBRKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:10:49 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7D41EAE6;
        Tue,  2 Aug 2022 10:10:47 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 272HAXwx017499;
        Wed, 3 Aug 2022 02:10:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 272HAXwx017499
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1659460234;
        bh=H30PAH1MVagmr+DocuLDEfTLf80xpGIilp7LXmrFWDA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Kb7f/tdIPYeAHcEGjMrCdmaIM2M9EG8Ly7RLUOr2UAzE0w57Xq2sClimpSdWb+wkZ
         bf2pDsUHWWiOaIpUOukO1DRdMEednH8giZDq2UpSlzSVkL6yZYt+qCTS9rW0o0VnQi
         b2VwymG8p3tVOOWTLPsTXWHo4R+eRy7VohKIfQ4MvctTa433DPSYL/rDMubeNYoT13
         vjfCwtMoaKMph9QGVqds8pA+o8KQ7GpcQFjoVe3FzqqgK2FwwWywDUgRMjqhwuYoSB
         IvX0MTLYC2j34pXQvy1uz/GDDE5xkdi4H3h3k8xMg1m8mpbuv0e5gmvu4GP3gI5WbK
         I29dbh7WAjWKA==
X-Nifty-SrcIP: [209.85.128.53]
Received: by mail-wm1-f53.google.com with SMTP id i128-20020a1c3b86000000b003a3a22178beso571554wma.3;
        Tue, 02 Aug 2022 10:10:33 -0700 (PDT)
X-Gm-Message-State: ACgBeo2YWwwIYhxP6PtDutZVJSXPJn+IY7fAGomi4czdi0GW74DKtKzK
        LXv+fST+WxuNqfycaIrREd4Knxvrn5n86CL2xfg=
X-Google-Smtp-Source: AA6agR4WDUvwILyzHBc8Y5fxbKXqaQqBUelJlkN0GZTbZz+5ss+2UTV07uzo3adpUpnkYrQQFpyUXJIxFkhMEkdX/zM=
X-Received: by 2002:a05:600c:35ce:b0:3a3:1b7f:bbd8 with SMTP id
 r14-20020a05600c35ce00b003a31b7fbbd8mr288103wmq.22.1659460232334; Tue, 02 Aug
 2022 10:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220730173636.1303357-1-masahiroy@kernel.org> <b655dfc5-f490-9722-6ac6-ac4b7e8b7b5b@quicinc.com>
In-Reply-To: <b655dfc5-f490-9722-6ac6-ac4b7e8b7b5b@quicinc.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 3 Aug 2022 02:09:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNATWYdcUkRXVANG4Dc-3Fr-qyh1y8ZcM0knY1f3KEsKspw@mail.gmail.com>
Message-ID: <CAK7LNATWYdcUkRXVANG4Dc-3Fr-qyh1y8ZcM0knY1f3KEsKspw@mail.gmail.com>
Subject: Re: [PATCH 1/3] modpost: add array range check to sec_name()
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 5:29 AM Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
>
> On 7/30/2022 10:36 AM, Masahiro Yamada wrote:
> > The section index is always positive, so the argunent, secindex, should
>
> nit: s/argunent/argument/

Thanks.
I will not send v2 just because of this typo.
I locally fixed it.

-- 
Best Regards
Masahiro Yamada
