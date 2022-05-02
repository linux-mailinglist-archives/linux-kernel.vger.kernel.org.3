Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F9851768B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386878AbiEBSdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386875AbiEBSdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:33:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBCEAE4A;
        Mon,  2 May 2022 11:29:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C81F5B819A3;
        Mon,  2 May 2022 18:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93489C385B5;
        Mon,  2 May 2022 18:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651516182;
        bh=CrRfg/9cfBBFf0VO9ibsjSXzw8h7t0DZsk/KDIO8BHA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jLKrUXebeC9SCVJOgJHDMCnwHFtb43YsvFgQIkW7no6QCbHow29tQOyAQxXt+cjTo
         dSLrApUJ9y8JCgohAjS/GNrmtHrNnhtM+1810qOkRbk96t/DOhF5ZBUrONHSeblrvD
         znE5izQvqYcQ1ojqqDdius028gZAH2yIWqnL1aqPKB35WvPS9lyJytkU+cAl08DWD5
         xOGeZE4Bocvq3sS+mr6MiaWQx68oVcWp/7rVGK1tfcVkvjr3IgPQh6+wphLB+q6Gkk
         MzvWT22fuc6/u4ST+hkBaJVsn77fV4FXtdxR+TfirxWWQNmH6HdKmQPqznH8uAF2RG
         P+J419vj9N+mQ==
Received: by mail-pl1-f177.google.com with SMTP id s14so13117988plk.8;
        Mon, 02 May 2022 11:29:42 -0700 (PDT)
X-Gm-Message-State: AOAM532Wop3v5rbDDi5HcCXGOpinp28g0F8weqE0d80iSm4+nic5j8Vw
        bsDb82HYlPaHVSgT2yT5oCqmyH97Hk3KfSRDfQ==
X-Google-Smtp-Source: ABdhPJxqvAJ+e4xPb1Ra2RkSi7/uZzgqQsqpc7lFME52yFwZl91ZpkiygCdcsaCfaFTOaFWHySeJ/GI9Rv3ITYSmuOc=
X-Received: by 2002:a17:902:e481:b0:15c:dc24:64e8 with SMTP id
 i1-20020a170902e48100b0015cdc2464e8mr13279773ple.35.1651516181934; Mon, 02
 May 2022 11:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220501000543.1368005-1-frowand.list@gmail.com>
 <20220501000543.1368005-2-frowand.list@gmail.com> <YnAOEqO23BQk53vz@robh.at.kernel.org>
 <367805de-3ef5-1e1d-3711-7d21b500a886@gmail.com>
In-Reply-To: <367805de-3ef5-1e1d-3711-7d21b500a886@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 2 May 2022 13:29:30 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJByh1kt13ATU0J8nYbusYu3XY3bXLwyuDg8XD6xmDkMA@mail.gmail.com>
Message-ID: <CAL_JsqJByh1kt13ATU0J8nYbusYu3XY3bXLwyuDg8XD6xmDkMA@mail.gmail.com>
Subject: Re: [PATCH 1/3] of: overlay: add entry to of_overlay_action_name[]
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Slawomir Stepien <slawomir.stepien@nokia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Slawomir Stepien <sst@poczta.fm>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 1:17 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 5/2/22 12:00, Rob Herring wrote:
> > On Sat, Apr 30, 2022 at 07:05:41PM -0500, frowand.list@gmail.com wrote:
> >> From: Frank Rowand <frank.rowand@sony.com>
> >>
> >> The values of enum of_overlay_notify_action are used to index into
> >> array of_overlay_action_name.  Add an entry to of_overlay_action_name
> >> for the value recently added to of_overlay_notify_action.
> >>
> >> Array of_overlay_action_name[] is moved into include/linux/of.h
> >> adjacent to enum of_overlay_notify_action to make the connection
> >> between the two more obvious if either is modified in the future.
> >>
> >> The only use of of_overlay_action_name is for error reporting in
> >> overlay_notify().  All callers of overlay_notify() report the same
> >> error, but with fewer details.  Remove the redundant error reports
> >> in the callers.
> >>
> >> Fixes: 067c098766c6 ("of: overlay: rework overlay apply and remove kfree()s")
> >> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> >> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> >> ---
> >>  drivers/of/overlay.c | 27 +++++----------------------
> >>  include/linux/of.h   | 13 +++++++++++++
> >>  2 files changed, 18 insertions(+), 22 deletions(-)
> >
> > This isn't applying for me.
>
> Weird, patch can apply it, but 'git am' does not work.  I see that when
> I try that on your dt/next branch.
>
> The problem seems to be that I did not create the series on top of
> dt/next: 5f756a2eaa44 of: overlay: do not break notify on NOTIFY_{OK|STOP}.

It should be more than just that. It was also not any base I have in
my tree, so 'git am' wouldn't try a 3-way merge either.

> I have rebased the series on top of that patch and am sending v2.

Thanks.

Rob
