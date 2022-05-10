Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0773520FCE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238083AbiEJIl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238150AbiEJIl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:41:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38110235C0D
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 01:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652171848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+bf0vsHdIZwwE9q6c75T7kOPMxvneKaFOveGY+sLTY=;
        b=ExL7ZMkaHmvZJqL4tczacj2GNE2kJc/5zCP3nMUQekB+hB5SFzXreQNOc0tIndRQ8lkXTM
        3c5l3+mYFC7yfkoBQCUo0uJ76b7CyZtDMujDlmoVA9EVTxgwOgmr734Mey+gyIXOT0Cnrk
        A6r/Brw9ZTrMUf5BBzlfvzZZLj+7wDI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-x-zcoHyAPzKLKosYXjUh8A-1; Tue, 10 May 2022 04:37:27 -0400
X-MC-Unique: x-zcoHyAPzKLKosYXjUh8A-1
Received: by mail-wr1-f69.google.com with SMTP id v29-20020adfa1dd000000b0020ad932b7c0so6729773wrv.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 01:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=j+bf0vsHdIZwwE9q6c75T7kOPMxvneKaFOveGY+sLTY=;
        b=3S1n6cmFTTPbY+HfjeStNVQnYTfYexzK10xnJ8/H47bewlT+m4DZsbwzg8aweFlCLC
         C2viLbJbmVJlul9aUPiXI5Kx4VWgrMPNGfzqf/s3K4Chv5w2sNkuv6hE67s6DXCeLBu7
         LimlyDrjl6O3xdOYgg9uvHshnrSeMOBhbS9x5uEmqYqgNYpBgrngs+ePtRkT6kwBrZPX
         SFi+v6hXbXIWvtLykhg/hClERqgyvG67p8m1jO0IfbUSqSEB2SElMpBCwlIEbLb6d0Qg
         wU2vjoo3wNNZqFUnlUU07JcSvPRtM9q8e98Fk/SzzU4SicCjBP2sPjP5U+7J5SN3XG98
         s2kg==
X-Gm-Message-State: AOAM531L5BjepOfnSyceURBHCbdq6MziRAKk3w69c/4b2WocSHPik/VA
        ngZkTZuOt0LV89hQKHWT0krWBr5pjj6AzFxOcqXHxKdbq7A+QPmtTFEsysm+qRzkEYftv2r4/Ox
        7r+pu0gNuPngtQRHVeFCOexFa
X-Received: by 2002:a5d:630d:0:b0:20a:e1a3:8018 with SMTP id i13-20020a5d630d000000b0020ae1a38018mr17590609wru.489.1652171845935;
        Tue, 10 May 2022 01:37:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGL3y7pRTXcLytDFuw+KuLGDAOLIN9orN+ms074kBoO0zDNQxsf08xbRCBU2oDTE8Z+kx8xA==
X-Received: by 2002:a5d:630d:0:b0:20a:e1a3:8018 with SMTP id i13-20020a5d630d000000b0020ae1a38018mr17590583wru.489.1652171845547;
        Tue, 10 May 2022 01:37:25 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-89.dyn.eolo.it. [146.241.113.89])
        by smtp.gmail.com with ESMTPSA id az20-20020adfe194000000b0020c5253d8basm13146661wrb.6.2022.05.10.01.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 01:37:25 -0700 (PDT)
Message-ID: <b140c37fe1aac315e07464dd6a2d7a8f463e6fe4.camel@redhat.com>
Subject: Re: [PATCH v6] net: atlantic: always deep reset on pm op, fixing up
 my null deref regression
From:   Paolo Abeni <pabeni@redhat.com>
To:     Manuel Ullmann <labre@posteo.de>,
        Igor Russkikh <irusskikh@marvell.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        regressions@lists.linux.dev, davem@davemloft.net,
        ndanilov@marvell.com, kuba@kernel.org, edumazet@google.com,
        Jordan Leppert <jordanleppert@protonmail.com>,
        Holger Hoffstaette <holger@applied-asynchrony.com>,
        koo5 <kolman.jindrich@gmail.com>
