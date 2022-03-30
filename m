Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285FD4EB865
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 04:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242070AbiC3Ck7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 22:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242053AbiC3Cky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 22:40:54 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12F8A76D3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 19:39:09 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id f11-20020a056602070b00b00645d08010fcso13593117iox.15
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 19:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=MGY4ked8FrP/RDpFhZIyerD1Rqnm8bxFvDVSgecXTM0=;
        b=VyJzefwG9B2DFlsfWLBtcHBw3A3mfQZr5EPvnpiDGigRw9YXDcQWWY0439g9VYP/dD
         QMossIkGbmO5eEnp2WQNpsYnV2ItG4Qrp0/pPiJh7mRcFtAI4ysOwYGEyyVKmJ449HWC
         Y9/Cboy4rGc0zgSQ9kNIl7vQw4xGLR36uE1AiI8kt8M6B6xadE7NbHMLVfgYNJ531+Nu
         9QjSFfJEZ/vveWsXRCKdUeCxpkEtjsf+BdoYoPi3Crh7uJskQBI/sh4+3Nn1O7U8xgVv
         P0hxqDL5jz9n/67LwU5vkI9bXvqx6HMl15fTbyvnJiwnMUdUFGXp27l0t7Vw44DUuOIZ
         GmSw==
X-Gm-Message-State: AOAM530dmwEUECKp0X32gM1F7TuFETPjP01sFiO/ame/LE3ZmzbJjuvt
        lMGMNGxRg0V+7iok6Ue/UjCA/RV6LSE3oOVNQGghSzhqMc0F
X-Google-Smtp-Source: ABdhPJyUEaP285XNxj6Cem8fvK5XyzQTUM+P5p8p/WLmotpZHrPuhjFTZSz2WN85+3r0Rj9bcw/GMtIqbVBAaoLLA24d9KdGtmei
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22c7:b0:323:9349:fc42 with SMTP id
 j7-20020a05663822c700b003239349fc42mr1407731jat.312.1648607949128; Tue, 29
 Mar 2022 19:39:09 -0700 (PDT)
Date:   Tue, 29 Mar 2022 19:39:09 -0700
In-Reply-To: <PH0PR11MB5880D33225C1E8A684BCFF64DA1F9@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002e8c1805db6673e2@google.com>
Subject: Re: [syzbot] memory leak in gs_usb_probe
From:   syzbot <syzbot+4d0ae90a195b269f102d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, mkl@pengutronix.de,
        netdev@vger.kernel.org, pabeni@redhat.com, pfink@christ-es.de,
        qiang1.zhang@intel.com, syzkaller-bugs@googlegroups.com,
        wg@grandegger.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/net/can/usb/gs_usb.c
patch: **** unexpected end of file in patch



Tested on:

commit:         c2528a0c Add linux-next specific files for 20220329
git tree:       linux-next
dashboard link: https://syzkaller.appspot.com/bug?extid=4d0ae90a195b269f102d
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=166a33ab700000

