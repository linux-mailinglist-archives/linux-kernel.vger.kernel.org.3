Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247C74EB3C0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 20:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240740AbiC2S6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 14:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbiC2S6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 14:58:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9ED22E975;
        Tue, 29 Mar 2022 11:56:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9862D210EA;
        Tue, 29 Mar 2022 18:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648580212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lkwhWbY1yF0+9nQZFkRJGmng1FNjwIj/lv2h8vOj/jM=;
        b=FocOWdNDFcE/1vq5Qf28TrhWjnIUK0sEMxYhSt4mNqDa1mWV6i6c1OYh1dNwhcXPSRo1W8
        AUaR4mfUoEhiUKXNTd4zk+imNYjYf7m9cGGUL4Mii/lelS+JDHWsq4JCGVliO8qE7kuZR/
        tqlK+qV5le6FzBsyVRiDixLjPnnMDI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648580212;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lkwhWbY1yF0+9nQZFkRJGmng1FNjwIj/lv2h8vOj/jM=;
        b=H+g+hnBhD66b6uAez6GoDoCgxcScOIaelFxBp/i1fZK5mWHE/msXzJxZUr3o0Wb/CulRwX
        Gs6ob8LsYn0nHUCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B2F413A7E;
        Tue, 29 Mar 2022 18:56:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SHB6EXRWQ2IsTgAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 29 Mar 2022 18:56:52 +0000
Message-ID: <64d5a997-a1bf-7747-072d-711a8248874d@suse.de>
Date:   Tue, 29 Mar 2022 20:56:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [REQUEST DISCUSS]: speed up SCSI error handle for host with
 massive devices
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>,
        Steffen Maier <maier@linux.ibm.com>,
        linux-scsi@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        Lee Duncan <lduncan@suse.com>
Cc:     Wu Bo <wubo40@huawei.com>, Feilong Lin <linfeilong@huawei.com>,
        zhangjian013@huawei.com
References: <71e09bb4-ff0a-23fe-38b4-fe6425670efa@huawei.com>
 <cd7bda98-2160-9271-9520-e98d1fe00ea5@linux.ibm.com>
 <331aafe1-df9b-cae4-c958-9cf1800e389a@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <331aafe1-df9b-cae4-c958-9cf1800e389a@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/22 14:40, Wenchao Hao wrote:
> On 2022/3/29 18:56, Steffen Maier wrote:
>> On 3/29/22 11:06, Wenchao Hao wrote:
>>> SCSI timeout would call scsi_eh_scmd_add() on some conditions, host 
>>> would be set
>>> to SHOST_RECOVERY state. Once host enter SHOST_RECOVERY, IOs 
>>> submitted to all
>>> devices in this host would not succeed until the scsi_error_handler() 
>>> finished.
>>> The scsi_error_handler() might takes long time to be done, it's 
>>> unbearable when
>>> host has massive devices.
>>>
>>> I want to ask is anyone applying another error handler flow to 
>>> address this
>>> phenomenon?
>>>
>>> I think we can move some operations(like scsi get sense, scsi send 
>>> startunit
>>> and scsi device reset) out of scsi_unjam_host(), to perform these 
>>> operations
>>> without setting host to SHOST_RECOVERY? It would reduce the time of 
>>> block the
>>> whole host.
>>>
>>> Waiting for your discussion.
>>
>> We already have "async" aborts before even entering scsi_eh. So your 
>> use case seems to imply that those aborts fail and we enter scsi_eh?
>>
> 
> Yes, I mean when scsi_abort_command() failed and scsi_eh_scmd_add() is 
> called.
> 
>> There's eh_deadline for limiting the time spent in escalation of 
>> scsi_eh, and instead directly go to host reset. Would this help?
>>
>>
> 
> The deadline seems not helpful. What we want to see is a single LUN's 
> command error
> would not stop other LUNs which share the same host. So my plan is to 
> move reset LUN out
> from scsi_unjam_host() which run with host set to SHOST_RECOVERY.

Nope. One of the key points of scsi_unjam_host() is that is has to stop 
all I/O before proceeding. Without doing so basically all SCSI parallel 
HBAs will fail EH as they _require_ I/O to be stopped.

And even on modern HBAs we have the challenge that 99% of every EH 
invocation is triggered by command timeouts, where 'LUN reset' is only 
of limited usability.

Cheers,

Hannes
