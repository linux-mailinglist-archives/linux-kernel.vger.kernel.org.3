Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5043475C96
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244036AbhLOQCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhLOQCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:02:09 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07890C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:02:09 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id d198-20020a1c1dcf000000b0034569cdd2a2so1351232wmd.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ojSdfd0w7V7R85NomeMNU+dNWNtj40x2sGkRYyr3HT0=;
        b=JYVSeMPRdrQ/41PTdozayyXZLXZSYkzQQG9C0KSLWhh9Br/hQFLt38glrIgdmQN37B
         DAPSJe67qjpRb/4nqsO3ViYn8hRtNfHSnLgjRdUCrcnf70lxqhqwVQIv5WPD6+jadLBu
         NBr1dNs5T7OPU56dnbVYrWz/5qxSbtO/GNlUdNQ9e7aa1zlZ/9/xgzcEfZuYQJyfoDLw
         oX1BIFy0sk+zfpBqP/p+YmUHVmCno9ZzPS98uY+Tz+VEQjSXnQKSJsE1WoD/6ECYDhzh
         ZvvV3ASqutKbPPT/1EJhEqXdrTPubyncO2GjYVwJ3/aYvB7JvBWiJMF9zMxayH2sJtW1
         EGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ojSdfd0w7V7R85NomeMNU+dNWNtj40x2sGkRYyr3HT0=;
        b=GWEF0PZtkHLDJpYC3zrBEcMg4abRhssKGShPdZpXZYJMz6Ht3CmplXs3igy9xO+Bqs
         7GPls8HP9juI5YzMIDxjpZL9tZBgmCmjFwxLO7jkkR4mRAuA4o5NMvo/RozXFLWvsMIh
         1CRbR5Sg4QCSdt1CcprJixzMkOEc0YpImBYsaQg5TGuQYtA15eLEodGsNAPv6lYWCz7A
         IF/ragVM1VmRLs+mDcE66qBwHHx6rHfZanaHDYBBAmYcAg2eEXk+uizau9up/1tU9jWz
         wimO2NKzCHY8Ru3GinwqO3bkZap/C2fiuvWiOAllVvPhZaWXoiNQoeawhkAye6pImGw3
         5Flw==
X-Gm-Message-State: AOAM531XyNcrpNRYLhTDvfXwe3DKQ1joXgOG5Gza3ZVzC7ulaZFI4Sp1
        /R5ecsAaV+/q9Aupg2/nxnKEOA==
X-Google-Smtp-Source: ABdhPJxHF+NyYbY/jjawRCuOpa8Ju7jrj/FHpwEjOWpopNN/JwGbTbeM6E/ehn2ANN0Hn9Tx628zTw==
X-Received: by 2002:a1c:ed07:: with SMTP id l7mr501846wmh.12.1639584127282;
        Wed, 15 Dec 2021 08:02:07 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:fc03:4f5b:4e9b:3ec1])
        by smtp.gmail.com with ESMTPSA id y11sm3097558wry.70.2021.12.15.08.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 08:02:06 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:02:03 +0000
From:   Quentin Perret <qperret@google.com>
To:     Andrew Walbran <qwandor@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 06/15] KVM: arm64: Implement kvm_pgtable_hyp_unmap()
 at EL2
Message-ID: <YboRe+ZRnqtCymHV@google.com>
References: <20211201170411.1561936-1-qperret@google.com>
 <20211201170411.1561936-7-qperret@google.com>
 <CA+_y_2EEP5tYbBTd17c1wuOeZ2jSfhgu0M2b=CpGKjKRgU-=gw@mail.gmail.com>
 <YbCAJZAqUXngvjZ2@google.com>
 <CA+_y_2GJk-F8ju0yXsMc2iwd_yFRQGOY1LW2YV-8bZLANwfCHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+_y_2GJk-F8ju0yXsMc2iwd_yFRQGOY1LW2YV-8bZLANwfCHQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andrew,

On Wednesday 08 Dec 2021 at 14:40:54 (+0000), Andrew Walbran wrote:
> Aha, I didn't realise that block mappings, but it makes sense in that
> case. How about adding a note to the function comment here explaining
> that reasoning? Otherwise it sounds like the caller has to handle it
> somehow.

Well in fact the caller does have to handle it if it decided to use
block mappings. We just decided not to use them in pkvm for now for
simplicity, but I guess that might change at some point. The page-table
library is meant to be architecturally compliant (it can create block
mappings or not, ...) but the decision of which mappings to create is
left to the caller and the handling logic belongs there. At least that's
my view of it. So, I actually like the comment the way it is, it
describes clearly what the function does, and what the caller should
expect. I have a bunch of changes for v4 queued locally, so I'll send it
now with that comment left untouched, but please shout if you have an
idea on how to make it better.

Cheers,
Quentin
