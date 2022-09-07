Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C0B5AFA04
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiIGCkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiIGCk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:40:28 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D2374CC2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 19:40:27 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id m66so13518662vsm.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 19:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=nRLryB5Xf6lBklSjFILLPLap9evfM0qCWn2PvmAqML0=;
        b=UJVC3Gng8U3UmQUkRK7cXsWmmJL7WkoCXMlUIomBRYjM86jMhNimaEYMGH9NI5etdf
         9dXdbKNrB3zpNZCcS5BDKaFI2z6VCPAUJI2fvx+yODlYzfl7JF4X78Lw2bXsJ110PQBE
         gWjQBfPs2Xv7o7gKddMwPZNmftTqOvcoK3U987SWDvW1PaCsLcXTWJEZgE4dEimJSWOQ
         iNX8zcjUof8AGeIgkZ8aP4qrAr7mK7cOlGo5XemApDnmELEDIjjUxbsKhUc7WCKCKAWB
         5l1qhf/8q+kZvglYXBSvov+hUlZtTqxzGRm1TqvtPO7gsLSZeq93rx1+qAmg3OjPCivG
         JmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=nRLryB5Xf6lBklSjFILLPLap9evfM0qCWn2PvmAqML0=;
        b=if8nrIK/uNMWV+mDEaUoqAshKXVvVbaQmo3i85b4lWl6nVIHkS6XPEgSvOFKLjmT08
         zgLZvRCxv5vlsrCkkiorYCjlA4sCDPmaoXvq+xwnZwObZ9/koeVwpL9Eq2OtVD+A+CXu
         exvslb5YNJz8ny6iHy6Wsz/ZZuP8uRDy1VcDxtmKuSsg/WBAOhnV6fZVDL5LWarHp8Fw
         t9f/qSM3rhdEV3PmcI40hdD3M8ZJUkLmBi6u3O5/gajgG3gEnwGJv2cXDd4+fSw9ORcC
         TqXpAZ9sXZS8oE8xxoOtw5yP7ogPrAzGS8fBEFS8w5IiuKhY3+AlYdD9tvXVMUE91sYM
         b6ig==
X-Gm-Message-State: ACgBeo3gXjKAVoxI9KIhf5RrHETg+0MAjwHtZIDnkW27zkjLtn5SX7mg
        F1X/GDWPm06HBUJKrlRT9cIkgGhk9jsFxuIkt6dwzQ==
X-Google-Smtp-Source: AA6agR44iTfe4vWGY8NVG62qnMuNdo07u4WWB0Hq3elNrucYrkLoB5SpIfHwPyNFT59Q2eNPmDt6Pc0Rc8oKHU/TE/A=
X-Received: by 2002:a67:fdd0:0:b0:397:c028:db6a with SMTP id
 l16-20020a67fdd0000000b00397c028db6amr477394vsq.58.1662518426470; Tue, 06 Sep
 2022 19:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220902154804.1939819-1-oliver.upton@linux.dev> <20220902154804.1939819-6-oliver.upton@linux.dev>
In-Reply-To: <20220902154804.1939819-6-oliver.upton@linux.dev>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Tue, 6 Sep 2022 19:40:10 -0700
Message-ID: <CAAeT=FwZ28XRgAkUH_aTxZfSPHRRrEUSy8-R-dj6rs6fmOnv0g@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] KVM: arm64: Add a visibility bit to ignore user writes
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 2, 2022 at 8:48 AM Oliver Upton <oliver.upton@linux.dev> wrote:
>
> We're about to ignore writes to AArch32 ID registers on AArch64-only
> systems. Add a bit to indicate a register is handled as write ignore
> when accessed from userspace.
>
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>

Reviewed-by: Reiji Watanabe <reijiw@google.com>
