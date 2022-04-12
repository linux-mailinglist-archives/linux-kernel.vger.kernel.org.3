Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9574FE5BB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 18:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357543AbiDLQYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 12:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357541AbiDLQYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 12:24:03 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD635D1B3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:21:44 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso2124832wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WQX52qYY8bg6hGfzOSBwUaKCGbHm9EJC/8UwMWYqta8=;
        b=oGf1ai2dAr+KbSX8nBOEFBiYefkx7CVNfmTOcirjviv6oF3MDfm8t9oW+NMzK0Vhhm
         /Op7M7jwjnfAg6bLlRUf0fPMJfYbY992TOQCEufmOqYsop2KcnWE2vRqM+4CBQbN2+no
         Rw8cNkaHgYsXaVTtSc+2ZskUXtG6f88atEa4xmit9z+MFvYVoDr/lmARF5FpHlDYCoXM
         6qmvmp82b6jemVOGf3jCxVW+sDjBdye+XM/5vbUcgwsnyh8DQHvZhAU2TuphI7Qg8HMw
         8whP4GlCBAvGMJSb6YUXJrifUua5I92E2BjBSlV0G+44KPWcKbc6VEpYEPMRHSGsuG2z
         yepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WQX52qYY8bg6hGfzOSBwUaKCGbHm9EJC/8UwMWYqta8=;
        b=CqIBWNn6fkcrvoj7oGA4FcGdmBShLOxpEKbPX1zOnRhgOtXBJsHq5JKDQdhnsvse0S
         EKviZWlMjFMMRY8EGLh3CrDw/E4354rxuHYHBZ5bz6i/oWL0wCNYiA46A1RMOEThp5Ym
         X/OrEYLrMsyU3uvnsvFUJjZNZ0uQCI2N6Zazd7PMi9pCyvK5ZUzmi3nTn+rdHfkBC5ur
         ddDASFcFpXJKYnHe1tDgA3SbYgHBDNZfbSSMwxcFJxCfPq+NiN93s3VDZJzTTPTdAlw4
         xIhgasyqKSiPZJ3TXewqFzCx/YEoiXmWlz/+xtqWEKG8Yf/B9jUvoRtsPxSdrKSUDAHJ
         SfzQ==
X-Gm-Message-State: AOAM533TFhHF2n85/Xui6PQ0wAnAfZhwsQd5DAZvnCNvfrP3nVjvyDI8
        peUwBC2t25lblorWHIIp0RA=
X-Google-Smtp-Source: ABdhPJwjkMvZyqLFG0sCHtMfhXXc+rnNiU+6PHYsFUbDEQ/8Oeh3KJV3n+MLBC0VwX3mYmmysHJimw==
X-Received: by 2002:a05:600c:3593:b0:38e:a8a2:abe3 with SMTP id p19-20020a05600c359300b0038ea8a2abe3mr4932472wmq.149.1649780502596;
        Tue, 12 Apr 2022 09:21:42 -0700 (PDT)
Received: from leap.localnet (host-82-60-208-254.retail.telecomitalia.it. [82.60.208.254])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c19c700b0038cc9aac1a3sm3011747wmq.23.2022.04.12.09.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 09:21:41 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liu Junqi <liujunqi@pku.edu.cn>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        sparmaintainer@unisys.com, linux-staging@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] MAINTAINERS: Remove D. Kershner from Unisys S-PAR maintainers
Date:   Tue, 12 Apr 2022 18:21:39 +0200
Message-ID: <1683735.QkHrqEjB74@leap>
In-Reply-To: <CAMhs-H_JJ7JVccYjdoj5opTt6R5CHRBwQ05tXPuFgenpCuyy4w@mail.gmail.com>
References: <20220412103629.8029-1-fmdefrancesco@gmail.com> <2976258.CbtlEUcBR6@leap> <CAMhs-H_JJ7JVccYjdoj5opTt6R5CHRBwQ05tXPuFgenpCuyy4w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergio,

On marted=C3=AC 12 aprile 2022 13:30:43 CEST Sergio Paracuellos wrote:
> Hi Fabio,
>=20
> Check this patchset [0] I sent a bit time ago removing two drivers from s=
taging,
>=20
> Hope this helps.
>=20
> Regards,
>     Sergio Paracuellos
>=20
> [0]: https://lore.kernel.org/all/20211113192045.32153-4-sergio.paracuello=
s@gmail.com/T/

Thank you very much for the link to your patchset :)

I have just taken a look at it. I'm pretty sure that it will be very useful
for accomplishing the task of removing the unisys sub-tree. I've planned to
do this work by the end of the current week.

Regards,

=46abio M. De Francesco


