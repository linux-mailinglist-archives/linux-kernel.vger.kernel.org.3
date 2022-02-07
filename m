Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780C94AB569
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 08:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241721AbiBGG6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244460AbiBGGjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:39:21 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F728C043184
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 22:39:21 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id x4so2822033plb.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 22:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=90XO5j4SSi21MWkXg4eItPBZYaK9KTBYZP48f+183o4=;
        b=i0DZqUdfdLyhAKlEgh+PGwJ7phDr5iQAosAX9Rasiie7jUMZVPiw3XZ8WXRQnaRTr/
         FhY4t69rFHxemXszxR5ixemlFPFNzGX1EctCHIq11qw8vPBshMobVguy5hyliUucXKa9
         w5hVm7cKg85ZG2XIm3Ww3rOnY3+GL3EwYOQwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=90XO5j4SSi21MWkXg4eItPBZYaK9KTBYZP48f+183o4=;
        b=i4u83fvPSFjnB8MThwE1np7DtbDkHbPJJWwafjqrUreDjPypJ7zBmklU3fd9QrFIPM
         l4PGS/BNSsj7vGQBxzVxLsE6+bQfQ02vONNbAjtfT5lip1mKwlqhEWg9FgjNxsDB9Gzc
         3V42dH2xxA72fRjdun2JntLOxZonoTDqt74/e5gPHNKmkkvLa1QX5ouGSk6d8bpct1xp
         juMByduskgu5XT+JwWMnB7xvuw84JBwZONFqVhj20IPDREgPyNekuPWcyrmvSrzHD0/0
         UfznTn29gQqn5Fvz0tHS3BdBzERO43b8NMcXvV3CpIONZHxDxGlONHUp0QGr+xMZbzjq
         cJcw==
X-Gm-Message-State: AOAM532JUQkhLciBAM2V7sDouvN6U1q6Nx4T1Vj32QZhyIjDMYUcPWDa
        GpoYBqbBuJ3vpunwG1dP09KbKj+NjQSqIg==
X-Google-Smtp-Source: ABdhPJzgL04N5Buz1tFGttNAZt5XY/2MMNztRGg7wk0/gdE/g5HEPJJ0QaDB+q1tFkDtBWWwXOFS9w==
X-Received: by 2002:a17:90a:4544:: with SMTP id r4mr12463872pjm.186.1644215960965;
        Sun, 06 Feb 2022 22:39:20 -0800 (PST)
Received: from localhost ([2001:4479:e300:600:88d8:e74b:308:eac6])
        by smtp.gmail.com with ESMTPSA id q2sm11190359pfj.94.2022.02.06.22.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 22:39:20 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     joel@jms.id.au
Cc:     andrew@aj.id.au, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, nayna@linux.ibm.com,
        Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v2 1/3] firmware: Add boot information to sysfs
Date:   Mon,  7 Feb 2022 17:39:15 +1100
Message-Id: <20220207063915.2079738-1-dja@axtens.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220203115344.267159-2-joel@jms.id.au>
References: <20220203115344.267159-2-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I really like this design.

Currently on powerpc, a user wanting to check if firmware was
configured to boot with secure boot has to understand both OpenPower
and PowerVM secure boot. On OpenPower they need to check for the
presence of a device-tree property. If they're on PowerVM they need to
decode a different device-tree property and check it's 2 or
greater. Of course, it's not stored as ASCII, it's \x02. And it's
stored big-endian too.

So if powerpc implemented this infrastructure, it would provide users
with one single place to look, and it would represent the value as
ASCII. All very lovely, and it would simplify some scripts enormously.

Reviewed-by: Daniel Axtens <dja@axtens.net>

Kind regards,
Daniel
