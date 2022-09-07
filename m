Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA535B0BC5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 19:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiIGRsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 13:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiIGRr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:47:59 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1157B14DA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 10:47:58 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 130so22689960ybw.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 10:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PJdZjFOGYcZr+6GORZ6uuk20no/Y1w8QVrjJZltjb1s=;
        b=sUTHKS44teHta3xPkJGc78XNjeRxZGDbLr/V4K3Ge7EQ6pEKU9jhfY3d2wYjAzjv2q
         CIT+smVVd7OH86kPq1XdMLiMDCo79dxvJ+hck5vEPmN7TIbZrqeMAAKJHz8iq2U/7cnW
         1nLse8ViCygV3VjUcuIokg28LJRmU/srFcIJVAbwvLLndtAoxbwtq5f25MILEthOBy28
         vc0JQjapyHnJZ91IqLe4QqbtjVtLyd+g4gVP7xskoySnP6nQ7D2LrDy05BZGdJsjpu1l
         9VMwGCbNEyDyXV/wAYFBNO3i4wF8H1ZdX9mZUIlt1/cPnJMEEyk4QuwuJtqGF6Mt31fj
         5Q7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PJdZjFOGYcZr+6GORZ6uuk20no/Y1w8QVrjJZltjb1s=;
        b=vnh8OKZnOku9ywUcP2epJf6FEebgrp4w5KmW9kesyMmDT2uySimEuZDMin980oHO/U
         yEa6fuikSB1fmjoo4eXEuMrSSx7W/WjZjRo9kERpFus7X/W+m2w9YbjO8IBs+cledt8e
         DSR2dJ/mZQl/jufEni2DzysadUan92S9fZLU/kNxdNKzu4TdhriWylyw4IXuJcy6Tfrr
         tRbWaiH0DZBortHlhX/wNFiIlosQoBaaGDZqH13uDe582hRBzkpT90vuW9oADf3Oeyp3
         2x2IFA8f6Hk4f8khzF0UoQ9DarRWszQP66d15UgGCWtVBE2rvEQdquqYm1K7nclzmZZL
         WUGA==
X-Gm-Message-State: ACgBeo3SguhyVmRUdZMZh+J/B2P4Xs/Jd9x7XzDZl/QUdTmbGLy+ZmEa
        qHd8EQNGjZDf6e5uTOhh/0798VWCKbLCosiOZ007jA==
X-Google-Smtp-Source: AA6agR5LSKC2erPcncwbGy8sWDcg/5azUit2GOKf4rSZd4wZKv7jqVKNxbKBmKGTWWcwlAOoaHKw3TbIacOSwgw0COA=
X-Received: by 2002:a25:d487:0:b0:6a9:3faf:ca99 with SMTP id
 m129-20020a25d487000000b006a93fafca99mr3769610ybf.16.1662572878122; Wed, 07
 Sep 2022 10:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220907173903.2268161-1-elver@google.com> <20220907173903.2268161-2-elver@google.com>
 <YxjXwBXpejAP6zoy@boqun-archlinux> <CANpmjNN2cch+HDVUYLD27sF9E39RaFrCf++KN=ZZ7j0DH8VaDw@mail.gmail.com>
 <YxjYY6SJhp1PtZos@boqun-archlinux>
In-Reply-To: <YxjYY6SJhp1PtZos@boqun-archlinux>
From:   Marco Elver <elver@google.com>
Date:   Wed, 7 Sep 2022 19:47:22 +0200
Message-ID: <CANpmjNPpSvWH7eV38NoPSdB0Qxov2cOsvYnSCCLy_vz4GQq3fA@mail.gmail.com>
Subject: Re: [PATCH 2/2] objtool, kcsan: Add volatile read/write
 instrumentation to whitelist
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Sept 2022 at 19:45, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> On Wed, Sep 07, 2022 at 07:43:32PM +0200, Marco Elver wrote:
> > On Wed, 7 Sept 2022 at 19:42, Boqun Feng <boqun.feng@gmail.com> wrote:
> > >
> > > On Wed, Sep 07, 2022 at 07:39:03PM +0200, Marco Elver wrote:
> > > > Adds KCSAN's volatile barrier instrumentation to objtool's uaccess
> > >
> > > Confused. Are things like "__tsan_volatile_read4" considered as
> > > "barrier" for KCSAN?
> >
> > No, it's what's emitted for READ_ONCE() and WRITE_ONCE().
> >
>
> Thanks for clarification, then I guess better to remove the word
> "barrier" in the commit log?

Yes, that'd be best. (I think it was a copy/paste error.)

Thanks,
-- Marco
