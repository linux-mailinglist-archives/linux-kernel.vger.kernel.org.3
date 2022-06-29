Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB16560159
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbiF2Nd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiF2Nd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:33:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F0F63C5;
        Wed, 29 Jun 2022 06:33:56 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LY2Pq2q0Cz687SB;
        Wed, 29 Jun 2022 21:29:51 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 15:33:54 +0200
Received: from [10.195.245.77] (10.195.245.77) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 14:33:52 +0100
Message-ID: <c57b353f-1325-4c90-f455-e53693ba585d@huawei.com>
Date:   Wed, 29 Jun 2022 14:33:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] hisi_lpc: Use acpi_dev_for_each_child()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <12026357.O9o76ZdvQC@kreacher>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <12026357.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.195.245.77]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
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

On 29/06/2022 13:55, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of walking the list of children of an ACPI device directly,
> use acpi_dev_for_each_child() to carry out an action for all of
> the given ACPI device's children.
> 
> This will help to eliminate the children list head from struct
> acpi_device as it is redundant and it is used in questionable ways
> in some places (in particular, locking is needed for walking the
> list pointed to it safely, but it is often missing).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Hi Rafael,

> ---
>   drivers/bus/hisi_lpc.c |   12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/bus/hisi_lpc.c
> ===================================================================
> --- linux-pm.orig/drivers/bus/hisi_lpc.c
> +++ linux-pm/drivers/bus/hisi_lpc.c
> @@ -471,6 +471,12 @@ static int hisi_lpc_acpi_remove_subdev(s
>   	return 0;
>   }
>   
> +static int hisi_lpc_acpi_clear_enumerated(struct acpi_device *adev, void *not_used)
> +{
> +	acpi_device_clear_enumerated(adev);
> +	return 0;
> +}
> +
>   struct hisi_lpc_acpi_cell {
>   	const char *hid;
>   	const char *name;
> @@ -480,13 +486,11 @@ struct hisi_lpc_acpi_cell {
>   
>   static void hisi_lpc_acpi_remove(struct device *hostdev)
>   {
> -	struct acpi_device *adev = ACPI_COMPANION(hostdev);
>   	struct acpi_device *child;
>   
I got this warn:

drivers/bus/hisi_lpc.c: In function ‘hisi_lpc_acpi_remove’:
drivers/bus/hisi_lpc.c:489:22: warning: unused variable ‘child’ 
[-Wunused-variable]
  489 |  struct acpi_device *child;
      |                      ^~~~~
  CC      drivers/bus/brcmstb_gisb.

With that fixed:

Acked-by: John Garry <john.garry@huawei.com>

Can you route this through one of your trees?

>   	device_for_each_child(hostdev, NULL, hisi_lpc_acpi_remove_subdev);
> -
> -	list_for_each_entry(child, &adev->children, node)
> -		acpi_device_clear_enumerated(child);
> +	acpi_dev_for_each_child(ACPI_COMPANION(hostdev),
> +				hisi_lpc_acpi_clear_enumerated, NULL);
>   }
>   
>   /*
> 
> 
> 

BTW, I don't know why I ever added a remove method for this driver 
instead of just setting suppress_bind_attrs....

Thanks,
John
