Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD475348C7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 04:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345514AbiEZCSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 22:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbiEZCR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 22:17:59 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54B5BC6F6
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 19:17:57 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id q21so540953ejm.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 19:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lV5zgCXHyqPoniN4egpc4ez8v2ywGktu+KT77l1Uk9w=;
        b=TWlmfSYO1gOTBu4bXnhrBzM1Rv9dK1/PZds8v/pKilDbkkFP21w0PVI58t7co3BHlF
         ShnTmtragg2Cx23Y2qLdT72mfuoDSuBYjJrJsDUEU7Vtde2CX1jBU9X4X3cgHbRlV4YI
         MLTPfTDlN5hV/rhUvSb/M5+0OjO3oa3jnaLnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lV5zgCXHyqPoniN4egpc4ez8v2ywGktu+KT77l1Uk9w=;
        b=oagC+PTq+OI+7zYgP4bgnKPVIBVTUukknOmck1Di1OUouHkx6imidY1dAYAEW6V5Ux
         SMnD2l5vYuVKkSl5l3x7PSPuWTbpZyX6EBPmXWuGLCA7d1GtZQ0Ht4Xl41/9ryBAYju8
         /wqJ2wj7BeSY19EjdaE31FBnea0gGhOKA80au2x7Hdp5SBJvZP+49wSmo2pDwh1SeTj3
         tapoPSf3TpuWjiN0Bjvat58/QzRK03YlEkCCcPeO2t19pg3B9JFT5sPGAkjEOlWx4x3K
         /jmJVnEqzqpw0ugBFWyy7xVkF+1UQwYQzPtb9qMjX3EcV8Qhq9OnnQCSf6SAQIND/CDv
         ZLcg==
X-Gm-Message-State: AOAM531qqq6sL713nNZ96xRiSzhxA/qOu/At1xuqIgf4c+oxn5hEYr6g
        9x+DQBhbPHXKBQSkwmbXwBvDffVxY6So5k/yht0=
X-Google-Smtp-Source: ABdhPJyUnquvcC+o4uJ7bnHCRnPHE58ouEU+DJIwPxELWonpFpQtxcOvN67vIagl+qY1/SKay6Ixww==
X-Received: by 2002:a17:906:99c2:b0:6fe:1bb4:4795 with SMTP id s2-20020a17090699c200b006fe1bb44795mr31586738ejn.120.1653531475976;
        Wed, 25 May 2022 19:17:55 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id p7-20020a170907910700b006fec27575f1sm82390ejq.123.2022.05.25.19.17.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 19:17:55 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 129-20020a1c0287000000b003975cedb52bso92248wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 19:17:55 -0700 (PDT)
X-Received: by 2002:a05:600c:3d18:b0:397:6531:b585 with SMTP id
 bh24-20020a05600c3d1800b003976531b585mr104467wmb.38.1653531474740; Wed, 25
 May 2022 19:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <bd25414c73fae85529568c6f5b88bfdad6df7b97.camel@HansenPartnership.com>
In-Reply-To: <bd25414c73fae85529568c6f5b88bfdad6df7b97.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 May 2022 19:17:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5SyuAox3QXvmJLwV4VgN_EK4oaAkh5-73FVf36ZdHog@mail.gmail.com>
Message-ID: <CAHk-=wh5SyuAox3QXvmJLwV4VgN_EK4oaAkh5-73FVf36ZdHog@mail.gmail.com>
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.18+ merge window
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 7:38 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> Max Gurtovoy (3):
>       scsi: target: iscsi: Rename iscsi_session to iscsit_session
>       scsi: target: iscsi: Rename iscsi_conn to iscsit_conn
>       scsi: target: iscsi: Rename iscsi_cmd to iscsit_cmd

People, there really isn't some incredible drought of letters in the
world. It's ok to write out "target" instead of just "t".

Done is done, and renaming things further is probably not worth it,
but when the commit talks about "more readable code" I really don't
know if "struct iscsit_session" and friends is conducive to "more
readable". It looks more like line noise.

Yeah, it's less typing, and maybe "struct iscsi_target_session" would
have been too long. But still, I had to do a double-take when looking
at the diff, and aside from it being line noise, having a structure
name that differs by just one character in the middle between target
and initiator feels like mistake.

Anyway, pulled despite what feels like an oddity.

                Linus
