Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F5650A400
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385790AbiDUP1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbiDUP1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:27:30 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0B643AC0;
        Thu, 21 Apr 2022 08:24:39 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Kkh6y2WlDzCrQS;
        Thu, 21 Apr 2022 23:20:10 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 23:24:36 +0800
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 23:24:36 +0800
Message-ID: <b6777ef0-629c-0bb6-da5a-6aef096b6079@huawei.com>
Date:   Thu, 21 Apr 2022 23:24:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [Question] SCSI_EH: How does EH guarantee there is no UAF of
 scsi_cmnd if host reset failed
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Feilong Lin <linfeilong@huawei.com>
References: <6301e87f-15f6-4c1f-41f5-d2f1aa4eedd7@huawei.com>
 <da087e9b-bd07-e5fd-421d-242e6adce22b@suse.de>
From:   Wenchao Hao <haowenchao@huawei.com>
In-Reply-To: <da087e9b-bd07-e5fd-421d-242e6adce22b@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/4/19 22:56, Hannes Reinecke wrote:
> On 4/19/22 16:28, Wenchao Hao wrote:
>> Hi all, I am wondered how does SCSI EH guarantee there is no UAF of scsi_cmnd
>> if host reset failed. If host reset failed and eh_cmd_q of shost is not empty,
>> these command in eh_cmd_q would be added to done_q in scsi_eh_offline_sdevs()
>> and finished by scsi_eh_flush_done_q(). So these scsi_cmnd and it's related
>> request would be freed.
>>
> Yes.
> 
>> While since host reset failed, we can not guarantee the LLDDs has cleared all
>> references to these commands in eh_cmd_q. Is there any possibility that the
>> LLDDs reference to these commands? If this happened, then a using after free
>> issue would occur.
>>
> If host reset has failed there are _no_ assumptions we can make about commands, and not even about the PCI device itself.
> So in effect, once host_reset failed the system is hosed.
> 
> We _might_ be able to resurrect the system by doing PCI EEH, but not many systems nor drivers implement that.
> 
> Cheers,
> 
> Hannes
> 
> .

Thanks a lot for your reply. I am writing single LUN reset EH flow which discussed in previous mail
and testing it, if the test result is good I would post it.

By the way, you said you would make EH rework, are you doing it? Could you tell us your plan
if it's not secret.
