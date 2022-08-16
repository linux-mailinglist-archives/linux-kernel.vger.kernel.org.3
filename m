Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C27595344
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiHPHCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbiHPHBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:01:00 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27451022A7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 19:27:17 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id a14-20020a0568300b8e00b0061c4e3eb52aso6628460otv.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 19:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=sXgeOW1LGi8MM4yVGp5zgGERRljNyGhH22BW5mob+Ls=;
        b=JjHhOaNDTBVJYBoaLj81WqLdQyGVp5S8sYO1N6gRxRWu9jMc6MatSBEeTcdhO5Q8Oj
         QCnS+iibiRCKrXHSsre9viWVJSdSTZjrYBB9vbWgywMczgWCI9HpHvv6AWyWr4KaxS5U
         TVNLpqqB/XvgfoPv96x1mJ35UOIEQx0jZhTvl9Km8DVPopdG1foUeFKCs0vldwM+OBXL
         IP0lFNv1hWA3zH1keduPNBVRZcGSQgmtbmmMEV+aIDSMRGT3mftZMlvHrT1s9YicyqsO
         X51vy30swk8Wxm+JZ0/5AzvdOTJiJoRUxQxsEpZVlIPT42uakjTNuf+St3S1k67XPDZI
         KEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=sXgeOW1LGi8MM4yVGp5zgGERRljNyGhH22BW5mob+Ls=;
        b=jbehlPhBxbEE0HIuVmwrmlzm+6nrxYZUwyDyWXFSP7ZPDiYpl4fU/gj3if0DTAAFkY
         FGmVRN9FVJCw5PTN8xC7gNh1FUdDEIWZuYuMExvZhBZQsYbN7inVuQmt7f9QSU4Lnt6I
         1z/GV6j6BHjqszYX7/PLhFsGikTADVbqgQjpIhyPp4UYixqXBciYvkNFuOd3kV2a5CJk
         wBdtyiQluFR2PQ3tWKtDDRUPwJJ95RKXHrVW8Ni114PSw1J1vosUGPJaco5X9vnl3G6H
         BRAaNtYKd3BxKADlvfNKGtHjNpKoogriPXdd4+5v3kjoPaHr4YWwkhYy/jcj+XOC0vcG
         6Muw==
X-Gm-Message-State: ACgBeo0iqn55TE+tn2KF0xtVkCU4ff0J9xnF1u0RDJxrMMjaJHa2mq9k
        Ui4OYcCgUGBcshAr0PzD0L77xva6klFRcbXABR8M
X-Google-Smtp-Source: AA6agR5kVy0voQZTkDhLI8nXNZG55rnEFkSvbfBoeVjBInK22na4RXuzhYFvSgpAS9LNZDSBz65Iaxw9i9FW4U35CbE=
X-Received: by 2002:a05:6830:33e4:b0:636:732d:5a48 with SMTP id
 i4-20020a05683033e400b00636732d5a48mr6937750otu.69.1660616837000; Mon, 15 Aug
 2022 19:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220714012421.55627-1-xiujianfeng@huawei.com>
 <CAHC9VhRM8_Eo9rCL88LLgY7e=soKpSSRK2Zftt9e24GC3A_yMQ@mail.gmail.com> <e4b4833e-7c28-9b7f-76d9-a1c5335368dd@huawei.com>
In-Reply-To: <e4b4833e-7c28-9b7f-76d9-a1c5335368dd@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 15 Aug 2022 22:27:06 -0400
Message-ID: <CAHC9VhRfkpc6MwEELLcWaGg1=h_=cVgV526qyVc5x0sQE7OVsw@mail.gmail.com>
Subject: Re: [PATCH RESEND -next] lsm_audit: Clean up redundant NULL pointer check
To:     xiujianfeng <xiujianfeng@huawei.com>
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Jul 13, 2022 at 10:49 PM xiujianfeng <xiujianfeng@huawei.com> wrote=
:
> =E5=9C=A8 2022/7/14 10:33, Paul Moore =E5=86=99=E9=81=93:
> > On Wed, Jul 13, 2022 at 9:27 PM Xiu Jianfeng <xiujianfeng@huawei.com> w=
rote:
> >> The implements of {ip,tcp,udp,dccp,sctp,ipv6}_hdr(skb) guarantee that
> >> they will never return NULL, and elsewhere users don't do the check
> >> as well, so remove the check here.
> >>
> >> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> >> ---
> >>   security/lsm_audit.c | 14 +-------------
> >>   1 file changed, 1 insertion(+), 13 deletions(-)
> > Hi Xiu Jianfeng,
> >
> > We just changed LSM maintainers earlier this week, and while I haven't
> > forgotten about your patch (I reviewed it previously), it is too late
> > in this current release cycle (-rc6) to merge non-critical fixes.
> > This would go into the LSM tree after the upcoming merge window.
> >
> > Thank you for your patience and understanding.
>
> Hi, paul, I get it, thanks very much :)

I just merged this into the lsm/next branch, thanks for your patience.

--=20
paul-moore.com
