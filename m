Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9501D56482B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 16:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiGCOyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 10:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGCOyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 10:54:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333535F5C;
        Sun,  3 Jul 2022 07:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B641D60FA3;
        Sun,  3 Jul 2022 14:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAA3C341CF;
        Sun,  3 Jul 2022 14:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656860091;
        bh=88wkh89XkHp/9p0l//ZjUquph6rMmdkjPS/iaaNhkXA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tddQo3ufrLs8QavlfdBeyIZN/7bCh1W3HX4yGN9crIN9yAfq5/doluj1y680rmPJK
         CwfAc7GBaJBQAt0xQjByyeOIePT+oF0seyRaWqmZ1kLM0/2u8Ws3ftjZGticA0dMuj
         50E0mnSm6DSPYMnq/ARFDmMbk+qoCoHPmM2ndQLXUUH0dkwWK77m4vcW9Pu898iceC
         OtgHBPZyKVvsUmrdxTKkG+JFWINaVllNZ1XQtfvnFpVJmDfcyC2HhrWrO11PHbj7z9
         pCLlclxZ//cG935oDZ9rkOMAqk0bPOE3dkBdrVwTwJes5OCjrFzEqkz9/v9hQ0J+mc
         2bLxpYKL0oKsQ==
Received: by mail-yb1-f177.google.com with SMTP id l11so12508289ybu.13;
        Sun, 03 Jul 2022 07:54:51 -0700 (PDT)
X-Gm-Message-State: AJIora/l8GyowBV3nl7rTmQ51NmBqDbKeuQJK8dhruHUE7OWxdDKwW89
        ZXgx4mpHcVnTkvKfA2RvTgafHHwFdnU/hCIpMxw=
X-Google-Smtp-Source: AGRyM1vU9/F7uX/uwhA8n/CMmP5g66QoUXyxKxnASYdt2j7D3JpJMnW9Q3/fV3GaACvlmLWk8qmePO4viL9ua4Ezdso=
X-Received: by 2002:a25:870f:0:b0:66e:2790:dd49 with SMTP id
 a15-20020a25870f000000b0066e2790dd49mr7200564ybl.449.1656860090118; Sun, 03
 Jul 2022 07:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220616191945.23935-1-logang@deltatee.com> <CAPhsuW5uEPptD3U=a9vqiZE34mmx88Yc7npfWDdDDP0WZMORSA@mail.gmail.com>
 <YsFKiBSzQWkh2qAu@infradead.org>
In-Reply-To: <YsFKiBSzQWkh2qAu@infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Sun, 3 Jul 2022 07:54:39 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6Y+OKC67wzHgR5TVNNn70YNLKoMnC=uWWgczgZzKRUEA@mail.gmail.com>
Message-ID: <CAPhsuW6Y+OKC67wzHgR5TVNNn70YNLKoMnC=uWWgczgZzKRUEA@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] Improve Raid5 Lock Contention
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 3, 2022 at 12:51 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Jun 22, 2022 at 09:48:02PM -0700, Song Liu wrote:
> > > Now that I've done some cleanup of the mdadm testing infrastructure
> > > as well as a lot of long run testing and bug fixes I'm much more
> > > confident in the correctness of this series. The previous posting is
> > > at [1].
> >
> > Applied to md-next. Thanks for the great work!
>
> They still don't seem to have made it to linux-next.

I will send pull request to Jens soon. Thanks for the reminder.

Song
