Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9A957D2AF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 19:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiGURlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 13:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiGURlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:41:51 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7446804B1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:41:49 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y4so3059182edc.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jrOYLEhcS0420xmVQthPyRSyBJPZ/EqshTnmV/2s3/o=;
        b=HaQMMf/lNG/g52eo3gYTsJdE60j17zx7piC5a1J+s9dbt/vdM1VejF+7jojw+wO3/N
         mtFIH/xngKCKZPh+SVIBBgXN6v7W7wdzeW2e2CK2BamcBsKmAZWsOPsXHqs3z/H7+RLZ
         n0ndHCmXYVLy9DnzwZjQrfJ5qVBMimGwmQAjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jrOYLEhcS0420xmVQthPyRSyBJPZ/EqshTnmV/2s3/o=;
        b=uNFpN0JnVdCy3KJsTxJytweuFMzpMnEqW077x+htyfGxR6j2UshQKgIs2XwzelyI86
         drn0ApWiF7EYGe9R0rq3fkeAuwvwwzqqzVpcK3l2xfLtj0azWF2ssJo8KuJYhVX6t+wm
         Uk8hpdT6YnxFYNMdOjMuRK0igEi96In9i1HuBoBriM4OHqrrrx6MhvrR2V/ljY98qYAq
         taWiutUfDz/n8hW/xzdtCovKorLl/95qE3xrOtVB1y3E44wklA2DdvVpUpBgv129r762
         /o4VeglmFSu+GV544k+x7I2Tk+0JiYXtwk5FvyNu5kj6+nq69V6ABBKncY3A6eyEtplZ
         1gGg==
X-Gm-Message-State: AJIora+U/8BZqUUrHs9WK9BzDzF1b+ZhoGreX3J9fbXFE0idDe8WcQPy
        rjOIabVQ3rpsF/xjyxrSrGNFZIlYJhHXG0FWy6E=
X-Google-Smtp-Source: AGRyM1vfTrz0wAguwCJml3wauWkTcHsoRuczDSOAJIrgVj4PbrYp13yoHCRJeI6hgJenDIK9GGFjcQ==
X-Received: by 2002:a05:6402:440f:b0:435:2e63:aca9 with SMTP id y15-20020a056402440f00b004352e63aca9mr57095257eda.162.1658425308160;
        Thu, 21 Jul 2022 10:41:48 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id cy24-20020a0564021c9800b0043ba1ecb0dfsm1336914edb.75.2022.07.21.10.41.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 10:41:46 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id w8-20020a05600c014800b003a32e89bc4eso1208443wmm.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:41:45 -0700 (PDT)
X-Received: by 2002:a05:600c:2211:b0:3a3:2149:88e1 with SMTP id
 z17-20020a05600c221100b003a3214988e1mr9253524wml.8.1658425305550; Thu, 21 Jul
 2022 10:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220721093042.9840-1-khalid.masum.92@gmail.com>
 <CAD=FV=UbRX194rDztr_=eoALg4kTmjzq=EXCX6RJSSq3vO=fbw@mail.gmail.com> <Ytl/xkb9OC43dgJd@bombadil.infradead.org>
In-Reply-To: <Ytl/xkb9OC43dgJd@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Jul 2022 10:41:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgDsUDBeLWfFXTWSQcAGq9YS5gjMeNe-1KpXmyo_RwG8A@mail.gmail.com>
Message-ID: <CAHk-=wgDsUDBeLWfFXTWSQcAGq9YS5gjMeNe-1KpXmyo_RwG8A@mail.gmail.com>
Subject: Re: [PATCH RESEND] scripts/gdb: Fix gdb 'lx-symbols' command
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Khalid Masum <khalid.masum.92@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        kgdb-bugreport@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 9:33 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
>
> This should go to Linus prior to the next rc.  Linus, I think this is
> worth picking up now as I smell a final release soon.

Applied. Thanks,

               Linus
