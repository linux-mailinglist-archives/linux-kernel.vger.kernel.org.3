Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2061449FBA2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 15:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349147AbiA1O1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 09:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbiA1O1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 09:27:02 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB09C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 06:27:02 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id p63so7046779iod.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 06:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=1bnORB1wkruXjbPQsxwiOmxlipkYRK0gZn3m0VjNnds=;
        b=SUn5DhBkNrcBlytCHFJFy16BnTHHKOlrENp0Y4zwHCYFlFKQNIuiGomBzHMtZ+qAsi
         OBLc2BCaiODyaZlss5gLV8wm+Pbf65SzlM2pwCZtbwvhUFboozN0ECuNvBeBR9FO4FLD
         MfjI83r5SfoI6MNqGB+UFjXcLfeNF7J0xy53IVdQunfF01HtaV6yzucwe0yk/QVeLkdC
         WCgwxRWn7tiFrNm/hq9JYG+bb1gT4EwE+Z4HHFvjt/6KnsLFOm94bQ038m7b6oww7/do
         ShqyuaaRY7ejMQwFR+q9UnfTaNZ4h9go1C5gTTYENFb+VOIl4F/gJAkTiEgxwodMuT7Z
         2RAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1bnORB1wkruXjbPQsxwiOmxlipkYRK0gZn3m0VjNnds=;
        b=Th95q6OjlphyafoU9l7kf3MMtsVmaH6+49HUCTiRiMYzIeUHgc6kaA76wMZxsIwZAP
         OmkawT4FLHnLcW4bI+SAdK14yz6BILa6zxRtMacNuJQS+ZzsjwLw3MvhZWlavYzlPK2W
         fcj8j73oe6DrOUpnEU37K6JWUSlP8U5GJJYKe6zyeXe8n60IFnLIPsIAbriYBc01I/p2
         /qyw88XAjbbXhZns/ICBkMylJ6Qfuo6pbvcUHqgOTb2W26+PUQ2sDfXPI6sbhtUSxL8h
         59PwRXlpiV6HoYaYpM9872dCwK1P1+uQPqjAkWalR4V8OPcnbqf24wWpnqpqzVBK6Hcq
         V5hQ==
X-Gm-Message-State: AOAM5327DyS2Q9yEQ6bTd3rPPLgGgmftm3T6JKGpjuz42T7pFHJO+fci
        LfvFUcdvuTC7qqZTIO48U1UkdDsiYr8LkJLfqkU=
X-Google-Smtp-Source: ABdhPJzd8keAgM79DYn7n5v3WjsKD74dnSWWSrq330nhqT0U0c7r5t4OGDflnZvo76hcpMuIexbijpFuoZz75hJO6VM=
X-Received: by 2002:a05:6602:2209:: with SMTP id n9mr5413049ion.106.1643380021757;
 Fri, 28 Jan 2022 06:27:01 -0800 (PST)
MIME-Version: 1.0
From:   Paul Mulders <justinkb@gmail.com>
Date:   Fri, 28 Jan 2022 15:26:51 +0100
Message-ID: <CAOn50SJrdS+uRnJ=e1vrb6n5e1TSWLBiLDdZe=7tSCXRVwtTjQ@mail.gmail.com>
Subject: Re: BUG: [PATCH v2] isoc: mediatek: Check for error clk pointer
To:     frank-w@public-files.de
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org,
        jiasheng@iscas.ac.cn, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I guess this breaks all MT7622 SoCs since it'll prematurely exit
init_clks (and subsequently init_scp) completely once devm_clk_get
fails to get a reference to the mm clock producer (which happens to be
the first one tried). This is because MT7623 has a GPU (so no mm
clock) and MT7622 doesn't, and as a result the other clock producer
pointers never get initialized (and other stuff in init_scp after
returning from the error never happens).

The patch seems fundamentally flawed, I guess it was either not tested
at all, or only tested on a MT7623. The initialization functions seem
designed with the idea that it's ok if some clocks aren't present, so
stopping the initialization when one of them isn't present seems
wrong. (For example, there is also a MT7622B variant of the MT7622
which probably also lacks some clocks MT7622(A) does have).
