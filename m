Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCA052084D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 01:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiEIXXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 19:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbiEIXXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 19:23:12 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC63A21607E
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 16:19:16 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id v8-20020a170902b7c800b0015e927ee201so8942564plz.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 16:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BCsnd9wzln6SIBCaSSlJS6Bpvy5MKz7jpyqA0qGwjBw=;
        b=Kz+o6BXhKfBZQQe7+daPzx+o7K9hHTFAVH4QKtZF5Gn+nc/t1mzzKy3ZtfaNprrlqe
         jpNDJvzr22gN8RN42cTqfRcmgqt1s5UUN+PQ9jGk5qgxY8Xjry+cRnp4X+uuDS0eO9vI
         /fH6w+aoKuU6nVrJYNlzS8Mrj6nRmQvQ31qYPpd2KXij8CmNdoEjTMRz9ZoIVSSQOSQ8
         UBZ2wc63dlv5XAGpoLeWsNP9bZsVNGnghPs3mScqP4fQ2WuApETk4/CIB7ZgbBWlwkNH
         NfFFt9w06quLYcuTwgnfMXzjLBnbqwlkQMHWXTs9grmvuKX2Mq8zIVIVnPwu4RrjLpTB
         vvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BCsnd9wzln6SIBCaSSlJS6Bpvy5MKz7jpyqA0qGwjBw=;
        b=dzvOiP/5L+dVI0JCM+0S9O8ejjcXlJv57ZOj2StvIppgEKpPbds6Nej2CkJQjMVk0T
         s3Nr8IAvxEXUJ35IMAxvA77nyjKrod9FnC8CyzyAL8L23tLxE+3xu4oEFwlEA5hvzgV+
         Ym+QagP9w8M8wxAiwKqdxdNHBWkLjfq5mU7l/5tO3mlbXvcQnucyhm/kQSkLabZqLNKq
         wDSsSj0dV2W+XaBsuqlDmiRQAXhvP3qux5isErP3tvYWNJBMqBNlaZR65ivRIyki+mjq
         yale8zr6cP8LdmaK4f2gpA92WxHAa5Rh/lmYAaBno9Z7euYhM8sd6c8/MTVF43xrosRc
         snpg==
X-Gm-Message-State: AOAM5313U/gKSjWEUul/tD3Pxp5Fe+GLdu2Gup/YJs2z/KroQYcLdSRE
        RiSv8DFFDsXJNBn+9MmlEM22lkU1qvsCWw==
X-Google-Smtp-Source: ABdhPJyKu726ioJrlfuyldA9N5yHePRxj0NUUXS7H/3v/b0NYwSEZubjln+Ns5cqVF9CpRinoeiSBNsIirjYGA==
X-Received: from zllamas.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:4c])
 (user=cmllamas job=sendgmr) by 2002:a17:902:b213:b0:158:d44d:cad4 with SMTP
 id t19-20020a170902b21300b00158d44dcad4mr18169199plr.45.1652138356306; Mon,
 09 May 2022 16:19:16 -0700 (PDT)
Date:   Mon,  9 May 2022 23:19:01 +0000
Message-Id: <20220509231901.3852573-1-cmllamas@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH] binder: fix printk format for commands
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure we use unsigned format specifier %u for binder commands as
most of them are encoded above INT_MAX. This prevents negative values
when logging them as in the following case:

[  211.895781] binder: 8668:8668 BR_REPLY 258949 0:0, cmd -2143260157 size 0-0 ptr 0000006e766a8000-0000006e766a8000

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index f3b639e89dd8..b4b0e4489bef 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3984,7 +3984,7 @@ static int binder_thread_write(struct binder_proc *proc,
 		} break;
 
 		default:
-			pr_err("%d:%d unknown command %d\n",
+			pr_err("%d:%d unknown command %u\n",
 			       proc->pid, thread->pid, cmd);
 			return -EINVAL;
 		}
@@ -4490,7 +4490,7 @@ static int binder_thread_read(struct binder_proc *proc,
 		trace_binder_transaction_received(t);
 		binder_stat_br(proc, thread, cmd);
 		binder_debug(BINDER_DEBUG_TRANSACTION,
-			     "%d:%d %s %d %d:%d, cmd %d size %zd-%zd ptr %016llx-%016llx\n",
+			     "%d:%d %s %d %d:%d, cmd %u size %zd-%zd ptr %016llx-%016llx\n",
 			     proc->pid, thread->pid,
 			     (cmd == BR_TRANSACTION) ? "BR_TRANSACTION" :
 				(cmd == BR_TRANSACTION_SEC_CTX) ?
-- 
2.36.0.512.ge40c2bad7a-goog

