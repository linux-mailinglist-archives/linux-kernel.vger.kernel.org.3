Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A668F4D2927
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 07:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiCIGvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 01:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiCIGvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 01:51:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D10E1520CE;
        Tue,  8 Mar 2022 22:50:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C598761926;
        Wed,  9 Mar 2022 06:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC23C340EE;
        Wed,  9 Mar 2022 06:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646808645;
        bh=lqJEjruwZx8mXXJiqlEh+/jeYPddOkNF5TLCou4N5HQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BblEClzX0poJxy4l8alu0/Rp5kko29oFe2eh00Fr2VFFdtFElysJ1sMhzSB4fLuR3
         /cP8+8LYNjSOcx4mXo3+3g7vBKDKvWbs2mQ/6dNAvbjTdzX1ploQm7ub4Xs7HW8pEs
         n2XwZ3GJweXuEoN14nhFBj6qpYS3bbNsJHhcsYOG1uT2nkQXSO1A1dms2ztAByMhlp
         jSg5j3mvcWyULO+UOjR/ibYXASs1N0pN/0ixBgXf/pvrRUKeYh6qbxeIQVKaJplLgt
         q080+UlRRQ6cpXTh3dw6n+d76OB/EoS05nFORkJo0t+GXJ/SCk3DVC/2h3bufnY/u/
         rjoHbVQY5Ou/Q==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2dbd97f9bfcso12177917b3.9;
        Tue, 08 Mar 2022 22:50:45 -0800 (PST)
X-Gm-Message-State: AOAM530dWefFuRp41WMqzIh68jW2R2XbXilrT9qLuhJzdulS4cDceJA7
        h4zF7jGgk+Sr14JMmAE/MTn1czgK6KRjmYfZLmg=
X-Google-Smtp-Source: ABdhPJyHp22I+w4JGDzDNV/6AmYBB8SYK1M82LxlCb2voafFb0oACUeG8g6G2nCOzwlfAEaQ9mdV9FJn1KkouM8ByG8=
X-Received: by 2002:a81:7814:0:b0:2ca:287c:6c2e with SMTP id
 t20-20020a817814000000b002ca287c6c2emr16133695ywc.211.1646808644210; Tue, 08
 Mar 2022 22:50:44 -0800 (PST)
MIME-Version: 1.0
References: <20220228112503.841449-1-hch@lst.de> <CAPhsuW7EGxoyc9dkpP0y9AUWrV5V6ZORhew+tX=rFXS+vRm_AA@mail.gmail.com>
 <20220309060846.GA31216@lst.de>
In-Reply-To: <20220309060846.GA31216@lst.de>
From:   Song Liu <song@kernel.org>
Date:   Tue, 8 Mar 2022 22:50:33 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7B+CaCuOPXnGwi5dL9QZrHbH6h2D_rWGm3c__6RDQG-Q@mail.gmail.com>
Message-ID: <CAPhsuW7B+CaCuOPXnGwi5dL9QZrHbH6h2D_rWGm3c__6RDQG-Q@mail.gmail.com>
Subject: Re: raid5 bio handling cleanups
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 10:08 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Mar 02, 2022 at 04:14:40PM -0800, Song Liu wrote:
> > On Mon, Feb 28, 2022 at 3:25 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > Hi Song,
> > >
> > > this series cleans up the raid5 bio handling to take advantage of
> > > the bio allocation interface changes in Jens' for-5.18 branches.
> >
> > Applied to md-next. Thank
>
> Unless I'm missing something these did not make it into the pull
> request to Jens, right?

I messed it up. I will send them in the next pull request.

Thanks,
Song
