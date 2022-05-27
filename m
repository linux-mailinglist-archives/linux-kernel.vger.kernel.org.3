Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705FA53576C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 04:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbiE0CBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 22:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiE0CBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 22:01:37 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A134B1E3DB
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 19:01:34 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i11so5685634ybq.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 19:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ftTeYKP9cfFJxUORbZTewghh6E2NdQvJ/R5uaGw+pNM=;
        b=gzHz70Tr6RZspSCNjG1e+dt5VKS5Nnq1KCvlvCNtiXgdkrj0ytyKL0EWBdF/HuhIz0
         vlRzvwQ8dc/D7+jJNeNnWTllUHKfGuLIJNsPPeEYjaNm2D4r9f2F9Oa7O1DRnd5rpTlv
         9f9R4O1D1SmDvDHbElYoIIQPrweXcNNPnM70H5BiP93rTSPMdNesCqxc0Hn5N/0pcO8R
         XIDkgN2eDMzU9z24QUIYywDKxPHWMmFtDzuJ9Kymyczc/yaXDzkrekV15rHpg6k/7Nmi
         9KGZKAr7VCrBkbEan8C0WaNF2KsGDvv+rnWp3+JTiB/hirgk/7BkuOZ20oSuB+tjKk5T
         JeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ftTeYKP9cfFJxUORbZTewghh6E2NdQvJ/R5uaGw+pNM=;
        b=Uo7yVesppdCZhB6W6ECWsnreF7yCfhw+ZlqnQxVdkMRApgYaB9qIaJ1G0i8wxnSk1T
         PkdUptpunZVk4sxaw1Au1m431MdiirRC++31vpBt41Nc3WUiDc+2ydPypBQjd9lw3Dx0
         B5D++6Z4RAwL5p/vGm3+KK26KNMVXj8WHNUdAyOpdCYV7xtkqXJxqNyCDBF6oBG6Bpj1
         efXfvO+orpiRNWoYtPYmbWb7OeuRNOO5Gh0UAIhzfXqIk+48kgPnM6AGaXidoORZx+aA
         bdfQzyCMYODJVV+uUBnNHEK6M4v1bb7nC2L+vdI3RaKqLFhXZHfDgU3XadrIZfRTbsC4
         amwQ==
X-Gm-Message-State: AOAM530kq2AErJM+OVWvukDxAihDB7rJdEP0bRadHtRySokAxf43OnS3
        yx+OTYPXpqGqSZ1AFD2bEHbK4g31pI7YA/kTep6rIA==
X-Google-Smtp-Source: ABdhPJzDrEKXS6UMHA7U1HfrHmrN2xLUemJnQ4xt0WmmzOwB+698wHv3+OyTpKcScCbxPnfNsEICIL571EOZDcb2Q08=
X-Received: by 2002:a05:6902:4e4:b0:655:caf6:dc38 with SMTP id
 w4-20020a05690204e400b00655caf6dc38mr9247302ybs.261.1653616893842; Thu, 26
 May 2022 19:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220526142038.1582839-1-bh1scw@gmail.com>
In-Reply-To: <20220526142038.1582839-1-bh1scw@gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 27 May 2022 10:00:55 +0800
Message-ID: <CAMZfGtUE5G8hV2tUTLTeU0PwZvLroNfxy3oR3rMYq3hE1rn2Fg@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: use PAGE_ALIGNED instead of IS_ALIGNED
To:     bh1scw@gmail.com
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 10:21 PM <bh1scw@gmail.com> wrote:
>
> From: Fanjun Kong <bh1scw@gmail.com>
>
> The <linux/mm.h> already provides the PAGE_ALIGNED macro. Let's
> use this macro instead of IS_ALIGNED and passing PAGE_SIZE directly.
>
> Signed-off-by: Fanjun Kong <bh1scw@gmail.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
