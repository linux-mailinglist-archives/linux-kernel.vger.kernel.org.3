Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB696565114
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbiGDJkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbiGDJkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:40:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B9E2634
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:40:17 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lc11b5RKZz67XGR;
        Mon,  4 Jul 2022 17:37:39 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Jul 2022 11:40:15 +0200
Received: from [10.195.35.180] (10.195.35.180) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Jul 2022 10:40:14 +0100
Message-ID: <2667eb2f-c341-88e6-3e49-116053f91ee4@huawei.com>
Date:   Mon, 4 Jul 2022 10:40:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] bus: hisi_lpc: fix missing platform_device_put() in
 hisi_lpc_acpi_probe()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        <linux-kernel@vger.kernel.org>, <rafael@kernel.org>
CC:     <andriy.shevchenko@linux.intel.com>, <gregkh@linuxfoundation.org>
References: <20220704093456.1405484-1-yangyingliang@huawei.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220704093456.1405484-1-yangyingliang@huawei.com>
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

On 04/07/2022 10:34, Yang Yingliang wrote:
> In error case in hisi_lpc_acpi_probe() after calling platform_device_alloc(),
> if platform_device_add() is not called successfully, hisi_lpc_acpi_remove()
> can't release the failed 'pdev' including its resource and data, so they will
> be leaked, call platform_device_put() to put the refcount, then they will be
> freed in platform_device_release().
> I'v constructed this error case and tested this patch on D05 board.

/s/I'v/I've/

> 
> Fixes: 99c0228d6ff1 ("HISI LPC: Re-Add ACPI child enumeration support")
> Reported-by: Hulk Robot<hulkci@huawei.com>
> Signed-off-by: Yang Yingliang<yangyingliang@huawei.com>

Reviewed-by: John Garry <john.garry@huawei.com>
