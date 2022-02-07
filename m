Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE57D4ACBFB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 23:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244171AbiBGWVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 17:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbiBGWVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 17:21:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B006C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 14:21:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DED3AB8170A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 22:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C77C340F2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 22:21:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UQlYmPI8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644272459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z1WhZRohSjwF5ki35hFdGu7AARlsDBZkg+dcLZ/0i5w=;
        b=UQlYmPI88xkNa9f3my5R+9vh2+tf91E5VuFOdmp/AVAgySp/D7HXKMkoP2dV6s4WIHlB12
        HqUtwOqpX8X+wEngg9BV4Vxl+VEKZio0vkJNcYqRUZu8JHMWKYGw1OevwUlOtItqy0Ky0v
        QeukkrwQK3wcaNnHX9cTJ+b/kwJz+4M=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4b6d17a6 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 7 Feb 2022 22:20:59 +0000 (UTC)
Received: by mail-yb1-f172.google.com with SMTP id g14so44305724ybs.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 14:20:58 -0800 (PST)
X-Gm-Message-State: AOAM533yyLHKCSCBNrE2GVL50SQ97qjgry2dJRBnQ8MladvW40NuPiJD
        3b2nRuEHhBol0YYjOH0By+rU1z5UM/B+OpFFl28=
X-Google-Smtp-Source: ABdhPJxCYVW8NPJ99IONZJRMtzLDEIz5VUL+CfPdsmsLWtOOqE8o3Shoi69FlfCvvnx4OZsYATYNZJO9QRKRq78dZmM=
X-Received: by 2002:a81:1084:: with SMTP id 126mr2128376ywq.231.1644272458038;
 Mon, 07 Feb 2022 14:20:58 -0800 (PST)
MIME-Version: 1.0
References: <e10b79cf-d6d5-ffcc-bce4-edd92b7cb6b9@molgen.mpg.de>
 <CAHmME9pktmNpcBS_DJhJ5Z+6xO9P1wroQ9_gwx8KZMBxk1FBeQ@mail.gmail.com>
 <CAG48ez2P9-CAdgRizcp5T_uuoXRAt0xtodh1doiMW0fKZVX-7g@mail.gmail.com>
 <CAG48ez3wZOZZX1UHM-Q=KhOnnGR85Unm08q7jT_wVfOq0PW94Q@mail.gmail.com> <CAHmME9oaj5g==Rhq6HvrxSHHfo-v1whdzwWTWFqmrDw8sBHqoA@mail.gmail.com>
In-Reply-To: <CAHmME9oaj5g==Rhq6HvrxSHHfo-v1whdzwWTWFqmrDw8sBHqoA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 7 Feb 2022 23:20:47 +0100
X-Gmail-Original-Message-ID: <CAHmME9phcxQ8gLpBLVwyJszPdnpxOdeTgcDYzno-TLdV15HZcw@mail.gmail.com>
Message-ID: <CAHmME9phcxQ8gLpBLVwyJszPdnpxOdeTgcDYzno-TLdV15HZcw@mail.gmail.com>
Subject: Re: BUG: KCSAN: data-race in add_device_randomness+0x20d/0x290
To:     Jann Horn <jannh@google.com>
Cc:     pmenzel@molgen.mpg.de, "Theodore Y. Ts'o" <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
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

Narrowing this a bit by looking at the disassembly from as similar as
a config as I could infer, there are three calls to _tsan_read1():

1. ... = lfsr;
2. ... = dest_buf[i % CHACHA_KEY_SIZE];
3. ... ^= src_buf[i % len] ...

1. lfsr, as you mentioned, appears protected by primary_crng.lock.
2. dest_buf is &primary_crng.state, which /should/ be protected by
primary_crng.lock. The only place where it's not is rand_initialize(),
but this is an early boot function that should complete well in
advance of where we are.
3. That would be tsk->se.sum_exec_runtime...
