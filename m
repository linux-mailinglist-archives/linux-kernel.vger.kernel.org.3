Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B35509A21
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386411AbiDUIH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355609AbiDUIHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:07:16 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFD91DA42
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:04:27 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-e2afb80550so4658173fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5BVjlGwH06cTyu6muXsNBsyVK6oxj3UYMa0frNggqds=;
        b=DW5A8NyrPu5kmtG6ZlwJsLfXNpG7VuBOeXgRhetvMBOfIpBJZ74ru8E03tjXxmvd+X
         aTPl5MB8ba9gBc2hX7NQogMvyWug9swFGeE6el5EXsMuiVASFXiATSgRsneQ7tant1Ny
         VsMSqP+yIbaMr8wWKqnDkjIRglGy/D6RQRzmmF08jDIB2uxobioRu0OouR6mGKOfmxAx
         3T7JXsBZoaBjSw70q6iUm5umC9UUyMIY+Rbo5405g77+oTYcx1d62W7AtAWgp2as7pnp
         htTdHxQt54wmw5KjhS2D6TVan8zS24RfO1Bf5JTZAqX3LhusLoz4k/SaUvktAw7xycvG
         p0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5BVjlGwH06cTyu6muXsNBsyVK6oxj3UYMa0frNggqds=;
        b=BHhE20mKRTEYGTfSnmLlS7LsnWIAozmLPX3LLe+PbaRx49Lj6TO4fTNb9o4mmI+vnE
         oN3ssrajqVAZOgy8CCFyGbOGNBMI+38U9zJ5L0OCIAD2E000CQrLKZQqeSqMtZgNLn3D
         +WlDlMXrBfPpFJJhr3E3gIHOOuCWw1cI+Kg75D8g2RVAFCZINZWYNhil2GMa/JjRlBu9
         TIDgOvcdlQTWT5279RlY7QpuAKcba6GaAm6RVPsAIGqwJftaGaUSN4ruf3kmJ9QYXPOf
         IUPdyzAvFLS5Lak/VchL8+eDnOwWuzsbt7LqcBE0s5E51ou86LCr6KtnXSCnAFR86InI
         w4cg==
X-Gm-Message-State: AOAM533MXlUm4XrEanZ42zzYFSWsuptueQ1dbZebTe+wOBz3zG/kdHIE
        3ny5EvY5PH3J4OFJF2x7FQvLI6jk5k7xJNgGOfRXSQ==
X-Google-Smtp-Source: ABdhPJxWY3/xQrMA/LGLDcUbYJsNHYAuaDCQ0ZZwkR5qeQGTshY+L+HBii+8hjXoK0Sn1TiQp41iyOWJUdQus1maen8=
X-Received: by 2002:a05:6870:d254:b0:db:12b5:da3 with SMTP id
 h20-20020a056870d25400b000db12b50da3mr3327530oac.211.1650528266235; Thu, 21
 Apr 2022 01:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004ecea505c28504b9@google.com> <0000000000007b1cbd05dd1cab5a@google.com>
In-Reply-To: <0000000000007b1cbd05dd1cab5a@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 21 Apr 2022 10:04:15 +0200
Message-ID: <CACT4Y+ZWAFKBCnj18n8g8KsrQL9bxO7uCMmcQjk8-24G_caZHw@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in pm_qos_update_target
To:     syzbot <syzbot+f7d9295d2565ee819d21@syzkaller.appspotmail.com>
Cc:     alsa-devel@alsa-project.org, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        pavel@ucw.cz, perex@perex.cz, rjw@rjwysocki.net,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 at 23:28, syzbot
<syzbot+f7d9295d2565ee819d21@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 3c3201f8c7bb77eb53b08a3ca8d9a4ddc500b4c0
> Author: Takashi Iwai <tiwai@suse.de>
> Date:   Tue Mar 22 17:07:19 2022 +0000
>
>     ALSA: pcm: Fix races among concurrent prepare and hw_params/hw_free calls
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=104e3034f00000
> start commit:   dbb5afad100a ptrace: make ptrace() fail if the tracee chan..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=91ff0467ce169bc
> dashboard link: https://syzkaller.appspot.com/bug?extid=f7d9295d2565ee819d21
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16c75e73d00000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: ALSA: pcm: Fix races among concurrent prepare and hw_params/hw_free calls
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection


Looks legit, that code is in the stack trace:

#syz fix:
ALSA: pcm: Fix races among concurrent prepare and hw_params/hw_free calls
