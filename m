Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAC64DADAD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350495AbiCPJnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiCPJnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:43:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BAE0C65485
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 02:42:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47F1B1476;
        Wed, 16 Mar 2022 02:42:32 -0700 (PDT)
Received: from [10.163.34.65] (unknown [10.163.34.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B61933F73D;
        Wed, 16 Mar 2022 02:42:30 -0700 (PDT)
Message-ID: <dad20ecc-efcd-4d3b-9d60-b5ad0b2c2c4b@arm.com>
Date:   Wed, 16 Mar 2022 15:12:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm: add access/dirty bit on numa page fault
Content-Language: en-US
To:     maobibo <maobibo@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220316010836.1137084-1-maobibo@loongson.cn>
 <93302a47-9fda-25c7-4212-41b8dd027696@arm.com>
 <3756661c-d710-7bf6-76ab-39ac44f8e8b3@loongson.cn>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <3756661c-d710-7bf6-76ab-39ac44f8e8b3@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/22 12:33, maobibo wrote:
> 
> On 03/16/2022 02:43 PM, Anshuman Khandual wrote:
>>
>> On 3/16/22 06:38, Bibo Mao wrote:
>>> During numa page fault, dirty bit can be added for old pte if
>>> fail to migrate on write fault. And if it succeeds to migrate,
>>> access bit can be added for migrated new pte, also dirty bit
>>> can be added for write fault.
>> The current code does not set the access and dirty bits when ever
>> applicable i.e on FAULT_FLAG_WRITE, on the pte (old if migration
>> fails, new if migration succeeds) ? Did not this cause any problem
>> earlier ? I am wondering how this might have gone unnoticed.

> On arm/x86 platform hw will set access/dirty bits automatically,
> however on MIPS platform access/dirty bits are set by software in next
> page fault, it is relatively easier to watch on MIPS platform.

Could you please update this in the commit message as well ?
