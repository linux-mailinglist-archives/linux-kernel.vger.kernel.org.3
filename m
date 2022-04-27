Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AAB5123E3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 22:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbiD0UbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 16:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236186AbiD0UbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 16:31:07 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484741EED3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 13:27:55 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-deb9295679so3203818fac.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 13:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gp/F1d/4pAenz5mNMTTask9wErh38GRFBpgSf17aNWY=;
        b=Y0AbeCNkAgs0mjiUiyGZ/engX4b8WVlc02Y2wUD0hDGZhyPfy6Xt5PelzXLROAIYMY
         eVpRZE834J9mmhPAjJ299MhHB3z/7Wuo1ma5GxgdRNqWE05oroUNUajPWkOIKCBk3FO8
         JUCvvnkFoHNwWAF74dhzq6T0KmyitBNxK07d8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gp/F1d/4pAenz5mNMTTask9wErh38GRFBpgSf17aNWY=;
        b=J+ljvn5jO08kWQrJGV8QUWWSBa3BfQm+xpUUa+uKRtPUPpIlCGPekbIkcDL9+Nwhby
         AzB7rHnuonXcbQSIDsqTi9URWAEutgST/a2eeYoGhvC8R84ksAFbhvls9sy5hwlrOFmG
         11wswa9RaZ8xNb3QNxhBZ5+O1gQ17C00cS92b7fNBjnkRMlHGh2oSDN7CYDOccOMQ2Da
         fQ7c7YzFmLyKdeEjNbzU5AomrPt7x07Gk/SYtr+L9hMvSc/TKBAerQ9xCdp7ovY9CDhk
         ocIG3kPAZR5j3US3l2yxXDlafBAiMM0rvq+58rseJoHT9Y/51cN7PzEc7zACqQtMz0Qk
         dRqw==
X-Gm-Message-State: AOAM530Xi4DF3iy8CHWpLI2PN50uCjoVxJ4qbO2PDK1mvz/iIVQMIFpW
        aY/A4DmUWFmechIizp+CVud7+4YWvXWNIA==
X-Google-Smtp-Source: ABdhPJw86nCJI5ftL2abxKJX9/pX7oKbnih7WadtiWcIpfxm1Df0egpG/yU0+b5rkpFKlY3yWKWLCg==
X-Received: by 2002:a05:6870:60a6:b0:e1:937f:22e8 with SMTP id t38-20020a05687060a600b000e1937f22e8mr17102395oae.183.1651091273633;
        Wed, 27 Apr 2022 13:27:53 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id 14-20020aca0f0e000000b003222ac151eesm6197991oip.1.2022.04.27.13.27.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 13:27:52 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id d16-20020a056830139000b00605e13c23c9so1245128otq.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 13:27:52 -0700 (PDT)
X-Received: by 2002:a9d:58c3:0:b0:605:9fa7:f5b6 with SMTP id
 s3-20020a9d58c3000000b006059fa7f5b6mr7777249oth.230.1651091272112; Wed, 27
 Apr 2022 13:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220426221859.v2.1.I650b809482e1af8d0156ed88b5dc2677a0711d46@changeid>
 <CA+ASDXPNFwvYVBMHjbTNQ-uTnQrs5TvPAH2jXgPKuFLUw2GbZA@mail.gmail.com> <CACTWRwtXSHnhxTEZ+pWWNpfd-BANtHuNUDimmwxJ=COL6HJQTA@mail.gmail.com>
In-Reply-To: <CACTWRwtXSHnhxTEZ+pWWNpfd-BANtHuNUDimmwxJ=COL6HJQTA@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 27 Apr 2022 13:27:40 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNLnb4OEZtFVb4D64QNkK=sGYUUVuZPwO1-zOOD0hfqyg@mail.gmail.com>
Message-ID: <CA+ASDXNLnb4OEZtFVb4D64QNkK=sGYUUVuZPwO1-zOOD0hfqyg@mail.gmail.com>
Subject: Re: [PATCH v2] ath10k: skip ath10k_halt during suspend for driver
 state RESTARTING
To:     Abhishek Kumar <kuabhs@chromium.org>
Cc:     kvalo@kernel.org, quic_wgong@quicinc.com,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 10:20 PM Abhishek Kumar <kuabhs@chromium.org> wrote:
> On Tue, Apr 26, 2022 at 3:34 PM Brian Norris <briannorris@chromium.org> wrote:
> > You could have retained my:
> >
> > Reviewed-by: Brian Norris <briannorris@chromium.org>
> >
> > but no worries; it's just a few characters ;)
> Oh! sorry about that, I was under the impression that if the next
> iteration is posted, then I cannot just add the Reviewed-by tag
> provided in the previous iteration by myself.

You certainly *can* add it, but it's a judgment call on whether you
should. In this case, you were only making cosmetic changes (commit
message and comments, requested by reviewers) between versions, so IMO
that's totally fine. If there are more substantial changes between
versions, it may be better to skip it, and let the reviewer re-review.
Sometimes a reviewer might even explicitly say, "with changes X and Y,
consider this Reviewed-by: foo <foo@bar.tld>", which is a pretty
strong indication you can add it.

Anyway, it's probably better to omit a review line that should have
been included, rather than include one that should not have been
(e.g., because undesirable changes were made). So again, no worries
from me!

Brian
