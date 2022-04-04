Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901834F0F0C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 07:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355372AbiDDFaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 01:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiDDF36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 01:29:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B02021838;
        Sun,  3 Apr 2022 22:28:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A3D13210E0;
        Mon,  4 Apr 2022 05:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649050081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c3Jl3xN1+ZJDwDSqXEjt8XdEW9eHbNf/gHTrPbTlPGg=;
        b=kxuT6iwU+kWRUJcyoskUv3rl12gvoI8ffMEuVPXzahulIXifhNchaCcX65dk2jFzy7hU5c
        F02BfyCip+v0TPVdM2uRjkNC3gqHHCvxAnhikZJWu+G90e69AxtexFh7jqM7flzeoufnar
        F9zA9J9OQjTydzxfF07HTStC19CJuvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649050081;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c3Jl3xN1+ZJDwDSqXEjt8XdEW9eHbNf/gHTrPbTlPGg=;
        b=+ZZyEJ/T57xeYaKDKJWa6MPOVxzG0urOZMGW6OkTuURzm7hAfNW8ety1NAvksZLvB4WGTT
        GoVd81QGpMD+rVCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 496C513A7C;
        Mon,  4 Apr 2022 05:28:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mwkrEOGBSmK3RAAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 04 Apr 2022 05:28:01 +0000
Message-ID: <769bcd36-4818-8470-2daa-49ac5c05b33a@suse.de>
Date:   Mon, 4 Apr 2022 07:28:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [REQUEST DISCUSS]: speed up SCSI error handle for host with
 massive devices
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>,
        Wenchao Hao <haowenchao@huawei.com>,
        Steffen Maier <maier@linux.ibm.com>,
        linux-scsi@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Lee Duncan <lduncan@suse.com>,
        John Garry <john.garry@huawei.com>
Cc:     Wu Bo <wubo40@huawei.com>, Feilong Lin <linfeilong@huawei.com>,
        zhangjian013@huawei.com
References: <71e09bb4-ff0a-23fe-38b4-fe6425670efa@huawei.com>
 <cd7bda98-2160-9271-9520-e98d1fe00ea5@linux.ibm.com>
 <331aafe1-df9b-cae4-c958-9cf1800e389a@huawei.com>
 <64d5a997-a1bf-7747-072d-711a8248874d@suse.de>
 <c4baacf1-0e86-9660-45f7-50ebc853e6af@huawei.com>
 <1dd69d03-b4f6-ab20-4923-0995b40f045d@suse.de>
 <d2f2c89f-c048-4f04-4d95-27958f0fa46a@huawei.com>
 <78d41ec1-b30c-f6d2-811c-e0e4adbc8f01@oracle.com>
 <84b38f16-2a32-f361-43e5-34bce1012e71@oracle.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <84b38f16-2a32-f361-43e5-34bce1012e71@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/22 19:17, Mike Christie wrote:
> On 4/3/22 12:14 PM, Mike Christie wrote:
>> We could share code with scsi_ioctl_reset as well. Drivers that support
>> TMFs via that ioctl already expect queuecommand to be possibly in the
>> middle of a run and IO not yet timed out. For example, the code to
>> block a queue and reset the device could be used for the new EH and
>> SG_SCSI_RESET_DEVICE handling.
>>
> 
> Hannes or others,
> 
> How do parallel SCSI drivers support scsi_ioctl_reset? Is is not fully
> supported and more only used for controlled testing?

That's actually a problem in scsi_ioctl_reset(); it really should wait 
for all I/O to quiesce. Currently it just sets the 'tmf' flag and calls 
into the various reset functions.

But really, I'd rather get my EH rework in before we're start discussing 
modifying EH behaviour.
Let me repost it ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
