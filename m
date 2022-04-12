Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB034FE14A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345646AbiDLM4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355199AbiDLMxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:53:53 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3295ED7F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:24:44 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id m132so3507379ybm.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zJUVoBzO6hrpLcfPPCFuSvuiFl3vyOjkTlhtr2tqjUY=;
        b=RR4qz6zD5RcZ/alMSeipglKTJWFZevMcYsmlcFVoj0DDLaWh93+6xpZ1fzeHQHGcSk
         IVhVntFFW9QlrtRJteIs2ZaPQb9KxwG1WfgD4iNAU50A9A4dVmiQ8IadWzoDULWplVdD
         Y2Xv8QedWTyzO6JmevYybLvY/2/YCHWXLmo72lNU5cTxOKQ88ZGN3Aboxk0VLTYrldt8
         Wq/svTPSlngiyC8t6Ggt0puulwk1VyWY8g6t4kNNUfLFAfy6xaPFuBBm4I02wTMm4UsW
         F6qL0JYnSddgSO159Uy3zmWqSe2LH7LM3VzN5cZf38Iii7n+RWorbVLhs2X9T9rwJwuB
         PANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zJUVoBzO6hrpLcfPPCFuSvuiFl3vyOjkTlhtr2tqjUY=;
        b=CTBf0z5NVgT8T0CkuuE35SpDH38cLvK/wBGUNoQUCDUmjVohlyyoH6g3pR1LQaebm3
         t3kSCF3oSz84Ny7WnW/9J2DkTbvUGmMeKfymJ0NvNqQ6a+QmJ9xcYzTgY3xiWOee+ZBC
         yRdlmAJzsIoB8IkVLGQ4aAapX8J01JTyhMY8hRj9UmVaBGJ9OhNeHq8u88fP5LWqyPU1
         YF9XUMfjVtHAdDPzMGUiveTiDdTqP3LtH1hGxo1AqAAmANyBQd1NmiFliKmarmdgHytG
         RAbYOhJnS1P++gA1tvRszDt0AXqrdnpCyoCXQXW0a7Ma62wOjH97W7MqbglhAKW6U18B
         Gyqw==
X-Gm-Message-State: AOAM533/6vp7Gw9eq55zz9hbKPh+2vUxYCtaHrobFPof7qb3nBoFh9X/
        tpWtSW3TnuRzaLcyXSsfEu6pxxSxI6lB95ftv1Dn+9xmROs=
X-Google-Smtp-Source: ABdhPJzqUzEcxwGD+V2PZC1IslinKI8zfvViS64AmY4H/Ji69FKtZVmSJQAI26xgNH66bp01UbBmQIU1wxntK69R0cw=
X-Received: by 2002:a05:6902:1247:b0:63d:c24a:5d51 with SMTP id
 t7-20020a056902124700b0063dc24a5d51mr25371817ybu.428.1649766283435; Tue, 12
 Apr 2022 05:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220316041612.71357-1-jiangshanlai@gmail.com>
 <20220317221943.6vhoqx3fdv7py6hi@treble> <CAJhGHyC1qPee2QOpgR8B+2Sd+XzfoJD3NL9biFZ5gKE-B9r_rQ@mail.gmail.com>
 <20220318170312.rc2zgtubddg4dpya@treble>
In-Reply-To: <20220318170312.rc2zgtubddg4dpya@treble>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 12 Apr 2022 20:24:32 +0800
Message-ID: <CAJhGHyAjXgqxxH+myLt0nMcSLQWWLrcOb8WevyQNf-Oajip7-A@mail.gmail.com>
Subject: Re: [PATCH] x86/sev: Add ENCODE_FRAME_POINTER after stack changed for #VC
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2022 at 1:03 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> Ok, maybe Joerg can test it.  It looks obviously right to me though.

It looks also obviously right to me.

Hello, Joerg

Any feedback?

> Since it fixes a real frame pointer unwinding bug, it probably needs:
>
>   Fixes: a13644f3a53d ("x86/entry/64: Add entry code for #VC handler")
>
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

Hello, Borislav

Can you have a look at the patch, please?

Thanks
Lai
