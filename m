Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0A9535A86
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346098AbiE0HfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347412AbiE0HfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:35:15 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3353CF748B
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 00:35:14 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gk22so3893149pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 00:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gb3zDFV9H+CHGG21xlS3jy0JJ5srdRQ7fNU8vIFlsFk=;
        b=IyLxRp1mE9Et2lxydx1HPhnWe6DCL7WQy7D5A4YpMUnrflrb5Hiq2ncgVKQXaeUG0P
         OvI2Jh0vueBWfpXSdRpYFTufDrmHUwIn+L0htDonTuGb+6wTiDbWSP1QEM/0vSZhg//L
         e/fesYXFPVmRUZcAwt6RYGO/iMF1BYVNS47r131t8pJofG0lvbO2fDqABq5hFYO3g7ku
         OThkgLBzZzr6BjYTYAokDR5eMHWU9tYlolgm+UhX0JuSeEcZwQNIeaUxiYXNS1QzSFdM
         7HMNCnDf4AJQl+lmc6Ig6aZpdecCj5f2K5C6NjpgLwzQTRCNzophenbmQn/JlyRb2mHZ
         nwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gb3zDFV9H+CHGG21xlS3jy0JJ5srdRQ7fNU8vIFlsFk=;
        b=JDRW0SwA/MOY4A+sdqvKHHM+Io+MGMQRU2sojnbDFaY4jozYO/oocvuvTwkrL5Hgqa
         L67vdwPtWhHE68QccPTL2+jsBgY/Vo2ODZl8+QCSP6Nb+rAgI261ez62drANzYAC25k6
         KT7cXU5T49lAUGWkGt/lUaxVN94yqbJMr9Jmyam/x9amZ6ug3E0VQzLGXvgvAPfDeXyH
         goBlZX7FkPq1AYUVPdn58ZgKYVnTbguU7F9zI52XLNWI0XoFdM1zK2E3lMmTeboMbY+S
         fRulaHpMAeZ7Xdf7ncK4VVISeHlvNFUCej8EwreJQyf6HW/TT5wHAbSV2sv3YRj+FOEP
         MZkA==
X-Gm-Message-State: AOAM530aUd+weBE9HRr6VJEY+7oBL0OAeAwGOoT7rQ6aL0PezUjGnGmE
        E9rSFNf6Df8jjr3g1qqRmZ10ZqXDPTWBYCP4O4+IMw==
X-Google-Smtp-Source: ABdhPJw62TEM52pirxa8VD09mT1OBlEzVQWoJlfF2xpk/wGrpzAjxoAYWL4kPHvBmJ5aNWUYCtrIJHogrA12d6+IRHo=
X-Received: by 2002:a17:902:ee52:b0:161:96bc:da8f with SMTP id
 18-20020a170902ee5200b0016196bcda8fmr41431829plo.25.1653636913616; Fri, 27
 May 2022 00:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220413143434.527-1-aajith@arista.com> <350f6a02-2975-ac1b-1c9d-ab738722a9fe@kernel.org>
 <CAOvjArTAce_68CkoUff_=Hi+mr731dsWcQdEbaev4xaMDFZNug@mail.gmail.com> <5f189615-8701-e2ca-d9a6-d6037f8799aa@kernel.org>
In-Reply-To: <5f189615-8701-e2ca-d9a6-d6037f8799aa@kernel.org>
From:   Arun Ajith S <aajith@arista.com>
Date:   Fri, 27 May 2022 13:05:01 +0530
Message-ID: <CAOvjArT+0Os_LBcAoZ778OYXZCw3N6WhbPG8ANnNGV=Ms-QStQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net/ipv6: Introduce accept_unsolicited_na
 knob to implement router-side changes for RFC9131
To:     David Ahern <dsahern@kernel.org>
Cc:     netdev@vger.kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        yoshfuji@linux-ipv6.org, kuba@kernel.org, pabeni@redhat.com,
        corbet@lwn.net, prestwoj@gmail.com, gilligan@arista.com,
        noureddine@arista.com, gk@arista.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 7:30 AM David Ahern <dsahern@kernel.org> wrote:
