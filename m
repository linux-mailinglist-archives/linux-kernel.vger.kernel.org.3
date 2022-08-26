Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9525A2D85
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344373AbiHZRbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244891AbiHZRbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:31:45 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C341CDB073
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:31:44 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id h22so4438692ejk.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Jme7uqqc6twTvBXYEnP6kaEZrCfdEsgOykmCLtXGQqQ=;
        b=cqn8OYgAgusLNPHbU9fDfjR9OHGrc1htGybhgrf3u8IJEBJOaU0/ceKFUnwpb/zB+E
         U0qrKqpxtNaJ2Ul3dpqZ9YHxZJvsHGbZZQANsomq+14hiAHBqLQ3DvSOElgzwdxSTuAM
         MPjiakXtex91wUcdaPqdsTaRK2qgDh6M5XOOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Jme7uqqc6twTvBXYEnP6kaEZrCfdEsgOykmCLtXGQqQ=;
        b=lRuhf4g3WfAmTKJuqhS40mmqYB5yYT93VG+LlyuOKYUyY5y8+U35orvSB0a3dauKMu
         CIG8nBN2Pqv99caqVRzSyjZOUj8PBdHWxBTK4UCq9H2RZm6eJrD+6W1UfCfNnWShbjcR
         3nN3dAZkkiFdJ2ydHwJyJ9VOrNr20ulnmcnx7lyWXawFQfU1Du5vFpdCDRc4dbvtW39y
         bfFu9YEWT3o7fiRa0tJeg9CamTZKcl9vyuj2gABi7gu4qJ/6KkDUQTyNAi7cFPGyaprD
         HbPYjJsoZAAMsNJgWGnWl/YR3cB1DSFEj+Gk6ZiAe8B6zmVyji3EOHW1c7n2y49ZUu5g
         8NVA==
X-Gm-Message-State: ACgBeo0FT2l3klGa0CkXgXP0jYfr0UyWjBxwEbgMmmGMPjr4dkG2YwYd
        7d1Ec7+JjUISwmnZWbZ8tb9p9KF1lXVWJDGF8rM=
X-Google-Smtp-Source: AA6agR6FPGqUJnixJya59kuKV8nyn4O1eCoDaSIpcYHMi3IZfhuIk2IXSOnqDaxkfxrtZxQynYwBHA==
X-Received: by 2002:a17:907:72cd:b0:73d:d610:8930 with SMTP id du13-20020a17090772cd00b0073dd6108930mr4992945ejc.194.1661535102997;
        Fri, 26 Aug 2022 10:31:42 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id z14-20020a1709060ace00b0073d6d6e698bsm1106781ejf.187.2022.08.26.10.31.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 10:31:42 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id k18-20020a05600c0b5200b003a5dab49d0bso1204164wmr.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:31:42 -0700 (PDT)
X-Received: by 2002:a05:600c:657:b0:3a5:e4e6:ee24 with SMTP id
 p23-20020a05600c065700b003a5e4e6ee24mr407390wmm.68.1661535101292; Fri, 26 Aug
 2022 10:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <042650172f59fca9836fe523ce14a07daccc4f2d.camel@HansenPartnership.com>
In-Reply-To: <042650172f59fca9836fe523ce14a07daccc4f2d.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Aug 2022 10:31:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjcvDA+TtFGiFS1faAX9-sVK_jkMGC+0FX01U+hw9tgkA@mail.gmail.com>
Message-ID: <CAHk-=wjcvDA+TtFGiFS1faAX9-sVK_jkMGC+0FX01U+hw9tgkA@mail.gmail.com>
Subject: Re: [GIT PULL] SCSI fixes for 6.0-rc2
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

On Fri, Aug 26, 2022 at 12:39 AM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> With full diff below.

Nothing there.

I assume you noticed that the full diff was unnecessarily big, but
left the notice..

               Linus
