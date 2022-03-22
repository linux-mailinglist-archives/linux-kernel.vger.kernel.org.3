Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251CF4E3B1B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiCVIsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbiCVIsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:48:02 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947464B87F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:46:35 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id v15so13469330qkg.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lum6gHZNVZl73tpEZdinesqDPVWiXnD2WgpPo5FetG4=;
        b=L3ZcW2UNnM/jkB7ZW7aLjs2sySRW9hQPXB+OzuX7I5aJiC9XScCV+LJJ4EweJWaX/D
         mNQvsPFJeI1ToKrWGdXzKHs68ZbdZIa8VbLJui/YZj7pO7hA2sIj4r98SKNWvTQ5Y0jY
         L636AmjkGZCX1BShKmXe1FKM1gNa45W06GrGQ20z0ykjpUPjE2y/NJ1c7Wns57DH7etJ
         zYlfevAmmZMu7D44KW+QVziLNINzyLmK+LM0JEWqsLLwXw4LzFO0GCRngUHk97GCoRMo
         g0TXA67KTSxa8RZvQZ/SwZCe0OxRFjLvAV7sbIZA15oRcedkZL1XZu4oqBY8u1xljU+X
         MhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lum6gHZNVZl73tpEZdinesqDPVWiXnD2WgpPo5FetG4=;
        b=ejoLD3WlFFcFCKGgCCuJYrsjmutc0ygJSCk+aKXkSOAfFEKlh5ziZiDoZNLJtfptbd
         J6JN6ln2azy48jkz3BqzfziWhfivnkfIHsK8bHcF/kfT3q/nw53RSeOWtUUKHXXwdSCx
         bKt1wN3m7zeLrQmHVDiUMAnebTN4mdd6NUxDJEV2Qfy15d6aUy0oB/1qxSEVhdxPW6vU
         4Zure/CZzaahudai8z8N0ET7hP6k12VcZr7zvqJeFWh1XEpWuv3wrFqcP3kmKAPfoZJf
         7krSqmnLGZGjfpjajKIwQ0plq+rniAVx4u6qalahCetyGd1FJ8nlY/4XyqJC4ni45xIn
         7X+g==
X-Gm-Message-State: AOAM5309ihFo6nhxZZvezRDjMe8N7nNCwfs+Zc0DrSn8B8lM+0cKQL1k
        Hq6Erof0OrLV17Zri/eyZeU=
X-Google-Smtp-Source: ABdhPJxR4ib1+6KnuZ2nr+wrsfySzBxIO+tJJO7dHFirzKgJGn6xIEVJgw0sYOW3Wqq3Nqk2Pnk23A==
X-Received: by 2002:a37:6902:0:b0:606:853:fe50 with SMTP id e2-20020a376902000000b006060853fe50mr14546604qkc.751.1647938794764;
        Tue, 22 Mar 2022 01:46:34 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f185-20020a37d2c2000000b0067e342d5e4dsm8211732qkj.105.2022.03.22.01.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 01:46:34 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     akpm@linux-foundation.org, lkp@intel.com
Cc:     juri.lelli@redhat.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com,
        peterz@infradead.org, keescook@chromium.org
Subject: Re: [PATCH v2] ksm: Count ksm merging pages for each process
Date:   Tue, 22 Mar 2022 08:46:29 +0000
Message-Id: <20220322084629.2339268-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220315114849.2119443-1-xu.xin16@zte.com.cn>
References: <20220315114849.2119443-1-xu.xin16@zte.com.cn>
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

Hi, everyone.

What do you think of this patch? I look forward to your views.

patch: https://lore.kernel.org/lkml/20220315114849.2119443-1-xu.xin16@zte.com.cn/#t

Thanks,
xu xin
