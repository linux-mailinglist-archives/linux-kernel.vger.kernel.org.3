Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875B159CA77
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 23:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237761AbiHVVCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 17:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiHVVB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 17:01:59 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ABA4D4C8;
        Mon, 22 Aug 2022 14:01:55 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id u22so11016099plq.12;
        Mon, 22 Aug 2022 14:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=2fAEc1Rx4yTE2rS5HAcZPT8ddPQQIssMf33uBzk9q2Q=;
        b=SLD67QfWS4wAo2SoK8qXgftpC09rjiyrfowvdQkk8y6E/WcVZIz89W5QfAH/3RYQWI
         qWZMi6JFHAv1Gn8Icfi8muq/92Or8Wa9LNDM96ATRlS2lOwjSCR5wxyivdQTZAbeAP18
         siIHso4OJ51j7kzxzxtbjHcUZwS/ydWtNO+fyb+M0uIRj0LK07fhCTbuecpZO5p4pOYH
         c+MUx+2EXUcxehrASlouuAHvcHJVZcxRcx4G1R0qnxPl0ShIUwMvx1Esf2TUbCnIFdO9
         w8B6HJk0Vdsz/R6Y3qD139cYYC/8FsFwARccGSCOdhkqZeP65eWXyok102o9zuR0SiQK
         NotQ==
X-Gm-Message-State: ACgBeo1Hxwkouf0kR24kBmrsjTv/DzhfqWdSU2LnRNOC+SAFSVNxfSzA
        zFXL5CEUbc9TySqhofnh9Jg=
X-Google-Smtp-Source: AA6agR6SDLTSCD/xx9U0zFMYjo/JnEL5yQTwusolER77hHZ/SAWBH7oJZ0lOqo3xIQLokJX1yIa4Gw==
X-Received: by 2002:a17:90b:3511:b0:1f7:3c52:4b98 with SMTP id ls17-20020a17090b351100b001f73c524b98mr172856pjb.17.1661202114880;
        Mon, 22 Aug 2022 14:01:54 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id m4-20020a17090a2c0400b001f54fa41242sm10553912pjd.42.2022.08.22.14.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 14:01:53 -0700 (PDT)
Message-ID: <3eb3867b-9bd5-3de0-b00e-de77d724636e@acm.org>
Date:   Mon, 22 Aug 2022 14:01:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [syzbot] INFO: task hung in scsi_remove_host
Content-Language: en-US
To:     syzbot <syzbot+bafeb834708b1bb750bc@syzkaller.appspotmail.com>,
        jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        syzkaller-bugs@googlegroups.com
References: <000000000000b5187d05e6c08086@google.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <000000000000b5187d05e6c08086@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/22 06:42, syzbot wrote:
> HEAD commit:    15b3f48a4339 Merge tag 'kbuild-fixes-v6.0' of git://git.ke..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=15f72c47080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3b9175e0879a7749
> dashboard link: https://syzkaller.appspot.com/bug?extid=bafeb834708b1bb750bc
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1503c1f3080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11559fc3080000

#syz test https://github.com/bvanassche/linux.git scsi-for-next

