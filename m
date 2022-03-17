Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4044DBC2B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 02:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356248AbiCQBUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 21:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240599AbiCQBUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:20:30 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B391D337
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:19:15 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id v62so4076680vsv.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=A+Wf6nipilc62C5+2uvqd/Mtv9A0A5YLc2vYs6Wsj5I=;
        b=Q71DUZDk7wnQyc8I2qTmyrUitsPPbwzcmK/9B3h+reFop1O6ehsoZATMGsZg3C80+b
         +mD3ePTRNq13qXn2y0ZbDx78rWSKe5vXWcpbMS+1GGS7Hyl0aIObyC38Suc/cHr6ZOeK
         YEKKNGliO6dHzhUPCV2tMVxszotQnLeylYlo8UwqdH6bQy04hzwJJH6SYICaaaPgdGL9
         PD2dJIfgsQKh088rCzfIPu35WU2Ene7GXHykCPdUbEJHcOsnZajKaW1Q5uHVXnOTHay3
         tJS1TUsJ97I/DeqHnAL35fRQqb4tZoR+oYMpY4T5ZYiFDSLU+h13fKPDxE29bJu8ubUr
         RSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=A+Wf6nipilc62C5+2uvqd/Mtv9A0A5YLc2vYs6Wsj5I=;
        b=iVJpp0B76s0utkxhvkCaxYFSCrdrjyy+A87ubdAyek4MKT2E8XS8RRuZVLH9uzaP7w
         MW0VyBhlCSh8TSRmIpVzZLbc7cClmvRiPsVFJsDjn3//NVumwlrE5Hoy0IJ0unsCcd4C
         uuxFao9nZfN6VxEoC3y/ymPefzfBD/drtGC3O1aMgfMGl4b1HMjFMXc4Yfyqf6bCbyye
         i/GRT64Tadh7wZb3gEr4r9g2WYzDR96avTI0DP+8iPF/ChDXtP3idSUD4v2GI1/h1nE+
         qIkdOeP+MwBY0qfy+8cjLJESfJuFMgfKR2OF7T/KHuytD1xuXDxzIm9Gji7V2dI95aJN
         5Ptw==
X-Gm-Message-State: AOAM5323QYDqv2O4eoVfN8w3U2KkwmcR5DigMUw/oufRNjjp/RR9RCx/
        qvCj+68gfqDwjwfnEKQDq1/vhf5w0t1WmkZPaYnkbhNo27vz5w==
X-Google-Smtp-Source: ABdhPJxBSvGKCpVl/6XrSos5P0R8nYjn7Z5y3/TpLMh2PYXWIqZjSALpvr3y9MEUgR++mT+Abgwn/ylDbNjLWeQ8WZc=
X-Received: by 2002:a05:6102:c02:b0:320:9e52:4856 with SMTP id
 x2-20020a0561020c0200b003209e524856mr801645vss.20.1647479954585; Wed, 16 Mar
 2022 18:19:14 -0700 (PDT)
MIME-Version: 1.0
From:   jim.cromie@gmail.com
Date:   Wed, 16 Mar 2022 19:18:48 -0600
Message-ID: <CAJfuBxx4=QY5Ah3ZNdPYNWPyBc_NnH5Swx7rvu7-qYRuK6d6XA@mail.gmail.com>
Subject: does kernel have any FOLD_LEFT macro equivalent ?
To:     LKML <linux-kernel@vger.kernel.org>
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

does the kernel have anything like
BOOST_PP_SEQ_FOLD_LEFT(op, state, seq)  ?

or any hand-coded implementation of the pattern in-kernel
that I can look at ?
