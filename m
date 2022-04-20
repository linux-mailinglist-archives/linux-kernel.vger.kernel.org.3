Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E1B507DB6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 02:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358620AbiDTAqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 20:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358610AbiDTAqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 20:46:00 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3161C27CF5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 17:43:16 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id k12so53588ilv.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 17:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l+ByOqKk3aTPDxOgi+MMXPoJaKvFYjmLHvE3XekD1Uk=;
        b=JmR0pcqjjI6YzateDyGtk1MhYbDzRKG/FbmqtGeN/mQoa5eGagsWoTWt7YHJ19A7yw
         IZvnTcD8zmglvHiaKtcUbQmYYQjwRPW4/B/maJVyPt69Vn+Df/Esf+QK+aBi8OOsffB2
         2ShP+sI29u2/BwgQ3bxIIHDCYwBU4J3ovXjSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l+ByOqKk3aTPDxOgi+MMXPoJaKvFYjmLHvE3XekD1Uk=;
        b=ztCD8fneXeoaQRLfcZtAVLYCme5hHXBSD7vpI8qOJiiQq0ckRQeQ7C4yY+zI0Tr1io
         rESB12U3nhcRq/TuyhxGqY/sdBwvUuw0WQ1xngYUQVvuYpYSUNGwZCokFm9YPVimw3jk
         9hTvTqEohrTbpQTwiRMBMDfH0t4ps9fi9EyNZt87adptE0yAa4f5bqcRuXAorQ6uEEbI
         9eqJ8MvX20qUAsY+dM6J+Q5g8fYieJD1XOslocBrmRBcoSjqpl5K65wWzIb25IfmloPO
         ZCYVWTHdMAFTVnvJAn8gvLSPOVykBLnGYsj4PGsjvuVhH25Fzb01mbvgrk5pHNjU1bwo
         IXxQ==
X-Gm-Message-State: AOAM532f+/lUz9rs4/RBIyuHhV2/i+jULEqCwy7KZfFE+r/Y+x7C/dky
        EeBMI7Xjxr42PfFr46h0jJFpuoQlOzKgEfYFghmiwA==
X-Google-Smtp-Source: ABdhPJxMZ9q71p23gnlmfhB955TXqLup+J9rvIv9OISue1PbZHuQDASslHqoDgDuQs/O6ZnxgiievLi/4a2/HhwYXRc=
X-Received: by 2002:a05:6e02:2184:b0:2cc:56e0:1686 with SMTP id
 j4-20020a056e02218400b002cc56e01686mr1048598ila.28.1650415395243; Tue, 19 Apr
 2022 17:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220107200417.1.Ie4dcc45b0bf365077303c596891d460d716bb4c5@changeid>
 <CAD=FV=W5fHP8K-PcoYWxYHiDWnPUVQQzOzw=REbuJSSqGeVVfg@mail.gmail.com>
 <87sfrqqfzy.fsf@kernel.org> <CAD=FV=U0Qw-OnKJg8SWk9=e=B0qgqnaTHpuR0cRA0WCmSHSJYQ@mail.gmail.com>
 <CACTWRwtpYBokTehRE0_zSdSjio6Ga1yqdCfj1TNck7SqOT8o_Q@mail.gmail.com> <87fsmio9y8.fsf@kernel.org>
In-Reply-To: <87fsmio9y8.fsf@kernel.org>
From:   Abhishek Kumar <kuabhs@chromium.org>
Date:   Tue, 19 Apr 2022 17:43:02 -0700
Message-ID: <CACTWRwvQNswu1nYNHS-Y580QqDV6MHiS56NwyRXm3cLN2que=Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] ath10k: search for default BDF name provided in DT
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        ath10k <ath10k@lists.infradead.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 3:47 AM Kalle Valo <kvalo@kernel.org> wrote:
>
> Abhishek Kumar <kuabhs@chromium.org> writes:
>
> > Hi All,
> >
> > Apologies for the late reply, too many things at the same time.
>
> Trust me, I know the feeling :)
>
> > Just a quick note, Qcomm provided a new BDF file with support for
> > 'bus=snoc,qmi-board-id=ff' as well, so even without this patch, the
> > non-programmed devices(with board-id=0xff) would work. However, for
> > optimization of the BDF search strategy, the above mentioned strategy
> > would still not work: - The stripping of full Board name would not
> > work if board-id itself is not programmed i.e. =0xff e.g. for
> > 'bus=snoc,qmi-board-id=ff,qmi-chip-id=320,variant=GO_LAZOR' => no
> > match 'bus=snoc,qmi-board-id=ff,qmi-chip-id=320' => no match
> > 'bus=snoc,qmi-board-id=ff' => no match 'bus=snoc' => no match because
> > all the BDFs contains board-id=67
>
> Sorry, not fully following your here. Are you saying that the problem is
> that WCN3990/hw1.0/board-2.bin is missing board file for 'bus=snoc'?
Ya, that is what I meant here, the board-2.bin file does not contain
an entry for 'bus=snoc' and so if board-id=oxff then still there
cannot be any BDF that matches. So adding BDF for 'bus=snoc' would
simplify the approach.
> That's easy to add, each board file within board-2.bin has multiple
> names so we can easily select one board file for which we add
> 'bus=snoc'.
>
> > So with this DT patch specifically for case 'bus=snoc,qmi-board-id=ff'
> > => no match, we fallback to default case ( the one provided in DT)
> > i.e. 'bus=snoc,qmi-board-id=67' => match . I do not see how exactly
> > the driver can know that it should check for a board-id of 67.
>
> Sorry, not following you here either. Why would the driver need to use
> board-id 67?
>
> > However, to still remove dependency on the DT, we can make the
> > board-id as no-op if it is not programmed i.e. if the board-id=ff then
> > we would pick any BDF that match 'bus=snoc,qmi-board-id=<XX>' where XX
> > can be any arbitrary number. Thoughts ?
>
> To me using just 'bus=snoc' is more logical than picking up an arbitrary
> number. But I might be missing something here.
The reason I mentioned that if the board-id=oxff then pick any
available BDF entry which matches
'bus=snoc,qmi-board-id=<XX>' is because:
- This will atleast let the wlan chip to boot.
- There is no BDF for 'bus=snoc' , so further stripping of boardname
will not find any match, but as you mentioned that BDF for 'bus=snoc'
can be added, then this will make the logic simpler and we don't have
to pick 'bus=snoc,qmi-board-id=<XX>' with any arbitrary board-id.
I will rollout a patch with this approach.
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

Thanks
Abhishek
