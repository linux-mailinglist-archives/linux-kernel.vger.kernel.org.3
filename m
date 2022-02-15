Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529234B704C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238588AbiBOPmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:42:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241641AbiBOPlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:41:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11ADCF20
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=zdWjWKUr0FGB2DO0mrVmCFwXLaTbI5tPcsnYFGfBcAM=; b=u/J6LxpPxW+8S/4jZY64ox18Vv
        53Kqv6Pqb4msIVZMZjR3gxuv3KrUee78AIHTIp6TLBIb7PTxIJGemN4NCgBDltMmWYSbKsK/pWG5o
        2ppqN3Ea0eLvf9nRv4HOK1y1U9O/eP/GZ3TA9NHLSTSuq05/R6Y8cSWxyDfv/TY33+67aaZZrUHh+
        vVNp8N810nxZ52uVHGGDdX0miuPs+sYlPk+DdDtCJ6WN7eZTize7h9H0596gxuYDynXAR9kCgqakl
        n7j8xQBddoSPK8QEYJ+7hRGDflrNIuLV8RFo42JFks8tSfDt0qxmcDMLZp26HDnXo4a+Jxxnfd3SJ
        h3/vl0PQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJzs4-00DxWc-Od; Tue, 15 Feb 2022 15:36:05 +0000
Message-ID: <5d11b1a5-d222-1565-3d45-261e48d32522@infradead.org>
Date:   Tue, 15 Feb 2022 07:36:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] firmware_loader: EXTRA_FIRMWARE does not support
 compressed files
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20220214222311.9758-1-rdunlap@infradead.org>
 <YgsHtdqm3xRU+QUD@bombadil.infradead.org>
 <29f9b063-96c9-f120-0920-acd088b01b89@infradead.org>
 <YgtWzLsIzXQX8jP/@bombadil.infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <YgtWzLsIzXQX8jP/@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/22 23:31, Luis Chamberlain wrote:
> On Mon, Feb 14, 2022 at 07:30:22PM -0800, Randy Dunlap wrote:
>>
>>
>> On 2/14/22 17:53, Luis Chamberlain wrote:
>>> On Mon, Feb 14, 2022 at 02:23:11PM -0800, Randy Dunlap wrote:
>>>> Document in the firmware loader Kconfig help text that firmware image
>>>> file compression is not supported for builtin EXTRA_FIRMWARE files so
>>>> that someone does not waste time trying that.
>>>>
>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>>>> ---
>>>> Yeah, I wasted some time trying to use an xz compressed file
>>>> as builtin EXTRA_FIRMWARE, 
>>>
>>> Curious *why* you are using EXTRA_FIRMWARE BTW.
>>
>> Hi Luis,
>>
>> I need to load i915 firmware very early
>> and I am not using an initramfs.
> 
> Curious, why don't you use an initramfs? I'm just
> trying to gather users of EXTRA_FIRMWARE as I thought
> they didn't exist.

It's an option, right?
I just prefer to be able to boot a bare kernel.


-- 
~Randy
