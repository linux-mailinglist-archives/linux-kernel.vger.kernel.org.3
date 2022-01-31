Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C634D4A4CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 18:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380790AbiAaRRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 12:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349672AbiAaRRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:17:34 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15981C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 09:17:34 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id w5so12013138ilo.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 09:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbuki-mvuki-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7FMF5d4y464/mBG+xgnW5AJzOcYV63lfjmbJHbKUYyU=;
        b=UwueWjOowGG9RoghSXrun46QDMCi3GoMJyAPkybLGed7comdsxsY2etq9o4kWeqD8d
         QcriPVfGnMdYOqKYOaXkcRniAdGl/FhQpc5KnXkVbJXNnx4yQFi7068Jzvsy+OdY0Yj/
         ZFa64V3MwcoXR0Lm56ebc6+zMkmyeAdIldQB2jCzB3kdOBuDKzgCQaiRr9doj23/n/Jc
         LNKkMdbiBYKtKqWovgIFZDiyTTqPMjUOxAyoOWrnWwlWL/RWOq+/EQh5AkYDjKGWerRM
         3zlQKOmKHv5fAhKYT/rvyb7vCNbLZpY0VuAi94Xub/kf/EHSxudndjNa1ITPC3NWD87v
         X6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7FMF5d4y464/mBG+xgnW5AJzOcYV63lfjmbJHbKUYyU=;
        b=kPK6CBspE7yCzd38PvFcrNh0eS5CYhPsbFCrUvyTwjEQ5Q8QaUZ3VSGlcA9JnyvEqy
         sZm8qlBhds+sTDcfNdedaFAoKPD8E7DT/SKmZadOQXBunA/2ALG/+5w5UugKS/Jcygop
         xGhaEj4ijjrwOkFgVW81MBov6Pwg/UMdDF9TUacDVMG+AxxI0L4zpmT/sIOspnJ14ROV
         3BHbRJxoXEqJW2RDNdG+zTAQejjLT/lVytaoD01pBpyRxbGixlhygjhIifh95AY+7tqG
         GrX0TVytmTu0a1hgkb7LvVzsON4ciXUymDQ92CzVaFrCkVMHKYFLAqeRRBU8Mlat84D0
         0ozQ==
X-Gm-Message-State: AOAM5329Cci96aM0wFA3QWi3+AsfVy0cHb84xpfAigCew1r+j9kbe0Bd
        Xgja7a/N9OTOUGAnMsq7PDWfxw==
X-Google-Smtp-Source: ABdhPJxAPbl4lIWo/zl/wBMjezsPxPZpgneEeANeylpou0230Vt3jxB5ymE7ds/N5HABAwYzorMKLA==
X-Received: by 2002:a05:6e02:20e1:: with SMTP id q1mr13387664ilv.172.1643649453386;
        Mon, 31 Jan 2022 09:17:33 -0800 (PST)
Received: from localhost (c-73-73-44-208.hsd1.il.comcast.net. [73.73.44.208])
        by smtp.gmail.com with UTF8SMTPSA id q4sm7815726ilv.5.2022.01.31.09.17.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 09:17:33 -0800 (PST)
From:   Jesse Hathaway <jesse@mbuki-mvuki.org>
To:     ycheng@google.com
Cc:     davem@davemloft.net, edumazet@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ncardwell@google.com, pavel@denx.de, sashal@kernel.org,
        soheil@google.com, stable@vger.kernel.org, weiwan@google.com,
        jesse@mbuki-mvuki.org
Subject: Re: [PATCH 5.10 099/167] tcp: disable TFO blackhole logic by default
Date:   Mon, 31 Jan 2022 11:17:32 -0600
Message-Id: <20220131171732.1018990-1-jesse@mbuki-mvuki.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAK6E8=cEX6MjxdnW36t9qq8+RqkPp9ZTwwH9Mr=emfbJ4=WV0Q@mail.gmail.com>
References: <CAK6E8=cEX6MjxdnW36t9qq8+RqkPp9ZTwwH9Mr=emfbJ4=WV0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 09:32:42 -0700 Yuchung Cheng <ycheng@google.com> wrote:

> On the other hand maybe we do not hear middlebox issues because this
> mechanism is working. So I am okay to avoid applying to stable and
> keep in net-next to test this new policy.

This change did indeed break our mail servers at Wikimedia, causing
difficult to diagnose timeout errors on sending outgoing email. I
resorted to bisecting the kernel, which resulted in finding this commit.
I have verified that reverting the sysctl value for
tcp_fastopen_blackhole_timeout_sec to 3600 does resolve the timeouts.

Given that it is not clear how a user would discover that this sysctl
has changed, or know how to fix a middle box somewhere on a path to
their destination, I would love to see this change reverted.

Yours kindly, Jesse Hathaway
