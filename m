Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE964B1598
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 19:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343575AbiBJSyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 13:54:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243255AbiBJSyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:54:50 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58623101E;
        Thu, 10 Feb 2022 10:54:50 -0800 (PST)
Message-ID: <79b15466-4fe5-ec2b-5530-e5dbfff52f2b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644519286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8SDUgzwF1MYpOKAYuMJLg2sJ5DHjLA2zzshxQ2LBlaw=;
        b=Cj6V3g1z+c2zakSOio6cOl9mjXUOx55J/eskpWaPON1f+kCnQUJ4TikXzusV2+6+4bdYHt
        zahBT+9pgJB1KUxxtP5MN3hiEBPQW6CsWnXTYzhtHayO2s5TefJbmtLEfWxovFotY+2mt2
        L4Tt2eq96r26NOtyCuoePRIBRxCgccA=
Date:   Thu, 10 Feb 2022 11:54:24 -0700
MIME-Version: 1.0
Subject: Re: [Bug] nvme blocks PC10 since v5.15 - bisected
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        m.heingbecker@googlemail.com,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>
References: <CAJZ5v0hvvYedSn5u-i7sjpoEHU4P65t7i1b2pVn=S1q0nHWgqQ@mail.gmail.com>
 <20220121210905.GA1114868@dhcp-10-100-145-180.wdc.com>
 <CAJZ5v0gybg+Wk+008UBFnm2WqrxowOarhst9Eh+91BN823mqNA@mail.gmail.com>
 <20220210145635.GA1617879@dhcp-10-100-145-180.wdc.com>
 <20220210182423.GB16171@lst.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20220210182423.GB16171@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/2022 11:24 AM, Christoph Hellwig wrote:
> On Thu, Feb 10, 2022 at 06:56:35AM -0800, Keith Busch wrote:
>> Apparently it works fine when you disable VMD, so sounds like the
>> acpi_storage_d3 is set, but we fail to find the correct acpi companion
>> device when it's in a VMD domain.
> 
> I guess the acpi_storage_d3 is set on the VMD device and we need
> to propagate that down the entire bus hanging off it.
This is all you needed to say

> 
> Which kinda makes sense in the twisted world where vmd was invented,
> given that vmd is Intel's evil plot so that only their Windows driver
> can bind to these devices, 
Is this relevant or necessary?


so the property also needs to be set on
> the vmd device.
> 
> Nirmal and Jonathan, can you help to sort this mess out?
