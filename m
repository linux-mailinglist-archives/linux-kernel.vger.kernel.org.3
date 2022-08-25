Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AE85A0B05
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239309AbiHYIHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239403AbiHYIHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:07:45 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DFCA0337
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:07:42 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b44so4801560edf.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=P/CzcI73c0gP0FvO61Psway+7tYvL+8/Afg+qkG5JWk=;
        b=Siyp/zyeK/0/GkdCirhBA59wwhDLPfeLNWaIDTTwNViK4f5wodojKBwOcMCsvOu/TG
         MuBRwm4gueU2OYRUaWwv/hgQGPNmszhCUtB05tIS702iWk+iIYHCUwiFK5m4F0U3U2p3
         u2QDKX7VmCsbayCZPTKz8aTVw2f0mQT2RnPhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=P/CzcI73c0gP0FvO61Psway+7tYvL+8/Afg+qkG5JWk=;
        b=S/n4FCNGvcfuQiZ74lVPiz7s0mPMgM/K7ouPEaADrPOMA4WO5aoNYDvkaAaH+sTmbb
         1o113Na6wqZJ/NNFu3QmyK+ZmAihEbLt8PF1oNfyVFX0p/3vKS6ZzuV5T11uthBuD98U
         v7xKRBwB6VOu1xk+pOvH8b0CgJI51xBVlBiqIO6Py71TeQqGG//TP+50mZcuzbBH01o6
         gkleteXYD2ZvcPh7R+/LtaDa6OsaeT7DBPnJ2gYv6NoC3ZrEP12bDosoDAM15ubCO4sw
         GQ5IFFggr9QE2W2doBByiXgRvxx/vAfyCWZSLe2vRT5cZVUTUePLiGAha01010mPTAZw
         xlQA==
X-Gm-Message-State: ACgBeo2bLqzzo94lGJSLQdtq/HvJ88PxURPIeitWghhwtuNbYz24J72+
        fallHHnr4YVQxEHrScE/RL1L1EsPDiGBqdZXL1o=
X-Google-Smtp-Source: AA6agR48rauJ44/mn5HADtlpnDBJgNuc9qMb5ErPOurxBByQrnf56uhNmdqKl1PTneopLwwMAqb5uA==
X-Received: by 2002:a05:6402:2d6:b0:447:ae9d:d0f1 with SMTP id b22-20020a05640202d600b00447ae9dd0f1mr1774277edx.256.1661414860786;
        Thu, 25 Aug 2022 01:07:40 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id k15-20020a1709063e0f00b0073c1e339a37sm2119062eji.149.2022.08.25.01.07.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 01:07:39 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id m3-20020a05600c3b0300b003a5e0557150so2714111wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:07:39 -0700 (PDT)
X-Received: by 2002:a05:600c:657:b0:3a5:e4e6:ee24 with SMTP id
 p23-20020a05600c065700b003a5e4e6ee24mr7114442wmm.68.1661414859275; Thu, 25
 Aug 2022 01:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220821000737.328590235@goodmis.org> <20220821000844.510643400@goodmis.org>
 <CAHk-=wjsxu782N0P+oMu35N7rJAOeh3buQFWJaZHZTNmVSB=3Q@mail.gmail.com>
 <5700ac75-f6a9-877e-4011-9b314f12b5ab@acm.org> <CAHk-=wjqkWEr0MRO5hWuBoTDgNUj4qQK8V_Y36et=61mdPztJw@mail.gmail.com>
 <02daa3d6-2847-d7e0-e23e-411076c6d4db@rasmusvillemoes.dk> <0163b361-14bf-7b4c-751a-14f1a004b1a9@acm.org>
 <CAHk-=wjMLb30d0WT_RyKBCX+JBkg3QQU6pCYkrV8f58Ya4Rgzw@mail.gmail.com>
 <b79c83af-e9fc-9fa0-dff7-f3a8a39887ff@acm.org> <CAHk-=wgV1F7_ErXkXT2wd+07LJd_3Vp-yVUKLROPiEgijeoTrQ@mail.gmail.com>
 <353e5bbd-cdd1-f818-6a2f-9a7c800f9879@acm.org> <CAHk-=whSZ20Hv4EyLDtUZGX4MsYmCLQ4+OOTbv1WEXfXDcxnWw@mail.gmail.com>
 <CAHk-=wjQGnVfb4jehFR0XyZikdQvCZouE96xR_nnf5kqaM5qqQ@mail.gmail.com> <29157fcb-a2c3-ff4d-2b74-f4da860a0dbe@rasmusvillemoes.dk>
In-Reply-To: <29157fcb-a2c3-ff4d-2b74-f4da860a0dbe@rasmusvillemoes.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Aug 2022 01:07:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=whim36a9_-5Eu4SJqiKsoXb87wUprUnn=q=xDeOGQXpHA@mail.gmail.com>
Message-ID: <CAHk-=whim36a9_-5Eu4SJqiKsoXb87wUprUnn=q=xDeOGQXpHA@mail.gmail.com>
Subject: Re: [for-linus][PATCH 01/10] tracing: Suppress sparse warnings
 triggered by is_signed_type()
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 12:57 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> One can also make the RHS not be a null pointer constant with something like
>
> (((t)(-1)) <= (1 ? (t)0 : (t)0))

Oh Gods.

Let's not go there. I'm sure some version of gcc will figure that out
as being NULL in the end and warn about that too.

I do agree that a comment about the exact choice and why (integers vs
pointers with NULL conversions, and compilers vs sparse) for the
particular syntax would not be misplaced.

               Linus
