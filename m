Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE9C4C1CE8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 21:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237333AbiBWUMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 15:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235667AbiBWUMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 15:12:34 -0500
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D11403D0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 12:12:06 -0800 (PST)
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id MxzYnod5Y41cbMxzYni1iG; Wed, 23 Feb 2022 21:12:04 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 23 Feb 2022 21:12:04 +0100
X-ME-IP: 90.126.236.122
Message-ID: <794ed508-3703-3dc6-5c04-f9fec737f277@wanadoo.fr>
Date:   Wed, 23 Feb 2022 21:12:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] spi: add missing pci_dev_put() before return
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Qing Wang <wangqing@vivo.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1644890407-65167-1-git-send-email-wangqing@vivo.com>
 <164558930131.1665159.11296485721987449047.b4-ty@kernel.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <164558930131.1665159.11296485721987449047.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 23/02/2022 à 05:08, Mark Brown a écrit :
> On Mon, 14 Feb 2022 18:00:07 -0800, Qing Wang wrote:
>> From: Wang Qing <wangqing-DGpbCiVdSXo@public.gmane.org>
>>
>> pci_get_slot() increases its reference count, the caller must
>> decrement the reference count by calling pci_dev_put()
>>
>>
> 
> Applied to
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> 
> Thanks!
> 
> [1/1] spi: add missing pci_dev_put() before return
>        commit: 4d986ffa036a773456476f70bd0fde2fb1330b7d
> 

Hi, not sure that the patch is correct.

Shouldn't the reference be released in the error handling path and in 
pch_spi_release_dma() ?

Instead of *unconditionally* at the end of pch_spi_request_dma()?

CJ
