Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C2E566529
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiGEIhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 04:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiGEIhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 04:37:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46A42DC5;
        Tue,  5 Jul 2022 01:37:35 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LcbZk5NPfz68916;
        Tue,  5 Jul 2022 16:34:54 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 5 Jul 2022 10:37:33 +0200
Received: from [10.195.35.180] (10.195.35.180) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 5 Jul 2022 09:37:32 +0100
Message-ID: <71dfc3cd-c2ae-8096-9280-67e77c21055e@huawei.com>
Date:   Tue, 5 Jul 2022 09:37:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3] hisi_lpc: Use acpi_dev_for_each_child()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yang Yingliang <yangyingliang@huawei.com>
References: <12026357.O9o76ZdvQC@kreacher> <2657553.mvXUDI8C0e@kreacher>
 <5606189.DvuYhMxLoT@kreacher>
 <e9666883-3285-36a6-6278-ace219b88f3c@huawei.com>
 <CAHp75Ve-Cm43HhqqxxfmKTbC_Gkx=0aAcj0jJmA=-Nr-NT1FqQ@mail.gmail.com>
 <CAHp75VdT1YZUQbdHupA2RmucUBSzypcPwKBgSa4=sVQAhC+Vsw@mail.gmail.com>
 <61fbd71b-9c36-345c-7aed-561b81c34259@huawei.com>
 <CAHp75VdxaBG8Sj3j7Wa7BrZOrn1j2eAtJMw0N8z255HwMSohYw@mail.gmail.com>
 <df8c0a5d-e950-1726-5d30-80dcc8b20ff9@huawei.com>
 <CAJZ5v0hv7nm57QrCYX+aX=fVoE0s0BxEpJfz+a8bsPzzSZt7+g@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <CAJZ5v0hv7nm57QrCYX+aX=fVoE0s0BxEpJfz+a8bsPzzSZt7+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.35.180]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2022 20:02, Rafael J. Wysocki wrote:

Hi Rafael,

> I've applied the patch from Yang Yingliang and I thought it would be
> OK to add your ACK to it based on the conversation so far (please let
> me know if that's not the case).  Next, I've added my patch rebased on
> top of it with the tags from you and Greg.
> 
> The result is on my bleeding-edge branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=bleeding-edge
> 
> and these are the commits in question
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=d674553009afc9b24cab2bbec71628609edbbb27
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=54872fea6a5ac967ec2272aea525d1438ac6735a
> 
> Please let me know if you see any issues with them.
> 

I gave these a quick test on my board and they look fine.

Acked-by: John Garry <john.garry@huawei.com>

> If not, I'll go ahead and move them to my linux-next branch.

Thanks,
John
