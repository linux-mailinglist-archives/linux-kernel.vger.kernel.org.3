Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6B1551030
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238198AbiFTGUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiFTGUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:20:41 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8764CDED7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 23:20:40 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id g8so8852727plt.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 23:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=847DDg6hmMSry+X3CbdyKKpEZE7fJcTvj1pxYsPYSEs=;
        b=TVfrpV+9ee06mypjQZlWEqFtNXU4E7sBxRe29ZU/P6peKxSlJpmPBgJTFoLW1gwIRL
         wFqmQ8R/LyAK6mTJjxcnwFcEaGI1+4nTZT+cELYBrnPmC/PGYWjH9DkrMLNkvjljN2+U
         mwpSMUO2e/3udg83ZSeRDxPG6tGvLoTHsaWUUXiS7f0otQ82jWHSQUkF8PvdOxli+QuE
         kSzHCWkxbjUJK19m46qHgk1zCKAuJt3pPYkAfnYleTdQH2LiBkLogbDHNMZKDtSYn++g
         5gqfwEjVNSh/HB5tVj0qNu0F2ubLzQgbO4kQ9j80rqb064kC7W10KmJwHCAEWRBy/9GZ
         CPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=847DDg6hmMSry+X3CbdyKKpEZE7fJcTvj1pxYsPYSEs=;
        b=hfWLhy7vy3ueP3xaQ1gqVQdKgGhpusdZCpaCsbt8CC341FshAWsF39vJC5PiSLai18
         Sm0ZgZOWVRhF1uFukX1KVZVJM2s/L3Z3XU64+tA8VC5RHscFP/VG+woQ4RQ1KNFvwSG+
         hKB6/umVz/LVuqGjpxLZhoKAtMCucnfgZVwQvCjiynz3wlj+Jpca29pI4SmEaR1yF59t
         bWcgzvPj5JpPV/EnUWGUmOtQvwqqJ+WjOEsrCZIYwgi5b8BtiXLmBNgcRVsAdcOimz+B
         9UMhcbEJcvTSCY0Rig+2RHuhNsDp+BPuQbhn0hhNqZ4TITjTCTRy9S/NjGu91luYxKAO
         QDwQ==
X-Gm-Message-State: AJIora/aqI3c1N+vVb0hSTuCJXFhjbM8C+iAZgX7OIdsQDYbNS5gSgnx
        tcNlCk5ZTEliLuSeJQsoPROg9mki8pE=
X-Google-Smtp-Source: AGRyM1vZTFZGidzxwI+PGvvFDVL/52CRRN/HbZNfGSvKQHcAwtAHKlBoxmPUEb5GasBhJL5eyFir3g==
X-Received: by 2002:a17:902:c40c:b0:16a:252c:ec82 with SMTP id k12-20020a170902c40c00b0016a252cec82mr3837080plk.5.1655706039615;
        Sun, 19 Jun 2022 23:20:39 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id p13-20020a63950d000000b003fd9e4911f9sm8010469pgd.31.2022.06.19.23.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 23:20:39 -0700 (PDT)
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3] rslib: Several improvements
Date:   Mon, 20 Jun 2022 14:20:09 +0800
Message-Id: <20220620062015.15612-1-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I made several improvements to reed-solomon library.
Please have a look. :)

Thanks!

Changes in [PATCH v3]:
Fixed kernel-doc style. Thanks to Randy Dunlap :)
(But I decide to keep "a*b" instead of "a * b" because I think it's more
readable)
Reordered some patches to group similar things together.

Best Regards,
Zhang Boyang

===

Changes in [PATCH v2]:
Added more patches. Removed init_rs16(), since init_rs_non_canonical()
can do the same job.
Link: https://lore.kernel.org/all/20220617144624.158973-1-zhangboyang.id@gmail.com/

Changes in [PATCH v1]:
Added init_rs16().
Link: https://lore.kernel.org/all/20220606101901.83538-1-zhangboyang.id@gmail.com/

[RFC PATCH]:
Link: https://lore.kernel.org/all/20220605073857.126497-1-zhangboyang.id@gmail.com/


