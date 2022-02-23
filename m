Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC63C4C0B4C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 05:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbiBWE5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 23:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiBWE5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 23:57:13 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D3A483BB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 20:56:46 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id j5so6040936qvs.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 20:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GRsWtuYPVtPE9giQevMBeF9cuFJK/NvIt7pyCSw7hDs=;
        b=khJDE2iVvaglQeQ9LXMCz6SMrTJJkiLvNqBliBXOjiVSkmbE0fh9SqGgEBmv3MVW1Y
         zJJY6OdkCBe7oKFRmakwPUdhMOfv7G/BzUnyjG3tn1OLARgoW9m00aIBwZ2LqItgUSFZ
         wl8MwBHbk8fVAdFqRX4ZogseAeQ6+Je/QNn5Eclr/RELyXfhWWgGSmYgIFEK7kbY7gLV
         1x8sbmoI1QZcm5x5ms9Y7+dW2Hz7KHiqVLwfYwC/XTRIMLv4VgDiZG87nixRmf7YoJ8o
         b7qOo5QwXazdfDJzCBHJI0CUYiCdFD3FlF6temGs6Hs/rlQjzqQGn2EEuolGfWoIEhsd
         Sa8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GRsWtuYPVtPE9giQevMBeF9cuFJK/NvIt7pyCSw7hDs=;
        b=C0rjMcdZFyu/Ifr5/hRz7nf/3EUFAYqEJ+c8S9mUPrsoK1LQj4pxHuUspD79e/oP7J
         Rpl+TiDO1Uk+bwBewqxXikX61lAtRXXUlJuhSrLW+JfUxlFPOWecoknJMSKLJnI4xE6b
         /IhDbclEGFCm7nfbJmtse4xk2EdELSOCcwFNNc4xrSm9+tE0KwUMVfdlnav0aHekp1aw
         /YSEFp1ikC+u11qFlYCm+euUbjFzbGZ9srykd0Pk57j6UFYLT2cEkJEQNVfgdzNpniLW
         OTYtSBj02oy6QiLhOBnri6ETJtZ0jKjdxupnXHvBy/6tNiSPeIjiyUVELFi69myupiy+
         NrQw==
X-Gm-Message-State: AOAM532J8W/VIuIpONKlMKjPEnD/MMuPYRd5mmIhWU49EEMNz+wV53tG
        b1yuS+HJn3A65r0AhAET1I8r1n8+BoU=
X-Google-Smtp-Source: ABdhPJwnF6BD9X6na/b400ybzxEnuRIEgmqgiA2Yc0f2crveMrPvg8r4nJnufal5GsBBQE4eQnFQGA==
X-Received: by 2002:ad4:5aef:0:b0:42c:3b31:86bf with SMTP id c15-20020ad45aef000000b0042c3b3186bfmr22102689qvh.72.1645592205740;
        Tue, 22 Feb 2022 20:56:45 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 15sm398444qtz.89.2022.02.22.20.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 20:56:44 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     ebiederm@xmission.com
Cc:     akpm@linux-foundation.org, balbir@linux.vnet.ibm.com,
        bsingharora@gmail.com, cgel.zte@gmail.com,
        containers@lists.linux.dev, deng.changcheng@zte.com.cn,
        linux-kernel@vger.kernel.org, xu.xin16@zte.com.cn
Subject: Re: [PATCH resend] kernel: Make taskstats available via genetlink per namespace
Date:   Wed, 23 Feb 2022 04:56:39 +0000
Message-Id: <20220223045639.1932955-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <87v8x678ph.fsf@email.froward.int.ebiederm.org>
References: <87v8x678ph.fsf@email.froward.int.ebiederm.org>
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

>> -sh-4.4# ./getdelays -d -p 186 -v
>> print delayacct stats ON
>> debug on
>> Error getting family id, errno 0
>>
>> As more and more applications are deployed in containers like Docker,
>> it is necessary to support getdelays to be used in net namespace.
>> Taskstats is safe for use per namespace as genetlink checks the
>> capability of namespace message by netlink_ns_capable().
>>
>> Make taskstats available via genetlink per namespace.
>
> Let me add a polite nack to this patch.

> Taskstats is completely senseless in a network namespace.  There is no
> translation of identifiers into the context of the receiver of the
> message.

The interface of taskstats is genetlink that is sensible in net namsespace.

> To make this work requires updating the taskstats code to do something
> sensible when in a pid namespace, as well as when in a network
> namespace.

Yes. Taskstats already does convert the input process ID into the task in the
correspoding pid namsespace. Do you mean to add some check of current user's
capability like SYS_ADMIN or else?
