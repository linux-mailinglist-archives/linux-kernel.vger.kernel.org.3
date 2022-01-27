Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D4749E2E9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241296AbiA0M6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241224AbiA0M6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:58:16 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7635C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 04:58:15 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id t14so4156792ljh.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 04:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=2mp5ghioe/qBbAdRfzPPiuSO1cf+J5YUWfClyBnPLZ4=;
        b=uYiu8ZPYgAYV99r0UbkphixsddqWS+SLId9J5ZN/UcjvzelBqaotIjengcXg8sSM5R
         bhNYMsu+ZgETej0z/VP4PGRky+zhDi8cx43A8IBOjScU4MbWIchD4+oBbMTW1yZPg1ww
         UDtvelv0y058vxStvnVbPdqVACJA3z+AIU0bbHR4zXdt9zVybDeXn2myxd/RKVRHnjMP
         hGID6DDioZwcc6GHnGxC5NbaO/UotkTYS5Ynw2uUNyeaBRlcSLNaoyGyeQ9KGNTUj2mQ
         nA/jEgtnRClKKRxuACg+fxRHuO5HyY2q8UP5yLt2DPqHZLG6lPPLCGKU9klhC0RHigpa
         F3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=2mp5ghioe/qBbAdRfzPPiuSO1cf+J5YUWfClyBnPLZ4=;
        b=usYTFv+9yZntqnOEA6tWiyXM0vZMCKukmBOU0NV5E9Fkuct4RUlyc851v2EeKCenzC
         1c3Ry4TmG9RtcgW8AfkYgFjGqL+jH8HCau/hLkd5cu0P4+s8eFTCFVY2oZM6Xgrn9Srk
         okqB4gp8N+D4nQQq7+rll6N01CrNaIeSN+gPdijuzrwndWIZX0IRrvm9gvnAkNmFq9N8
         YTeFmJGpIxvTR6KrbTmlL4HAjYpuSprJhTNt/xWW7ADWa+QSW3SmO4iyPkIuSIfUXJI5
         w53aeDRDeRaPnq+YZLgtC1HxT4OlsSrdmPt+41GTU1lzzL9yyFlNtAgR28smlDbpYZJz
         TFcw==
X-Gm-Message-State: AOAM530bQLSXPKJ+DPnwa5rnDNJsOImhdQ3VdKLIIoyoG+1XNK0Pb00q
        qc5q0oN8SSZvwfuczw2ZwtxGU2y0JIUTbA==
X-Google-Smtp-Source: ABdhPJyarmap0BgotEIdGm+1YZClhzRr1eHoiBmgS0XVSZC0VkrQoxKExzftmOeMpa1/0Q7IwOq7pg==
X-Received: by 2002:a2e:7a11:: with SMTP id v17mr2763595ljc.63.1643288293893;
        Thu, 27 Jan 2022 04:58:13 -0800 (PST)
Received: from wkz-x280 (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id d13sm1795843lfv.172.2022.01.27.04.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 04:58:13 -0800 (PST)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: dsa: mv88e6xxx: Improve performance
 of busy bit polling
In-Reply-To: <YfHdCDIUvpaYpDSF@lunn.ch>
References: <20220126231239.1443128-1-tobias@waldekranz.com>
 <20220126231239.1443128-2-tobias@waldekranz.com>
 <YfHdCDIUvpaYpDSF@lunn.ch>
Date:   Thu, 27 Jan 2022 13:58:12 +0100
Message-ID: <87o83xbajf.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 00:45, Andrew Lunn <andrew@lunn.ch> wrote:
> There are a few bit-banging systems out there. For those, i wonder if
> 50ms is too short? With the old code, they had 16 chances, no matter
> how slow they were. With the new code, if they take 50ms for one
> transaction, they don't get a second chance.
>
> But if they have taken 50ms, around 37ms has been spent with the
> preamble, start, op, phy address, and register address. I assume at
> that point the switch actually looks at the register, and given your
> timings, it really should be ready, so a second loop is probably not
> required?
>
> O.K, so this seems safe.

I think you raise a good point though. Say that you then have this
series of events:

1. Bang out ST
2. Bang out OP
3. Bang out PHYADR
4. Bang out REGADR
5. Clock out TA
6. schedule()
7. A SCHED_FIFO/P99 task runs
8. Clock in DATA

- Steps 1 through 5 could plausibly be completed before the bit clears
  if you are running over some memory mapped GPIO lines
- Step 7 could execute for more than 50ms
- After step 8, you would see the busy bit set, but your time is up

All of this is of course _very_ unlikely, but not impossible. Should we
ensure that you always get at least two bites at the apple?
