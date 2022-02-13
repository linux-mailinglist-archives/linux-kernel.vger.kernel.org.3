Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F1E4B3B85
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 14:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbiBMNIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 08:08:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiBMNIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 08:08:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965915B88F
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 05:08:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CB2661175
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 13:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BC9C340F0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 13:08:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="k6SFkzer"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644757687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YoXlrtp1L0W5/yTU1Jd3iz8yL8+rzRT8N1JuVJxuCFU=;
        b=k6SFkzerCHo8Hjv/GY8ebjjO6T07jkhn+wB+uKT36Z6xnHHkNewin+2kNIqxJprxO0ZKx3
        WVtfOk9a4ToXbmbr8w2ejiwkaLNIu5fBXiT+GXKQIpwYaSP5GsKrFUms6Y2tdIP15DkVeM
        riaFGpsxEuZuPygYogArKjAqVZUcW8g=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d4aefb45 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Sun, 13 Feb 2022 13:08:06 +0000 (UTC)
Received: by mail-yb1-f181.google.com with SMTP id y6so38573158ybc.5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 05:08:06 -0800 (PST)
X-Gm-Message-State: AOAM531xWfcPB52q2Zc8mULCUQ6pXy6yzdLBrDDXQF/js3GO2pUSk8Px
        ynWyHNivS+V1XXa/1kjKI16S5xbEMtwh5dc8Nm8=
X-Google-Smtp-Source: ABdhPJxFJyCVUlnTE5hJ8VmgliIH1hKdPybHaOMY90F1WUZdEsOKjEzeRK6COoTZVCsU/TQmkos/4whFSgS1juInUhY=
X-Received: by 2002:a25:dc14:: with SMTP id y20mr5308263ybe.115.1644757686332;
 Sun, 13 Feb 2022 05:08:06 -0800 (PST)
MIME-Version: 1.0
References: <20220212122318.623435-1-Jason@zx2c4.com> <YgirSXcAxKyO9BhD@owl.dominikbrodowski.net>
In-Reply-To: <YgirSXcAxKyO9BhD@owl.dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 13 Feb 2022 14:07:55 +0100
X-Gmail-Original-Message-ID: <CAHmME9os8G7bmvksE3bWkzRF4OAg-BMZUzi6TX0odug4oLUvsg@mail.gmail.com>
Message-ID: <CAHmME9os8G7bmvksE3bWkzRF4OAg-BMZUzi6TX0odug4oLUvsg@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] random: re-group and re-document functions
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     LKML <linux-kernel@vger.kernel.org>
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

On Sun, Feb 13, 2022 at 7:57 AM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> thanks for your massive patchset. While some of it was a bit tedious and
> repetetive to review, feel free to add my

Thank you very much for slogging through it and reviewing it! Much appreciated.
