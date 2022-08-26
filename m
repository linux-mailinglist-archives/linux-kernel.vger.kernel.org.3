Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C225A2D8B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344563AbiHZRd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiHZRdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:33:25 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A7DDD4EC
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:33:24 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id c93so2937203edf.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=76XEfqYjwqOQE6P6BeL3QuaQXtbKxRWXyl9AHHbuuJI=;
        b=fovr/iuQnnMBlOZwvSLpHdgMu27bplWIzY424RNTnscWELSMTMCbX7cBqZJR60x9YF
         UMxJ4y+em0TNtI9cMgGL4O1yBU0no/Hcs+XNT4WcVXq1fm6vWuHPOzACTljbk7w90whv
         HLj36FlAdAVhoNgay7affO8+9wIUL7jtNoiug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=76XEfqYjwqOQE6P6BeL3QuaQXtbKxRWXyl9AHHbuuJI=;
        b=Ogoa8b2Ctv7gCRGrMYWTyKRpvqEpMA+X+sKoZTSZX5P2hioTafIlXTfwfkD0De/Vgp
         Z16jrzOw5UjSRag3uHsaqtdT0BsRMtgY9WIQVfrDDJUfLDaHsslk2fTRZZ2Y+v/oztkx
         im8v+xzAJkn98V++vxX19gC70dJYRAeoSlgbJGjDIyrigKgHIC+haxWnQ1V1fMa2QVTy
         sxa1vrjJRSl3cuHQUBRAju7TgCkYpC23omCqP4/fgc4m202IqKxKDHE+SnhM58jgPMt1
         YTrUMNm+CKKNF/YL1kha2Rivh9e7+xUsLYDHIeXDbh7IJp+UxGZAFRTxqZp50MatGYsU
         NaJA==
X-Gm-Message-State: ACgBeo2Hq1SJEtJ2UnLe+aNLq1b6x4t1IhNpk85lm3PENDbybi7cERkN
        7Hay4IE0A9CBRPZXCaEb1kI1MO++Hf5eQ+XiUn4=
X-Google-Smtp-Source: AA6agR5nkGPxO+cmogNzd8eNh1Gm6Iz/pD20qKY5GIFlpYQOLMhEkFxTuYQ0qgu2Mf9z2htIOv2Q+A==
X-Received: by 2002:a05:6402:4282:b0:43e:612c:fcf7 with SMTP id g2-20020a056402428200b0043e612cfcf7mr7419726edc.242.1661535202471;
        Fri, 26 Aug 2022 10:33:22 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id 23-20020a170906319700b0073dcc56d3ebsm1125073ejy.220.2022.08.26.10.33.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 10:33:21 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id u5so2570406wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:33:21 -0700 (PDT)
X-Received: by 2002:adf:e60b:0:b0:225:877e:176c with SMTP id
 p11-20020adfe60b000000b00225877e176cmr397646wrm.193.1661535201101; Fri, 26
 Aug 2022 10:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAC8pb093n-OYJf8kpwyV7eDrCJZ+10oY=NeqbtPBDaTzAxGRjw@mail.gmail.com>
 <4e88d9a9-0897-8ec9-a344-b6df3f75a428@acm.org>
In-Reply-To: <4e88d9a9-0897-8ec9-a344-b6df3f75a428@acm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Aug 2022 10:33:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVFWD8+L8qH1o9OM8rxPrV2FO4Ds8XWQefJJ0idN_sVQ@mail.gmail.com>
Message-ID: <CAHk-=wiVFWD8+L8qH1o9OM8rxPrV2FO4Ds8XWQefJJ0idN_sVQ@mail.gmail.com>
Subject: Re: [BISECTED][REGRESSION] Kernel 6.0-rcX hangs on resume on Sony
 Vaio VPCM13M1E
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Fabio Comolli <fabio.comolli@gmail.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
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

On Fri, Aug 26, 2022 at 6:37 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 8/26/22 00:24, Fabio Comolli wrote:
> > Please let me know if you need more details and CC: me as I'm not subscribed to linu-kernel.
>
> Thanks for the detailed report. A revert request has been posted here:

.. and I actually got the revert with the SCSI pull this morning as
commit 785538bfdd68 ("scsi: sd: Revert "Rework asynchronous resume
support"")

                  Linus
