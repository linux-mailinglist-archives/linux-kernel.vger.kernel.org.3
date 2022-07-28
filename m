Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBAE583D4D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236597AbiG1LYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236520AbiG1LXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:23:46 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C3416BC06
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:21:12 -0700 (PDT)
Received: from localhost.localdomain (unknown [111.9.175.10])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxn9EmceJizQI_AA--.43170S3;
        Thu, 28 Jul 2022 19:21:11 +0800 (CST)
Subject: Re: [PATCH 3/5] LoongArch: Support relocation against
 _GLOBAL_OFFSET_TABLE_
To:     Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev
References: <385f63bcbee8e37c42f479ce9cdc7e7d731d419b.camel@xry111.site>
 <99733532831377ab6585d43ee40bf314a2d4c5a3.camel@xry111.site>
 <10c1e0f9-8409-a0f4-9b18-a5f56dfb14e1@loongson.cn>
 <9a79a424a11339ae025539c38fe121104ff00804.camel@xry111.site>
 <caf8ec4b-f74d-e6ef-17f2-9e899d41b3a9@loongson.cn>
 <73f83b51eaf40ff1f173059e1f187182db47a1c6.camel@xry111.site>
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>
From:   Jinyang He <hejinyang@loongson.cn>
Message-ID: <1671786a-d2a5-5f98-e8be-244ba0a91e91@loongson.cn>
Date:   Thu, 28 Jul 2022 19:21:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <73f83b51eaf40ff1f173059e1f187182db47a1c6.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxn9EmceJizQI_AA--.43170S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr1DCF48Gw4DuF48CFyfWFg_yoW3urcE9F
        Z2qrn5G398Zr9FgF47KF43tr9IgF4fGr4xZFsrXa1Dt3sYqFsxCFs3urn09FyYga1jvr9I
        gws5XF4jvwsI9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbc8YjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAI
        w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUgg_TUUUUU
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/28/2022 06:57 PM, Xi Ruoyao wrote:

> On Thu, 2022-07-28 at 17:14 +0800, Jinyang He wrote:
>> Not sure but maybe re-align is needed here.
>> Since '{BYTE(0)}' actually use 1byte. _GLOABL_OFFSET_TABLE_ may have
>> difference with really GOT table entry. Have no machine and without
>> test... :-(
> BYTE(0) is only for preventing the linker from removing the section.
> All we want from the linker is a slot for .got in the section table, and
> the actual property (including size) will be filled at runtime by
> module_frob_arch_sections.  The first GOT entry won't be "appended"
> after one byte, it is wrote into the start of .got (at runtime).
Thank you for the detail answer which solves a doubt
that bothered me for a long time. I used to define the
'sym' outside of '.sec'. It always failed without align.

