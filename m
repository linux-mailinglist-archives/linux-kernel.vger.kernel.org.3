Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33AC57EEEA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 12:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239371AbiGWK7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 06:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiGWK7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 06:59:34 -0400
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCF11CFC0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 03:59:31 -0700 (PDT)
X-QQ-mid: bizesmtp79t1658573961tz10fe20
Received: from eureka.localdomain ( [123.124.208.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 23 Jul 2022 18:59:09 +0800 (CST)
X-QQ-SSF: 01400000002000B0D000B00A0000020
X-QQ-FEAT: 4rCmCcmdMHfwis57XlYAPZfJdHJIxkKNcwfR4eFB0vZN/Pzx6uJfciJh7n054
        lVJvDLJ+negW15WQMWccV6GExZ/LlNYWlxKKf3+qMYqLuvwQ/D3boqidj+aiShvFxaZgme2
        4kn+D+afWkNCf4eoZPf0ziVTYWv7hWET0Yvt2Ypv5hgwvsO36g3TVzxjNcG/JBs/J/DZPma
        NVGfCJ5EGrrdM+4QVPMm9RqPhirigUk8UMqTNj1fG2hzu7QrbDcxKjzLjsI9gfNVLAr4zHl
        N4hNDAprzRHmzRT5Zu4eserDeuXbo4jvk+McsmlEcBwHsCr9sP+38bmR2U5PdLUZmqSdWcI
        rErMgv8rUAwPaH4Tc3oYAlBjZDZ6QWxHb3v77Zk+qVEbcKMT9dWpS1b4KBR3Ff0DE3t7Vic
X-QQ-GoodBg: 2
From:   Wang You <wangyoua@uniontech.com>
To:     bvanassche@acm.org
Cc:     axboe@kernel.dk, fio@vger.kernel.org, hch@lst.de,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        wangxiaohua@uniontech.com, wangyoua@uniontech.com
Subject: Re: [PATCH v2 2/2] block/mq-deadline: Prioritize first request
Date:   Sat, 23 Jul 2022 18:59:09 +0800
Message-Id: <20220723105909.440050-1-wangyoua@uniontech.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <f798c875-0bb9-add7-d7a3-4ac2a76e85d9@acm.org>
References: <f798c875-0bb9-add7-d7a3-4ac2a76e85d9@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign3
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What is MG04ACA400N?

It is a Toshiba 7200 RPM hard drive.

> The above results are low enough such that these could come from a hard 
> disk. However, the test results are hard to interpret since the I/O 
> pattern is neither perfectly sequential nor perfectly random (32 
> sequential jobs). Please provide separate measurements for sequential 
> and random I/O.

> The above results show that this patch makes reading from a hard disk 
> slower. Isn't the primary use case of mq-deadline to make reading from 
> hard disks faster? So why should these two patches be applied if these 
> slow down reading from a hard disk?

The data of MG04ACA400N on the raid controller is obviously different from 
the single disk, especially the reading data, I did not expect this situation, 
the data on the raid controller made me mistakenly think that the same applies 
to HDD.

I will re-analyze the impact of this patch on the HDD later, please ignore it 
for now.

Also, can I ask? If using fio or other tools, how should testing be done to get 
more accurate and convincing data? Such as the perfectly sequential and random I/O 
performance you mentioned above (fio's multi-threaded test does result in neither 
perfectly sequential nor perfectly random, but single thread dispatch is too slow, 
and cannot play the merge and sorting ability of elv).

Thanks,

Wang.


