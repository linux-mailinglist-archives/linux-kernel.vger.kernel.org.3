Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6347A52E0EA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343781AbiESX4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiESX4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:56:30 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485FE58E65
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:56:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8646ECE2342
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C364C385B8
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:56:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="K/drI8ip"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653004581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EudNmb21pYZa2JQr3j9+SsFHpyCBzhXAptn5vQa9OZU=;
        b=K/drI8ipAGocWAk3PGT+STRsEYdubh1I6IjCGmf/UeevYWlU9xRNUrmSonznILBjf/w2nP
        R7Gt3VOtmwt7fbCGg07taZ+o/Zm209bDq2/U4AB4EIJoIkFqtHHXgLNTYSJyYa+Dq7VK2W
        aACvv9X6F1bnVf74UGjf0JzqkCsBPK4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c4cb0971 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Thu, 19 May 2022 23:56:21 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2f83983782fso72172017b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:56:20 -0700 (PDT)
X-Gm-Message-State: AOAM5306nR8xz/XOCBas1Po4Ia8judWlLJ6zKp4rB+ewWkRt3+C5MO1n
        n17Oaj4wu/H1H9XYFbjczLpYYOF2MEv901S+5QQ=
X-Google-Smtp-Source: ABdhPJwrKFkx/D+awmKk86Dr3mfMpIcZ9ofD/LTug/0K3VnP2AYQZeBEzz6ekjBPU8kYqZ6SoTiTRe8cjtHeU/Q/2f8=
X-Received: by 2002:a81:11c9:0:b0:2ff:570a:700d with SMTP id
 192-20020a8111c9000000b002ff570a700dmr7368484ywr.231.1653004579893; Thu, 19
 May 2022 16:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220519233137.20415-1-axboe@kernel.dk>
In-Reply-To: <20220519233137.20415-1-axboe@kernel.dk>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 20 May 2022 01:56:09 +0200
X-Gmail-Original-Message-ID: <CAHmME9p9jipQk96q_nY0YzFMUaAQ4jOAAN_cmVorddfKV8cn6g@mail.gmail.com>
Message-ID: <CAHmME9p9jipQk96q_nY0YzFMUaAQ4jOAAN_cmVorddfKV8cn6g@mail.gmail.com>
Subject: Re: [PATCHSET v2 0/2] Fix splice from random/urandom
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

This patchset seems to work. I'll queue it up with some cosmetic
changes. Thanks a lot.

Jason
