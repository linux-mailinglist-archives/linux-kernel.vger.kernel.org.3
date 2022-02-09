Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C504AE85B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 05:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345140AbiBIEIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 23:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347124AbiBIDjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:39:07 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F74DC07E5C8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:31:54 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id n32so1926851pfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 19:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nm1MhDiI7ACoH1isbwKzuaKIm3CJ2CO2yAwTgo4zGJk=;
        b=kwyPIA8EWByHJHhMVfppWnBxtF3QcD13PaBI5rdfaENrQgBWfvqL6YSlZtQwhmJq0Z
         tuhPmt+oprwxq0EInA4/+brjf6wHfqUB+32bl1xSbtGxsLyBUqDfdybaphiUqddncfHG
         Mbo2jEmUnPagMQ756cNld1u4eOu25tlL8zIQXDfPYtjsJF+Tp64LoODMZNozk+n9erLa
         jWMlNGkhbN417gsgV3u184szVbtzZzRsa6i9YbEVUT2mOyl0ARtaeI1erWzTdBar8O0M
         ylpSW0v8lAEraRaZ+mdiL3frPXTxOtStqKdXNmcUrbV4vQAhC7qxu2JM4bKtMB6LcEVZ
         Fz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nm1MhDiI7ACoH1isbwKzuaKIm3CJ2CO2yAwTgo4zGJk=;
        b=g4ZKoSBShsVmMwRJ4QILXIDAeA1gxaz7F3FpQ4erZq1l6m/wWBiYUDsdEp7mYuu0ml
         HAakT4BpqbRM4pcige8H3n9bjd4J85NS+vvxONMmiSZkU5D7YqyMLRKhpuF1VWJ68MsC
         RG5eNKf5Nn2Na7i8/CJB4gJmmm9YlOOdXDlqHwsJxamwPjUAo8c+Zuq1C01sETx1MnFk
         2qdfmtWdbdZadluJcRZIjCJINWW9T05Mqa+hisOVpCzigkr4huSaWuQdu+lqn0ym7Nz6
         EX1jSjKU5r7HHjKhZukg9L93PTiiHAHelkZn7lTnbXkOV+QNBIfMTG3dpnkREtHGCRtw
         TQfA==
X-Gm-Message-State: AOAM532NekOrVQt4SjRBJ4UzCCJn7AoDJDfib59bYG984n9hl9w2mD8F
        rB/9uN+I1MZhrmLvkmBEg5u2VaDwo8yUdg==
X-Google-Smtp-Source: ABdhPJzrgWHaTE7DCxTP2Ukf5PB8XE7cA8htaCjEpV284mIxWtbOGk1GuU5hQRMvjPNu/XXWb5KUdw==
X-Received: by 2002:a05:6a00:1c5e:: with SMTP id s30mr284243pfw.43.1644377513631;
        Tue, 08 Feb 2022 19:31:53 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:4b6f:f14d:be50:86a])
        by smtp.gmail.com with ESMTPSA id nl12sm4827508pjb.1.2022.02.08.19.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 19:31:53 -0800 (PST)
Date:   Wed, 9 Feb 2022 11:31:50 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROMEOS EC USB TYPE-C DRIVER" 
        <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH 3/4] platform/chrome: cros_ec_typec: Configure muxes at
 start of port update
Message-ID: <YgM1pjwN2MHaMQCJ@google.com>
References: <20220207214026.1526151-1-pmalani@chromium.org>
 <20220207214026.1526151-4-pmalani@chromium.org>
 <YgIBv2SQdwXm7RLt@google.com>
 <CACeCKaezRNgsqrq3QJ1ViHjYScFrjpC-kCaYmE8kOXCcW9MRrw@mail.gmail.com>
 <YgJQ30D8nc4LWvUy@google.com>
 <CACeCKaf4+jxSkKFqx9g3YSPWj-FkbL=jrmHE3YEu7oU0ySPJ4Q@mail.gmail.com>
 <CACeCKadujMj4pJqf_jNNmO4UkQinw9QNu_MXe5zkTySUn6R=dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACeCKadujMj4pJqf_jNNmO4UkQinw9QNu_MXe5zkTySUn6R=dw@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 02:58:51PM -0800, Prashant Malani wrote:
> On Tue, Feb 8, 2022 at 10:35 AM Prashant Malani <pmalani@chromium.org> wrote:
> > In general, I think you may benefit from reading:
> > - The entire cros_ec_typec driver
> > - The EC Type C state machine [2] and interfaces [3][4]
> >
> > The above 2 will help understand how this entire stack works. Without
> > it, it is challenging
> > to process the flow (just from code review).
> >
> > If you have further questions our would like to better understand the
> > drivers, feel free to reach
> > out to me over IM/email. I don't think public list code review is the
> > best option for this
> > sort of explanation.
> >
> > [1] https://elixir.bootlin.com/linux/latest/source/drivers/platform/chrome/cros_ec_typec.c#L549
> > [2] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/common/usbc/
> > [3] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/driver/usb_mux/usb_mux.c
> > [4] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/common/usb_pd_host_cmd.c

Thanks for the link pointers.  It would take me some time to understand the
background for reviewing the patch though.

But in general, I would suggest to change the title for a stronger signal
that it fixes something (per [1]).  Otherwise, the title and the description
in cover letter looks like a move refactor.

[1]: https://patchwork.kernel.org/project/chrome-platform/patch/20220207214026.1526151-4-pmalani@chromium.org/#24727676
