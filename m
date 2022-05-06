Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFC251DDFA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443991AbiEFRBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 13:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443981AbiEFRBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 13:01:09 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0276A079
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:57:26 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id m20so15548123ejj.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 09:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kWTfFwPUe+akq8O9xoc+GEwOhm09+8e/D5W4UvY4gD0=;
        b=ceuvAqXdWvZeF2C0Y5EDLKK77hsGHUE38ZdM2vcpFkVoxaH8YseTLQnxTfC7bMDIvD
         1kTp25IZh3PciTkBUs79hUfk7bwcW4lK6yeFGtAhg21SmiEZbuqdeo1nDpMVLZhL4Zpj
         tcEZogQAbi8rzX8rgTUf8CXMGeP9r8q6PuGtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kWTfFwPUe+akq8O9xoc+GEwOhm09+8e/D5W4UvY4gD0=;
        b=SL0peW5w8NRTuwRKAsJz4NOUVmCiGa5nhEQDftOvsUw+qlKmEfJCvn8Y7aFUK0x1Ej
         0ByouFmq8xYA+HkA6cY2wBW6PK38QZsR2hy4zsRzaZiYCmvl3vh30P7lMmQBcdBPInCt
         w6jakyExKnZG6FXYpU3Y6j5HeYZxjuRXMFRE7JVnV0krzFCgqG6GoZXjToGYn/y7ZD4M
         0O5lFCIPsX7DECSHO+3J7faEV7ntS0fVfhX8M4Mep2TxFwv9uYw/Iq6UitqbWFeU9FjC
         RzUX/HRVScJLFiCUWXxbC0uKkB+jBINg3z5SSve/Jw5wPhypdxpkxpSuudhqcYxvdpAW
         tbpQ==
X-Gm-Message-State: AOAM5337FsOtk+tDtMLN22V0+BBXJ5b2vxcE24peFW0k72B/gWoNd4dU
        fiaoqxScHqNE3XyDvMSqCI+AbFwqotk0r8q6+qg=
X-Google-Smtp-Source: ABdhPJzFhR7kGiKLKsfhICHFmndUNNlXK6/ANdR1xFt/aCn8bT+Iw74I9oNsdWLX5OgVBA4cOMPs4g==
X-Received: by 2002:a17:907:7e91:b0:6f4:3b93:1f6e with SMTP id qb17-20020a1709077e9100b006f43b931f6emr3891509ejc.91.1651856244943;
        Fri, 06 May 2022 09:57:24 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id z22-20020a50f156000000b0042617ba63c3sm2492427edl.77.2022.05.06.09.57.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 09:57:24 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id i67-20020a1c3b46000000b003946c466c17so747306wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 09:57:24 -0700 (PDT)
X-Received: by 2002:a1c:cc16:0:b0:394:61e1:94f with SMTP id
 h22-20020a1ccc16000000b0039461e1094fmr4204147wmb.38.1651856243921; Fri, 06
 May 2022 09:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220506160151.GA596656@nvidia.com>
In-Reply-To: <20220506160151.GA596656@nvidia.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 May 2022 09:57:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZZvzpMHPSWSUWV3tq7VEZW_m-SJqwEDMzYVHdYV_UDA@mail.gmail.com>
Message-ID: <CAHk-=whZZvzpMHPSWSUWV3tq7VEZW_m-SJqwEDMzYVHdYV_UDA@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>
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

On Fri, May 6, 2022 at 9:01 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
>  6 files changed, 92 insertions(+), 103 deletions(-)

I couldn't for the life of me understand how you got to that diffstat,
since everything I tried gave me

 6 files changed, 85 insertions(+), 96 deletions(-)

instead.

Until I realized that you must be using the '--histogram' flag to git
diff. It seems to give quite different results for rxe/rxe_mcast.c.

Better? Worse? I dunno. But it threw me.

                Linus
