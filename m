Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE7746E21E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 06:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbhLIFs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 00:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbhLIFsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 00:48:54 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A7AC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 21:45:21 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id m25so4319709qtq.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 21:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=Wcs4fYEQI1Jqq6kBZB1ZnOXmYbDoVM5sVRAmN4BWitA=;
        b=MlsalTZOPPARgWp5jOY14+HoXjQAVBQippX01GmqBUhmdTlU7N/JS8/KlWFaGahL26
         Yg8+DkXwOSEDVhlnMSkHwKhtHE5AT3gMDX+bMisQ8WuulUJWsUpqfY1EHwlA0SIAYC9f
         ItYECk4YZkQhMm28hA6XfMiefA2hP8n2V89gNzvFOmO3517TwwGnVRhd8PYN1BhgdfXE
         d33NhXdfiUVSFJj/m23zAKzo3AEjWn54NNk1zuV2ltqKvFxK7dq6rn7cguvZWbgenHVV
         f/HSnYgv/Wi92pHRigo+Xef6z/ErJcJTkgXXTNikpmkJh1shNr8yOaLaCIDKCyDhSxhR
         jr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=Wcs4fYEQI1Jqq6kBZB1ZnOXmYbDoVM5sVRAmN4BWitA=;
        b=CfzXExYRZ1/VAZXjgZpvY1q3IbQrxfAWobmJLU/PmGKbVsn7S8rHxYUQFZQsVDTlV7
         m8wFLAZ+9N9/tai5o0sZVZMzrzZgrAMkUBoEAflxzCxhZCh2KrY4DWEHWdVKt87xmUbL
         iJ04/R1uQUSTwBxi/dn3jNa25Fxp/kMB1KMVZCXO1lUNZgtd/DN6qnCkuqTdqRrTq2Rd
         KIQu5qe5p+vvSGrbAOqS46aPfGbwnta3/sp7dkmE/RsL0jyK7Na3CiYZlNIDisFQkcg9
         6gxKboOC1oY8ZGOFfgkuXiEE66mSCcY7xvlArJh8kanaJgc+MbhuE4gMdvQjmhCgjJLg
         4jxA==
X-Gm-Message-State: AOAM532dmDfEMBIOr00UZ3avFs4AjhR76MBK7SrrJLydYxUCWtvBygQ/
        kHnTc6OejWRBtduQPE1SlgZVlwORbcfElA==
X-Google-Smtp-Source: ABdhPJyeMj/jXj5Z9K4zAIgi5asZ4Lpf4iEFpjV/t6ROs+o5QQcPTdf46Dn4NpIzOTNmeKupmTrnLA==
X-Received: by 2002:ac8:7d47:: with SMTP id h7mr14606926qtb.486.1639028720171;
        Wed, 08 Dec 2021 21:45:20 -0800 (PST)
Received: from [192.168.1.227] (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f34sm3522424qtb.7.2021.12.08.21.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 21:45:19 -0800 (PST)
Date:   Wed, 8 Dec 2021 21:44:54 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Borislav Petkov <bp@suse.de>
cc:     Dan Williams <dan.j.williams@intel.com>,
        Anjaneya Chagam <ajaneya.chagam@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: 5.16-rc: "x86/boot: Pull up cmdline" breaks mem=
Message-ID: <ae2bb14d-d27a-e76d-adde-ef888d373343@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bad news, I'm afraid: I boot with "mem=1G" on the cmdline for testing,
which worked fine on 5.16-rc1, but does not work on 5.16-rc2 onwards.

Bisection arrived at 8d48bf8206f7 ("x86/boot: Pull up cmdline preparation
and early param parsing"); and reverting c0f2077baa41 ("x86/boot: Mark
prepare_command_line() __init") then 8d48bf820cf7 does fix my "mem=1G".

I have not tried 5.15-stable, but guess that is likewise afflicted.
Sympathy, but no suggestions from me: early init ordering is hard!

Hugh
