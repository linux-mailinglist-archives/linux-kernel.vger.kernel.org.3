Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1218147B901
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 04:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhLUDb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 22:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhLUDb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 22:31:58 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3265C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 19:31:57 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id j6so7721240ila.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 19:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IX+uUQCF9P2eCH266SQzZoVePdC14hak3G85DS88fnk=;
        b=KUaxgnbLpTy66lVTsBwE75uCiUpPUwz+n8wtpr89WrmdbkH/hLIArFdcvdr7fqMcQn
         J8tmGcnmtF8uzCb3kuRNYKUFUYq+0XBtPt1M3KfGmxoq9nWQJa1j2h/xblPnyphCdx0w
         yYWHs2CRNvAIrIgAXTmRdajZdItFc67EW0Fch5XDebcWsZc7qBwTbqEPd21TpekqwKKs
         Vuv0/R26L1j3/LIVr2yQQC4Nfocqc8yfoL/rHqz9ltfO58Thgg+rNob1eEUELuJmwyg0
         irLCqkuNxBKYy+uIH2YBjGXYTLe62qxKDS8jg+xEDDV7fw/denn4GtrGmxY4gzwlCmN/
         9E/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IX+uUQCF9P2eCH266SQzZoVePdC14hak3G85DS88fnk=;
        b=1/meraPArJZJCI5fetQB25jyO2z8G5+9SL9z8/VEM45Sf5SYiyqUI7Ialrm2WjfsNd
         0XpzbW+9gr4Ic//aTUJ8YhJ9j/VOvmIHe2eJmxRwo9YijOC2QwVAxZNEX5Q4wNRr+JN0
         GXcoZFzOsuDpvz8BN2niO4AbhYEHftUig0IifDHB81gqtnEiuW+qQ+b7Iv8KpV5eErQy
         gjs1sevFUfCfdLmpb3ovOMDsXgZELQFPuKA86GkY8OGg6TJRbUa3tR0IptsNuB24pIau
         bzlkAM5xzv+kploAEe3BYR5b817q1uHHIgaDUH/qrYkv3L0rbMxzsIxtZImLwTj17EeD
         XaHw==
X-Gm-Message-State: AOAM531VOZh6LbGt0pQAc+D3WYnuvhplT1hucjRnSvvJ2RDHHF99uYX5
        caAhgSnUckUeFrMEH5oi8rdUKg==
X-Google-Smtp-Source: ABdhPJwOeZYy0UzXdlhGKKGr+t6JmPPmgYo9Quqsyq6dO0hsu5+101xGlWU+6swE/jNulm4tx28Bew==
X-Received: by 2002:a92:cdaa:: with SMTP id g10mr566082ild.142.1640057516671;
        Mon, 20 Dec 2021 19:31:56 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id n11sm11244331ili.33.2021.12.20.19.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 19:31:56 -0800 (PST)
Subject: Re: [axboe-block:for-5.17/block 106/108] block/blk-ioc.c:307
 set_task_ioprio() error: we previously assumed 'task->io_context' could be
 null (see line 300)
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        Christoph Hellwig <hch@lst.de>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
References: <202112171520.5hNnOM0q-lkp@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <921dd30d-b9d1-c66c-525f-b678a0b97a47@kernel.dk>
Date:   Mon, 20 Dec 2021 20:31:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202112171520.5hNnOM0q-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/21 12:49 AM, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-5.17/block
> head:   5ef1630586317e92c9ebd7b4ce48f393b7ff790f
> commit: 5fc11eebb4a98df5324a4de369bb5ab7f0007ff7 [106/108] block: open code create_task_io_context in set_task_ioprio
> config: i386-randconfig-m021-20211216 (https://download.01.org/0day-ci/archive/20211217/202112171520.5hNnOM0q-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> block/blk-ioc.c:307 set_task_ioprio() error: we previously assumed 'task->io_context' could be null (see line 300)

This should fix it:


diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 87bdc9ca8295..71c3a933cf16 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -279,7 +279,12 @@ int set_task_ioprio(struct task_struct *task, int ioprio)
 			return -ENOMEM;
 
 		task_lock(task);
-		if (task->io_context || (task->flags & PF_EXITING)) {
+		if (task->flags & PF_EXITING) {
+			err = -ESRCH;
+			kmem_cache_free(iocontext_cachep, ioc);
+			goto out;
+		}
+		if (task->io_context) {
 			kmem_cache_free(iocontext_cachep, ioc);
 			ioc = task->io_context;
 		} else {
@@ -287,8 +292,9 @@ int set_task_ioprio(struct task_struct *task, int ioprio)
 		}
 	}
 	task->io_context->ioprio = ioprio;
+out:
 	task_unlock(task);
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL_GPL(set_task_ioprio);
 

-- 
Jens Axboe

