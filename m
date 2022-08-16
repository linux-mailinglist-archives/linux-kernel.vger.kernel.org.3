Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44316595409
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiHPHkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiHPHjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:39:42 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D8A34DBCA
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 21:29:15 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id g186-20020a636bc3000000b0041c3d64031cso3388070pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 21:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=3R4SbMocYqn0aKWiSCME3cxm+xlqeKBx85exrgtFn/4=;
        b=j0Y+OpfnMKnaEjy++rzYOhJEurpk+s4NCRCI1Kp1f8VZOgPK4bSZXR5S98aCEn8I36
         yjdhodt18oWR1+UhHsGyHY9PBzJ5qcY4PP2QhZeJGyRogNur3NbFRZKgqFeMQQmy2hO8
         JUR6TQPNPKhhi6Au1DqYtC/BlzFTynquVUgt1esazr2A9ktFsIXDlw8ETiRHYq1xWkD+
         lsQRlQ7Siy48RAQmQlvaSOEUarzRGK4nZ3LYddbDF9aGS8kdHWXSLVyAf81Yxy9bQua9
         QM4JGghaGwQpbHcPIjiHZCI8eBoL2BLQQzknmVJlzsjUQoyU/i1XpKtMJh7+OwA1l+f0
         lL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=3R4SbMocYqn0aKWiSCME3cxm+xlqeKBx85exrgtFn/4=;
        b=eArDdEOJp/f/rNNd8cNnBIsW1oa3eF4UqFrkHhy0EmBXmEp2bzeiqoPfbXRPzxD/h0
         c6eZWWRoOecR6flE4EX4V+JkiDsIyhD7KFXeQc30pTcFxoPNAkXL6f5xNsQPMJgw8ZHh
         JBSkOvNnt2E0Wz1qZzNkig30rKGnLJFdeyUtzNqj/B81M6M/X1v5ZbhX5L2/RzouuyzR
         nejBkkSEJAjp557vKYaOYC48Y4m5s0FprD0F2yuGfMqC/oVGD7HZ+lrcTIorFX3LMaLG
         YqYifwZhfC96Ku6gIVoO9MZ7YoZhWN9OVl2VUecsOIyXHN2JoDCYovIySDoZmjLIrypd
         06iA==
X-Gm-Message-State: ACgBeo3iESpRU4hsEFbUh8Ue8cKYqojdmMd3NzZH4jmAFdhy9ke1ekbA
        qwLZFUORTwRpROGCkbAfAUfHgP1d1UCBqw==
X-Google-Smtp-Source: AA6agR7DjVs4rFMXWkLeUtyhrwS3I0pCnXaNHgSm6fX8PD/SoxcqoDWZfYMZayLP8OO3Fm8Ph09m3UiI6JvN6A==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:903:4094:b0:170:ced1:5fb0 with SMTP
 id z20-20020a170903409400b00170ced15fb0mr20576194plc.138.1660624143937; Mon,
 15 Aug 2022 21:29:03 -0700 (PDT)
Date:   Tue, 16 Aug 2022 12:28:55 +0800
In-Reply-To: <20220815174102.14807-1-joefradley@google.com>
Message-Id: <20220816042855.1155349-1-davidgow@google.com>
Mime-Version: 1.0
References: <20220815174102.14807-1-joefradley@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: Re: [PATCH] tools: Add new "test" taint to kernel-chktaint
From:   David Gow <davidgow@google.com>
To:     joefradley@google.com
Cc:     corbet@lwn.net, kunit-dev@googlegroups.com,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks! This looks good to me!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David
