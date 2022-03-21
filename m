Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755A54E1F50
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 04:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344293AbiCUDYk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 20 Mar 2022 23:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344030AbiCUDYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 23:24:37 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2EB35870
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 20:23:12 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id z16-20020a05660217d000b006461c7cbee3so9732921iox.21
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 20:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:content-transfer-encoding;
        bh=0c661rytmbWAhVeK5Jck1fqKGOvw1zkyYHC4V10VBis=;
        b=iTk44a+3qEqAqFo9B7VdLm4xFH2qtGNjCm3CxWcYs5urvImMPfx1vsV0q+5VsQRFeT
         D1VylJEZhCNnLie3YO97Pv2WqkD36n9aPn3U2Ogp8eE4XNFMfJ4gj56qlR/RwTpJTwHd
         d/g7UUc1mIw2kLnA4c5Osi0J7NRQE26hkTuO6VwanX0Y+0F8Px9j5qjFi/bSrBNz/pGv
         S1z5e3u2MQemEpFzRujfEMjS2dSngYptJsSo+42FGhxNRuxOJRYz02PoMIoFXZHxGRpM
         mgu6DEbmn0vjYHuV/s9MAJxk/otz/FcPOnNS/bkIpiXkSRMAUcatLgMxYltmK1D4O78E
         kRgw==
X-Gm-Message-State: AOAM530BlvIWlvmOVTsgcN+6JusmACzemgz44Oii1E2TdpyhRowzN1qQ
        7dqK4seHCAWig/+tkpJTrnLhilaoPOOFqA1ykpytzIY7q8Ya
X-Google-Smtp-Source: ABdhPJxd2Leqx2t6u0MJESQop/sKLcScxhr2HltZTyOotmeB9E4ES6Xx7QjPS/Hn8rW3LVp/7rm6NR1HF4wjxwrSoVd7jn/Z7iIp
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1525:b0:2c7:acda:c557 with SMTP id
 i5-20020a056e02152500b002c7acdac557mr9180645ilu.35.1647832992182; Sun, 20 Mar
 2022 20:23:12 -0700 (PDT)
Date:   Sun, 20 Mar 2022 20:23:12 -0700
In-Reply-To: <20220321031535.2804-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025f60c05dab204c5@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in gc_worker (3)
From:   syzbot <syzbot+eec403943a2a2455adaa@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to create VM pool: failed to create GCE image: create image operation failed: &{Code:PERMISSIONS_ERROR Location: Message:Required 'read' permission for 'disks/ci-upstream-linux-next-kasan-gce-root-test-job-test-job-image.tar.gz' ForceSendFields:[] NullFields:[]}.


Tested on:

commit:         91265a6d Add linux-next specific files for 20220303
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=617f79440a35673a
dashboard link: https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17ce6425700000

