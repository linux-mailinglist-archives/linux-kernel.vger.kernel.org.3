Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFE9489000
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 07:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbiAJGGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 01:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiAJGGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 01:06:49 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F0CC06173F;
        Sun,  9 Jan 2022 22:06:49 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id b77so7449926vka.11;
        Sun, 09 Jan 2022 22:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=LK3tmlug+DMfgByubmuTTbml4FXkpQCC66d1KNzfJC4=;
        b=Vi0k//5j8p2xpFzFUPfJSHx1/TavX6yCKRtKYEfQRWbqHTbKLD9s22o13V9k8QB+Ax
         dJwPL7GDVIx/4o/aO6Toov5KJVbC5CiNP2SlVCWtVH+BlAK7VdtNDQSdGRPsuC1hepXG
         UlRZvF43jZedZwBMZhLbGsHp8P4IQNSIx4fHlB3XnwFQ3O45Ohm7AGGxYOvIU5ogU1gr
         HzM9IAPbbaCVuiZKW69RiciB0PmWggJzuptXWOnwB6BhyVtqnEskD6ezMWdesHE579KF
         eBgph6aR+TcIlA0PuzD7aanNPVn/Nl7DBfKrWyHQJRLdD4+W5Isf7HUJevqFb+MdlIfD
         gRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LK3tmlug+DMfgByubmuTTbml4FXkpQCC66d1KNzfJC4=;
        b=qLMCbB8zVLe3NTVCCaMH5/kz084lLTf8yieGvkjpJaCqEq59AY8XXPSYZGKeDRh4w2
         ymwhGXuhktIsci/XHN0+pSwZ+VL8zrz5Vv97jdBNq9ptPKLSYjWOXyr9XafSUN+a6AS1
         DlXIWweDHUm9NwR4bxwrnKPZ8qBvAsq0UOOARjH2M03gMF0Cw6ed1b4cNs3K3gab8Fyi
         b201yW1rdyJrGWyPO6I+fai0AUfzCNdp6KdtgjAEYfjIQaiEIGAYtYky2DuVXZWDyHRT
         gstYNulfb1nZE04nBP/84oGbCzD3Csche1bqQdv8O788VOq+8KukX1NpdAvKUcXV+I5y
         av7w==
X-Gm-Message-State: AOAM530po60MjiMY45jtyS2RQZ2tW7VNxkXPAvYbIbCCAy+P9p0bAtVa
        pinIyQhNvz+uSggDHZkT0EMJ407bJRzFqrMWSBDe3+1o/Zo=
X-Google-Smtp-Source: ABdhPJzRkFi8X3uZCbxDPI80V/p/7TM6f2eWnIbdmtMCHJMTqd7tnwn99jORBO2CfBXUQIjkDH2kWLAY+oXJLoRfCd8=
X-Received: by 2002:a1f:e243:: with SMTP id z64mr25606383vkg.28.1641794808093;
 Sun, 09 Jan 2022 22:06:48 -0800 (PST)
MIME-Version: 1.0
From:   Davyd McColl <davydm@gmail.com>
Date:   Mon, 10 Jan 2022 08:06:37 +0200
Message-ID: <CAJjP=Bt52AW_w2sKnM=MbckPkH1hevPMJVWm_Wf+wThmR72YTg@mail.gmail.com>
Subject: Possible regression: unable to mount CIFS 1.0 shares from older
 machines since 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c
To:     linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day

I'm following advice from the thread at
https://bugzilla.kernel.org/show_bug.cgi?id=215375 as to how to report
this, so please bear with me and redirect me as necessary.

Since commit 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c, I'm unable to
mount a CIFS 1.0 share ( from a media player: mede8er med600x3d, which
runs some older linux). Apparently I'm not the only one, according to
that thread, though the other affected party there is windows-based.

I first logged this in the Gentoo bugtracker
(https://bugs.gentoo.org/821895) and a reversion patch is available
there for the time being.

I understand that some of the encryption methods upon which the
original feature relied are to be removed and, as such, the ability to
mount these older shares was removed. This is sure to affect anyone
running older Windows virtual machines (or older, internally-visible
windows hosts) in addition to anyone attempting to connect to shares
from esoteric devices like mine.

Whilst I understand the desire to clean up code and remove dead
branches, I'd really appreciate it if this particular feature remains
available either by kernel configuration (which suits me fine, but is
likely to be a hassle for anyone running a binary distribution) or via
boot parameters. In the mean-time, I'm updating my own sync software
to support this older device because if I can't sync media to the
player, the device is not very useful to me.

Thanks
-d
