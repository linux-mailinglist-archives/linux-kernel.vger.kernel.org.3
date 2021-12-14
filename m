Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF8B4745C4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbhLNPAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbhLNPAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:00:35 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDC2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 07:00:35 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id m6so306813qvh.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 07:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=Npa6QpxvQmUYEbEQSNgotdNWQmrkFsXB8W3hh04fQNA=;
        b=QE1b46oXawWE16Q6299aw877vrz4bJ24DCo9N8MfL52Mwr7pMXyZStfJfmNbnMJHXG
         Q/wdsjZuEz9IpnZ8QCf/rrX6+C6FoxnwUW87pwWEPRcQ5s/Oj5kGpiZCxp1FdXhCgc0Y
         bSA9LoCbhZ383WGo9TeSzV/eQS6CMxsXMoblA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=Npa6QpxvQmUYEbEQSNgotdNWQmrkFsXB8W3hh04fQNA=;
        b=ezvLnvve5RcFIdnK6qP9BtK4LsRiGUxhO3HE/Nd/LKcwNDVFd2Q8PaYnxllkBA6nNh
         cV7/jpp/tatJjj9lEHosxlP93jov85xWN/NEAvZywJN2dTBmQoVjlukH35xxN4yn5Dkl
         xiOy6y9EwnaqrGoWFiuTv32ZCTW68EH60AV2l7/EOf4BY+gSptXb7UV94Ko1X39pnfmf
         mPX5e9a3N7NN7bmiUIEuOKif6x28+myvLQa57xrBvMiFvNFH+pa1UW3lA1PyEy5eyxeg
         c5xNAKhoIQrDwpBjKR2W8teEP9jO20P7YO/waPKQlSMJP8eLuYO7+/PjIwAxbW6dzcH3
         VDyw==
X-Gm-Message-State: AOAM533pOMnuDCRfbXPGKIVkXNHknhAFd9UnXGbND1/k9QvChpzQHhiF
        lKzadF1/zzyyKWBhcC96hZydjFljH9g/UA==
X-Google-Smtp-Source: ABdhPJysMsQHTSpqtSUB6yJRtHWO4iRBaY90YIRx4kJEa7kLZuqmi3Vjza8X+xVRXeoDT1QiZA+0DA==
X-Received: by 2002:a05:6214:4103:: with SMTP id kc3mr5822680qvb.1.1639494034609;
        Tue, 14 Dec 2021 07:00:34 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id i23sm35570qkl.101.2021.12.14.07.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 07:00:34 -0800 (PST)
Date:   Tue, 14 Dec 2021 10:00:32 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     postmaster@intel.com, linux-kernel@vger.kernel.org
Subject: Please switch intel.com DKIM signatures to c=relaxed/simple
Message-ID: <20211214150032.nioelgvmase7yyus@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Intel Postmaster:

The intel.com domain has recently started DKIM-signing all outgoing mail,
which is great news, as it helps to add a degree of cryptographic attestation
to smtp-exchanged messages.

Unfortunately, your DKIM c= (canonicalization) setting is currently configured
as simple/simple, which is unnecessarily fragile and will likely result in a
greater degree of quarantined mail, especially for messages traversing a
mailing list service.

To explain, the first "simple" in simple/simple means that the message headers
are signed without any whitespace normalization. If an SMTP-processing gateway
even so much as rewraps a header by adding or deleting newlines (which it is
perfectly allowed per RFC), the DKIM signature will stop validating and the
message will likely be quarantined by the recipient's SMTP gateway. This is
happening right now for any intel.com messages sent via vger.kernel.org --
they are marked as spam by services like Gmail.

So, please reconfigure intel.com's DKIM signature setting to use
c=relaxed/simple. It will have the exact same security effect (nobody cares
about whitespace in headers), and it will greatly improve the lives of many
kernel developers at Intel.

Best regards,
-- 
Konstantin Ryabitsev
Director, Core IT Projects
The Linux Foundation
