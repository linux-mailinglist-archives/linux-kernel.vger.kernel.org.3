Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE38E507122
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244431AbiDSPAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353584AbiDSO7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:59:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1084C3298B;
        Tue, 19 Apr 2022 07:56:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C4809210DE;
        Tue, 19 Apr 2022 14:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650380213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P0bHge+GMMYbznLePUUnvwkPwSt8s9dbZBlPzkfEDUk=;
        b=L4yhz0ozTVo9fBukVYFThXvzy5umuiahsDQqOO5KbrWfq5gsjRz0HEbii/PP1EYy0+NVHo
        +kzZlDy7QDMnnQpVS8wsq2/i03B6XdcScoQjCYBJwd9k4/PgGcw0nAPcZ7Z/FSgGU/KoN/
        QvctlGqEdKZ8ADjIErOfAz37jFuQOO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650380213;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P0bHge+GMMYbznLePUUnvwkPwSt8s9dbZBlPzkfEDUk=;
        b=Q6GawvPbP9nlR/fBI2mZjRUJRjMR3BYbxLuA40glIlT/hfcWPkHMNm4Qlo3E6e1+4FeL8l
        2gv3oO9/w4AE3XDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E148139BE;
        Tue, 19 Apr 2022 14:56:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KRf5IbXNXmIhLQAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 19 Apr 2022 14:56:53 +0000
Message-ID: <da087e9b-bd07-e5fd-421d-242e6adce22b@suse.de>
Date:   Tue, 19 Apr 2022 16:56:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Question] SCSI_EH: How does EH guarantee there is no UAF of
 scsi_cmnd if host reset failed
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Feilong Lin <linfeilong@huawei.com>
References: <6301e87f-15f6-4c1f-41f5-d2f1aa4eedd7@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <6301e87f-15f6-4c1f-41f5-d2f1aa4eedd7@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/22 16:28, Wenchao Hao wrote:
> Hi all, I am wondered how does SCSI EH guarantee there is no UAF of scsi_cmnd
> if host reset failed. If host reset failed and eh_cmd_q of shost is not empty,
> these command in eh_cmd_q would be added to done_q in scsi_eh_offline_sdevs()
> and finished by scsi_eh_flush_done_q(). So these scsi_cmnd and it's related
> request would be freed.
> 
Yes.

> While since host reset failed, we can not guarantee the LLDDs has cleared all
> references to these commands in eh_cmd_q. Is there any possibility that the
> LLDDs reference to these commands? If this happened, then a using after free
> issue would occur.
> 
If host reset has failed there are _no_ assumptions we can make about 
commands, and not even about the PCI device itself.
So in effect, once host_reset failed the system is hosed.

We _might_ be able to resurrect the system by doing PCI EEH, but not 
many systems nor drivers implement that.

Cheers,

Hannes

