Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9724B623C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 05:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiBOErY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 23:47:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiBOErW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 23:47:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E21390266
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 20:47:13 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07FD01063;
        Mon, 14 Feb 2022 20:47:13 -0800 (PST)
Received: from [10.163.48.145] (unknown [10.163.48.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFE7E3F718;
        Mon, 14 Feb 2022 20:47:10 -0800 (PST)
Subject: Re: [PATCH] mm/pages_alloc.c: Don't create ZONE_MOVABLE beyond the
 end of a node
To:     Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org
Cc:     jhubbard@nvidia.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ziy@nvidia.com
References: <20220215025831.2113067-1-apopple@nvidia.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <7b752e06-f345-cbb2-d05c-57e5fc5d8e5a@arm.com>
Date:   Tue, 15 Feb 2022 10:17:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220215025831.2113067-1-apopple@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alistair,

On 2/15/22 8:28 AM, Alistair Popple wrote:
> ZONE_MOVABLE uses the remaining memory in each node. It's starting pfn
> is also aligned to MAX_ORDER_NR_PAGES. It is possible for the remaining
> memory in a node to be less than MAX_ORDER_NR_PAGES, meaning there is
> not enough room for ZONE_MOVABLE on that node.

How plausible is this scenario on normal systems ? Should not the node
always contain MAX_ORDER_NR_PAGES aligned pages ? Also all zones which
get created from that node should also be MAX_ORDER_NR_PAGES aligned ?
I am just curious how a node could end up being like this.

- Anshuman
