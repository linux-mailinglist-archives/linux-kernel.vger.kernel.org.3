Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A59518DA6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236255AbiECUCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiECUCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:02:45 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2101D403C5
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 12:59:12 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l11-20020a17090a49cb00b001d923a9ca99so2905876pjm.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 12:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=br876lXgoKnwNSah9sz+Nro9CuCjWyEdAR5ePv2IfYc=;
        b=6fuea+VF2h7bfZGs4cNm6a/vwBAOvCpaUnQ4ck8ginaLolPOwrrZQP+oOTTEiMNhT8
         I6J0sI+mHmDRQuYDcG6bFQ4nCzwZOUX4fO+fzzywiBtzPHy3QkYGA3KiEx0Y7O40yV7S
         qOMqt50XcklYwLTzEfbFIhHalmMuEFCyHg8cCKsidEnACQj9itWPCqDRmbXwtikUmjVe
         gXdIuRsTzljxw8/JnOtusAf8OSXimTvZubtWOFWUI4f9LfCOsC5IbvYzQZowuQ2hAXoE
         OFvsgRnK4Lm2oYtHZcnyGtfrfmYX8MU+Lp8u0Ki4X1amSfvFQFX292i6SM/BvcxsCDt3
         l9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=br876lXgoKnwNSah9sz+Nro9CuCjWyEdAR5ePv2IfYc=;
        b=eQATRNgz1O5Qe80PCEMuFNsCzbUDkLyYUAGjfTArrOM5wdRshp8htop/LafV3nA6W/
         phulGLe9V1UUfv11ZcmXk/O/an9VSk2xfVL0f3AbUV8zbCw4halmS6Z6IoA2yzojSSEW
         JWBRm6QbWS77lM3qhPXyRxDSSY+bgVm2OE9Z/MuuCov77vV4ETY56uikQYki9ujMwRiW
         a5zK+TRuuNKt0xtRfr1oT9NNP4hHB+vKQzGvzRby/9C2V30xhrqsGCGDXtWWf2EoRutP
         qik4HqqHcqtiqqhu7VcI1OsBGBkVb3coBIetyVkk2G6esqKfUbI3b4hKOLBDna27GnGZ
         W9ZQ==
X-Gm-Message-State: AOAM531dUo4mC85cHAIrcYlb9gf8nlLznGeRTjJfsavvRYKPkaakx6KZ
        nqCsvhWNg0rgs2ZXKdciecrT8rmA4pvP3zJl6AdL
X-Google-Smtp-Source: ABdhPJw9EKdTly/DgbIhDLGWnjmswNtCrk+mCRGjhS0WEEm/jYfwLptQ0upL2OqF4YBy3SqWNTxHqLPrA3t+E5bU2ZM=
X-Received: by 2002:a17:902:b094:b0:15c:dee8:74c8 with SMTP id
 p20-20020a170902b09400b0015cdee874c8mr18054438plr.6.1651607951529; Tue, 03
 May 2022 12:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220308165527.45456-1-cgzones@googlemail.com> <20220502144345.81949-1-cgzones@googlemail.com>
In-Reply-To: <20220502144345.81949-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 3 May 2022 15:59:00 -0400
Message-ID: <CAHC9VhRhi_dA5XyvQpBmh3aBz-zLp9y4iGuGc4pV2qKc=Q-ouw@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: declare data arrays const
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Michal Orzel <michalorzel.eng@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Austin Kim <austin.kim@lge.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 10:43 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The arrays for the policy capability names, the initial sid identifiers
> and the class and permission names are not changed at runtime.  Declare
> them const to avoid accidental modification.
>
> Do not override the classmap and the initial sid list in the build time
> script genheaders.
>
> Check flose(3) is successful in genheaders.c, otherwise the written data
> might be corrupted or incomplete.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v2:
>   Drop const exemption for genheaders script by rewriting stoupperx().
> v3:
>   - Declare some additional data array const
>   - Do not use static buffer in genheaders.c::stoupperx()
>   - Check fclose(3) in genheaders.c
> ---
>  scripts/selinux/genheaders/genheaders.c       | 75 +++++++++++--------
>  scripts/selinux/mdp/mdp.c                     |  4 +-
>  security/selinux/avc.c                        |  2 +-
>  security/selinux/include/avc_ss.h             |  2 +-
>  security/selinux/include/classmap.h           |  2 +-
>  .../selinux/include/initial_sid_to_string.h   |  4 +-
>  security/selinux/include/policycap.h          |  2 +-
>  security/selinux/include/policycap_names.h    |  2 +-
>  security/selinux/ss/avtab.c                   |  2 +-
>  security/selinux/ss/policydb.c                | 36 ++++-----
>  security/selinux/ss/services.c                |  4 +-
>  11 files changed, 72 insertions(+), 63 deletions(-)

Thanks this revision is much better, merged into selinux/next.  I did
have to apply parts of this patch manually, so if you notice anything
wrong with the commit please let me know.

--=20
paul-moore.com
