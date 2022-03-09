Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70794D293A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiCIHBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiCIHBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:01:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C032C11A;
        Tue,  8 Mar 2022 23:00:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7485A618C5;
        Wed,  9 Mar 2022 07:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB13C340EE;
        Wed,  9 Mar 2022 07:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646809247;
        bh=FEPiHd1X+MDtLyCbhxtahY903mlGOqX+stTXIKB2rg8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VtEx7RsetUkvviMtaz7t+sj8l4StzP6Pp+GtswZCxljvYOPC+Bt602nRWOLI/sDxy
         5hFdkD1Yrn07FXu0OAO7ILO5+jVkqf7g7fhJN9/d9F20uzppKyPjZQEg7gAYxhR7MP
         gU7j2G7qOAdtL6pBY3pTPKj+6E+ZC3OTiJ7fdkbQEYlHctlscetGLXVYmKf/k+TrQt
         q7qF1qJNBWomnaIS6lHp2wJaeL/x4oL+myEiQnQ2zUslVigGKp6CiAVXnuqVYyLRKO
         ip8q8u2PvWFHkgkLABHzPjKQb2E8l0GJCe6Naj2c/zR4+LjUWfPO2v2nzAWxZtdqLG
         gal7T7TFl+c6g==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2dc242a79beso12412627b3.8;
        Tue, 08 Mar 2022 23:00:47 -0800 (PST)
X-Gm-Message-State: AOAM533dJ9rurKk24nDdKPc+fMmk6bdeSeZnniroTpUSt1V1WeC33rm3
        zNtHWUT2hc2rsr5+kDf7q90ceVPm3JRFVUm5kvA=
X-Google-Smtp-Source: ABdhPJzxKENx22Ul7Ucspy9KxYfaix5JdSHRerjRLT0lWnpOw0NpG9wve82+uqSGGyQ9NFo6MuZEua2BqPLTH8WXCQw=
X-Received: by 2002:a81:7814:0:b0:2ca:287c:6c2e with SMTP id
 t20-20020a817814000000b002ca287c6c2emr16150633ywc.211.1646809246902; Tue, 08
 Mar 2022 23:00:46 -0800 (PST)
MIME-Version: 1.0
References: <20220228112503.841449-1-hch@lst.de> <CAPhsuW7EGxoyc9dkpP0y9AUWrV5V6ZORhew+tX=rFXS+vRm_AA@mail.gmail.com>
 <20220309060846.GA31216@lst.de> <CAPhsuW7B+CaCuOPXnGwi5dL9QZrHbH6h2D_rWGm3c__6RDQG-Q@mail.gmail.com>
In-Reply-To: <CAPhsuW7B+CaCuOPXnGwi5dL9QZrHbH6h2D_rWGm3c__6RDQG-Q@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 8 Mar 2022 23:00:35 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5=Wnwz6bcAtS_AZwUhnnbafiWOYDC0YoHfSyqQKZSmRg@mail.gmail.com>
Message-ID: <CAPhsuW5=Wnwz6bcAtS_AZwUhnnbafiWOYDC0YoHfSyqQKZSmRg@mail.gmail.com>
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

On Tue, Mar 8, 2022 at 10:50 PM Song Liu <song@kernel.org> wrote:
>
> On Tue, Mar 8, 2022 at 10:08 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Wed, Mar 02, 2022 at 04:14:40PM -0800, Song Liu wrote:
> > > On Mon, Feb 28, 2022 at 3:25 AM Christoph Hellwig <hch@lst.de> wrote:
> > > >
> > > > Hi Song,
> > > >
> > > > this series cleans up the raid5 bio handling to take advantage of
> > > > the bio allocation interface changes in Jens' for-5.18 branches.
> > >
> > > Applied to md-next. Thank
> >
> > Unless I'm missing something these did not make it into the pull
> > request to Jens, right?
>
> I messed it up. I will send them in the next pull request.

I just pushed it again to md-next. I will send the pull request tomorrow
or the day after.

Sorry for the confusion.

Song
