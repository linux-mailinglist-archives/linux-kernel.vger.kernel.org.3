Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F5951419B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 06:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237868AbiD2E6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 00:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237838AbiD2E55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 00:57:57 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF53EBE30
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 21:54:40 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2f16645872fso73862207b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 21:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MqqX3ka8zJReoZtiWcnDAcedEDd+UEm6RzIL1DYOGvQ=;
        b=byzgI0KGWf10i8tYtMgDmaATKLEHBWPh1aXvwQGXRHQsws2xOU/hs1TaR4+GmsEozD
         9HRzx1z4K+uZp6HSlu7cN6+Iulb6zDClI20WoDj7g5LWTjkO1DdJN50hTeXlgDaceObw
         Ks6TySoJsA/YxOg2cs7QVZKfJPHMVSlVoDRpY6UbNWz96fUOiYAjzY9hB14wldJ4ZsgY
         7EsxgKbicyFk7lt9QDgMCjd8zftSEtfMNZn6yg/4lgJZNDMbQ277sKT/ZhpbpRufA4XQ
         optSw4oH+QOGD3K0aMQedbhOMpF9otQz3DpN2NhDiAIMV7tU7HB8hrVyUNH2nufip5f8
         ZrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MqqX3ka8zJReoZtiWcnDAcedEDd+UEm6RzIL1DYOGvQ=;
        b=CU83RJOY48WQm0bJf2PXMDbHlq+brPcQA17m8jojauCUhKx+xbxosQt5eu4NHj2vzG
         CGwQz9JCCuCAgVpfQ9ncNuOoxfuiqPc4kRJ/EQ79lSxTdVqz6JZEmvmGiaOZKIf171LJ
         jCJ0Xn3YXaMpDfSOi0V8beighNWc0ISPk7WPrsUOnWkZNdvniS2FKmWWcOOLlNCTR00P
         wCq8LKZcYoNF+KbBtwtrI7WBpBfY5IRC5gciC12puzP1Fsc6kIvDr0f70L8FImT73kl/
         WQEjqGJcGc1Sx/ZUGTw95wf19iQRfUFn2RL6gQ3WZu+g98Rz9x3jnni+fy0ITxvRZpLf
         EDqw==
X-Gm-Message-State: AOAM531FYuENQt2dt/NL/+DK86M7llLqNIYp3DPe9dO8QOROyaJXtG67
        Lnxyi70MJRtgOz1mAHwlH6z5N+GFsLThMidDfw4aDw==
X-Google-Smtp-Source: ABdhPJwPtGEnA1JIR1D+p6mHm5yrwHpeKq99JiuwPNn3idfjaVfAdwt9EfvbRLOpvZv5HNO9cZTVT51pFT3RNp37Ea8=
X-Received: by 2002:a0d:e296:0:b0:2f7:c169:126f with SMTP id
 l144-20020a0de296000000b002f7c169126fmr30851860ywe.431.1651208079823; Thu, 28
 Apr 2022 21:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220428061707.768468-1-tweek@google.com> <YmpQOSf0bdOcIZSU@kroah.com>
In-Reply-To: <YmpQOSf0bdOcIZSU@kroah.com>
From:   =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date:   Fri, 29 Apr 2022 14:54:24 +1000
Message-ID: <CA+zpnLcV40ciweXMr+W+qT0xGgKAsUq47x26JGYaiOiQYcshfg@mail.gmail.com>
Subject: Re: [PATCH v3] firmware_loader: use kernel credentials when reading firmware
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <jstultz@google.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Alistair Delva <adelva@google.com>,
        Adam Shih <adamshih@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

> As stated before, should this go to stable kernels?  If so, how far
> back?

Yes, it should go to stable kernels. It should apply cleanly on 5.10.
Ideally, up to 4.19 but it will require a fixup. I can send a
backported patch for 5.4 and 4.19 branches once it lands in the main
tree.

>
> And you forgot to cc: John?

Done
Thanks
