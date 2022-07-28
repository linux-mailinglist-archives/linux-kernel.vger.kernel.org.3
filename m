Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7578D5837AB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbiG1DoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiG1DoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:44:08 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F47D237F7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:44:07 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id z17-20020a921a51000000b002ddff313ab2so61492ill.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Uk8xlHZP9Ax1yPtTzB8HCmPUbJsG2uFHTHKQ1aByY5s=;
        b=1eaIucjDZRbVlXVeNg9xhe0FZKnQxFNSQ/wm2lrNyKKBIQnjWMGMK75qAc2sELwV1W
         re6mgIPIauJG0lChNUIPoHHnEwS5utILPAOhg45UAHZ+tsBA2jHAnWIePic9w3YsaJ9/
         kbDXz0SSDlM0KM3vsFha4YK/vTvCKOrpWOfLLvPYXa+Sfgy1ToQezVe9GtSJq/Ghk/lR
         PuJaXBVz8twusjIMJsTIxkYAASMRsw3Fg058IytFMnZt7jCk8syBqi5TMb4SbiT+RQRv
         FhAJ0IO5s1ddaInzJ5Ob4MklWvpKDpYG5G5L6P1Hl4MExE+NUpJecdYTDe2+qKXBwKGR
         y91Q==
X-Gm-Message-State: AJIora+EmNiN8qcjWmfncQ+v2SO7yiR4lPd7ExZuSApkZ4A9o6YpiufR
        TW/l9lpQX1PZNZu5k82FWwjhRnQpwTNqforfkXeuw2YACATG
X-Google-Smtp-Source: AGRyM1tkiIr72bZ2vZWuPsEYNTGaH9RQy89TDaaN2rd9DNeAhbKbQ4XY5ObPv2CKU0aGanlGBJiMFf+80jJVyqzohDtD9cWnbivg
MIME-Version: 1.0
X-Received: by 2002:a92:c266:0:b0:2dd:4171:ebce with SMTP id
 h6-20020a92c266000000b002dd4171ebcemr8111918ild.190.1658979847063; Wed, 27
 Jul 2022 20:44:07 -0700 (PDT)
Date:   Wed, 27 Jul 2022 20:44:07 -0700
In-Reply-To: <20220728032630.611-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007951e105e4d55807@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in net_tx_action
From:   syzbot <syzbot+3ba0493d523d007b3819@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

kernel/time/hrtimer.c:945:6: error: conflicting types for 'clock_was_set'
kernel/time/hrtimer.c:985:16: error: 'CLOCK_SET_WALL' undeclared (first use in this function)


Tested on:

commit:         d6765985 Revert "be2net: disable bh with spin_lock in ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
dashboard link: https://syzkaller.appspot.com/bug?extid=3ba0493d523d007b3819
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=161b38de080000

