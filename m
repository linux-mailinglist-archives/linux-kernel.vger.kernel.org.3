Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCE759CAB4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 23:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbiHVVUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 17:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238014AbiHVVUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 17:20:14 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E580451432;
        Mon, 22 Aug 2022 14:20:13 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id x19so11068107plc.5;
        Mon, 22 Aug 2022 14:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=OiLq9jWCfKJ4+st1sKCjNqpo8+tt/E7IjyRd3lma/Xk=;
        b=7grAJXH+3A6fUFD4/4s0bR7FzYfB1v74uTU33yzVRxBFB/gPFdEv03XnSfXX4812b4
         QURQsL0IWC6tHrmoQSB5n1efzsWlMfrCVqr/DBEa2AwfivERB0NpUv5QTB2YZel/2NmR
         owNAIhLsV8cg9L2bcUrpEnuhaCL3hzJFVYFgEt5vljSlCFRiV1yyx/Vs2lVmu1TBCDeb
         NBetWwcKUHS+vT1nWaOK0IBHWIuWSymCWGkOZvi4ygmvS/elAyjPl8VAdFbgwRKKbnA5
         /4TT0rvErj0MzvfjoQZ01uN74kK+ThofYv3Nei58nLcC7EHjL17g1jTFJyThskWqgPA6
         9kPQ==
X-Gm-Message-State: ACgBeo3TKYYd9YkP1rmhOUW09GzYzMHl8q39uCfxDhMC7rzvEP6aWrr3
        ausyxUqukz4KScfbn39VymU=
X-Google-Smtp-Source: AA6agR7pGr/VS86cFUj14yul6XaNpS7RjoD2KCfjUwqs9xoQDsolr/nUhyk3zWiZECxTsbOtHrazRw==
X-Received: by 2002:a17:90a:744c:b0:1fa:c029:7a24 with SMTP id o12-20020a17090a744c00b001fac0297a24mr237385pjk.54.1661203213144;
        Mon, 22 Aug 2022 14:20:13 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id a6-20020a17090ad80600b001fb1de10a4dsm3204272pjv.33.2022.08.22.14.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 14:20:12 -0700 (PDT)
Message-ID: <27a26f00-95dd-c9bc-dab3-3bbd650b0d87@acm.org>
Date:   Mon, 22 Aug 2022 14:20:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [syzbot] INFO: task hung in scsi_remove_host
Content-Language: en-US
To:     syzbot <syzbot+bafeb834708b1bb750bc@syzkaller.appspotmail.com>,
        dsterba@suse.com, hch@lst.de, hdanton@sina.com, jejb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, ming.lei@redhat.com, nborisov@suse.com,
        syzkaller-bugs@googlegroups.com, wqu@suse.com
References: <0000000000006d456105e6da8d58@google.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <0000000000006d456105e6da8d58@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/22 13:47, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit ae643a74ebdb150b004601d0d5fe5a1faba9b04d
> Author: Qu Wenruo <wqu@suse.com>
> Date:   Sun May 22 11:47:48 2022 +0000
> 
>      btrfs: introduce a data checksum checking helper
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=176ef485080000
> start commit:   e3f259d33c0e Merge tag 'i2c-for-6.0-rc2' of git://git.kern..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=14eef485080000
> console output: https://syzkaller.appspot.com/x/log.txt?x=10eef485080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3bd9363f7b80ef9c
> dashboard link: https://syzkaller.appspot.com/bug?extid=bafeb834708b1bb750bc
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108e1a3d080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154720f3080000
> 
> Reported-by: syzbot+bafeb834708b1bb750bc@syzkaller.appspotmail.com
> Fixes: ae643a74ebdb ("btrfs: introduce a data checksum checking helper")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Qu, feel free to ignore the above bisection result. I think it is wrong.

Bart.
