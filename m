Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7E150DB41
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbiDYIhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiDYIhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:37:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2082F5F25D;
        Mon, 25 Apr 2022 01:34:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D39511F38A;
        Mon, 25 Apr 2022 08:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650875648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B4jqnWenFZHQCUs5OAJuRbzriGZGZ0eaUJcJbghY+N4=;
        b=I5Xrka/BDzgXsY/o0+xExA38ALlvMvPN9TcuyZM2IPYfgndbcEpCzYwdJxJ12zmyxaA3Lv
        Zv2yq5KzZ3m7nMh/0q28JgxKtlEvyRKAovKRCQT7DKFFL6UD8VM7exvp1v9ccgyCwcrYTQ
        uzy/H+CqA6babuYGUGzQydV5swRqmEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650875648;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B4jqnWenFZHQCUs5OAJuRbzriGZGZ0eaUJcJbghY+N4=;
        b=DG0FqFGRerUDCBHAZ/P7IruakjHvzR+dk6L3p0YX1wzIzQ5y2da/ph7IN2grM4jKtbK8uI
        WUC+M7TmecHzHVCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A153C13AF3;
        Mon, 25 Apr 2022 08:34:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id naa9JQBdZmKsfwAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 25 Apr 2022 08:34:08 +0000
Message-ID: <39975d62-b706-7d03-01a8-f6095c7af4ac@suse.de>
Date:   Mon, 25 Apr 2022 10:34:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/4] scsi: libsas: Add sas_execute_internal_abort_single()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, jinpu.wang@cloud.ionos.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajish.Koshy@microchip.com, linuxarm@huawei.com,
        Viswas.G@microchip.com, hch@lst.de, liuqi115@huawei.com,
        chenxiang66@hisilicon.com
References: <1646309930-138960-1-git-send-email-john.garry@huawei.com>
 <1646309930-138960-2-git-send-email-john.garry@huawei.com>
 <929aede0-9e58-9c3d-5951-6151a3281edd@suse.de>
 <83328d95-5d5e-f311-952c-ce627cb035ea@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <83328d95-5d5e-f311-952c-ce627cb035ea@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/22 10:27, John Garry wrote:
> On 20/04/2022 13:21, Hannes Reinecke wrote:
>>>   int sas_execute_tmf(struct domain_device *device, void *parameter,
>>>               int para_len, int force_phy_id,
>>>               struct sas_tmf_task *tmf)
>>> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
>>> index df2c8fc43429..2d30d57916e5 100644
>>> --- a/include/scsi/libsas.h
>>> +++ b/include/scsi/libsas.h
>>> @@ -557,6 +557,16 @@ struct sas_ata_task {
>>>       int    force_phy_id;
>>>   };
>>> +/* LLDDs rely on these values */
>>> +enum sas_internal_abort {
>>> +    SAS_INTERNAL_ABORT_SINGLE    = 0,
>>> +};
>>> +
>>
>> Why don't you use the existing TMF_XXX values here?
>> Your 'single' method pretty much _is_ a TMF_ABORT_TASK, and the 
>> 'device' method _is_ a TMF_ABORT_TASK_SET, no?
> 
> Sure, they are doing the same as TMFs and there is equivalence in the 
> 'single' and 'device' methods, as you say.
> 
> However, as mentioned in the comment, the LLDDs rely on the values in 
> enum sas_internal_abort, which do not match the values in 
> TMF_ABORT{_TASK, _TASK_SET}.
> 
How can they rely on a value which you just introduced?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
