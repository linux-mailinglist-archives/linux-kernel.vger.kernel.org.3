Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A51521415
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbiEJLrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbiEJLrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:47:06 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A572044D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:43:10 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id k184-20020a6bbac1000000b0065aeedd4ba8so4422286iof.20
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=+hcN6KOrZKuKF0nZ3ml+ZJMwUYxUmOc0YadMDJjGPzI=;
        b=JDha8WPzPeL7TKxyR7wiRnokPWnsXCBfh0gRr8Ea8TPQccjm30sR9lPe3uaz32Vt9Z
         y2XARnfyYCGCyQxMUbczsIz3BrT05cHlgHqVXEzqO+ikgBMJLsw/FbnN1szTfDNITm1S
         jsKxZf81ytpV0mEiRPsVmaYMjxkwkvdGX8w2BN/M37OPzkIltzG6VKNXCLoz4JUWZYcc
         ZxMX3hdnprnKtp7oav3tIqHXt1YAmpfhrPPf3mfiEocfhqklqMBT+YGSGLoTNt6WOQw1
         B5jUfsE0yxFHpaTnFam/KMRLO6ituo5xc2Fe51POJ8JklJ8ROZhxoNREa/LpRcO/HFhK
         VbTA==
X-Gm-Message-State: AOAM5331u7IVjFDFSqjQ9Wl13wAvAJOQEBGYFgDwDE9lRpdMMLFi4rX+
        VjyUY2PFXAEqQo0sXRJ5Lbu2DRr6FWpWJ8Pn1evbcXmFM7YV
X-Google-Smtp-Source: ABdhPJzEVkh+cxwCN8xR+j6qouR9Ne8flJA674LJ5+ZG+B8CccTZzovUgERuO7hfguyeCkmo6nMkjIeP1mRyFmx3OLrVf5X6llUM
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1642:b0:65a:c4b5:fa51 with SMTP id
 y2-20020a056602164200b0065ac4b5fa51mr7574566iow.163.1652182989649; Tue, 10
 May 2022 04:43:09 -0700 (PDT)
Date:   Tue, 10 May 2022 04:43:09 -0700
In-Reply-To: <20220510110816.5751-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000033bd9905dea6d4e2@google.com>
Subject: Re: [syzbot] INFO: task hung in synchronize_rcu (3)
From:   syzbot <syzbot+0c6da80218456f1edc36@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/sched/sch_taprio.c:750:54: error: expected ')' before 'hrtimer_set_expires'
net/sched/sch_taprio.c:760:1: error: expected expression before '}' token


Tested on:

commit:         4fa640dc Merge tag 'vfio-v5.8-rc7' of git://github.com..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
dashboard link: https://syzkaller.appspot.com/bug?extid=0c6da80218456f1edc36
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=155bd6b9f00000

