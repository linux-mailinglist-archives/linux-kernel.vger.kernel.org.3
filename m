Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291B050EDFF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 03:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240689AbiDZBRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 21:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiDZBRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 21:17:54 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE36AF2A23;
        Mon, 25 Apr 2022 18:14:46 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id i24so16456040pfa.7;
        Mon, 25 Apr 2022 18:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fCWvB464odNBf/ShDLHlbpM456OS0PdmNMNwSmxnbdw=;
        b=S6lWrfiVnptzHmrsPXaktkm95tMgzaRZNIZ/Y4RlTu4Sjaq1pJ4nOW8YMp7thRXm6M
         /rLpCZZEltPBuVURpXOcgsRUHnPYpEgRiqMZzWLcvCVWQyum04dIzeCbqlQLtOl2TPZA
         K9BbsPgSVceIanf68eYdRAzug+nU3T/5H8VSasHOcw5PdCIARdLZzbmj1oFPqCtaoj8V
         jwmE9YTclhmOjX9HKEC+KfRfifqA9eXfz0D8iePJtsG66RdCmK7rKFO63D9vTI17wt+t
         r1TdNpiSyvcOorAZyr6fUernQuyJQTt+3ma8E8bx0cOcnL7PugcrESFeeAZl9pjH4c8B
         kK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fCWvB464odNBf/ShDLHlbpM456OS0PdmNMNwSmxnbdw=;
        b=IGT9I8oGSP4+WV/NwJBnZbQ6VpnBByAPcodROBEWETPKK6fhCPK1SQa8rr9xlQ70B4
         S3mwHuoNPTu8E662TRuxb9ohwVAe8pampv3uqj7p1QUH6PQC4DJbvoUiJEt89buB0Fv9
         sDvLIJv6WXCa7rf+8UfYhBm39vdcIdwejfMq1dAPZRLtq8dDkDgcoKmX300eGQEOVDFY
         hagdDA/I0r6fNdst9BUkA/J3GxTM+1Tv+eJkwS83ULRfyuFrw5+RUA7O9TwkuNn89wFh
         vzqAsagMrT/noZR7qqV4kikHAXn2cjbenKKY5aALPKNpOet+F9PbFSUwz9rZKEAc5xf9
         zCVQ==
X-Gm-Message-State: AOAM531PoHY1wsc6u8uu0b2t3PEapldIaLOV8sR86VMvBXZojDQPrr0q
        OOl5TmzaQfjtbUrr/mR89r5m2CnFMuEzxg==
X-Google-Smtp-Source: ABdhPJzMjo07FOU0xjwNR73clW5nEaFT1TPwWTYOK1ieJREH3tInCaoMKpFnhyNYV8746Nj/aoJfnA==
X-Received: by 2002:a05:6a00:24cc:b0:50d:58bf:5104 with SMTP id d12-20020a056a0024cc00b0050d58bf5104mr791982pfv.36.1650935686298;
        Mon, 25 Apr 2022 18:14:46 -0700 (PDT)
Received: from [172.20.119.1] ([61.16.102.74])
        by smtp.gmail.com with ESMTPSA id y126-20020a62ce84000000b0050d223013b6sm9244057pfg.11.2022.04.25.18.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 18:14:45 -0700 (PDT)
Message-ID: <fd886bf6-3fd8-d786-5211-423d465603ef@gmail.com>
Date:   Tue, 26 Apr 2022 09:14:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH] xfs: fix the ABBA deadlock around agf and inode
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220425070620.19986-1-jianchao.wan9@gmail.com>
 <d2ecf0b8-3bd9-e992-f723-178aae58a0a4@gmail.com>
 <20220425161650.GE17025@magnolia>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
