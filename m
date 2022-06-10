Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFE2546644
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 14:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347660AbiFJMGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 08:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347121AbiFJMGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 08:06:00 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27483F32C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 05:05:57 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id c4so10457642lfj.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 05:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=130B3kkD/RZIkOCrcmz351BczRa1xYiEzwjuOf+BIgM=;
        b=E7/lo+IHcf40eLTK2hdrDgSXpWYiZZx33aHPtjRfBkJ5+KwfnypczseU/evZGlMKHS
         wdTE0F34tV97mzUPq5NeVhXM8MGKNDBzKJRqNxzmLH5Fkefsa11QkIiGc5mF9mPxTCOx
         C+ak6qQvMLINN6c9cGRExCq3uqQv/bk7BG7ngLnSjX07nA8OvXGW0m3CSXJ8zZP8TsSo
         K4Cd7JXgGA4jLI008NOD7MlPfKROGzPol5DFWMQSdInu6sh3kh7V2Mr1SqJB4KvCZPHo
         eTmor6XZKpk+inF5sIf5xfDX5iOeAUVxRn58Y2TR0+bXwQLBc3itmURO3u+UJk7JFdWg
         NlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=130B3kkD/RZIkOCrcmz351BczRa1xYiEzwjuOf+BIgM=;
        b=BjK/FGisGNw8jPSvvc3aay9sLHh6cozSXIxYQj1Ch3PLDd6DVwa5pT8pCljS6nkuUd
         w0td2nX5KVSugUJi8dLYCr1aOIg13jgRw81Is4TBL7QFzE1bI/CxNB2RoOg77qdJLxxa
         OEcptzkOfm+fnyCsK++Ga2vFxM9sutF9uLI+q5MR915FfRcRUVbcTs0ALPuovL7YBcsu
         NpEv6kgAnUWa46i6D5VCgQU26mqJogTpcbhR7NTO9wPT5J4TjLTbg0JDpCvIPZKpqYUa
         Bdg0ZN57C3uZc4Z+MAvGxhobLPdqRxXYjAtqWR540KHwKfEZJKIn/W/PDp0s59odB3vW
         M5Kw==
X-Gm-Message-State: AOAM533NCPD4C0npOPPYXtayDHN8bAkbY60xGpZytTb2gnNhf5KTPvue
        kuwPyA254gmiNe6Elgxo4lY=
X-Google-Smtp-Source: ABdhPJyewHpKPtRT9Pz2gZdCnPyd60KQ0mno5fKFPbEcrCwStmYLat3hyEHndZKfU4T/we0GvsOTMQ==
X-Received: by 2002:a05:6512:3183:b0:479:3e62:2cb with SMTP id i3-20020a056512318300b004793e6202cbmr16934264lfe.459.1654862756109;
        Fri, 10 Jun 2022 05:05:56 -0700 (PDT)
Received: from localhost (87-49-45-7-mobile.dk.customer.tdc.net. [87.49.45.7])
        by smtp.gmail.com with ESMTPSA id o18-20020ac25e32000000b00478fc1eca9bsm4690143lfg.131.2022.06.10.05.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 05:05:55 -0700 (PDT)
Date:   Fri, 10 Jun 2022 14:05:54 +0200
From:   Pankaj Raghav <pankydev8@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "R, Monish Kumar" <monish.kumar.r@intel.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "alan.adamson@oracle.com" <alan.adamson@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>,
        Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        "Rao, Abhijeet" <abhijeet.rao@intel.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Subject: Re: 2 second nvme initialization delay regression in 5.18 [Was: Re:
 [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR
 observed during blktests]
Message-ID: <20220610120554.ry7w37jbf3g6w3p3@quentin>
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
 <Ykyf5Zuz1W8yHhNY@zx2c4.com>
 <CAHmME9pwz4q0m-pSUy7ReWu4nNzxySNcYZrqyDZiTuGxHN=1NQ@mail.gmail.com>
 <CAHmME9o-orF52HzkT80054e3Op5fLOcTHb-KHpvvU7H3FpAJ7A@mail.gmail.com>
 <SA2PR11MB5115DCE45778910C96813CA1C3A79@SA2PR11MB5115.namprd11.prod.outlook.com>
 <YqG/pybFg0P5yQ9a@zx2c4.com>
 <20220610061449.GD24331@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610061449.GD24331@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 08:14:49AM +0200, Christoph Hellwig wrote:
> The 970 seems to actually be very slightly newer than the X5.  What
> I suspect is that they actually are the same m.2 SSD or at least a
> very similar one and Samsung decided to ship it in the thunderbolt
> attached versions first.  Maybe one of the Samsung folks here can
> confirm.
> 
> That leaves us with two plausible theories:
> 
>  - the problems could be due to an earlier firmware version or
>    ASIC stepping
>  - the problems are due to the thunderbolt attachment
> 
I have forwarded this report internally within Samsung and I will post an
update once I have more information about this issue.

Cheers,
Pankaj
