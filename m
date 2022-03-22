Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFFD4E36DF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 03:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbiCVCvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 22:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbiCVCvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 22:51:33 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC9D4EF52
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:50:07 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id c2so11648860pga.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=id351bfFcXjcDLKiqWj1IvJglNtPMr9BFJLybhTc7GM=;
        b=dKUtvynk+xRhkGYM2Xd0U1xlkpcIKgq0da8OMASRHTkEon4QQe6TEU5RSKK66qTjKh
         BUL2dMnjQSPJeQ6zVrcpy3hHNBvLMUxoe71aKhpI6Jfj6ENdf16qXPgTtpND0smR2Z+i
         2cNqi+hXYDgP3Uh3yRiz8UmV6GQN9FCA5PdWAvzq4NAjDOckvqiBUqLrnM6iBBOnqeTe
         aYr+0lVIXK+soipvdFCi8f6QTPDVBIT4od7Simmn2/QsICQe0ceN++05V9lMVZjPNVlG
         V3QfEemZaTi7A03KPCQ92xK79C7KPJ5x+Mc6aj/tZZznJfhYz2rPr9FZlwTVvIVP6Mth
         YVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=id351bfFcXjcDLKiqWj1IvJglNtPMr9BFJLybhTc7GM=;
        b=k/NzhbTXeGOxpQPA0eDlTq5CQM1gapP8UzGKEQlvFMcIDDgibI17dZkYO10CdU2Yh6
         nsgJ88N5flvr4PB8SBFfgLz6rMA5I8YNvEfbPrCKlW5dZSyBSrGgG+EgryGB4VGwezYk
         gB/MBY26Y51cJ5JeU8iTO+v3Y3+bT2oxPmycurommw8U3Z1g7CNsTsEVW4u6MOlNYtAI
         TkeH9IXQcHr3StboDXgLwOgalqDyQS8wnMRcgxV0D52ZhKMtv4qzOt70DPtuB00Rn/sW
         0O5u3/Y8NSdKT5kAFsILAvzguqEQa8RUyVcHnGvVL/f4crI9de0j+5Twn/gNlKJgtBT0
         HIWA==
X-Gm-Message-State: AOAM531Yju4uOk/rKBLb49tAlDu1as0OfSGf/KnyOuE8fCDqVpgIMsmz
        xWDHa2WsqaKwNZaXnZa570w=
X-Google-Smtp-Source: ABdhPJz42V1dZmz5Je52FVNhkWwZrIOHQz29spKl89Bey+/lDpOYMnrNcOGIDBt6uzwssK9lJWVsTw==
X-Received: by 2002:a05:6a00:1944:b0:4fa:952b:48cd with SMTP id s4-20020a056a00194400b004fa952b48cdmr9921204pfk.10.1647917406579;
        Mon, 21 Mar 2022 19:50:06 -0700 (PDT)
Received: from mi-HP-ProDesk-600-G5-PCI-MT.xiaomi.com ([43.224.245.244])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a019600b001c6457e1760sm750024pjc.21.2022.03.21.19.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 19:50:06 -0700 (PDT)
From:   chenguanyou <chenguanyou9338@gmail.com>
X-Google-Original-From: chenguanyou <chenguanyou@xiaomi.com>
To:     gregkh@linuxfoundation.org
Cc:     chenguanyou9338@gmail.com, dave@stgolabs.net, hdanton@sina.com,
        jaegeuk@google.com, linux-kernel@vger.kernel.org,
        longman@redhat.com, mazhenhua@xiaomi.com, mingo@redhat.com,
        peterz@infradead.org, quic_aiquny@quicinc.com, will@kernel.org
Subject: Re:[PATCH v5] locking/rwsem: Make handoff bit handling more consistent
Date:   Tue, 22 Mar 2022 10:49:58 +0800
Message-Id: <20220322024958.24633-1-chenguanyou@xiaomi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <Yi73sVutB2w3zxbT@kroah.com>
References: <Yi73sVutB2w3zxbT@kroah.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What ever happened with this testing?

> thanks,

> greg k-h

We updated android gki, monkey test mini patch.
Link: https://cs.android.com/android/kernel/superproject/+/common-android12-5.10-2022-03:common/kernel/locking/rwsem.c;l=1290

thanks,
Guanyou.Chen
