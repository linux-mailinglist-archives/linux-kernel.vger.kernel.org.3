Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0192152E613
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 09:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346268AbiETHUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 03:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiETHUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 03:20:07 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C19A13C4FC
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:20:06 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so7195730pjq.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hsjxg2lV0kHqZ2OGp1MCfh1/3ZpmNndhrm6POUvbWnI=;
        b=AKX0ckYf8ZI5edSV7TwmJosTcQGnse4e+Vfl3LK2R7eqMpRtDtl8Na08m5VXAih5aK
         dseNsN0Djff0CXnEculuh4Eot/g2q6qhnfP31n5M4x3ArLW8/LXF3jeBV35v8NvNigks
         F5mHYmZwECadQRhawkRNff09rvzeXeyaEQmusx2Jz/ptC9J7Q8Vb/sOzWHyhyBN58jZe
         N7gK9xtyZwOxUMjjpbng0EQssqvWXGfQ0N7MKFAYyRxDieRtLGxk86LMtFc7izsXbRTw
         npZn7rovM35L5l0Cncar9XdfVs1KDKBWUKdxkrkie181C43sm500hGDexJt8Y65SJNQk
         t5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hsjxg2lV0kHqZ2OGp1MCfh1/3ZpmNndhrm6POUvbWnI=;
        b=AjIf4xHfGCs1Crngg01i+5cka5TKRxUsEa4t8ndqlBImPGnqZNZDu2qe8geZ1q62jb
         ERxeHx+GpMoIzf3bnJpRdDZPDKG/UdHtZy2gCwx7XFPnLFQ3biRBA2azrStq/2TYCqSF
         W7gWu1C55fDoo4vxxckA+EmqYrsa9sDFHxckfqVguaglIUFdcOyyJkzuTARRz32tLH/P
         z4Kgi2nHV+yyJ2ZuO68ZlrpJhX1SROvYyDQZ4si1VLy8Y6+SKYPO8qO2mlN/I8wyEIrD
         J+g5dqDwVUtl3d2eYCLJdNkYAalZvZDwOO0LmotvDXz9E8sEZH9t5IbRe40VXKq3ajRl
         WdQg==
X-Gm-Message-State: AOAM531whs4ffqUFnM2AdOk2JrbW97/MGxS1tEKK9A6So4yczTFXiTQL
        4U9RwiWTert2LLZlvaqplAO3HLMdUKwin0/Y72ar/w==
X-Google-Smtp-Source: ABdhPJy0P1kA+Qi9bbiBnljc+PhkQb8M4k3s68fhoc6cGxqUck1kCUXPWO9AJTe2PlCORCf0F51fQhfrkGhq7qT/CU4=
X-Received: by 2002:a17:902:d043:b0:161:e9f7:2afe with SMTP id
 l3-20020a170902d04300b00161e9f72afemr4025914pll.29.1653031205457; Fri, 20 May
 2022 00:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220413143434.527-1-aajith@arista.com> <350f6a02-2975-ac1b-1c9d-ab738722a9fe@kernel.org>
In-Reply-To: <350f6a02-2975-ac1b-1c9d-ab738722a9fe@kernel.org>
From:   Arun Ajith S <aajith@arista.com>
Date:   Fri, 20 May 2022 12:49:53 +0530
Message-ID: <CAOvjArTAce_68CkoUff_=Hi+mr731dsWcQdEbaev4xaMDFZNug@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net/ipv6: Introduce accept_unsolicited_na
 knob to implement router-side changes for RFC9131
To:     David Ahern <dsahern@kernel.org>
Cc:     netdev@vger.kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        yoshfuji@linux-ipv6.org, kuba@kernel.org, pabeni@redhat.com,
        corbet@lwn.net, prestwoj@gmail.com, gilligan@arista.com,
        noureddine@arista.com, gk@arista.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 3:37 AM David Ahern <dsahern@kernel.org> wrote:
>
> On 4/13/22 8:34 AM, Arun Ajith S wrote:
> > diff --git a/tools/testing/selftests/net/ndisc_unsolicited_na_test.py b/tools/testing/selftests/net/ndisc_unsolicited_na_test.py
> > new file mode 100755
> > index 000000000000..f508657ee126
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/ndisc_unsolicited_na_test.py
> > @@ -0,0 +1,255 @@
> > +#!/bin/bash
>
> that file name suffix should be .sh since it is a bash script; not .py
>
> other than that looks good to me.
>
> Reviewed-by: David Ahern <dsahern@kernel.org>

Hi David,

It has been pointed out to me that I might have read RFC9131 in a
narrower sense than what was intended.
The behavior of adding a new entry in the neighbour cache on receiving
a NA if none exists presently
shouldn't be limited to unsolicited NAs like in my original patch,
rather it should extend to all NAs.

I am quoting from the RFC below

   |  When a valid Neighbor Advertisement is received (either solicited
   |  or unsolicited), the Neighbor Cache is searched for the target's
   |  entry.  If no entry exists:
   |
   |  *  Hosts SHOULD silently discard the advertisement.  There is no
   |     need to create an entry if none exists, since the recipient has
   |     apparently not initiated any communication with the target.
   |
   |  *  Routers SHOULD create a new entry for the target address with
   |     the link-layer address set to the Target Link-Layer Address
   |     Option (if supplied).  The entry's reachability state MUST be
   |     set to STALE.  If the received Neighbor Advertisement does not
   |     contain the Target Link-Layer Address Option, the advertisement
   |     SHOULD be silently discarded.

I want to fix this, but this would mean the sysctl name
accept_unsolicited_na is no longer appropriate
I see that the net-next window for 5.19 is still open and changing the
sysctl name
wouldn't mean changing an existing interface.
I was thinking of renaming the sysctl to accept_untracked_na to
highlight that we are accepting NAs even if there is
no corresponding entry tracked in the neighbor cache.

Also, there's an error in my comment, where I say "pass up the stack"
as we don't pass NAs up the stack.
The comment can be updated as:
        /* RFC 9131 updates original Neighbour Discovery RFC 4861.
         * NAs with Target LL Address option without a corresponding
         * entry in the neighbour cache can now create a STALE neighbour
         * cache entry on routers.
         *
         *   entry accept  fwding  solicited        behaviour
         * ------- ------  ------  ---------    ----------------------
         * present      X       X         0     Set state to STALE
         * present      X       X         1     Set state to REACHABLE
         *  absent      0       X         X     Do nothing
         *  absent      1       0         X     Do nothing
         *  absent      1       1         X     Add a new STALE entry
         */

In summary
1. accept=0 keeps original(5.18) behavior for all cases.
2. accept=1 changes original behavior for entry=asbent, fwding=1 case
provided the NA had specified target link-layer address.

Please let me know what you think.

Thanks,
Arun
