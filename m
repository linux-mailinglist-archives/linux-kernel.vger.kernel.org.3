Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520184A6493
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 20:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242283AbiBATEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 14:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238994AbiBATEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:04:31 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8EEC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 11:04:31 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id g15-20020a17090a67cf00b001b7d5b6bedaso3563381pjm.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 11:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=wIaENBg/7AsUHJDq4OgnIPqvHUp4Vts4+P8qgAxYW1s=;
        b=Y95dzwDrfydpWDBxj30R2ZccMBa6llxL8kVA34F+lHigePxpWyJM1muhJRfbeXA5Go
         0eKhAoQ5DrDBUxYRj46MLXMjhW9WDqWO27hhkKB2VbeNmYWnn9cZlLdSJaeqyf6SxhGT
         /LlkOBZ5N4r4rO0KCSZBCZnVLl8x14f9/mLfR8Kn+8/6hUl2mDVGUxiftpPgUsXYB2j/
         oXkjyEfIeIZ1UFp4r2Sm5StQhyJCU0JqxolSVYYoTW8lHIMWUj0In0Uk5kzWAPPF8orv
         RKz8F8zPEtTNamxib0Pz+00rphknQEOZBAIQtn9LxZUEQH6vC14znFQ61HUsIKVnG0PO
         9bHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wIaENBg/7AsUHJDq4OgnIPqvHUp4Vts4+P8qgAxYW1s=;
        b=p4ihhcxg9F66gxX4fHqkeaXck/NwChV394gSzamVxgH8w/A+ekMEInZBhUC0HwuPsD
         ZE7zAhxutHSOJMHhXTlRsmhIlSDqpBZmQYTuDcFMrmtQAimcXmXf6T/zpagKYLbbWGWG
         Rc3YSZV7+VdRZOXujYdD+qYz/8BbPrsoI1Pg43uqNYYZoeb708vmzl4OYoYkJQXfMn4P
         l4AwX06/gA+6qnlO9oiLYS/8MWSqevKZeuuNcj1e727GLJMxViozioX0F0JMc70LGFR5
         BRpVuk0Dn7DEoQQ8KnVq056XN+X30FNUg2nuQ6wjKn4PDMBNn7LTK9Dj8PyddhgEs8O2
         ao/A==
X-Gm-Message-State: AOAM531bGpeZQvh/zO6+Q7vgUimCkGEJ2eqv9GF1hZKo2tV9RV10r5ye
        EPYQ/WO2Xk5dEMIFOVfFD/4KAQ==
X-Google-Smtp-Source: ABdhPJygCi8b1yCmG8oqZZPB+iH/tseA+EFVP6QFMDH3+XAyTEM1OWhw4r4ydzfW6NVUYlCesgahMA==
X-Received: by 2002:a17:902:d2c3:: with SMTP id n3mr27222538plc.45.1643742270670;
        Tue, 01 Feb 2022 11:04:30 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id d32sm33229135pgb.46.2022.02.01.11.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 11:04:30 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: Re: [PATCH 0/3] arm64: dts: meson: add ATF BL32 reserved-memory
 regions
In-Reply-To: <20220126044954.19069-1-christianshewitt@gmail.com>
References: <20220126044954.19069-1-christianshewitt@gmail.com>
Date:   Tue, 01 Feb 2022 11:04:29 -0800
Message-ID: <7hr18m9znm.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Hewitt <christianshewitt@gmail.com> writes:

> This series supersedes [0] which fixed a long-running kernel panic issue
> seen with Beelink G12B devices booted from Amlogic vendor firmware. The
> same issue exists with a wider set of devices from GXBB to SM1, although
> it is not often seen due to my kernel fork including 'catch-all' patches
> for some time (the meson-gx patch was suggested by Matheusz in 2019) and
> many distros actively supporting Amlogic hardware consuming some or all
> of my regular patchset.
>
> I've also included a cleanup to the SEI510/SEI610 board files. If that's
> not desirable feel free to ignore that patch. I also dropped the fixes
> tagging as I'm not sure what original commits could be targetted. If you
> think fixes are good please provide some guidance and I'll be happy to
> send a revised series.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
