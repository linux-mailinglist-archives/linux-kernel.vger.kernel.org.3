Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F97524249
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 04:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbiELCEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 22:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiELCEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 22:04:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5385F6004D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:04:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AFBEB826B8
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5154CC340EE;
        Thu, 12 May 2022 02:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652321045;
        bh=Wud9ZjEwcU5I2fkae6/vF+vlYg7dBuM3CqHBWPGLhc0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D4zOOI8NdqlXQXE3TicnihYvWwIQMf4jp+7RWrZbjVOj2aH+VQghK+NKn1QO0ypnt
         jAY4YV0CuZPDmhv+2gqT35MZ1erNz09DlNSsYVfTfB57RJ9Vlcnr/UkyG3AT8Q/dLO
         6RD8IhJR4kF/11P3IIC9wxg/njSPK8VHlMD2OjsSCkRJHlvPvkwaQvFVPjiPze88Da
         KqOGJ+xVkqRgWODyGk1QaTBVVFcnpQxoXDsLRjA3E1m8LvuCiKNT4or+L37tkMw0Vx
         ATr+HThX4wvg9JjSb3fDqCEGcGes2pR4fzOWk4yjC73lmHThO4e7OZmXtohlWFFebk
         vlAIo/Vu0yk9g==
Message-ID: <ab569309-f639-33af-ebb3-909a02158d02@kernel.org>
Date:   Thu, 12 May 2022 10:04:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [f2fs-dev] [PATCH 4/5] f2fs: do not stop GC when requiring a free
 section
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220506232032.1264078-1-jaegeuk@kernel.org>
 <20220506232032.1264078-4-jaegeuk@kernel.org>
 <77e870dd-fd7a-f58e-79fb-d0e5b8fbfc16@kernel.org>
 <YnlHdgHix+3qlc1a@google.com>
 <42c23c83-1914-e8dd-c765-df3d6d872532@kernel.org>
 <Ynvoszmp7+64NdZg@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Ynvoszmp7+64NdZg@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/12 0:47, Jaegeuk Kim wrote:
>>>>> @@ -147,6 +147,7 @@ static int gc_thread_func(void *data)
>>>>>     		gc_control.init_gc_type = sync_mode ? FG_GC : BG_GC;
>>>>>     		gc_control.no_bg_gc = foreground;
>>>>> +		gc_control.nr_free_secs = foreground ? 1 : 0;

[snip]

> 
> I mean gc_control->nr_free_secs should be 0.

[snip]

>>>>> @@ -528,7 +528,8 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
>>>>>     				.init_gc_type = BG_GC,
>>>>>     				.no_bg_gc = true,
>>>>>     				.should_migrate_blocks = false,
>>>>> -				.err_gc_skipped = false };
>>>>> +				.err_gc_skipped = false,
>>>>> +				.nr_free_secs = 1 };

Oh, so, in above two paths, when .nr_free_secs is 1, no_bg_gc should be true
to keep skipping BG_GC flow.

How about adding a check condition in f2fs_gc() to avoid invalid argument
usage in future?

From: Chao Yu <chao@kernel.org>

---
  fs/f2fs/gc.c | 17 +++++++++++++----
  1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 385282017317..a98276fd3cc1 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1799,10 +1799,19 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
  			gc_type = FG_GC;
  	}

-	/* f2fs_balance_fs doesn't need to do BG_GC in critical path. */
-	if (gc_type == BG_GC && gc_control->no_bg_gc) {
-		ret = -EINVAL;
-		goto stop;
+	if (gc_type == BG_GC) {
+		/* f2fs_balance_fs doesn't need to do BG_GC in critical path. */
+		if (gc_control->no_bg_gc) {
+			ret = -EINVAL;
+			goto stop;
+		}
+		/*
+		 * BG_GC never guarantee that blocks are migrated synchronously.
+		 */
+		if (gc_control->nr_free_secs) {
+			ret = -EINVAL;
+			goto stop;
+		}
  	}
  retry:
  	ret = __get_victim(sbi, &segno, gc_type);
-- 
2.25.1



Thanks,
