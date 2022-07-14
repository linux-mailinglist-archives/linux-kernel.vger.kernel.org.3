Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223A8575378
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbiGNQzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbiGNQzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:55:01 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E611D49B46
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:55:00 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id fz10so3407407pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=rdhaQE9Wpa1/gPvXlfxNfKdRrZgXd8VVZEiGYLTcLZ0=;
        b=U2wbg5wmwTtjsEL+wIHMBMa1U4MAeXyOJ1NdNwVMBkKXU5xzbhqbu3uiBZm0megZOw
         h5+C8nGmThv4/3VkzmiYs/MzMxGtr9/4Qbzb+6wzcy/3+y/MVQA5eHTg1x3pHPj5Ypcs
         PSMdrIwCegrNXdWH78NC+dfQUKAtUOYZDSSCFbyWe6oMQ9ThXKpZ1OPXz1lXzUwzQQ9B
         AhaTg3ZrY3cEmUoA2b1C5I0gHVvxK7QSifOn9XCMAqC95WgGZAFZrWojoWMZHpmOvLoM
         9xCZ4WfZbVoyIyn0NUhDx81GqIc8Y1eY0JTqXL3oO0UW/y2aReckRROqGRmsNg2/7Usm
         xy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=rdhaQE9Wpa1/gPvXlfxNfKdRrZgXd8VVZEiGYLTcLZ0=;
        b=hiVPchLd8MsITOiN8NQQvnlQ573eLKwCK0AMFSH/4fWOydCgT/3YH53tCal5gAeqLw
         GO7WVZMaVuyKtRzII/Ni32jW3ev4ReH6q0svrvBaltCD1YRJoEiGky5GcyP5dcVfVPGJ
         8NWKNS0C8zuRlg/n6l7dwNolouZGVZnxdbDLWiXYSjtPmGbhDgEo73gaAGANXJm+Gd+l
         Q98tz5TZWvK9rjSHxAkVyAVLibymyTKUdJ8owJC8OU48YRudTgBOgiLauLJhxwahtc0w
         pP+fn8aYa254IaxMv8DJUVq6fNoXf2QNRc1sWyK4ybLDAA+RiK+xxoTTD/9c3RQrv3DB
         rcig==
X-Gm-Message-State: AJIora9L692YvW32jh1ENidB8TUVoghYIQ9AL2rJ4Wo+aUG+xPc8WZm1
        L2za/Dd3IfG50KSEBy8eRqJvuno2lDL22g==
X-Google-Smtp-Source: AGRyM1vm3YwxYBLHQLFT1qiIy9HzpT917y99nVlxeUXM42Io1vK5/aoWhxhX40oUdKEKCttnc8sRtA==
X-Received: by 2002:a17:90a:e7cd:b0:1f0:c82:c88f with SMTP id kb13-20020a17090ae7cd00b001f00c82c88fmr16861390pjb.100.1657817700215;
        Thu, 14 Jul 2022 09:55:00 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090332c900b0016bee668a5asm1739211plr.161.2022.07.14.09.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 09:54:59 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     songmuchun@bytedance.com, snitzer@kernel.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220713140226.68135-1-songmuchun@bytedance.com>
References: <20220713140226.68135-1-songmuchun@bytedance.com>
Subject: Re: [PATCH] block: fix missing blkcg_bio_issue_init
Message-Id: <165781769944.633825.16442620187314211955.b4-ty@kernel.dk>
Date:   Thu, 14 Jul 2022 10:54:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 22:02:26 +0800, Muchun Song wrote:
> The commit 513616843d73 ("block: remove superfluous calls to
> blkcg_bio_issue_init") has removed blkcg_bio_issue_init from
> __bio_clone since submit_bio will override ->bi_issue.
> However, __blk_queue_split is called after blkcg_bio_issue_init
> (see blk_mq_submit_bio) in submit_bio. In this case, the
> ->bi_issue is 0. Fix it.
> 
> [...]

Applied, thanks!

[1/1] block: fix missing blkcg_bio_issue_init
      commit: 957a2b345cbcf41b4b25d471229f0e35262f066c

Best regards,
-- 
Jens Axboe


