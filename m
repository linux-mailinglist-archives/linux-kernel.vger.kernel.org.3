Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E614E3FCB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbiCVNsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbiCVNsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:48:00 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DF026ACB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:46:32 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2e5827a76f4so191014777b3.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iQXVtoNNOTzoC5qZU7/1ecuc9O/zDp2OQHUTN6wFNH4=;
        b=qXbsV6VDEGOklazgM3cMrjtcJViQEQD+5sjq/f8HPRSOkw9PfJbLmANL2XxUdpi8nU
         kg6sSs8d6uPoAfawQLGXG2TWj7dBOySsSfG8Fb6RH03xwEx8SaWEWfS35xIQbuHBL7jE
         aaeKfKFPuOfsoaulDr6cv6o3aIeJ/udNHdKCSKlieJ0kzF6RJDNPd81RZ+y/3BqFmfx8
         qgGJaZSdQqwop60RX1HT58wL91s7krigV8jwHibUgizeSB3IE9DmeTeG4/nP3pBXxRKJ
         q/BKLJ2G6rBiS/5tdRicXh/eY/ZltWUa4hwkcC5/5430zPwc1CZ/coRxWKFjzAGz+AxD
         SABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iQXVtoNNOTzoC5qZU7/1ecuc9O/zDp2OQHUTN6wFNH4=;
        b=Wl7q1AGJLKhHHL/39DyOPuGG4qsTEtkp5XBfbh1yxhB+QdTMYE1/y9ZDffkle/1VuZ
         Z+R2hAoYM8aIk1ROFS/ecV2bdiZ0pTsdcoBm8d8rttF/LduWtv5+n/T48tp/k2CwqKbn
         u0lGrjG3ob17T3A4FsaKG+9k9RTAKQTKg3jFzrJMQ1pQtLYxmI17ntdjQh9HQOoXiTKq
         d8XphzpEHOZLyfYVEvZ6ft1BJHnnZmGE5mu4/As4jFtfPXhvz2iILa0AfQBQf+qiGHAS
         4Mu1V0XH4+hBPjQB0NfPM355KrjXdFiirxTLtYI4PqjKAZqhVURBa0v1xzxjWnoS5aUg
         kxow==
X-Gm-Message-State: AOAM533rE0lAZlJ7Qo35JE0MmzU7CDizTFdR3P5HPzatOSQ/2feCc6z8
        yNeXai2loThbp2ZeHtBAp359d9Rks63AiaRk13fKYiXvTBF2dQ==
X-Google-Smtp-Source: ABdhPJzFT8gy0YTryuzIkqAwXuMAOd4TJntnOiSZt+GqRpVTvpk3Jc9rNKAQjUkIPCmI5srs5BWm4mxrQHc9KwFPhb4=
X-Received: by 2002:a81:5dd6:0:b0:2d6:3041:12e0 with SMTP id
 r205-20020a815dd6000000b002d6304112e0mr30293148ywb.331.1647956792172; Tue, 22
 Mar 2022 06:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220322121338.27428-1-liqiong@nfschina.com>
In-Reply-To: <20220322121338.27428-1-liqiong@nfschina.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 22 Mar 2022 21:44:36 +0800
Message-ID: <CAMZfGtVxFieFwEB5Xw0yKbri39og97u2RngRABTAUVXZSD_2Vw@mail.gmail.com>
Subject: Re: [External] [PATCH] mm: remove unnecessary (void*) conversions.
To:     liqiong <liqiong@nfschina.com>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, yuzhe@nfschina.com,
        renyu@nfschina.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 8:14 PM liqiong <liqiong@nfschina.com> wrote:
>
> No need cast (void*) to (struct hwp_walk*).
>
> Signed-off-by: liqiong <liqiong@nfschina.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
