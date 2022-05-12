Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BF3524DF0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354215AbiELNL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354249AbiELNKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:10:54 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2691DA51
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:10:49 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-edeb6c3642so6561556fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sdLATnA0kcPNoqu23cfiMLmFcXc/ybpMfIMW+RMWEMQ=;
        b=WH/Yg/K2dHDjtYEYJw7pMyeqK00jg9PMsnBNd1pniF5ESO43pGuCO5fdpfXfdvg5GS
         dXTx+tXrKuQ2bEym+hdoMu3ZiHpWZh8HoBecQMlgoxILQUx5GP3ns+53JGTVqz81nxHs
         H8XCAbvLb1JMXpVlagB8O97aKBvYKmmLaiP9k1qxyXicWB1+cyUX/noBAfgX4Iwf+DWx
         Q/0VY3i4K/tlbkd14LKewDJl+22Dflp2EotibMBNPrwppTqRJghkISNCNY5jVSXp71Xy
         uYOFVcj6HHUiZvS0Sb2f8wEKmaPnVeXbBFwQS50AXuIsCdKGe5jPHfxGmCKc9rqrQBrU
         +CwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sdLATnA0kcPNoqu23cfiMLmFcXc/ybpMfIMW+RMWEMQ=;
        b=lozOdndO/g+ve+NRH7xwGHm3IR7G7PWXW7d1er3kjZvMIyQsi0zJY4eahxZldZ0WSx
         l0NYxmIosCK9FQOgh+A8huld4mGKUi7WPvmzHHgriYm6e9RWjrQ14GvnZr/tb/P8kgKN
         dvMFFO2rPxBcPlhW5cQkpTaRZswOeTayDhm8bhNvhrzMo1Nia7nk2dj5QWCDCvv7d9WE
         pBKmqHMZggn3fErXpaZ8ZicG9MTTXSocl+dXfohAms+64mRUpFqh/RjbzQ/1rHYqqo4C
         IRnXsVJeWMrpSShUicvUQ0FZc0/2SmMpXRzzbiE372VMIeMDGgHBsZR/0+I9ByigcKL2
         9qEA==
X-Gm-Message-State: AOAM533NBwa1sULy9v58GjFHr5sppGQDrp4I07xvjMWyAYaGPw+2lyDd
        Lqby5MtdTzgTj4lXWqSYCcoXPeCd2EEauDYS1QjjJw==
X-Google-Smtp-Source: ABdhPJyS3tE3qF+JcU9MU6Fu4rHz6PDTLQJ7dBPcxrOf3QlhTSnRdWW6XbLBXQksgHFll5uPtYKXAL4qBCTjy5JTea8=
X-Received: by 2002:a05:6870:d254:b0:db:12b5:da3 with SMTP id
 h20-20020a056870d25400b000db12b50da3mr5466937oac.211.1652361048752; Thu, 12
 May 2022 06:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008a7a1c05c9e53c87@google.com> <000000000000942c2205d6dc0896@google.com>
In-Reply-To: <000000000000942c2205d6dc0896@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 12 May 2022 15:10:37 +0200
Message-ID: <CACT4Y+Yfw+SFqbjqkBFw9aN7PABEgJapr7M2iY-O3nBwrMHVfQ@mail.gmail.com>
Subject: Re: [syzbot] WARNING in drm_gem_shmem_vm_open
To:     syzbot <syzbot+91525b2bd4b5dff71619@syzkaller.appspotmail.com>
Cc:     airlied@linux.ie, bugs-a21@moonlit-rail.com,
        christian.koenig@amd.com, daniel.vetter@ffwll.ch,
        daniel.vetter@intel.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, javierm@redhat.com,
        linaro-mm-sig-owner@lists.linaro.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        maxime@cerno.tech, melissa.srw@gmail.com, mripard@kernel.org,
        sumit.semwal@linaro.org, syzkaller-bugs@googlegroups.com,
        tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 at 08:50, syzbot
<syzbot+91525b2bd4b5dff71619@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 0499f419b76f94ede08304aad5851144813ac55c
> Author: Javier Martinez Canillas <javierm@redhat.com>
> Date:   Mon Jan 10 09:56:25 2022 +0000
>
>     video: vga16fb: Only probe for EGA and VGA 16 color graphic cards
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=126571e0700000
> start commit:   5d6ab0bb408f Merge tag 'xtensa-20211008' of git://github.c..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=32e6048063923b7b
> dashboard link: https://syzkaller.appspot.com/bug?extid=91525b2bd4b5dff71619
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11073300b00000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: video: vga16fb: Only probe for EGA and VGA 16 color graphic cards

Not sure, but maybe:

#syz fix: video: vga16fb: Only probe for EGA and VGA 16 color graphic cards
