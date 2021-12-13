Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF20B473527
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242410AbhLMTnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:43:21 -0500
Received: from www381.your-server.de ([78.46.137.84]:49386 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240557AbhLMTnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=/U2kRbjnUmmfO5VcGjkbT326Y4PX+CdMdtu1XG7vuao=; b=A4VhOy/ckIuFeL7tUGbt4bYZWt
        DwRHP1fdP5yz9xLPvfjJCF99l73Qb6NHRsfVgf43y/V5iXNKr9nkjlvK9uzhfy28zMzFX4EVtas39
        om1Uuu2om2W6Fo29+0KtNusZYcSUaLeobVSBWyJYH1y+AJ16Jj7YEPF32pX9/M0rKW3GuPM2iU872
        1V7Aj4KmNrhkPvo1zaZU7cxFECG2FK3xX1L1dLmUvHClevs5ZYnsBcSIPEvJrTT4fPfAZBWc0Gqcp
        1NbBwuX8n8RJdgLI2yIW0VPy6kJcm/r2nf9CJDq5DroA0i5qFKklB5Ejhu9gQVkFQk8TmaWm18VaF
        7b6oVnwQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mwrEC-000FhI-7q; Mon, 13 Dec 2021 20:43:16 +0100
Received: from [2001:a61:2aa6:c001:9e5c:8eff:fe01:8578]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mwrEB-000AeU-DF; Mon, 13 Dec 2021 20:43:15 +0100
Subject: Re: [PATCH v2 6/6] drivers: remoteproc: Add Xilinx r5 remoteproc
 driver
To:     Tanmay Shah <tanmay.shah@xilinx.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ben Levinsky <ben.levinsky@xilinx.com>,
        Bill Mills <bill.mills@linaro.org>,
        Sergei Korneichuk <sergei.korneichuk@xilinx.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20211123062050.1442712-1-tanmay.shah@xilinx.com>
 <20211123062050.1442712-7-tanmay.shah@xilinx.com>
 <ab9e009a-5e35-ae49-2c8e-65be6ba36d7f@metafoo.de>
 <acbd7749-7bb2-0de2-5658-2b62ace9520a@xilinx.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <b8b24b65-786b-2a4e-5548-5e5e8bf988be@metafoo.de>
Date:   Mon, 13 Dec 2021 20:43:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <acbd7749-7bb2-0de2-5658-2b62ace9520a@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26385/Mon Dec 13 10:38:12 2021)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/21 8:31 PM, Tanmay Shah wrote:
>>> +static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
>>> +{
>>> [...]
>>> +
>>>
>>> +    i = 0;
>>> +    for_each_available_child_of_node(dev_node, child) {
>>> +        child_pdev = of_find_device_by_node(child);
>>> +        if (!child_pdev)
>> A return or a break in a for_each_available_child_of_node() will leak 
>> the reference to the child node.
>
> Do you mean I have to use of_put_node for each child?

You have to put a `of_put_node(child)` before each break or return in 
the loop.

If you search the kernel commit history for 
for_each_available_child_of_node or for_each_child_of_node you'll find 
many fixes for similar problems. For example 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e1b391e9712db

