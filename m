Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4936658630B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 05:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237259AbiHADYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 23:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237074AbiHADX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 23:23:56 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B429C65B1;
        Sun, 31 Jul 2022 20:23:55 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q7so10888490ljp.13;
        Sun, 31 Jul 2022 20:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=GNxvEO8zKMF9CuL60442aziMrziKJwXDy+lUG20M/ag=;
        b=iyx3d/NDu2nKpMoy/Z9uAw6CuiuFJYmEEu4gVHmqdwBt5ror1Ahn3BNZL1p+OmS9HE
         tAyIPEko9+xcgfN/Je26e00wMf18DiARtGozbBZRu4XaFfijI2YJ1oOIIq0CMr9spXu2
         gi4ZVOjpKapMxnbUlHVaXaqDmaXALMj9+WD8ojtm6zhn7JMOGlvHC9r1PpAPfYIdT/8E
         5deVq7qTyvZBBlec470JvDLuZzF8vEiT+4etz6i/E+rlNeM6m9tz/ywPWCtAlo6cM74i
         3dDoNaDkeNIs2CGOpop3eiqjG9K21J0xneISc9BX6XowptUOuOtuL7Au/vbnV7crIYFh
         xPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=GNxvEO8zKMF9CuL60442aziMrziKJwXDy+lUG20M/ag=;
        b=C7gCt1igVj2Swks3cQDGuUJfLlMbJUwzH/vs+t6YTYUPuPx+MPGegUx2n/ijcmneh1
         g0LBqaaZZbFO6djAGe/PxuTPok8MrUAsqVECkkQvBBR9kWzZjgfKqdRy6gzTX+BMkwY2
         euUj7BB2Te4lW0oRQYV0hMy16kbVbsgANYddk8NCNb1N0Kfkt0P/MTeCqyno4EDdO+5n
         W2kA7NPMhQ+0bKLSxNyFyFvnBmW585EPZx1rjp0Tz9Gu1VY6bIOLbHWqVs76hPE0JRAD
         x8sRY+CTAmmBX7+ma7wOhrbgUYveSp+lqLeOBp2+nsLugVX+56Ibm3cMTFBTBsdnKICD
         PVGg==
X-Gm-Message-State: AJIora8ud5PWpejrIMEgibiFaCylZKGCXbNbfFylb3Nr80IkfWxyg12B
        Jx6B0mgHVpGsOTFwjSnQTJXVx6KwLNQ6tGWZaw==
X-Google-Smtp-Source: AGRyM1tC/foZjMEICK7b3UU3dizOYg3b315tP53NJ2o45HmK9C2RYWpFxF7iN7nxEF1ccgNI3PN6erQlx3BUs/zqYBo=
X-Received: by 2002:a05:651c:98d:b0:25d:eb67:7160 with SMTP id
 b13-20020a05651c098d00b0025deb677160mr4247395ljq.385.1659324233799; Sun, 31
 Jul 2022 20:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220720204414.1.I699244ea7efbd326a34a6dfd9b5a31e78400cf68@changeid>
In-Reply-To: <20220720204414.1.I699244ea7efbd326a34a6dfd9b5a31e78400cf68@changeid>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Mon, 1 Aug 2022 11:23:42 +0800
Message-ID: <CAGaU9a_Tm_awy+EAaYpv1Aj+URKkrD1yZDY2dWbhoWj0qUr5uw@mail.gmail.com>
Subject: Re: [PATCH] ufs: core: ufshcd: use CLOCK_BOOTTIME for debugging timestamps
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniil,

On Wed, Jul 20, 2022 at 6:49 PM Daniil Lunev <dlunev@chromium.org> wrote:
>
> CLOCK_MONOTONIC is not advanced when the system is in suspend. This
> becomes problematic when debugging issues related to suspend-resume:
> the timestamps printed by ufshcd_print_trs can not be correlated with
> dmesg entries, which are timestamped with CLOCK_BOOTTIME.
>
> This CL changes the used clock to CLOCK_BOOTTIME for the informational
> timestamp variables and adds mirroring CLOCK_BOOTIME instances for
> variables used in subsequent derevations (to not change the semantics of
> those derevations).
>
> Signed-off-by: Daniil Lunev <dlunev@chromium.org>
>

Regarding the suspend/resume issue breakdown with aligned timestamp
with the dmesg logs, perhaps we need to use "sched_clock()" since it
is the timestamp used by dmesg?

Thanks,
Stanley