>
> On 5/20/22 1:19 AM, Arun Ajith S wrote:
> > On Thu, Apr 14, 2022 at 3:37 AM David Ahern <dsahern@kernel.org> wrote:
> >>
> >> On 4/13/22 8:34 AM, Arun Ajith S wrote:
> >>> diff --git a/tools/testing/selftests/net/ndisc_unsolicited_na_test.py b/tools/testing/selftests/net/ndisc_unsolicited_na_test.py
> >>> new file mode 100755
> >>> index 000000000000..f508657ee126
> >>> --- /dev/null
> >>> +++ b/tools/testing/selftests/net/ndisc_unsolicited_na_test.py
> >>> @@ -0,0 +1,255 @@
> >>> +#!/bin/bash
> >>
> >> that file name suffix should be .sh since it is a bash script; not .py
> >>
> >> other than that looks good to me.
> >>
> >> Reviewed-by: David Ahern <dsahern@kernel.org>
> >
> > Hi David,
> >
> > It has been pointed out to me that I might have read RFC9131 in a
> > narrower sense than what was intended.
> > The behavior of adding a new entry in the neighbour cache on receiving
> > a NA if none exists presently
> > shouldn't be limited to unsolicited NAs like in my original patch,
> > rather it should extend to all NAs.
> >
> > I am quoting from the RFC below
> >
> >    |  When a valid Neighbor Advertisement is received (either solicited
> >    |  or unsolicited), the Neighbor Cache is searched for the target's
> >    |  entry.  If no entry exists:
> >    |
> >    |  *  Hosts SHOULD silently discard the advertisement.  There is no
> >    |     need to create an entry if none exists, since the recipient has
> >    |     apparently not initiated any communication with the target.
> >    |
> >    |  *  Routers SHOULD create a new entry for the target address with
> >    |     the link-layer address set to the Target Link-Layer Address
> >    |     Option (if supplied).  The entry's reachability state MUST be
> >    |     set to STALE.  If the received Neighbor Advertisement does not
> >    |     contain the Target Link-Layer Address Option, the advertisement
> >    |     SHOULD be silently discarded.
> >
> > I want to fix this, but this would mean the sysctl name
> > accept_unsolicited_na is no longer appropriate
> > I see that the net-next window for 5.19 is still open and changing the
> > sysctl name
> > wouldn't mean changing an existing interface.
> > I was thinking of renaming the sysctl to accept_untracked_na to
> > highlight that we are accepting NAs even if there is
> > no corresponding entry tracked in the neighbor cache.
> >
> > Also, there's an error in my comment, where I say "pass up the stack"
> > as we don't pass NAs up the stack.
> > The comment can be updated as:
> >         /* RFC 9131 updates original Neighbour Discovery RFC 4861.
> >          * NAs with Target LL Address option without a corresponding
> >          * entry in the neighbour cache can now create a STALE neighbour
> >          * cache entry on routers.
> >          *
> >          *   entry accept  fwding  solicited        behaviour
> >          * ------- ------  ------  ---------    ----------------------
> >          * present      X       X         0     Set state to STALE
> >          * present      X       X         1     Set state to REACHABLE
> >          *  absent      0       X         X     Do nothing
> >          *  absent      1       0         X     Do nothing
> >          *  absent      1       1         X     Add a new STALE entry
> >          */
> >
> > In summary
> > 1. accept=0 keeps original(5.18) behavior for all cases.
> > 2. accept=1 changes original behavior for entry=asbent, fwding=1 case
> > provided the NA had specified target link-layer address.
> >
> > Please let me know what you think.
> >
>
> Changes can be made until it is in a released kernel to users. This
> feature has many weeks before it hits that level.

Thanks, I have made the proposed changes here:
https://patchwork.kernel.org/project/netdevbpf/patch/20220527073111.14336-1-aajith@arista.com/
