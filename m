Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE2A4EBDB1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244837AbiC3JeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241954AbiC3JeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:34:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A038E2ED6B;
        Wed, 30 Mar 2022 02:32:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5672B218EF;
        Wed, 30 Mar 2022 09:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648632724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r+nughnReHhFuD/TpuTTU7U3+FMke0CXkY0cWV22ILo=;
        b=bWBOSyaFV5jEYGMhIZbepWpiyL9YLniHd0dNTiQ6yZyx3bQZFA78Ml4/wnqAejDIAw9mW0
        95wh1K5ftrs6/8wwRilaYSHvD6rWMwGDzx24ujpOt0olubl3VEZ/FpBWLpOmCwYA4802Ja
        MQ/G6k9kzgMAtCQ9kBo8AuUnXrfypiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648632724;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r+nughnReHhFuD/TpuTTU7U3+FMke0CXkY0cWV22ILo=;
        b=1jViVL6i1k5fZthyR+hzNFvwPZ/KRJyL4vVvySg9sddLvhACr7b04gb4pw1RC0oTETvZ6K
        HvTdCsMe/ckxHkDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28D8713A60;
        Wed, 30 Mar 2022 09:32:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IkzGB5QjRGLJXQAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 30 Mar 2022 09:32:04 +0000
Message-ID: <1dd69d03-b4f6-ab20-4923-0995b40f045d@suse.de>
Date:   Wed, 30 Mar 2022 11:32:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>,
        Steffen Maier <maier@linux.ibm.com>,
        linux-scsi@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        Lee Duncan <lduncan@suse.com>,
        John Garry <john.garry@huawei.com>
Cc:     Wu Bo <wubo40@huawei.com>, Feilong Lin <linfeilong@huawei.com>,
        zhangjian013@huawei.com
References: <71e09bb4-ff0a-23fe-38b4-fe6425670efa@huawei.com>
 <cd7bda98-2160-9271-9520-e98d1fe00ea5@linux.ibm.com>
 <331aafe1-df9b-cae4-c958-9cf1800e389a@huawei.com>
 <64d5a997-a1bf-7747-072d-711a8248874d@suse.de>
 <c4baacf1-0e86-9660-45f7-50ebc853e6af@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Subject: Re: [REQUEST DISCUSS]: speed up SCSI error handle for host with
 massive devices
In-Reply-To: <c4baacf1-0e86-9660-45f7-50ebc853e6af@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/22 11:11, Wenchao Hao wrote:
> On 2022/3/30 2:56, Hannes Reinecke wrote:
>> On 3/29/22 14:40, Wenchao Hao wrote:
>>> On 2022/3/29 18:56, Steffen Maier wrote:
>>>> On 3/29/22 11:06, Wenchao Hao wrote:
>>>>> SCSI timeout would call scsi_eh_scmd_add() on some conditions, host would be set
>>>>> to SHOST_RECOVERY state. Once host enter SHOST_RECOVERY, IOs submitted to all
>>>>> devices in this host would not succeed until the scsi_error_handler() finished.
>>>>> The scsi_error_handler() might takes long time to be done, it's unbearable when
>>>>> host has massive devices.
>>>>>
>>>>> I want to ask is anyone applying another error handler flow to address this
>>>>> phenomenon?
>>>>>
>>>>> I think we can move some operations(like scsi get sense, scsi send startunit
>>>>> and scsi device reset) out of scsi_unjam_host(), to perform these operations
>>>>> without setting host to SHOST_RECOVERY? It would reduce the time of block the
>>>>> whole host.
>>>>>
>>>>> Waiting for your discussion.
>>>>
>>>> We already have "async" aborts before even entering scsi_eh. So your use case seems to imply that those aborts fail and we enter scsi_eh?
>>>>
>>>
>>> Yes, I mean when scsi_abort_command() failed and scsi_eh_scmd_add() is called.
>>>
>>>> There's eh_deadline for limiting the time spent in escalation of scsi_eh, and instead directly go to host reset. Would this help?
>>>>
>>>>
>>>
>>> The deadline seems not helpful. What we want to see is a single LUN's command error
>>> would not stop other LUNs which share the same host. So my plan is to move reset LUN out
>>> from scsi_unjam_host() which run with host set to SHOST_RECOVERY.
>>
>> Nope. One of the key points of scsi_unjam_host() is that is has to stop all I/O before proceeding. Without doing so basically all SCSI parallel HBAs will fail EH as they _require_ I/O to be stopped.
>>
> 
> I still can not understand why we must stop all I/O. In my comprehension, stopping all I/O
> is because we might reset host during scsi_error_handler() and we must wait host's number of
> failed command equal to number of busy command then we can wake up scsi_error_handler().
> 
> If move reset LUN out of scsi_error_handler(), and perform single LUN reset, we only need
> stop I/O of this single LUN, this would not affect other LUNs. If single LUN reset failed,
> we can then call in the large scale error handle.
> 
I know the EH flow.

Problem here is the way parallel SCSI operates. Remember, parallel SCSI 
is a _bus_, and there can be only one command at a time on the bus.
So if one command on the bus misfires and you have to start EH you have 
to stop all I/O on the bus to ensure that your EH command is the only 
one active on the bus.

For modern HBAs we sure can device other ways and means of error 
recovery, but I can't really see how we would do that on legacy HBAs.

> Here is a brief flow:
> 
> abort command
>     ||
>     || failed
>     ||
>     \/
> stop single LUN's I/O (need to wait LUN's failed command number equal to busy command  number)
>     ||
>     || failed  (according to our statistic, 90% reset LUN would succeed)
>     ||
>     \/

Interesting. This does not match up with my experience, where 99% of the 
errors were due to a command timeout.

So which errors do you see here? What are the causes?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