In-Reply-To: <20220425161650.GE17025@magnolia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/26 12:16 上午, Darrick J. Wong wrote:
> On Mon, Apr 25, 2022 at 03:10:02PM +0800, Wang Jianchao wrote:
>> The deadlock context is as following,
>> hold inode, try to require agf
>>
>> inode buf xfs_buf.b_log_item ffff9ca7491eb2c0
>>
>> PID: 82240  TASK: ffff9ca4cd633d80  CPU: 88  COMMAND: ""
>>  #0 [ffffb696ad7f7410] __schedule at ffffffffa0067073
>>  #1 [ffffb696ad7f74b0] schedule at ffffffffa0067678
>>  #2 [ffffb696ad7f74b8] schedule_timeout at ffffffffa006b88d
>>  #3 [ffffb696ad7f7558] __down at ffffffffa0069dcb
>>  #4 [ffffb696ad7f75b8] down at ffffffff9f90890b
>>  #5 [ffffb696ad7f75d0] xfs_buf_lock at ffffffffc6cb1133 [xfs]
>>  #6 [ffffb696ad7f75f0] xfs_buf_find at ffffffffc6cb15fa [xfs]
>>  #7 [ffffb696ad7f7688] xfs_buf_get_map at ffffffffc6cb18e0 [xfs]
>>  #8 [ffffb696ad7f76d0] xfs_buf_read_map at ffffffffc6cb20e8 [xfs]
>>  #9 [ffffb696ad7f7710] xfs_trans_read_buf_map at ffffffffc6ce6796 [xfs]
>> #10 [ffffb696ad7f7750] xfs_read_agf at ffffffffc6c66fde [xfs]
>> #11 [ffffb696ad7f77b8] xfs_alloc_read_agf at ffffffffc6c670ae [xfs]
>> #12 [ffffb696ad7f77f0] xfs_alloc_fix_freelist at ffffffffc6c675dc [xfs]
>> #13 [ffffb696ad7f7900] xfs_alloc_vextent at ffffffffc6c6796b [xfs]
>> #14 [ffffb696ad7f7940] __xfs_inobt_alloc_block at ffffffffc6c972f0 [xfs]
>> #15 [ffffb696ad7f79f8] __xfs_btree_split at ffffffffc6c7ee5d [xfs]
>> #16 [ffffb696ad7f7ab8] xfs_btree_split at ffffffffc6c7f34b [xfs]
>> #17 [ffffb696ad7f7b68] xfs_btree_make_block_unfull at ffffffffc6c80882 [xfs]
>> #18 [ffffb696ad7f7bc8] xfs_btree_insrec at ffffffffc6c80ccd [xfs]
>> #19 [ffffb696ad7f7ca0] xfs_btree_insert at ffffffffc6c80e3b [xfs]
>> #20 [ffffb696ad7f7d60] xfs_difree_finobt at ffffffffc6c94859 [xfs]
>> #21 [ffffb696ad7f7db8] xfs_difree at ffffffffc6c9634e [xfs]
>> #22 [ffffb696ad7f7e08] xfs_ifree at ffffffffc6cc63d2 [xfs]
>> #23 [ffffb696ad7f7e58] xfs_inactive_ifree at ffffffffc6cc6551 [xfs]
>> #24 [ffffb696ad7f7e88] xfs_inactive at ffffffffc6cc66fe [xfs]
>> #25 [ffffb696ad7f7ea0] xfs_fs_destroy_inode at ffffffffc6ccfdb8 [xfs]
>> #26 [ffffb696ad7f7ec0] do_unlinkat at ffffffff9face066
>> #27 [ffffb696ad7f7f38] do_syscall_64 at ffffffff9f8041cb
>> #28 [ffffb696ad7f7f50] entry_SYSCALL_64_after_hwframe at ffffffffa02000ad
>>     RIP: 00007f5e27b64e57  RSP: 00007f5e0d1f9a98  RFLAGS: 00000202
>>     RAX: ffffffffffffffda  RBX: 00007f578b4011a0  RCX: 00007f5e27b64e57
>>     RDX: 00007f5b1684e680  RSI: 0000000000000070  RDI: 00007f5b1684e680
>>     RBP: 00007f578b4011c0   R8: 00000000000002e8   R9: 0000000000000007
>>     R10: 00007f5e0d1fae20  R11: 0000000000000202  R12: 00007f5e0d1f9c00
>>     R13: 00007f5d191e2118  R14: 00007f5d191e22d0  R15: 00007f5e0d1f9b50
>>     ORIG_RAX: 0000000000000057  CS: 0033  SS: 002b
>>
>>
>> The task hold agf, try to require inode
>>
>>
>> PID: 1653499  TASK: ffff9c9f5490bd80  CPU: 66  COMMAND: "kworker/u209:2"
>>  #0 [ffffb696ccdff270] __schedule at ffffffffa0067073
>>  #1 [ffffb696ccdff310] schedule at ffffffffa0067678
>>  #2 [ffffb696ccdff318] schedule_timeout at ffffffffa006b88d
>>  #3 [ffffb696ccdff3b8] __down at ffffffffa0069dcb
>>  #4 [ffffb696ccdff410] down at ffffffff9f90890b
>>  #5 [ffffb696ccdff428] xfs_buf_lock at ffffffffc6cb1133 [xfs]
>>  #6 [ffffb696ccdff448] xfs_buf_find at ffffffffc6cb15fa [xfs]
>>  #7 [ffffb696ccdff4e0] xfs_buf_get_map at ffffffffc6cb18e0 [xfs]
>>  #8 [ffffb696ccdff528] xfs_buf_read_map at ffffffffc6cb20e8 [xfs]
>>  #9 [ffffb696ccdff568] xfs_trans_read_buf_map at ffffffffc6ce6796 [xfs]
>> #10 [ffffb696ccdff5a8] xfs_imap_to_bp at ffffffffc6c9a3e7 [xfs]
>> #11 [ffffb696ccdff608] xfs_trans_log_inode at ffffffffc6ce757e [xfs]
>> #12 [ffffb696ccdff658] xfs_bmap_btalloc at ffffffffc6c75ccc [xfs]
>> #13 [ffffb696ccdff750] xfs_bmapi_write at ffffffffc6c77ca0 [xfs]
>> #14 [ffffb696ccdff8a8] xfs_bmapi_convert_delalloc at ffffffffc6c782a4 [xfs]
>> #15 [ffffb696ccdff8d0] xfs_iomap_write_allocate at ffffffffc6cc11a7 [xfs]
>> #16 [ffffb696ccdff940] xfs_map_blocks at ffffffffc6ca9f97 [xfs]
>> #17 [ffffb696ccdff9d0] xfs_do_writepage at ffffffffc6caa911 [xfs]
>> #18 [ffffb696ccdffa48] write_cache_pages at ffffffff9fa20675
>> #19 [ffffb696ccdffb40] xfs_vm_writepages at ffffffffc6caa3e4 [xfs]
>> #20 [ffffb696ccdffba8] do_writepages at ffffffff9fa217c1
>> #21 [ffffb696ccdffc10] __writeback_single_inode at ffffffff9faec1bd
>> #22 [ffffb696ccdffc58] writeback_sb_inodes at ffffffff9faec953
>> #23 [ffffb696ccdffd38] __writeback_inodes_wb at ffffffff9faecc1d
>> #24 [ffffb696ccdffd78] wb_writeback at ffffffff9faecf9f
>> #25 [ffffb696ccdffe08] wb_workfn at ffffffff9faed8a2
>> #26 [ffffb696ccdffe98] process_one_work at ffffffff9f8cd9f7
>> #27 [ffffb696ccdffed8] worker_thread at ffffffff9f8ce0fa
>> #28 [ffffb696ccdfff10] kthread at ffffffff9f8d3802
>> #29 [ffffb696ccdfff50] ret_from_fork at ffffffffa020023f
> 
> Does this solve the same problem as[1]?
> 
> [1]
> https://lore.kernel.org/linux-xfs/20220404232204.GT1544202@dread.disaster.area/

