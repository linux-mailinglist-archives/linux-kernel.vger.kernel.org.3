Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEC1566479
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiGEHu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiGEHu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:50:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED90A1116C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657007454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3mhVFlgimWg9LuZoozj/WO4OkyYlpDttySH5oyPfnFA=;
        b=c8MYZqUbpajF6TFoyLXAxUGB2asmPpNF5TSQlX1G3KBOpttki1Y5wi8cZC1tIwOJiY9nLJ
        qdZyh8qt5lVjN4fVu9TN0d5UCXIozhLa/YSLp/cvpe1s4t08TCpKjRpzFm8VjGzdTfIUIp
        RCKVgwZPsiFtHFF/oTRsd0cQaXy5NhQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444--WFdSJK1MYaliCCgbMhWpg-1; Tue, 05 Jul 2022 03:50:52 -0400
X-MC-Unique: -WFdSJK1MYaliCCgbMhWpg-1
Received: by mail-wm1-f69.google.com with SMTP id r128-20020a1c4486000000b003a2b44d876aso1697651wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 00:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=3mhVFlgimWg9LuZoozj/WO4OkyYlpDttySH5oyPfnFA=;
        b=YsqOcyjwFwJ+zpZnLz1EVUuhMR9neNSiP3Spm0uYqZGjJUh+xUXR4mHRhL4BLYUpng
         luHmPcPHd++GRkKR1NTwqb1h0XE0dl2hP07w65kAZKs5WhqUkW3XMRSHiA91SDyykR2l
         7jsX30tHuPBMbkxCjdAYOGypIPjzY6WUNcFQBERuTvXssqgd81/hqex4pFTKPzVVlCJd
         jqcUMn+EAJmdzX9ytq7Lwjfipkf1uu1T97VZX3iYMeM+Pyw+k3wK2G0m8ZwfG29XZXWu
         xP5R5FZ8jVH9kYqybNUKeEx7SggeumeRExt0a/F+953jMnvQHUhoWHkkGLT8X2BS7wb7
         zSYQ==
X-Gm-Message-State: AJIora99SRebAxXippc2zF2Okat6N4+24eD489cvY4HvfaX0CYdA9OEq
        phL4lOgREpOE9OyY9EChvO6P2emi7XcjfnGq0Jm7dfBOahxeYNAYBJVj/mzRXi76oQPvKDv2UgM
        sVwWtqOoTOkXKCJPok0/c5uHz
X-Received: by 2002:adf:d1eb:0:b0:21b:dbb5:fe05 with SMTP id g11-20020adfd1eb000000b0021bdbb5fe05mr30859888wrd.651.1657007450938;
        Tue, 05 Jul 2022 00:50:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t/AiVteUgJHbi4Khx9nn8ixsMgPTlFIsRDPciRkUJUbx+Zg1KwJrbM0hr/EOuQW8za8zLOng==
X-Received: by 2002:adf:d1eb:0:b0:21b:dbb5:fe05 with SMTP id g11-20020adfd1eb000000b0021bdbb5fe05mr30859864wrd.651.1657007450761;
        Tue, 05 Jul 2022 00:50:50 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id e22-20020a05600c4e5600b003973435c517sm22460305wmq.0.2022.07.05.00.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:50:50 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH] sched/fair: move nohz definition to where it's used
In-Reply-To: <20220623130325.49813-1-zhouchengming@bytedance.com>
References: <20220623130325.49813-1-zhouchengming@bytedance.com>
Date:   Tue, 05 Jul 2022 08:50:49 +0100
Message-ID: <xhsmhwncsf15y.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/22 21:03, Chengming Zhou wrote:
> The nohz definition is too far from where it's used, just move it
> to the right place. No functional change.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Standalone cosmetic changes are very unlikely to get anywhere, I'd suggest
bundling this with some other non-cosmetic patches hitting the area.