Date:   Tue, 10 May 2022 10:37:24 +0200
In-Reply-To: <87bkw8dfmp.fsf@posteo.de>
References: <87bkw8dfmp.fsf@posteo.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-05-08 at 00:36 +0000, Manuel Ullmann wrote:
> From 18dc080d8d4a30d0fcb45f24fd15279cc87c47d5 Mon Sep 17 00:00:00 2001
> Date: Wed, 4 May 2022 21:30:44 +0200
> 
> The impact of this regression is the same for resume that I saw on
> thaw: the kernel hangs and nothing except SysRq rebooting can be done.
> 
> Fixes regression in commit cbe6c3a8f8f4 ("net: atlantic: invert deep
> par in pm functions, preventing null derefs"), where I disabled deep
> pm resets in suspend and resume, trying to make sense of the
> atl_resume_common() deep parameter in the first place.
> 
> It turns out, that atlantic always has to deep reset on pm
> operations. Even though I expected that and tested resume, I screwed
> up by kexec-rebooting into an unpatched kernel, thus missing the
> breakage.
> 
> This fixup obsoletes the deep parameter of atl_resume_common, but I
> leave the cleanup for the maintainers to post to mainline.
> 
> Suspend and hibernation were successfully tested by the reporters.
> 
> Fixes: cbe6c3a8f8f4 ("net: atlantic: invert deep par in pm functions, preventing null derefs")
> Link: https://lore.kernel.org/regressions/9-Ehc_xXSwdXcvZqKD5aSqsqeNj5Izco4MYEwnx5cySXVEc9-x_WC4C3kAoCqNTi-H38frroUK17iobNVnkLtW36V6VWGSQEOHXhmVMm5iQ=@protonmail.com/
> Reported-by: Jordan Leppert <jordanleppert@protonmail.com>
> Reported-by: Holger Hoffstaette <holger@applied-asynchrony.com>
> Tested-by: Jordan Leppert <jordanleppert@protonmail.com>
> Tested-by: Holger Hoffstaette <holger@applied-asynchrony.com>
> CC: <stable@vger.kernel.org> # 5.10+
> Signed-off-by: Manuel Ullmann <labre@posteo.de>
> ---
> I'm very sorry for this regression. It would be nice, if this could
> reach mainline before 5.18 release, if applicable. This restores the
> original suspend behaviour, while keeping the fix for hibernation. The
> fix for hibernation might not be the root cause, but still is the most
> simple fix for backporting to stable while the root cause is unknown
> to the maintainers.
> 
> Changes in v2:
> Patch formatting fixes
> ~ Fix Fixes tag
> ~ Simplify stable Cc tag
> ~ Fix Signed-off-by tag
> 
> Changes in v3:
> ~ Prefixed commit reference with "commit" aka I managed to use
>   checkpatch.pl.
> ~ Added Tested-by tags for the testing reporters.
> ~ People start to get annoyed by my patch revision spamming. Should be
>   the last one.
> 
> Changes in v4:
> ~ Moved patch changelog to comment section
> ~ Use unicode ndash for patch changelog list to avoid confusion with
>   diff in editors
> ~ Expanded comment
> ~ Targeting net-next by subject
> 
> Changes in v5:
> ~ Changed my MTA transfer encoding to 8 bit instead of
>   quoted-printable. Git should like this a bit more.
> 
> Changes in v6:
> ~ Reducing content to 7 bit chars, because nipa did not apply v4 and v5, while
>   git does against a fresh net-next HEAD. Maybe it chokes on the
>   additional bit.
> ~ Omitting target tree to resemble the last passing patch version the most.

For future submission, please always specify the target tree (which is
-net in this case). No need to resubmit: I'm applying it.

Thanks,

Paolo

