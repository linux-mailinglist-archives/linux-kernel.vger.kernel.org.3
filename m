Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E5C5AC45E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 15:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiIDNEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 09:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiIDNEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 09:04:30 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB923E9A
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 06:04:24 -0700 (PDT)
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 284D3o68045784;
        Sun, 4 Sep 2022 22:03:50 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Sun, 04 Sep 2022 22:03:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 284D3o0C045779
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 4 Sep 2022 22:03:50 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9d4c7f38-6a30-3efb-7887-9c6224494ffd@I-love.SAKURA.ne.jp>
Date:   Sun, 4 Sep 2022 22:03:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] net/9p: use a dedicated spinlock for trans_fd
Content-Language: en-US
To:     Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net
Cc:     syzkaller-bugs@googlegroups.com, linux_oss@crudebyte.com,
        linux-kernel@vger.kernel.org,
        syzbot <syzbot+2f20b523930c32c160cc@syzkaller.appspotmail.com>
References: <2470e028-9b05-2013-7198-1fdad071d999@I-love.SAKURA.ne.jp>
 <20220904112928.1308799-1-asmadeus@codewreck.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220904112928.1308799-1-asmadeus@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/09/04 20:29, Dominique Martinet wrote:
> Since the locks actually protect different things in client.c and in
> trans_fd.c, just replace trans_fd.c's lock by a new one specific to the
> transport instead of using spin_lock_irq* variants everywhere
> (client.c's protect the idr for tag allocations, while
> trans_fd.c's protects its own req list and request status field
> that acts as the transport's state machine)

OK, I figured out what this patch changes.

  $ grep -nF -- '->lock' *.[ch]
  client.c:286:   spin_lock_irq(&c->lock);
  client.c:293:   spin_unlock_irq(&c->lock);
  client.c:367:   spin_lock_irqsave(&c->lock, flags);
  client.c:369:   spin_unlock_irqrestore(&c->lock, flags);
  client.c:816:   spin_lock_irq(&clnt->lock);
  client.c:819:   spin_unlock_irq(&clnt->lock);
  client.c:838:   spin_lock_irqsave(&clnt->lock, flags);
  client.c:840:   spin_unlock_irqrestore(&clnt->lock, flags);
  client.c:945:   spin_lock_init(&clnt->lock);
  trans_virtio.c:139:     spin_lock_irqsave(&chan->lock, flags);
  trans_virtio.c:151:     spin_unlock_irqrestore(&chan->lock, flags);
  trans_virtio.c:268:     spin_lock_irqsave(&chan->lock, flags);
  trans_virtio.c:287:                     spin_unlock_irqrestore(&chan->lock, flags);
  trans_virtio.c:296:                     spin_unlock_irqrestore(&chan->lock, flags);
  trans_virtio.c:303:     spin_unlock_irqrestore(&chan->lock, flags);
  trans_virtio.c:474:     spin_lock_irqsave(&chan->lock, flags);
  trans_virtio.c:515:                     spin_unlock_irqrestore(&chan->lock, flags);
  trans_virtio.c:524:                     spin_unlock_irqrestore(&chan->lock, flags);
  trans_virtio.c:532:     spin_unlock_irqrestore(&chan->lock, flags);
  trans_virtio.c:621:     spin_lock_init(&chan->lock);
  trans_xen.c:142:        spin_lock_irqsave(&ring->lock, flags);
  trans_xen.c:149:                spin_unlock_irqrestore(&ring->lock, flags);
  trans_xen.c:164:        spin_unlock_irqrestore(&ring->lock, flags);
  trans_xen.c:314:        spin_lock_init(&ring->lock);

This patch changes "struct p9_client"->lock to be used for only
protecting idr, as explained at

 * @lock: protect @fids and @reqs

line. Makes sense and looks correct.

> Tetsuo Handa-san, thank you very much!
> I'm sorry for not respecting your opinion but it's been a pleasure to
> have submissions from someone on JST :)

Thank you for responding quickly. :-)