Yes, it is !

Thanks so much
Jianchao

> 
> --D
> 
>>
>>
>> Thanks
>> Jianchao
>>
>> On 2022/4/25 3:06 下午, Wang Jianchao (Kuaishou) wrote:
>>> Recently, we encounter a deadlock case where there are many tasks
>>> hung on agi and agf xfs_buf. It end up with a deadlock between
>>> agf and inode xfs_buf as following,
>>>
>>> xfs_ifree()             xfs_bmap_btalloc()
>>> xfs_iunlink_remove()    xfs_alloc_vextent()
>>>   hold inode bp           hold agf
>>> xfs_difree()            xfs_trans_log_inode()
>>>   require agf             require inode bp
>>>
>>> The task requires inode bp with agf held block other tasks which
>>> want to require agf with agi held. Then the whole filesystem
>>> looks like a agi/agf deadlock. To fix this issue, get agf in
>>> xfs_iunlink_remove() after it get agi and before get indoe bp.
>>>
>>> Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
>>> ---
>>>  fs/xfs/xfs_inode.c | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
>>> index 9de6205fe134..c0a29fd00b0e 100644
>>> --- a/fs/xfs/xfs_inode.c
>>> +++ b/fs/xfs/xfs_inode.c
>>> @@ -36,6 +36,7 @@
>>>  #include "xfs_reflink.h"
>>>  #include "xfs_ag.h"
>>>  #include "xfs_log_priv.h"
>>> +#include "xfs_alloc.h"
>>>  
>>>  struct kmem_cache *xfs_inode_cache;
>>>  
>>> @@ -2337,6 +2338,7 @@ xfs_iunlink_remove(
>>>  {
>>>  	struct xfs_mount	*mp = tp->t_mountp;
>>>  	struct xfs_agi		*agi;
>>> +	struct xfs_buf		*agfbp;
>>>  	struct xfs_buf		*agibp;
>>>  	struct xfs_buf		*last_ibp;
>>>  	struct xfs_dinode	*last_dip = NULL;
>>> @@ -2352,6 +2354,14 @@ xfs_iunlink_remove(
>>>  	error = xfs_read_agi(mp, tp, pag->pag_agno, &agibp);
>>>  	if (error)
>>>  		return error;
>>> +
>>> +	/*
>>> +	 * Get the agf buffer first to ensure the lock ordering against inode bp
>>> +	 */
>>> +	error = xfs_read_agf(mp, tp, pag->pag_agno, 0, &agfbp);
>>> +	if (error)
>>> +		return error;
>>> +
>>>  	agi = agibp->b_addr;
>>>  
>>>  	/*
